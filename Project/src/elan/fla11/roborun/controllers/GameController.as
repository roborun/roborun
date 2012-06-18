package elan.fla11.roborun.controllers
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import elan.fla11.roborun.ChatBtnGfx;
	import elan.fla11.roborun.Embeder;
	import elan.fla11.roborun.InfoBtnGfx;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.events.ConnectionEvent;
	import elan.fla11.roborun.events.GameEvent;
	import elan.fla11.roborun.events.StartEvent;
	import elan.fla11.roborun.models.LevelData;
	import elan.fla11.roborun.models.LevelModel;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.ConnectionManager;
	import elan.fla11.roborun.utils.KeyboardManager;
	import elan.fla11.roborun.utils.LevelCamera;
	import elan.fla11.roborun.utils.LevelLoader;
	import elan.fla11.roborun.utils.SpritePool;
	import elan.fla11.roborun.view.GameCard;
	import elan.fla11.roborun.view.gui.Button;
	import elan.fla11.roborun.view.pages.CardBanner;
	import elan.fla11.roborun.view.pages.ChatPage;
	import elan.fla11.roborun.view.pages.GameBackground;
	import elan.fla11.roborun.view.robots.BullRobot;
	import elan.fla11.roborun.view.robots.GiraffeRobot;
	import elan.fla11.roborun.view.robots.RobotBase;
	import elan.fla11.roborun.view.robots.WheelieRobot;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;

	public class GameController extends Sprite
	{
		private var _world				:Sprite;
		private var _level				:Sprite;
		private var _camera				:LevelCamera;
			
		private var _levelLoader		:LevelLoader;
		private var _robots				:Vector.<RobotBase>;
		
		private var _cardPool			:SpritePool;
		private var _numCard			:uint;
		private var _cards				:Array;
		
		private var _cardBanner			:CardBanner;
		private var _gameMenuGfx		:GameBackground;
		
		private var _userID				:String;
		private var _userOrder			:uint;
		private var _userDetails		:Object;
		
		private var _players			:Array;
		
		private var _chatPage			:ChatPage;
		private var _chatBtn			:ChatBtnGfx;
		private var _infoBtn			:InfoBtnGfx;
		private var _isChatOpen			:Boolean;
		
		public function GameController()
		{
			init();
		}
		
		private function init(): void
		{
			_robots = new Vector.<RobotBase>();
			
			_players = [];
			_cards = [];
			_levelLoader = new LevelLoader();
			_camera = new LevelCamera();
			
			_cardBanner = new CardBanner();
			
			_gameMenuGfx = new GameBackground();
			addChild( _gameMenuGfx );
			
			_world = new Sprite();
			addChild( _world );

			initChat();
			
			ConnectionManager.dispatcher.addEventListener(ConnectionEvent.CONNECTED, onConnected_initNewGame);
		}
		
		private function initChat(): void
		{
			_infoBtn = new InfoBtnGfx;
			_infoBtn.x = 768;
			_infoBtn.y = 615;
			addChild(_infoBtn);

			_chatBtn = new ChatBtnGfx;
			_chatBtn.x = 879;
			_chatBtn.y = 615;
			_chatBtn.gotoAndStop( 0 );
			_chatBtn.addEventListener(MouseEvent.CLICK, handleChatBtnClicked);
			addChild(_chatBtn);
			
			_chatPage = new ChatPage();
			GameSettings.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_chatPage.addEventListener(Event.CHANGE, onChatChange_playChatBtn);
			_chatPage.addEventListener(ButtonEvent.CLOSE, handleChatCloseBtnClicked);			
		}
		
		private function onKeyDown( e:KeyboardEvent ): void
		{
			trace( ' keydown ', e.keyCode, e.keyCode == Keyboard.C );
			switch( e.keyCode )
			{
				case Keyboard.C:
					if( !_isChatOpen ) handleChatBtnClicked();
					else handleChatCloseBtnClicked();
					break;
			}
		}
		
		private function onChatChange_playChatBtn( e:Event ): void
		{
			_chatBtn.play();
		}
		
		private function handleChatBtnClicked(evt:MouseEvent = null):void
		{
			_chatBtn.gotoAndStop( 0 );
			addChild(_chatPage);
			_chatPage.activateEnter();
			_isChatOpen = true;
			if( _camera != null ) _camera.deactivate();
		}
		
		private function handleChatCloseBtnClicked(evt:ButtonEvent = null):void
		{
			_chatBtn.gotoAndStop( 0 );
			removeChild(_chatPage);
			_chatPage.deactivateEnter();
			_isChatOpen = false;
			if( _camera != null ) _camera.activate();
		}
		
		
		private function onConnected_initNewGame( e:ConnectionEvent ): void
		{
			
			_userID = e.user.id;
			_userOrder = e.user.details.playerOrder;
			_userDetails = e.user.details;
			
			
			addEventListener(Event.ENTER_FRAME, onLoop);
			ConnectionManager.dispatcher.addEventListener(ConnectionEvent.USER_ADDED, onUserAdded_addNewPlayer);
			ConnectionManager.dispatcher.addEventListener(ConnectionEvent.DATA_RECEIVED, onDataReceived_playRound);
			
			
		}
		
		private function onUserAdded_addNewPlayer( e:ConnectionEvent ): void
		{
			var idx : uint = e.userCount -1;
			_chatPage.players = e.userArray;
			
			// Joining player
			if( e.user.details.level != undefined)
			{
				_levelLoader.loadLevel( LevelModel.levels[e.user.details.level].source );
				_robots.push( addRobot( e.user.details.robot, e.user.id ) );
				_robots.push( addRobot( _userDetails.robot, _userID ) );
			}
			// Host player
			else
			{
				_levelLoader.loadLevel( LevelModel.levels[_userDetails.level].source );
				_robots.push( addRobot( _userDetails.robot, _userID ) );
				_robots.push( addRobot( e.user.details.robot, e.user.id ) );
			}
			
			_levelLoader.addEventListener(Event.COMPLETE, onComplete_startGame);
			_level = _levelLoader.level;
			_world.addChild( _level );		
			
		}
		
		private function onDataReceived_playRound( e:ConnectionEvent ): void
		{
			_players.push( e.gameData );
			trace( 'GameData', e.gameData, _players.length, e.userCount );
			
			if( _players.length >= e.userCount -1 )
			{
				playRound( 0 );
			}
		}
		
		private function playRound( time:uint ): void
		{

			//_players.splice( 0, 0, {userID: _userID, cards: _cards}  );
			trace( _players[0].points[0] );
			var order : Array = [-1];
			for (var i:int = 0; i < _players.length; i++) 
			{
				if( _players[i].points[time] > order[i] )
				{
					order.splice( 0, 0, i );
				}
				
				trace( _players[i].points[0] );
			}
			

			
			trace(' order all:', order );
			
			trace( 'order:', order.length, _players[ order[0] ] ); 
			order.pop();
			trace( 'order2:', order.length,  _players[ order[1] ] ); 
			
			switch( _players[ order[0] ].types[time] )
			{
				case GameSettings.BACK_UP:
					trace(' back up' ); 
					_robots[order[0]].move( -1 );
					break;
				
				case GameSettings.MOVE_ONE:
					trace(' move 1' );
					_robots[order[0]].move( 1 );
					
					break;
				
				case GameSettings.MOVE_TWO:
					_robots[order[0]].move( 2 );
					trace(' move 2' );
					
					break;
				
				case GameSettings.MOVE_THREE:
					trace(' move 3' );
					_robots[order[0]].move( 3 );
					
					
					break;
				
				case GameSettings.TURN_LEFT:
					_robots[0].rotate( -1 );					
					break;
				
				case GameSettings.TURN_RIGHT:
					_robots[0].rotate( 1 );					
					break;
				
				case GameSettings.U_TURN:
					
					break;
			}
		}
		
		
		private function onComplete_startGame( e:Event ): void
		{
			_numCard = 9;		
			_camera.setWorld( _world );
			
			/*var orderIdx : uint = _robots.length - (1 + _userOrder);

			_robots[ _userOrder ].x = _levelLoader.startPositions[ _userOrder ].x;
			_robots[ _userOrder ].y = _levelLoader.startPositions[ _userOrder ].y;
			
			_robots[ orderIdx ].x = _levelLoader.startPositions[ orderIdx ].x;
			_robots[ orderIdx ].y = _levelLoader.startPositions[ orderIdx ].y;
*/			
			for (var i:int = 0; i < _robots.length; i++) 
			{
				_robots[ i ].x = _levelLoader.startPositions[ i ].x;
				_robots[ i ].y = _levelLoader.startPositions[ i ].y;
				_world.addChild( _robots[ i ] );
				
			}
			
			
			/*_world.addChild( _robots[ orderIdx ] );
			_world.addChild( _robots[ _userOrder ] );*/
			
			
			_world.addEventListener(MouseEvent.CLICK, onClick_add);
			_gameMenuGfx.addEventListener(MouseEvent.CLICK, onClick_remove);
			
			addCards();

		}
		
		private function onClick_add( e:MouseEvent ): void
		{
			_gameMenuGfx.addWarning();
		}
		private function onClick_remove( e:MouseEvent ): void
		{
			_gameMenuGfx.removeWarning();
		}
		
		
		private function addCards(): void
		{
			_cardBanner.x = GameSettings.STAGE_W;
			_cardBanner.y = 515;
			addChild( _cardBanner );
			_cardBanner.dealCards( _numCard );
			TweenLite.to( _cardBanner, 1, {x: 0, delay: 1} );
			
			_cardBanner.addEventListener(GameEvent.TIMES_UP, onTimesUp_tweenCardBanner);
			
		}
		
		private function onTimesUp_tweenCardBanner( e:GameEvent ): void
		{
			TweenLite.to( _cardBanner, 1, {x: GameSettings.STAGE_W, delay: 1, onComplete: addChoosenCards});		
		}
		
		private function addChoosenCards(): void
		{
			_players = [];
			_cards = SpritePool.getChoosenCards();
			
			var points : Array = []; 
			var types : Array = []; 
			
			for (var i:int = 0; i < _cards.length; i++) 
			{
				_cards[i].x = 110 * i + 133;
				_cards[i].y = 590;
				_cards[i].alpha = 0;
				addChild( _cards[i] );
				
				points.push( _cards[i].point );
				types.push( _cards[i].type );
			}
			
			TweenMax.allTo( _cards, .2, {alpha: 1}, .3);
			_players.push( {userID: _userID, points: points, types: types} );
			trace( 'current number of players:',_players.length );
			ConnectionManager.sendData( {userID: _userID, points: points, types: types} );
		}
		
		private function addRobot( robotID:uint, userID:String ): RobotBase
		{
			var robot : RobotBase;
			switch( robotID )
			{
				case GameSettings.BULL:
					robot = new BullRobot( userID );
					break;
				
				case GameSettings.GIRAFFE:
					robot = new GiraffeRobot( userID );
					break;
				
				case GameSettings.WHEELIE:
					robot = new WheelieRobot( userID );
					break;
			}
			return robot;
		}
		
		
		private function onLoop( e:Event ): void
		{
			for (var i:int = 0; i < _robots.length; i++) 
			{
				_robots[i].update();
			}
			
			_camera.update();
		}
	}
	
}