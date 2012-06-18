package elan.fla11.roborun.utils
{
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.KeyboardManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	public class LevelCamera /*extends Sprite*/
	{
		private var _world				:Sprite;
		private var _window				:Sprite;
		private var _zoom				:Number = 1;
		
		private var _border				:uint = 20;
		private var _speedX				:int;
		private var _speedY				:int;
		
		private var _allowUpdate		:Boolean;
		private var _isInit				:Boolean;
		
		
		public function LevelCamera()
		{
			init();
		}
		
		private function init(): void
		{
			_window = new Sprite();
			_window.graphics.beginFill( 0 );
			_window.graphics.drawRect( 0, 0, 1000, 500 );
			
			_window.x = 12;
			_window.y = 20;

			
			//addChild( _window );
		}
			
		
		public function setWorld( newWorld:Sprite ): void
		{
			_world = newWorld;
			_world.mask = _window;
			
			_isInit = true;
			reset();
		}
		
		public function reset(): void
		{
			_zoom = 1;
			
			_world.scaleX = _zoom;
			_world.scaleY = _zoom;
			
			_world.x = 12;
			_world.y = 12;
			
			
			
			deactivate();
			activate();
		}
		
		public function activate(): void
		{
			if( _isInit ) _allowUpdate = true;
			GameSettings.STAGE.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel_scroll);			
		}

		public function deactivate(): void
		{
			_allowUpdate = false;
			GameSettings.STAGE.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel_scroll);			
		}
		
		
		
		private function onMouseWheel_scroll( e:MouseEvent ): void
		{
			
			_zoom += e.delta * 0.1;
			
			zoomOnMap();
		}
		
		private function zoomOnMap(): void
		{
			if( _zoom <= 0.5 ) _zoom = 0.5;
			if( _zoom >= 2 ) _zoom = 2;
			
			_world.scaleX = _zoom;
			_world.scaleY = _zoom;				
		}
		
		
		public function update(): void
		{
			if( _allowUpdate )
			{
				_speedX = 0;
				_speedY = 0;
				
				if( _window.mouseX < _window.x + _border && _window.mouseX > 0 )
				{

					if( _window.mouseY > 0 && _window.mouseY < _window.height )
					{
						_speedX = 5;
					}

				}
	
				if( _window.mouseX > _window.width - _border && _window.mouseX < _window.width )
				{

					if( _window.mouseY > 0 && _window.mouseY < _window.height )
					{
						_speedX = -5;
					}
				}
	
				if( _window.mouseY < _border && _window.mouseY > 0 )
				{

					if( _window.mouseX > 0 && _window.mouseY < _window.width )
					{
						_speedY = 5;
					}
				}
	
				if( _window.mouseY > _window.height - _border && _window.mouseY < _window.height )
				{

					if( _window.mouseX > 0 && _window.mouseY < _window.width )
					{
						_speedY = -5;
					}
				}
	
				if( KeyboardManager.isKeyDown( Keyboard.UP ) ) _speedY = 5;
				if( KeyboardManager.isKeyDown( Keyboard.DOWN ) ) _speedY = -5;
				if( KeyboardManager.isKeyDown( Keyboard.LEFT ) ) _speedX = 5;
				if( KeyboardManager.isKeyDown( Keyboard.RIGHT ) ) _speedX = -5;
				if( KeyboardManager.isKeyDown( Keyboard.Z ) ) _zoom -= 0.1;
				if( KeyboardManager.isKeyDown( Keyboard.X ) ) _zoom += 0.1;
				
				zoomOnMap();
				_world.x += _speedX;
				_world.y += _speedY;
				
				//Left
				if((_world.x) > _window.x)
				{
					_world.x = _window.x;
				}
				
				// Right
				if((_world.x + _world.width) < _window.width + _window.x)
				{
					_world.x = (_window.width - _world.width) + _window.x;
					
				}
				
				// Up
				if(_world.y > _window.y)
				{
					_world.y = _window.y;
				}
				
				// Down
				if((_world.y + _world.height) < _window.height + _window.y)
				{		
					_world.y = (_window.height - _world.height) + _window.y;

				}
				
			}
			
		}
	}
}