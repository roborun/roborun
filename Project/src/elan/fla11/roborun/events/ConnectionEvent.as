package elan.fla11.roborun.events
{
	import com.reyco1.multiuser.data.UserObject;
	
	import flash.events.Event;
	
	public class ConnectionEvent extends Event
	{
		public static const CONNECTED			:String = 'connected';
		public static const USER_ADDED			:String = 'userAdded';
		public static const USER_REMOVED		:String = 'userRemoved';
		public static const DATA_RECEIVED		:String = 'dataReceived';
		public static const MESSAGE_RECEIVED	:String = 'messageReceived';
		
		
		public var user 				:UserObject;
		public var peerID				:String;
		public var gameData				:Object;
		public var message				:String;
		
		public function ConnectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}