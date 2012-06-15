package elan.fla11.roborun.events
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		public static const POWER_DOWN		:String = 'powerDown';
		public static const DEAD			:String = 'dead';
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}