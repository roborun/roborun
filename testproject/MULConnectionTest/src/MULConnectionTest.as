package
{
	import com.reyco1.multiuser.MultiUserSession;
	import com.reyco1.multiuser.data.UserObject;
	import com.reyco1.multiuser.debug.Logger;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	[SWF(frameRate="60", height="480", width="700")]
	public class MULConnectionTest extends Sprite
	{
		private const DEV_SERVER	:String = 'rtmfp://p2p.rtmfp.net/c91a99ad1324c2e48ea04c05-6647b9ba2efd/';
		
		private var _connection 	:MultiUserSession;
		private var _cursors		:Object = {};
		private var _userName		:String;
		private var _userId			:String;
		private var _color			:uint;
		
		public function MULConnectionTest()
		{
			Logger.LEVEL = Logger.LEVEL;
			initialize();
		}
		
		private function initialize(): void
		{
			_connection = new MultiUserSession(DEV_SERVER);
			_connection.onConnect = onConnect;
			_connection.onUserAdded = onUserAdded;
			_connection.onUserRemoved = onUserDeleted;
			_connection.onObjectRecieve = onGetObject;
			
			trace( 'init :', _connection.userCount );
			
			_userName = 'user_' + String( uint( Math.random()*100 ));
			_color = Math.random()* 0xFFFFFF;
			
			 _connection.connect( _userName, {color: _color} );
			
		}
		
		private function onConnect( user : UserObject ): void
		{

			Logger.log("I'm connected "+ user.name + ' id '+ user.id +", total "+ _connection.userCount);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, sendMyData);
			
			_userId = user.id;
			_cursors[_userId] = new CursorSprite( user.name, user.details.color);
			addChild( _cursors[_userId] );	
		
		}
		
		private function onUserAdded( user : UserObject ): void
		{
			Logger.log("User added: " + user.name + ", total users: " + _connection.userCount);
			_cursors[user.id] = new CursorSprite( user.name, user.details.color);
			addChild( _cursors[user.id] );

			if( _connection.userCount > 2 ) deleteUser( user ); 
			
			sendMyData();	
		}
		
		private function deleteUser( user : UserObject ): void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, sendMyData);
			onUserDeleted( user );
		}
		
		private function onUserDeleted( user : UserObject ): void
		{
			Logger.log("User disconnected: " + user.name + ", total users: " + _connection.userCount);
			if( _cursors[ user.id ] != null )
			{
			removeChild( _cursors[user.id] );  
			delete _cursors[user.id];
			}
		}
		
		private function sendMyData( e:MouseEvent = null ): void
		{
			_connection.sendObject( {x: mouseX, y: mouseY } );
			_cursors[ _userId ].x = mouseX;
			_cursors[ _userId ].y = mouseY;		
		}
		
		private function onGetObject( peerId :String, data:Object ): void
		{
			if( _cursors[ peerId ] != null )
			_cursors[ peerId ].update( data.x, data.y );
			
		}
	}
}