package elan.fla11.roborun.events
{
	import flash.events.Event;
	
	public class StartEvent extends Event
	{
		public static const START_GAME	:String = 'startGame';
		public var groupName			:String;
		public var userDetails			:Object;
		public var levelId				:uint;
		
		public function StartEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}