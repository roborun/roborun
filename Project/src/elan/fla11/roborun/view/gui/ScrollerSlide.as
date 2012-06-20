package elan.fla11.roborun.view.gui
{
	import elan.fla11.roborun.ScrollBarGfx;
	import elan.fla11.roborun.ScrollThumbGfx;
	import elan.fla11.roborun.events.ScrollEvent;
	import elan.fla11.roborun.settings.GameSettings;
	
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
		
		private var _scrollEnabled:Boolean;
		
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
		
		public function activateScroll():void
		{
			if(!_scrollEnabled)
				GameSettings.STAGE.addEventListener(MouseEvent.MOUSE_WHEEL, handleMouseWheel);
			_scrollEnabled = true;
		}
		
		private function handleMouseWheel(evt:MouseEvent):void
		{
			_scrollerThumb.y -= evt.delta;
			checkPos();
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
			checkPos();
		}
		
		private function checkPos():void
		{
			if(_scrollerThumb.y <= 0)
				_scrollerThumb.y = 0;
			
			if(_scrollerThumb.y >= _scrollerTrack.height - _scrollerThumb.height)
				_scrollerThumb.y = _scrollerTrack.height - _scrollerThumb.height;
			
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
			checkPos();
		}
		
		public function set scrollThumbDown(position:Number):void
		{
			_scrollerThumb.y += position;			
			checkPos();
		}
	}
}