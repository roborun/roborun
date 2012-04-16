package elan.fla11.roborun.utils
{
	import com.reyco1.multiuser.MultiUserSession;
	import com.reyco1.multiuser.data.UserObject;
	
	import elan.fla11.roborun.events.ConnectionEvent;
	
	import flash.events.EventDispatcher;

	/**
	 * ConnectionManager [STATIC] 
	 * 
	 * Send in groupName and userDetails (Object) to connect to an allready existing group or to create a new group.
	 * 
	 * @author Anton Strand.
	 **/
	
	public class ConnectionManager
	{
		private static const DEV_SERVER		:String = 'rtmfp://p2p.rtmfp.net/c91a99ad1324c2e48ea04c05-6647b9ba2efd/';
		
		private static var _dispatcher 		:EventDispatcher;
		private static var _isInitialized	:Boolean;
		
		private static var _connection 		:MultiUserSession;
		
		public function ConnectionManager()
		{
		}
		
		private static function initialize(): void
		{
			if( !_isInitialized )
			{
				_dispatcher = new EventDispatcher();
				_isInitialized = true;
			}
		}
		
		/**
		 * Connect by sending in groupName (String)  and userDetails (Object).
		 **/
		public static function connect( groupName:String, userDetails:Object ): void
		{
			initialize();
			_connection = new MultiUserSession( DEV_SERVER, groupName );
			_connection.onConnect = onConnect;
			_connection.onUserAdded = onUserAdded;
			_connection.onObjectRecieve = onReceivingObject;
			_connection.onChatMessage = onReceivingMessage;
		}
		
		/**
		 * Send game data to the other players
		 **/
		public static function sendData( gameData : Object ): void
		{
			_connection.sendObject( gameData );
		}
		
		/**
		 * Send a message to specific player
		 **/
		public static function sendChatMessage( message : String, targetUser : UserObject ): void
		{
			_connection.sendChatMessage( message, targetUser );
		}
		
		private static function onConnect( user : UserObject ): void
		{
			var event : ConnectionEvent = new ConnectionEvent( ConnectionEvent.CONNECTED );
			event.user = user;
			
			_dispatcher.dispatchEvent( event );
		}

		private static function onUserAdded( user : UserObject ): void
		{
			var event : ConnectionEvent = new ConnectionEvent( ConnectionEvent.USER_ADDED );
			event.user = user;
			
			_dispatcher.dispatchEvent( event );
		}
		
		private static function onReceivingObject( peerID:String, gameData:Object ): void
		{
			var event : ConnectionEvent = new ConnectionEvent( ConnectionEvent.DATA_RECEIVED );
			event.peerID = peerID;
			event.gameData = gameData;
			
			_dispatcher.dispatchEvent( event );
		}

		private static function onReceivingMessage( message:String ): void
		{
			var event : ConnectionEvent = new ConnectionEvent( ConnectionEvent.MESSAGE_RECEIVED );
			event.message = message;
			
			_dispatcher.dispatchEvent( event );
		}
		
		/**
		 * Listen to the dispatcher to hear ConnectionEvents. 
		 * E.g. ConnectionManager.dispatcher.addEventListener(ConnectionEvent.CONNECT, onConnect);
		 **/
		public static function get dispatcher(): EventDispatcher
		{
			return _dispatcher;
		}
	}
}