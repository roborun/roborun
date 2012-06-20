package elan.fla11.roborun.view.slideshow
{
	import elan.fla11.roborun.SlideShowBgGfx;
	import elan.fla11.roborun.SlideShowButton_leftGfx;
	import elan.fla11.roborun.SlideShowButton_rightGfx;
	import elan.fla11.roborun.SlideShowScreenGfx;
	import elan.fla11.roborun.sound.Sounds;
	import elan.fla11.roborun.utils.SoundManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class SlideShow extends Sprite
	{
		private var _screen:SlideShowScreenGfx;
		private var _bg:SlideShowBgGfx;
		private var _button_left:SlideShowButton_leftGfx;
		private var _button_right:SlideShowButton_rightGfx;
		private var _slides:SlideCollection;
		private var _mask:Sprite;
		
		public static const slideShow_width:Number = 500;
		public static const slideShow_height:Number = 375;
		
		public function SlideShow()
		{
			super();
			init();
		}
		
		private function init():void
		{
			_mask = new Sprite();
			_mask.x = 5;
			_mask.graphics.beginFill(0);
			_mask.graphics.drawRect(0, 0, 440, 375);
			_mask.graphics.endFill();
			_mask.x = 58;
			addChild(_mask);
			
			_bg = new SlideShowBgGfx();
			_screen = new SlideShowScreenGfx();
			_slides = new SlideCollection();
			_slides.x = slideShow_width/2 - _slides.width/2;
			_slides.y = slideShow_height/2 - _slides.height/2;
			_slides.mask = _mask;
			addChild(_bg);
			addChild(_slides);
			addChild(_screen);
			
			_button_left = new SlideShowButton_leftGfx();
			_button_left.x = _button_left.width;
			_button_left.y = slideShow_height/2;
			addChild(_button_left);
			_button_left.buttonMode = true;
			_button_left.useHandCursor = true;
			_button_left.addEventListener(MouseEvent.CLICK, handleClick_left);
			
			_button_right = new SlideShowButton_rightGfx();
			_button_right.x = slideShow_width - _button_right.width;
			_button_right.y = _button_left.y;
			addChild(_button_right);
			_button_right.buttonMode = true;
			_button_right.useHandCursor = true;
			_button_right.addEventListener(MouseEvent.CLICK, handleClick_right);
		}
		
		private function playSound():void
		{
			SoundManager.playSound(Sounds.BUTTON, .1);
		}
		
		private function handleClick_right(evt:MouseEvent):void
		{
			playSound();
			_slides.nextSlide();
		}
		
		private function handleClick_left(evt:MouseEvent):void
		{
			playSound();
			_slides.prevSlide();
		}
	}
}