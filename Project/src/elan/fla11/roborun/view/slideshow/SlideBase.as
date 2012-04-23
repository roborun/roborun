package elan.fla11.roborun.view.slideshow
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	
	public class SlideBase extends Sprite
	{
		public var robotName:String;
		
		public function SlideBase()
		{
			super();
			scaleX = .3;
			scaleY = .3;
		}
	}
}