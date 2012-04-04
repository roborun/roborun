package
{
	import com.roborun.p2pupdate.RobotConstants;
	import com.roborun.p2pupdate.events.ConnectionManagerEvent;
	import com.roborun.p2pupdate.utils.ConnectionManager;
	import com.roborun.p2pupdate.utils.LevelCreator;
	import com.roborun.p2pupdate.views.Card;
	import com.roborun.p2pupdate.views.Robot;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	[SWF(width="1024", height="768")]
	public class P2PUpdate extends Sprite
	{
		private var _levelCreator	:LevelCreator;	
		private var _player			:Sprite;
		
		private var _message		:Object;
		
		private var _players		:Vector.<Robot>;
		private var _playerCount	:uint;
		private var _cur_player_idx	:uint;
		private var _prevPos		:Point;
		
		private var _cardHolder		:Sprite;
		
		public function P2PUpdate()
		{
			init();
		}
		
		private function init(): void
		{
			ConnectionManager.connect();
			
			_message = {};
			_players = new Vector.<Robot>();
			_prevPos = new Point();
			
			_levelCreator = new LevelCreator();
			addChild( _levelCreator.level );
			
			addEventListener(MouseEvent.CLICK, onClick_movePlayer);
			
			ConnectionManager.eventDispatcher.addEventListener(ConnectionManagerEvent.CONNECTED, startGame);
			ConnectionManager.eventDispatcher.addEventListener(ConnectionManagerEvent.MESSAGE_RECEIVED, onMessageReceived_movePlayer);
			
			addCards();
			
		}
		
		private function addCards(): void
		{
			_cardHolder = new Sprite();
			
			for (var i:uint = 0; i < 5; i++) 
			{
				var card : Card = new Card();
				card.x = i * (card.width +20);
				_cardHolder.addChild( card );
			}
			
			_cardHolder.y = 570;
			_cardHolder.x = 100;
			addChild( _cardHolder );
			
		}
		
		private function startGame( e:Event ): void
		{
			//ConnectionManager.eventDispatcher.removeEventListener(ConnectionManagerEvent.CONNECTED, startGame);
			trace( 'Start Game' );
			var m : Object = {};
			
			m.type = RobotConstants.NEW_ROBOT;
			
			ConnectionManager.sendMessage( m );
		}
		
		private function onMessageReceived_movePlayer( e:ConnectionManagerEvent ): void
		{
			_message = e.message;
			
			var exist : Boolean;
			trace( 'trace', e.message.type, e.message.sender);
			
			for (var i:uint = 0; i < _players.length; i++) 
			{
				if( _players[i].id == _message.sender )
				{
					_cur_player_idx = i;
					exist = true;
					trace(i);
				
				}
			}
			
			// Om en ny spelare har connectat och hans spelare inte existerar ska en ny robot skapas.
			if( _message.type == RobotConstants.NEW_ROBOT && !exist)
			{
				initPlayer();	
				addEventListener(Event.ENTER_FRAME, onLoop_update);
			}
			
			_prevPos.x = _players[ _cur_player_idx ].x;
			_prevPos.y = _players[ _cur_player_idx ].y;
			_players[ _cur_player_idx ].rotate = _message.rotate;
		}
		
		private function onLoop_update( e:Event ): void
		{
			if( _message.xpos != 0 )
			{
				if( _message.xpos < 0 && _players[ _cur_player_idx ].x > ( _prevPos.x + _message.xpos * 50 ))
				{
					if( _levelCreator.levelDesign[ _players[ _cur_player_idx ].y / 50 ][ _players[ _cur_player_idx ].x / 50 - 1 ] != 1 )
					{
						_players[ _cur_player_idx ].moveX = -5;					
					}
				}

				if( _message.xpos > 0 && _players[ _cur_player_idx ].x < ( _prevPos.x + _message.xpos * 50 ))
				{
					if( _levelCreator.levelDesign[ _players[ _cur_player_idx ].y / 50 ][ _players[ _cur_player_idx ].x / 50 + 1 ] != 1 )
					{
						_players[ _cur_player_idx ].moveX = 5;					
					}
				}
			}

			if( _message.ypos != 0 )
			{
				if( _message.ypos < 0 && _players[ _cur_player_idx ].y > ( _prevPos.y + _message.ypos * 50 ))
				{
					if( _levelCreator.levelDesign[ Math.ceil(_players[ _cur_player_idx ].y / 50 -1 )][uint( _players[ _cur_player_idx ].x / 50 )] != 1 )
					{
						_players[ _cur_player_idx ].moveY = -5;
					}
				}

				if( _message.ypos > 0 && _players[ _cur_player_idx ].y < ( _prevPos.y + _message.ypos * 50 ))
				{
					if( _levelCreator.levelDesign[ Math.floor(_players[ _cur_player_idx ].y / 50 + 1 )][uint( _players[ _cur_player_idx ].x / 50 )] != 1 )
					{
						_players[ _cur_player_idx ].moveY = 5; 
					}
				}
			}
		}
		
		private function onClick_movePlayer( e:MouseEvent ): void
		{
			trace( e.target );
			
			var targetCard : Card = Card( e.target );
			
			var message : Object = {};
			
			message.cardType = targetCard.type;
			
			if( _players[ _cur_player_idx ].robotRotation == 90 )
			{
				message.ypos = targetCard.steps;
			}

			else if( _players[ _cur_player_idx ].robotRotation == 270 || _players[ _cur_player_idx ].robotRotation == -90 )
			{
				message.ypos = -targetCard.steps;
			}

			else if( _players[ _cur_player_idx ].robotRotation == 0 )
			{
				message.xpos = targetCard.steps;
			}

			else if( _players[ _cur_player_idx ].robotRotation == -180 || _players[ _cur_player_idx ].robotRotation == 180 )
			{
				message.xpos = -targetCard.steps;
			}
			
			
			message.rotate = targetCard.cardRotation;
			
			ConnectionManager.sendMessage( message );
		}
		
		
		private function initPlayer(): void
		{
			
			_players.push( new Robot( _message.sender ) );
			
			_players[ _playerCount ].x = 50;
			_players[ _playerCount ].y = 50;
			
			addChild( _players[ _playerCount ] );
			_playerCount++;
			
			trace('player count:', _playerCount );
		}
	}
}