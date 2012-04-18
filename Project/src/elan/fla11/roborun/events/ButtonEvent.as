package elan.fla11.roborun.events
{
	import flash.events.Event;
	
	public class ButtonEvent extends Event
	{
		public static const NEW_GAME		:String = 'NewGame_clicked';
		public static const BACK			:String = 'Back_clicked';
		public static const JOIN_GAME		:String = 'JoinGame_clicked';
		public static const INSTRUCTIONS	:String = 'Instructions_clicked';
		
		public function ButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ButtonEvent(type, bubbles, cancelable);
		}
	}
}