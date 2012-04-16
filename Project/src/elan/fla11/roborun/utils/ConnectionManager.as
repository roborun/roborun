package elan.fla11.roborun.utils
{
	import com.reyco1.multiuser.MultiUserSession;

	/**
	 * ConnectionManager [STATIC] 
	 * 
	 * Send in groupName and userDetails (Object) to connect to an allready existing group or to create a new group.
	 * 
	 * @author Anton Strand.
	 **/
	
	public class ConnectionManager
	{
		private static const DEV_SERVER	:String = 'rtmfp://p2p.rtmfp.net/c91a99ad1324c2e48ea04c05-6647b9ba2efd/';
		
		private static var _connection 	:MultiUserSession;
		
		public function ConnectionManager()
		{
		}
		
		public static function connect( groupName:String, userDetails:Object ): void
		{
			_connection = new MultiUserSession( DEV_SERVER, groupName );
		}
	}
}