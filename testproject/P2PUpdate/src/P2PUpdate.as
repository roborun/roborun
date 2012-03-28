package
{
	import com.roborun.p2pupdate.RobotConstants;
	import com.roborun.p2pupdate.events.ConnectionManagerEvent;
	import com.roborun.p2pupdate.utils.ConnectionManager;
	import com.roborun.p2pupdate.utils.LevelCreator;
	import com.roborun.p2pupdate.views.Robot;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width="1024", height="768")]
	public class P2PUpdate extends Sprite
	{
		private var _levelCreator	:LevelCreator;	
		private var _player			:Sprite;
		
		private var _message		:Object;
		
		private var _players		:Vector.<Robot>;
		private var _playerCount	:uint;
		private var _cur_player_idx	:uint;
		
		public function P2PUpdate()
		{
			init();
		}
		
		private function init(): void
		{
			ConnectionManager.connect();
			
			_message = {};
			_players = new Vector.<Robot>();
			
			_levelCreator = new LevelCreator();
			addChild( _levelCreator.level );
			
			//initPlayer();
			
			addEventListener(MouseEvent.CLICK, onClick_movePlayer);
			
			ConnectionManager.eventDispatcher.addEventListener(ConnectionManagerEvent.CONNECTED, startGame);
			ConnectionManager.eventDispatcher.addEventListener(ConnectionManagerEvent.MESSAGE_RECEIVED, onMessageReceived_movePlayer);
			
		
			
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
		}
		
		
		private function onLoop_update( e:Event ): void
		{
			
			_players[ _cur_player_idx ].x = _message.xpos * 50;	
			_players[ _cur_player_idx ].y = _message.ypos * 50;	
		}
		
		private function onClick_movePlayer( e:MouseEvent ): void
		{
			var message : Object = {};
			
			//message.xpos = _players[ _cur_player_idx ].x + 100;
			message.xpos = uint(mouseX/50);
			message.ypos = uint(mouseY/50);
			message.rotate = 'none';
			
			ConnectionManager.sendMessage( message );
		}
		
		
		private function initPlayer(): void
		{
			
			_players.push( new Robot( _message.sender ) );
			addChild( _players[ _playerCount ] );
			_playerCount++;
			
			trace('player count:', _playerCount );
		}
	}
}