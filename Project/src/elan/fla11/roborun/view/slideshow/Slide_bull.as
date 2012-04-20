package elan.fla11.roborun.view.slideshow
{
	import elan.fla11.roborun.BullAnimationGfx;

	public class Slide_bull extends Slide
	{
		private var _bull:BullAnimationGfx;
		
		public function Slide_bull()
		{
			super();
			_bull = new BullAnimationGfx();
			addChild(_bull);
		}
	}
}