package elan.fla11.roborun.events
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		public static const POWER_DOWN		:String = 'powerDown';
		public static const DEAD			:String = 'dead';
		public static const ON_FLAG			:String = 'dead';
		public static const TIMES_UP		:String = 'timesUp';
		public static const MOVED			:String = 'moved';
		public static const LEVEL_FUNCTIONS :String = 'levelFunctions';
		public static const ON_FLAG			 :String = 'onFlag';
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}