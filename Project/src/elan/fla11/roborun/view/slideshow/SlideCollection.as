package elan.fla11.roborun.view.slideshow
{
	import com.greensock.TweenLite;
	
	import elan.fla11.roborun.BullAnimationGfx;
	import elan.fla11.roborun.GiraffeAnimationGfx;
	import elan.fla11.roborun.RobotNameGfx;
	import elan.fla11.roborun.WheelieAnimationGfx;
	import elan.fla11.roborun.settings.GameSettings;
	
	import flash.display.Sprite;
	
	public class SlideCollection extends Sprite
	{
		private var _slides:Vector.<SlideBase>;
		
		private static var _currentSlide:uint;
		private var _prevSlide:uint;
		private var _nextSlide:uint;
		private var _robotName:RobotNameGfx;
		
		public function SlideCollection()
		{
			super();
			_slides = new Vector.<SlideBase>();
			addSlides();
		}
		
		private function addSlides():void
		{
			_slides.push(new Slide_bull);
			_slides.push(new Slide_giraffe);
			_slides.push(new Slide_wheelie);
			addChild(_slides[0]);
			_currentSlide = 0;
			_robotName = new RobotNameGfx();
			_robotName.x = this.width/2;
			_robotName.y = this.height;
			addChild(_robotName);
			updateName();
		}
		
		public static function get robotIndex(): uint
		{
			return _currentSlide;
		}
		
		public function nextSlide():void
		{			
			_prevSlide = _currentSlide;
			
			if(_currentSlide == _slides.length -1)
				_currentSlide = 0;
			else
				_currentSlide++;
			
			removeChild(_slides[_prevSlide]);
			addChild(_slides[_currentSlide]);
			updateName();
		}
		
		public function prevSlide():void
		{			
			_prevSlide = _currentSlide;
	
			if(_currentSlide == 0)
				_currentSlide = _slides.length -1;
			else
				_currentSlide--;
			
			removeChild(_slides[_prevSlide]);
			addChild(_slides[_currentSlide]);
			updateName();
		}
		
		private function updateName():void
		{
			_robotName.Tf.text = _slides[_currentSlide].robotName;
		}
	}
}