package com.roborun.p2pupdate.utils
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;

	public class GameCamera extends Sprite
	{
		private var _gc		:Sprite;
		private var _mask 	:Sprite;
		
		public function GameCamera( gameContainer : Sprite )
		{
			setupMask();
			updateLevel( gameContainer );
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel_zoom);
		}
		
		private function setupMask(): void
		{
			_mask = new Sprite();
			_mask.graphics.beginFill(0);
			_mask.graphics.drawRect(0,0, 1024, 500);
		}
		
		public function updateLevel( gameContainer : Sprite ): void
		{
			_gc = gameContainer;	
			_gc.mask = _mask;
		}
		
		public function update(): void
		{
			if( mouseX > _mask.x && mouseX < _mask.x + 20 ) moveRight();
			if( mouseX < _mask.x + _mask.width && mouseX > (_mask.x + _mask.width) - 20 ) moveLeft();
			if( mouseY > _mask.y && mouseY < _mask.y + 20 ) moveUp();
			if( mouseY < _mask.y + _mask.height && mouseY > (_mask.y + _mask.height) - 20 ) moveDown();
			
			if( KeyboardManager.isKeyDown( Keyboard.A ) ) moveRight();
			if( KeyboardManager.isKeyDown( Keyboard.D ) ) moveLeft();
			if( KeyboardManager.isKeyDown( Keyboard.W ) ) moveUp();
			if( KeyboardManager.isKeyDown( Keyboard.S ) ) moveDown();

			if( KeyboardManager.isKeyDown( Keyboard.Q ) ) zoomIn();
			if( KeyboardManager.isKeyDown( Keyboard.E ) ) zoomOut();
			
			checkBorder();
		}
		
		private function checkBorder(): void
		{
			// Right
			if((_gc.x + _gc.width) < _mask.width)
			{
				_gc.x = _mask.width - _gc.width;	
			}
			//Left
			if((_gc.x) > _mask.x)
			{
				_gc.x = _mask.x;
			}
			
			// Up
			if(_gc.y > _mask.y)
			{
				_gc.y = _mask.y;
			}
			
			// Down
			if((_gc.y + _gc.height) < _mask.height)
			{		
				_gc.y = _mask.height - _gc.height;
			}
			
			// Max zoom out
			if( (_gc.width/_mask.width) < .9 )
			{
				_gc.scaleX = .9;
				_gc.scaleY = .9;
			}
			else if( (_gc.height/_mask.height) < .9)
			{
				_gc.scaleX = .9;
				_gc.scaleY = .9;
			}
			
			// Max zoom in
			else if( (_gc.width/_mask.width) > 1.5 )
			{
				_gc.scaleX = 1.3;
				_gc.scaleY = 1.3;
			}
			else if( (_gc.height/_mask.height) > 1.5 )
			{
				_gc.scaleX = 1.3;
				_gc.scaleY = 1.3;
			}
				
			
		}
		
		private function moveRight(): void
		{
			_gc.x+=5;
		}
		private function moveLeft(): void
		{
			_gc.x-=5;
		}
		private function moveUp(): void
		{
			_gc.y+=5;
		}
		private function moveDown(): void
		{
			_gc.y-=5;
		}
		private function zoomIn(): void
		{
			_gc.scaleX = _gc.scaleY += .1;
		}
		private function zoomOut(): void
		{
			_gc.scaleX = _gc.scaleY -= .1;
		}
		
		private function onMouseWheel_zoom( e:MouseEvent ): void
		{
			
		}
	}
}