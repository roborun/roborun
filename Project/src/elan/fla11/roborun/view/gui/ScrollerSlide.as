package elan.fla11.roborun.view.gui
{
	import elan.fla11.roborun.ScrollBarGfx;
	import elan.fla11.roborun.ScrollThumbGfx;
	import elan.fla11.roborun.events.ScrollEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ScrollerSlide extends Sprite
	{
		private var _scrollEvent:Event;
		private var _scrollerTrack:ScrollBarGfx;
		private var _scrollerThumb:ScrollThumbGfx;
		private var _scrollPos:Number;
		private var _offset:Number;
		
		public function ScrollerSlide(trackHeight:uint)
		{
			_scrollEvent = new ScrollEvent(ScrollEvent.SCROLLING);
			_scrollerThumb = new ScrollThumbGfx();
			_scrollerTrack = new ScrollBarGfx();
			
			_scrollerTrack.height = trackHeight;
			_scrollerTrack.visible = false;
			addChild(_scrollerTrack);
			
			_scrollerThumb.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown_scroll);
			addChild(_scrollerThumb);
		}
		
		private function handleMouseDown_scroll(evt:MouseEvent):void
		{
			_offset = _scrollerThumb.y - mouseY;
			stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp_stopScroll);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove_scrolling);
		}
		
		private function handleMouseUp_stopScroll(evt:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp_stopScroll);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove_scrolling);
		}
		
		private function handleMouseMove_scrolling(evt:MouseEvent):void
		{
			_scrollerThumb.y = mouseY + _offset;
			if(_scrollerThumb.y <= 0)
			{
				_scrollerThumb.y = 0;
			}
			if(_scrollerThumb.y >= _scrollerTrack.height - _scrollerThumb.height)
			{
				_scrollerThumb.y = _scrollerTrack.height - _scrollerThumb.height;
			}
			
			_scrollPos = _scrollerThumb.y/(_scrollerTrack.height - _scrollerThumb.height);
			dispatchEvent(_scrollEvent);
		}
		
		public function get scrollPosition():Number
		{
			return _scrollPos;
		}
		
		public function set scrollThumbUp(position:Number):void
		{
			_scrollerThumb.y -= position;
			if(_scrollerThumb.y <= 0)
			{
				_scrollerThumb.y = 0;
			}
			_scrollPos = _scrollerThumb.y/(_scrollerTrack.height - _scrollerThumb.height);
			dispatchEvent(_scrollEvent);
		}
		
		public function set scrollThumbDown(position:Number):void
		{
			_scrollerThumb.y += position;
			if(_scrollerThumb.y >= _scrollerTrack.height - _scrollerThumb.height)
			{
				_scrollerThumb.y = _scrollerTrack.height - _scrollerThumb.height;
			}
			_scrollPos = _scrollerThumb.y/(_scrollerTrack.height - _scrollerThumb.height);
			dispatchEvent(_scrollEvent);
		}
	}
}