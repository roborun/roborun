package elan.fla11.roborun.events
{
	import flash.events.Event;
	
	public class LvlsCompleteEvent extends Event
	{
		
		public static const lvlsLoaded		:String = 'Lvls_are_loaded';
		
		public function LvlsCompleteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}