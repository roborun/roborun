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
		
		
		/**
		 * infomation about the user
		 **/
		public var user 				:UserObject;
		
		/**
		 * Used as userID. Unique for all players
		 **/
		public var peerID				:String;
		
		/**
		 * infomation about the other players moves
		 **/
		public var gameData				:Object;
		
		/**
		 * The message
		 **/
		public var message				:String;
		
		
		/**
		 * Number of connected users
		 **/
		public var userCount			:uint;
		
		/**
		 * List of all users UserObject
		 **/
		public var userArray			:Array;
		
		public function ConnectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}