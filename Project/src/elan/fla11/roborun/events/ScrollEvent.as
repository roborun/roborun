package elan.fla11.roborun.events
{
	import flash.events.Event;
	
	public class ScrollEvent extends Event
	{
		public static const SCROLLING:String = "scrolling";
		
		public function ScrollEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new ScrollEvent(type, bubbles, cancelable);
		}
	}
}