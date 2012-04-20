package elan.fla11.roborun.view.slideshow
{
	import elan.fla11.roborun.GiraffeAnimationGfx;

	public class Slide_giraffe extends SlideBase
	{
		private var _giraffe:GiraffeAnimationGfx;
		
		public function Slide_giraffe()
		{
			super();
			_giraffe = new GiraffeAnimationGfx();
			addChild(_giraffe);
		}
	}
}