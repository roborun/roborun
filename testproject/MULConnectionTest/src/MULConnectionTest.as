package
{
	import com.reyco1.multiuser.MultiUserSession;
	import com.reyco1.multiuser.data.UserObject;
	import com.reyco1.multiuser.debug.Logger;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	[SWF(frameRate="60", height="480", width="700")]
	public class MULConnectionTest extends Sprite
	{
		private const DEV_SERVER	:String = 'rtmfp://p2p.rtmfp.net/c91a99ad1324c2e48ea04c05-6647b9ba2efd/';
		
		private var _connection 	:MultiUserSession;
		private var _cursors		:Object = {};
		private var _userName		:String;
		private var _userId			:String;
		private var _color			:uint;
		private var _group_tf		:TextField;
		private var _button:Sprite;
		
		public function MULConnectionTest()
		{
			Logger.LEVEL = Logger.LEVEL;
			setGroupName();
		}
		
		private function setGroupName(): void
		{
			_group_tf = new TextField();
			_group_tf.type = TextFieldType.INPUT;
			_group_tf.border = true;
			addChild( _group_tf );
			
			_button = new Sprite();
			_button.graphics.beginFill( 0 );
			_button.graphics.drawCircle(100, 100, 10);
			addChild( _button );
			
			_button.addEventListener(MouseEvent.CLICK, initialize);
		}
		
		private function initialize( e:MouseEvent ): void
		{
			var groupName : String = _group_tf.text;
			
			_connection = new MultiUserSession(DEV_SERVER, groupName);
			_connection.onConnect = onConnect;
			_connection.onUserAdded = onUserAdded;
			_connection.onUserRemoved = onUserDeleted;
			_connection.onObjectRecieve = onGetObject;
			
			trace( 'init :', _connection.userCount );
			
			_userName = 'user_' + String( uint( Math.random()*100 ));
			_color = Math.random()* 0xFFFFFF;
			
			 _connection.connect( _userName, {color: _color} );
			 
			 removeChild( _group_tf );
			 removeChild( _button );
			
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