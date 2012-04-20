package elan.fla11.roborun.view.slideshow
{
	import elan.fla11.roborun.BullAnimationGfx;
	import elan.fla11.roborun.GiraffeAnimationGfx;
	import elan.fla11.roborun.WheelieAnimationGfx;
	import elan.fla11.roborun.settings.GameSettings;
	
	import flash.display.Sprite;
	
	public class SlideCollection extends Sprite
	{
		private var _slides:Vector.<Slide>;
		
		public function SlideCollection()
		{
			super();
			_slides = new Vector.<Slide>();
			addSlides();
		}
		
		private function addSlides():void
		{
			_slides.push(new Slide_bull);
			_slides.push(new Slide_giraffe);
			_slides.push(new Slide_wheelie);
			for (var i:int = 0; i < _slides.length; i++) 
			{
				addChild(_slides[i]);
				_slides[i].x = i*(_slides[i].width + 20);
			}
			
		}
		
		public function nextSlide():void
		{
			trace('nextSlide');
		}
		
		public function prevSlide():void
		{
			trace('prevSlide');
		}
	}
}