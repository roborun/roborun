package elan.fla11.roborun.view.slideshow
{
	import elan.fla11.roborun.WheelieAnimationGfx;

	public class Slide_wheelie extends SlideBase
	{
		private var _wheelie:WheelieAnimationGfx;
		
		public function Slide_wheelie()
		{
			super();
			robotName = 'Wheelie';
			_wheelie = new WheelieAnimationGfx();
			addChild(_wheelie);
		}
	}
}