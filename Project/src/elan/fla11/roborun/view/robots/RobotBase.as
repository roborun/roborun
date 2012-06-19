package elan.fla11.roborun.view.robots
{
	import com.greensock.TweenLite;
	
	import elan.fla11.roborun.events.GameEvent;
	import elan.fla11.roborun.settings.ColorCode;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.LevelLoader;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class RobotBase extends Sprite
	{
		protected var _userID		:String;
		protected var _robotID		:uint;
		
		protected var _gfx			:Sprite;
		
		private var _delta			:int;

		private var _prevPos		:Point;
		private var _prevRot		:uint;
		
		private var _dispatchDelay	:Timer;
		
		private var _isFinished		:Boolean;
		private var _wasFinished	:Boolean;
		
		private var _levelDesign	:BitmapData;

		public function RobotBase()
		{
			_prevPos = new Point();
			_prevRot = GameSettings.RIGHT;
			
			_levelDesign = new BitmapData(40,20);
			
			_gfx.x = GameSettings.GRID_SIZE *.5;
			_gfx.y = GameSettings.GRID_SIZE *.5;
			addChild( _gfx );
			
			_dispatchDelay = new Timer(1000);
			_dispatchDelay.addEventListener(TimerEvent.TIMER, dispatch);
			trace( 'Init robot', _userID );
		}

		public function setStartPos(): void
		{
			_prevPos.x = x;
			_prevPos.y = y;		
			
			_levelDesign = LevelLoader.levelDesign;
		}
		
		public function get userID(): String
		{
			return _userID;
		}
		
		public function move( d:int = 0 ): void
		{
			_prevPos.x = x;
			_prevPos.y = y;
			_delta = d * GameSettings.GRID_SIZE;
		}
		
		public function rotate( rot:int = 0 ): void
		{
			TweenLite.to( _gfx, 1, {rotation: _gfx.rotation + rot, onComplete: movedFinished});
			trace( 'Robot rotation', _gfx.rotation );
		}
		
		public function update(): void
		{	
			if( _gfx.rotation == GameSettings.UP ||  _gfx.rotation == -90 )
			{
				if( y > _prevPos.y - _delta )
				{
					if( isAbleToProceed( _levelDesign.getPixel( x, y-1 ) ) )
					{
						--y;
						_isFinished = false;						
					}
					else
					{
						_delta = 0;
						_prevPos.y = y;
						_isFinished = true;
					}
				}
				else if( y < _prevPos.y - _delta)
				{
					if( isAbleToProceed( _levelDesign.getPixel( x, y+1 ) ) )
					{
						++y;
						_isFinished = false;
					}
					else
					{
						_delta = 0;
						_prevPos.y = y;
						_isFinished = true;
					}
				}
				else
				{
					_delta = 0;
					_prevPos.y = y;
					_isFinished = true;
				}
			}
			else if(  _gfx.rotation == GameSettings.DOWN || _gfx.rotation == -270 )
			{
				if( y < _prevPos.y + _delta )
				{
					if( isAbleToProceed( _levelDesign.getPixel( x, y+1 ) ) )
					{
						++y;
						_isFinished = false;
					}
					else
					{
						_delta = 0;
						_prevPos.y = y;
						_isFinished = true;
					}
				}
				else if( y > _prevPos.y + _delta )
				{
					if( isAbleToProceed( _levelDesign.getPixel( x, y-1 ) ) )
					{
						--y;
						_isFinished = false;						
					}
					else
					{
						_delta = 0;
						_prevPos.y = y;
						_isFinished = true;
					}
				}
				else
				{
					_delta = 0;
					_prevPos.y = y;
					_isFinished = true;
				}
			}
			else if(  _gfx.rotation == GameSettings.RIGHT || _gfx.rotation == -360 )
			{
				if( x < _prevPos.x + _delta )
				{
					if( isAbleToProceed( _levelDesign.getPixel( x+1, y ) ) )
					{
						++x;
						_isFinished = false;						
					}
					else
					{
						_delta = 0;
						_prevPos.y = y;
						_isFinished = true;
					}
				}
				else if( x > _prevPos.x + _delta )
				{
					--x;
					_isFinished = false;
				}
				else
				{
					_delta = 0;
					_prevPos.x = x;
					_isFinished = true;
				}
			}
			else if(  _gfx.rotation == GameSettings.LEFT || _gfx.rotation == -180)
			{
				if( x > _prevPos.x - _delta )
				{
					if( isAbleToProceed( _levelDesign.getPixel( x-1, y ) ) )
					{
						--x;
						_isFinished = false;						
					}
					else
					{
						_delta = 0;
						_prevPos.y = y;
						_isFinished = true;
					}
				}
				else if( x < _prevPos.x - _delta )
				{
					++x;
					_isFinished = false;
				}
				else
				{
					_delta = 0;
					_prevPos.x = x;
					_isFinished = true;
				}
			}
			
			
			//trace( _isFinished, _wasFinished );
			if( _isFinished && !_wasFinished ) movedFinished();
			
			_wasFinished = _isFinished;
		}
		
		private function isAbleToProceed( color:uint ): Boolean
		{
			switch( color )
			{	
				case ColorCode.WALL:
					return false;
					break;
				
				case ColorCode.LASER_RIGHT:
					return false;					
					break;
				
				case ColorCode.LASER_LEFT:
					return false;					
					break;
				
				case ColorCode.LASER_UP:
					return false;					
					break;
				
				case ColorCode.LASER_DOWN:
					return false;					
					break;

				default:
					return true;
					
			}
		}
		
		
		private function movedFinished(): void
		{
			_dispatchDelay.start();	
		}
		
		private function dispatch( e:TimerEvent ): void
		{
			_dispatchDelay.reset();
			trace( 'robot DISPATCHES' );
			dispatchEvent( new GameEvent(GameEvent.MOVED) );			
		}
	}
}