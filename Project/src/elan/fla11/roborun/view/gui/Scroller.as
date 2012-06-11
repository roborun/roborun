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
		
		public function Scroller(scrollBarHeight:uint)
		{
			_buttonUp = new UpArrowGfx();
			_buttonDown = new DownArrowGfx();
			
			_scrollerSlide = new ScrollerSlide(scrollBarHeight - _buttonUp.height*2);
			
			_scrollerSlide.addEventListener(ScrollEvent.SCROLLING, handleScrollerSlide_scrolling);
			_scrollerSlide.y = _buttonUp.height;
			addChild(_scrollerSlide);
			
			addChild(_buttonUp);
			_buttonUp.addEventListener(MouseEvent.CLICK, handleUpClicked);
			
			_buttonDown.y = scrollBarHeight - _buttonDown.height;
			addChild(_buttonDown);
			_buttonDown.addEventListener(MouseEvent.CLICK, handleDownClicked);
		}
		
		private function handleScrollerSlide_scrolling(evt:Event):void
		{
			dispatchEvent(evt.clone());
		}
		
		private function handleUpClicked(evt:MouseEvent):void
		{
			_scrollerSlide.scrollThumbUp = 10;
		}
		
		private function handleDownClicked(evt:MouseEvent):void
		{
			_scrollerSlide.scrollThumbDown = 10;
		}
		
		public function get scrollPosition():Number
		{
			return _scrollerSlide.scrollPosition;
		}
	}
}