package elan.fla11.roborun.view.slideshow
{
	import elan.fla11.roborun.BullAnimationGfx;

	public class Slide_bull extends SlideBase
	{
		private var _bull:BullAnimationGfx;
		
		public function Slide_bull()
		{
			super();
			robotName = 'Bull';
			_bull = new BullAnimationGfx();
			addChild(_bull);
		}
	}
}