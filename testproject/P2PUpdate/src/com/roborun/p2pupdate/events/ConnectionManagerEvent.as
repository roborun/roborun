package com.roborun.p2pupdate.events
{
	import flash.events.Event;
	
	/**
	 * Dispatched when message is received
	 *                                    
	 *  - set message
	 * 	- get message
	 * 
	 * 
	 * @author Anton Strand
	 **/
	
	public class ConnectionManagerEvent extends Event
	{
		public static const CONNECTED	:String = 'connected';
		public static const MESSAGE_RECEIVED	:String = 'messageReceived';
		
		private var _message : Object;
		
		public function ConnectionManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_message = {};
		}
		
		public function set message( p_message:Object ): void
		{
			_message = p_message;
		}
		
		public function get message(): Object
		{
			return _message;
		}
	}
}