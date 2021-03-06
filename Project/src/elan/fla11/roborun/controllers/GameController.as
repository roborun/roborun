package elan.fla11.roborun.controllers
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.reyco1.multiuser.data.UserObject;
	
	import elan.fla11.roborun.ChatBtnGfx;
	import elan.fla11.roborun.Embeder;
	import elan.fla11.roborun.InfoBtnGfx;
	import elan.fla11.roborun.ResultScreen;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.events.ConnectionEvent;
	import elan.fla11.roborun.events.GameEvent;
	import elan.fla11.roborun.events.StartEvent;
	import elan.fla11.roborun.models.LevelData;
	import elan.fla11.roborun.models.LevelModel;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.sound.Sounds;
	import elan.fla11.roborun.utils.ConnectionManager;
	import elan.fla11.roborun.utils.KeyboardManager;
	import elan.fla11.roborun.utils.LevelCamera;
	import elan.fla11.roborun.utils.LevelLoader;
	import elan.fla11.roborun.utils.SoundManager;
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
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
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
		
		private var _user				:UserObject;	
		private var _userID				:String;
		private var _userDetails		:Object;
		private var _userOrder			:uint;

		private var _coUserOrder		:uint;
		
		private var _players			:Array;
		
		private var _chatPage			:ChatPage;
		private var _chatBtn			:ChatBtnGfx;
		private var _infoBtn			:InfoBtnGfx;
		private var _isChatOpen			:Boolean;
		
		private var _gameObject			:Object;
		private var _order				:Array;
		private var _roundCount			:uint;
		private var _orderIdx			:uint;
		private var _levelFunctionCount :uint;
		
		private var _listeners			:Boolean;

		
		public function GameController()
		{
			init();
		}
		
		private function init(): void
		{
			_robots = new Vector.<RobotBase>();
			
			_players = [0,1];
			_cards = [];
			_levelLoader = new LevelLoader();
			_camera = new LevelCamera();
			
			_cardBanner = new CardBanner();
			
			_gameMenuGfx = new GameBackground();
			_gameMenuGfx.addEventListener(GameEvent.DEAD, onAllLifesGone_dispatchGameOvet);
			addChild( _gameMenuGfx );
			
			_world = new Sprite();
			addChild( _world );

			initButtons();
			
			ConnectionManager.dispatcher.addEventListener(ConnectionEvent.CONNECTED, onConnected_initNewGame);
		}
		
		private function initButtons(): void
		{
			_infoBtn = new InfoBtnGfx;
			_infoBtn.x = 768;
			_infoBtn.y = 615;
			addChild(_infoBtn);

			_chatBtn = new ChatBtnGfx;
			_chatBtn.x = 879;
			_chatBtn.y = 615;
			_chatBtn.gotoAndStop( 0 );
			addChild(_chatBtn);		
			
			_chatPage = new ChatPage();
		}
		
		private function handleInfoBtnClicked(evt:MouseEvent = null):void
		{
			navigateToURL(new URLRequest(GameSettings.INSTRUCTIONS_URL), '_blank');
			SoundManager.playSound(Sounds.BUTTON, .1);
		}
		
		
		private function initButtonListeners():void
		{
			_listeners = true;
			_infoBtn.addEventListener(MouseEvent.CLICK, handleInfoBtnClicked);
			_chatBtn.addEventListener(MouseEvent.CLICK, handleChatBtnClicked);
			GameSettings.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_chatPage.addEventListener(ConnectionEvent.MESSAGE_RECEIVED, onChatChange_playChatBtn);
			_chatPage.addEventListener(ButtonEvent.CLOSE, handleChatCloseBtnClicked);
		}
		
		private function onKeyDown( e:KeyboardEvent ): void
		{
			trace( ' keydown ', e.keyCode, e.keyCode == Keyboard.C );
			switch( e.keyCode )
			{
				case Keyboard.C:
					if( !_isChatOpen ) handleChatBtnClicked();
					break;
				
				case Keyboard.I:
					if( !_isChatOpen ) handleInfoBtnClicked();
					
			}
		}
		
		private function onChatChange_playChatBtn( e:Event ): void
		{
			SoundManager.playSound(Sounds.CHAT, .02);
			_chatBtn.play();
		}
		
		private function handleChatBtnClicked(evt:MouseEvent = null):void
		{
			SoundManager.playSound(Sounds.BUTTON, .1);
			if( _camera != null ) _camera.deactivate();
			_chatBtn.gotoAndStop( 0 );
			addChild(_chatPage);
			_chatPage.activateEnter();
			_isChatOpen = true;
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
			_user = e.user;
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
			
			_coUserOrder = e.user.details.playerOrder;
			
			// Joining player
			if( e.user.details.level != undefined)
			{
				_levelLoader.loadLevel( LevelModel.levels[e.user.details.level].source );
				_robots.push( addRobot( e.user.details.robot, e.user ) );
				_robots.push( addRobot( _userDetails.robot, _user ) );
			}
			// Host player
			else
			{
				_levelLoader.loadLevel( LevelModel.levels[_userDetails.level].source );
				_robots.push( addRobot( _userDetails.robot, _user ) );
				_robots.push( addRobot( e.user.details.robot, e.user ) );
			}
			
			_levelLoader.addEventListener(Event.COMPLETE, onComplete_startGame);
			_level = _levelLoader.level;
			_world.addChild( _level );		
			
		}
		
		private function onDataReceived_playRound( e:ConnectionEvent ): void
		{
			if(_listeners == false)
				initButtonListeners();
			
			if( e.gameData.victory == undefined )
			{
				_players[ _coUserOrder ] = e.gameData;
			
				_roundCount = 0;
				_orderIdx = 0;
				playRound();			
			}
			else if( e.gameData.victory == false )
			{
				gameOver_restult( _robots[_coUserOrder].userDetails.name+' is dead. Victory is yours!' );
			}
		}
		
		private function playRound(): void
		{
			
			if( _players[ _userOrder ].points[ _roundCount ] >= _players[ _coUserOrder ].points[ _roundCount ] )
			{
				_order = [ _userOrder, _coUserOrder ]; 
			}
			
			else if( _players[ _userOrder ].points[ _roundCount ] < _players[ _coUserOrder ].points[ _roundCount ] )
			{
				_order = [ _coUserOrder, _userOrder ]; 
			}

			if( _roundCount < 5 )
			{
				movePlayer();
			}
			else
			{
				addCards();
			}
			
		}
		
		private function movePlayer(): void
		{
			switch( _players[ _order[_orderIdx] ].types[_roundCount] )
			{
				case GameSettings.BACK_UP:
					trace(' back up' ); 
					_robots[_order[_orderIdx]].move( -1 );
					break;
				
				case GameSettings.MOVE_ONE:
					trace(' move 1' );
					_robots[_order[_orderIdx]].move( 1 );
					
					break;
				
				case GameSettings.MOVE_TWO:
					_robots[_order[_orderIdx]].move( 2 );
					trace(' move 2' );	
					break;
				
				case GameSettings.MOVE_THREE:
					trace(' move 3' );
					_robots[_order[_orderIdx]].move( 3 );
					break;
				
				case GameSettings.TURN_LEFT:
					trace(' rotate left');
					_robots[_order[_orderIdx]].rotate( -90 );					
					break;
				
				case GameSettings.TURN_RIGHT:
					trace(' rotate right');
					_robots[_order[_orderIdx]].rotate( 90 );					
					break;
				
				case GameSettings.U_TURN:
					trace(' u turn');
					_robots[_order[_orderIdx]].rotate( 180 );					
					break;
			}
			
			_robots[_order[_orderIdx]].addEventListener(GameEvent.MOVED, onRobotMoved);		
		}
		
		private function onRobotMoved( e:GameEvent ): void
		{
			_robots[_order[_orderIdx]].removeEventListener(GameEvent.MOVED, onRobotMoved);
			if( _orderIdx < 1 )
			{
				_orderIdx++;
				movePlayer();
			}
			else
			{
				_levelFunctionCount = 0;
				for (var i:int = 0; i < _robots.length; i++) 
				{
					_robots[i].checkLevelFunctions();
					_robots[i].addEventListener(GameEvent.LEVEL_FUNCTIONS, onLevelFunctionComplete);
				}

				for (var j:int = 0; j < _levelLoader.levelObjects.length; j++) 
				{
					_levelLoader.levelObjects[j].activate();
				}
			}
		}
		
		private function onLevelFunctionComplete( e:GameEvent ): void
		{
			trace( ' level functions complete');
			_levelFunctionCount++;
			
			if( _levelFunctionCount > 1 )
			{
				removeChild( _cards[ _roundCount ] );
				SpritePool.returnCard( _cards[ _roundCount  ] );
				_roundCount++;
				_orderIdx = 0;
				playRound();				
			}
		}
		
		private function onComplete_startGame( e:Event ): void
		{
			_numCard = 9;		
			_camera.setWorld( _world );
					
			for (var i:int = 0; i < 2; i++) 
			{
				_robots[ i ].x = _levelLoader.startPositions[ i ].x;
				_robots[ i ].y = _levelLoader.startPositions[ i ].y;
				_robots[ i ].setStartPos();
				_robots[ i ].addEventListener(GameEvent.ON_FLAG, handleRobotOnFlag_checkIfTaken);
				_robots[ i ].addEventListener(GameEvent.DEAD, onRobotDie);
				_world.addChild( _robots[ i ] );		
			}

			//_world.addEventListener(MouseEvent.CLICK, onClick_add);
			//_gameMenuGfx.addEventListener(MouseEvent.CLICK, onClick_remove);
			
			addCards();

		}
		
		/*private function onClick_add( e:MouseEvent ): void
		{
			_gameMenuGfx.addWarning();
		}
		private function onClick_remove( e:MouseEvent ): void
		{
			_gameMenuGfx.removeWarning();
		}*/
		
		
		private function addCards(): void
		{
			_cardBanner.x = GameSettings.STAGE_W;
			_cardBanner.y = 515;
			addChild( _cardBanner );
			_cardBanner.dealCards( _numCard );
			TweenLite.to( _cardBanner, 1, {x: 0, delay: 1, onStart:playSound} );
			
			_cardBanner.addEventListener(GameEvent.TIMES_UP, onTimesUp_tweenCardBanner);
			
		}
		
		private function playSound():void
		{
			SoundManager.playSound(Sounds.CARD_BANNER, .2);
		}
		private function onTimesUp_tweenCardBanner( e:GameEvent ): void
		{
			TweenLite.to( _cardBanner, 1, {x: GameSettings.STAGE_W, delay: 1, onStart:playSound, onComplete: addChoosenCards});		
		}
		
		private function addChoosenCards(): void
		{
			_cards = SpritePool.getChoosenCards();
			
			trace( ' num of cards:', _cards.length );
			
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
			_gameObject = {userID: _userID, points: points, types: types};
			_players[ _userOrder ] = _gameObject;
			trace( 'current number of players:',_players.length );
						
			
			TweenMax.allTo( _cards, .2, {alpha: 1}, .3, onComplete_sendGameObject);
			
		}
		
		private function onComplete_sendGameObject(): void
		{
			ConnectionManager.sendData( _gameObject );
		}
		
		private function addRobot( robotID:uint, userDetails:Object ): RobotBase
		{
			var robot : RobotBase;
			switch( robotID )
			{
				case GameSettings.BULL:
					robot = new BullRobot( userDetails );
					break;
				
				case GameSettings.GIRAFFE:
					robot = new GiraffeRobot( userDetails );
					break;
				
				case GameSettings.WHEELIE:
					robot = new WheelieRobot( userDetails );
					break;
			}
			return robot;
		}
		
		
		private function handleRobotOnFlag_checkIfTaken( e:GameEvent ): void
		{
			var cur_robot : RobotBase = RobotBase( e.target );
			
			_gameMenuGfx.removeWarning();
			
			if( _levelLoader.flagPositions[ cur_robot.takenFlags ].x == cur_robot.x &&
				_levelLoader.flagPositions[ cur_robot.takenFlags ].y == cur_robot.y )
			{
				cur_robot.takenFlags++;
				cur_robot.setCheckPoint();
				trace( 'FLAG TAKEN' );
				
				if( _levelLoader.flagPositions.length == cur_robot.takenFlags )
				{		
					if( _robots[_userOrder].userDetails.id == cur_robot.userDetails.id )
					{
						gameOver_restult( 'Congratulations, you won!' );  	
						ConnectionManager.sendData( {victory: true} );
					}
					else
					{
						gameOver_restult( 'Too bad, you lost!' );  											
					}
				}
			}	
		}
		
		private function onRobotDie( e:GameEvent ): void
		{
			var cur_robot : RobotBase = RobotBase( e.target );
			
			trace( cur_robot.userDetails.name, 'died' );
			
			if( _userID == cur_robot.userDetails.id )
			{
				_gameMenuGfx.die();
			}
		
			cur_robot.gotoCheckPoint();
		}
		
		private function onAllLifesGone_dispatchGameOvet( e:GameEvent ): void
		{
			gameOver_restult( 'You lost! Next time, do like the Bee Gees and stay alive!' );
		}
		
		private function gameOver_restult( text:String ): void
		{
			var resultScreen : ResultScreen = new ResultScreen();
			addChild( resultScreen );
			resultScreen.mouseChildren = false;
			resultScreen.textfield.text = text;  					
			
			removeEventListener(Event.ENTER_FRAME, onLoop);
			_gameMenuGfx.removeEventListener(GameEvent.DEAD, onAllLifesGone_dispatchGameOvet);
			for (var i:int = 0; i < _robots.length; i++) 
			{
				_robots[i].removeEventListener(GameEvent.MOVED, onRobotMoved);
				_robots[i].removeEventListener(GameEvent.LEVEL_FUNCTIONS, onLevelFunctionComplete);
			}
			
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