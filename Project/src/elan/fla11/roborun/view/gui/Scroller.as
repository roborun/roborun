package elan.fla11.roborun.view.gui
{
	import elan.fla11.roborun.DownArrowGfx;
	import elan.fla11.roborun.UpArrowGfx;
	import elan.fla11.roborun.events.ScrollEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Scroller extends Sprite
	{
		private var _buttonUp:UpArrowGfx;
		private var _buttonDown:DownArrowGfx;
		private var _scrollerSlide:ScrollerSlide;
		private var _scrollCounter:uint;
		private var _scrollingUp:Boolean;
		private var _scrollingDown:Boolean;
		
		public function Scroller(scrollBarHeight:uint)
		{
			_buttonUp = new UpArrowGfx();
			_buttonDown = new DownArrowGfx();
			
			_scrollerSlide = new ScrollerSlide(scrollBarHeight - _buttonUp.height*2);
			
			_scrollerSlide.addEventListener(ScrollEvent.SCROLLING, handleScrollerSlide_scrolling);
			_scrollerSlide.y = _buttonUp.height;
			addChild(_scrollerSlide);
			
			addChild(_buttonUp);
			_buttonUp.addEventListener(MouseEvent.MOUSE_DOWN, handleUpClicked);
			
			_buttonDown.y = scrollBarHeight - _buttonDown.height;
			addChild(_buttonDown);
			_buttonDown.addEventListener(MouseEvent.MOUSE_DOWN, handleDownClicked);
		}
		
		private function handleScrollerSlide_scrolling(evt:Event):void
		{
			dispatchEvent(evt.clone());
		}
		
		private function handleUpClicked(evt:MouseEvent):void
		{
			_scrollingUp = true;
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			_buttonUp.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp_buttonUp);
		}

		private function handleDownClicked(evt:MouseEvent):void
		{
			_scrollingDown = true;
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			_buttonDown.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp_buttonDown);
		}
		
		private function handleMouseUp_buttonDown(evt:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
			_scrollingDown = false;
		}
		
		
		private function handleMouseUp_buttonUp(evt:MouseEvent):void
		{
			_scrollingUp = false;
			removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		public function get scrollPosition():Number
		{
			return _scrollerSlide.scrollPosition;
		}
		
		private function handleEnterFrame(evt:Event):void
		{
			if(_scrollingUp)
				_scrollerSlide.scrollThumbUp = 5;
			if(_scrollingDown)
				_scrollerSlide.scrollThumbDown = 5;
				
		}
		
		public function msgScroll():void
		{
			_scrollerSlide.scrollThumbDown = 5;
		}
	}
}