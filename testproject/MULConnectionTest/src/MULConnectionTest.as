package
{
	import com.reyco1.multiuser.MultiUserSession;
	import com.reyco1.multiuser.data.UserObject;
	import com.reyco1.multiuser.debug.Logger;
	
	import flash.display.Sprite;
	
	[SWF(frameRate="60", height="480", width="700")]
	public class MULConnectionTest extends Sprite
	{
		private const DEV_SERVER	:String = 'rtmfp://p2p.rtmfp.net/c91a99ad1324c2e48ea04c05-6647b9ba2efd/';
		
		private var _connection 	:MultiUserSession;
		private var _cursors		:Object;
		private var _userName		:String;
		private var _color			:uint;
		
		public function MULConnectionTest()
		{
			Logger.LEVEL = Logger.OWN;	
		}
		
		private function initialize(): void
		{
			_cursors = {};
			_connection = new MultiUserSession(DEV_SERVER);
			_connection.onConnect = onConnect;
		}
		
		private function onConnect( user : UserObject ): void
		{
			
		}
	}
}