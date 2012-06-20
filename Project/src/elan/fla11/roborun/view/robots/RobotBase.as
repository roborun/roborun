package elan.fla11.roborun.view.robots
{
	import com.greensock.TweenLite;
	
	import elan.fla11.roborun.events.GameEvent;
	import elan.fla11.roborun.settings.ColorCode;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.LevelLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class RobotBase extends Sprite
	{
		public var takenFlags			:uint;
		
		protected var _robotID			:uint;
		protected var _userDetails		:Object;
		
		protected var _gfx				:Sprite;
		
		private var _delta				:int;
		private var _deltaX				:int;
		private var _deltaY				:int;

		private var _checkPointPos		:Point;
		private var _prevPos			:Point;
		private var _prevRot			:uint;
		
		private var _dispatchDelay		:Timer;
		private var _functionDelay		:Timer;
		
		private var _isFinished			:Boolean;
		private var _wasFinished		:Boolean;
		private var _isPushed			:Boolean;
		private var _isSecTime		:Boolean;	
		
		private var _levelDesign		:BitmapData;

		public function RobotBase( userDetails:Object )
		{
			_userDetails = userDetails;
			
			trace( '__________________________________' );
			trace( '	ROBOT AND USER INFO!' );
			trace( '	UserName:', _userDetails.name );
			trace( '	UserID:', _userDetails.id );
			trace( '__________________________________' );
			initBase();
		}
		
		private function initBase(): void
		{
			_checkPointPos = new Point();
			_prevPos = new Point();
			_prevRot = GameSettings.RIGHT;
			
			_levelDesign = new BitmapData(40,20);
		
			_gfx.x = GameSettings.GRID_SIZE *.5;
			_gfx.y = GameSettings.GRID_SIZE *.5;
			addChild( _gfx );
			
			_dispatchDelay = new Timer(1000);
			_dispatchDelay.addEventListener(TimerEvent.TIMER, dispatchMoved);

			_functionDelay = new Timer(1000);
			_functionDelay.addEventListener(TimerEvent.TIMER, dispatchFunctionFinished);
		}

		public function setStartPos(): void
		{
			_prevPos.x = x;
			_prevPos.y = y;		
			
			_levelDesign = LevelLoader.levelDesign;
			
			setCheckPoint();
		}
		
		public function setCheckPoint(): void
		{
			_checkPointPos.x = x;
			_checkPointPos.y = y;			
		}
		public function gotoCheckPoint(): void
		{
			x = _checkPointPos.x;
			y = _checkPointPos.y
				
			_gfx.rotation = GameSettings.RIGHT;	
				
			_prevPos.x = x;
			_prevPos.y = y;	
		}

		public function get userDetails(): Object
		{
			return _userDetails;
		}

		public function move( d:int = 0 ): void
		{
			_prevPos.x = x;
			_prevPos.y = y;
			_delta = d * GameSettings.GRID_SIZE;
			_isPushed = false;
		}
		
		public function rotate( rot:int = 0 ): void
		{
			TweenLite.to( _gfx, 1, {rotation: _gfx.rotation + rot, onComplete: movedFinished});
			trace( 'Robot rotation', _gfx.rotation );
		}

		private function rotatePlate( rot:int = 0 ): void
		{
			TweenLite.to( _gfx, 1, {rotation: _gfx.rotation + rot, onComplete: levelFunctionFinished});
			trace( 'Robot rotation', _gfx.rotation );
		}
		
		public function checkLevelFunctions(): void
		{
			switch( _levelDesign.getPixel( x/GameSettings.GRID_SIZE, y/GameSettings.GRID_SIZE ) )
			{	
				case ColorCode.BAND_PLATE_RIGHT:
					trace( 'push right' );
					TweenLite.to( this, 2, {x: (x + GameSettings.GRID_SIZE), onComplete: levelFunctionFinished});
					break;
				
				case ColorCode.BAND_PLATE_LEFT:
					trace( 'push left' );
					TweenLite.to( this, 2, {x: (x - GameSettings.GRID_SIZE), onComplete: levelFunctionFinished});
					break;
				
				case ColorCode.BAND_PLATE_UP:
					trace( 'push up');
					TweenLite.to( this, 2, {y: (y - GameSettings.GRID_SIZE), onComplete: levelFunctionFinished});
					break;
				
				case ColorCode.BAND_PLATE_DOWN:
					trace('push down');
					TweenLite.to( this, 2, {y: (y + GameSettings.GRID_SIZE), onComplete: levelFunctionFinished});
					break;
		
				case ColorCode.LEFT_ROTATION:
					rotatePlate( -90 );
					break;
				
				case ColorCode.RIGHT_ROTATION:
					rotatePlate( 90 );
					break;
				
				case ColorCode.FLAG_PLATE:
					dispatchEvent( new GameEvent(GameEvent.ON_FLAG) );
					levelFunctionFinished();
					break;
				
				default:
					levelFunctionFinished();
			}
		}
		
		
		public function update(): void
		{	
			
			if( !_isPushed )
			{
				
				if( _gfx.rotation == GameSettings.UP ||  _gfx.rotation == -90 )
				{
					if( y > _prevPos.y - _delta )
					{
						if( isAbleToProceed( _levelDesign.getPixel( uint(x/GameSettings.GRID_SIZE), Math.ceil(y/GameSettings.GRID_SIZE -1) ) ) )
						{
							--y;
							_isFinished = false;						
						}
						else
						{
							_delta = 0;
							x = roundToNearestGrid( x );
							y = roundToNearestGrid( y );
							_prevPos.y = y;
							_wasFinished = false;
							_isFinished = true;
						}
					}
					else if( y < _prevPos.y - _delta)
					{
						if( isAbleToProceed( _levelDesign.getPixel( uint(x/GameSettings.GRID_SIZE ), Math.floor(y/GameSettings.GRID_SIZE +1) ) ) )
						{
							++y;
							_isFinished = false;
						}
						else
						{
							_delta = 0;
							x = roundToNearestGrid( x );
							y = roundToNearestGrid( y );
							_prevPos.y = y;
							_wasFinished = false;
							_isFinished = true;
						}
					}
					else
					{
						_delta = 0;
						x = roundToNearestGrid( x );
						y = roundToNearestGrid( y );
						_prevPos.y = y;
						_isFinished = true;
					}
				}
				else if(  _gfx.rotation == GameSettings.DOWN || _gfx.rotation == -270 )
				{
					if( y < _prevPos.y + _delta )
					{
						if( isAbleToProceed( _levelDesign.getPixel( uint(x/GameSettings.GRID_SIZE), Math.floor(y/GameSettings.GRID_SIZE +1) ) ) )
						{
							++y;
							_isFinished = false;
						}
						else
						{
							_delta = 0;
							x = roundToNearestGrid( x );
							y = roundToNearestGrid( y );
							_prevPos.y = y;
							_wasFinished = false;
							_isFinished = true;
						}
					}
					else if( y > _prevPos.y + _delta )
					{
						if( isAbleToProceed( _levelDesign.getPixel( uint(x/GameSettings.GRID_SIZE), Math.ceil(y/GameSettings.GRID_SIZE -1) ) ) )
						{
							--y;
							_isFinished = false;						
						}
						else
						{
							_delta = 0;
							x = roundToNearestGrid( x );
							y = roundToNearestGrid( y );
							_prevPos.y = y;
							_wasFinished = false;
							_isFinished = true;
						}
					}
					else
					{
						_delta = 0;
						x = roundToNearestGrid( x );
						y = roundToNearestGrid( y );
						_prevPos.y = y;
						_isFinished = true;
					}
				}
				else if(  _gfx.rotation == GameSettings.RIGHT || _gfx.rotation == -360 )
				{
					if( x < _prevPos.x + _delta )
					{
						if( isAbleToProceed( _levelDesign.getPixel( Math.floor(x/GameSettings.GRID_SIZE +1), uint(y/GameSettings.GRID_SIZE) ) ) )
						{
							++x;
							_isFinished = false;						
						}
						else
						{
							_delta = 0;
							x = roundToNearestGrid( x );
							y = roundToNearestGrid( y );
							_prevPos.x = x;
							_wasFinished = false;
							_isFinished = true;
						}
					}
					else if( x > _prevPos.x + _delta )
					{
						if( isAbleToProceed( _levelDesign.getPixel( Math.ceil(x/GameSettings.GRID_SIZE -1), uint(y/GameSettings.GRID_SIZE) ) ) )
						{
							--x;
							_isFinished = false;						
						}
						else
						{
							_delta = 0;
							x = roundToNearestGrid( x );
							y = roundToNearestGrid( y );
							_prevPos.x = x;
							_wasFinished = false;
							_isFinished = true;
						}
					}
					else
					{
						_delta = 0;
						x = roundToNearestGrid( x );
						y = roundToNearestGrid( y );
						_prevPos.x = x;
						_isFinished = true;
					}
				}
				else if(  _gfx.rotation == GameSettings.LEFT || _gfx.rotation == -180)
				{
					if( x > _prevPos.x - _delta )
					{
						if( isAbleToProceed( _levelDesign.getPixel( Math.ceil(x/GameSettings.GRID_SIZE -1), uint(y/GameSettings.GRID_SIZE) ) ) )
						{
							--x;
							_isFinished = false;						
						}
						else
						{
							_delta = 0;
							x = roundToNearestGrid( x );
							y = roundToNearestGrid( y );
							_prevPos.x = x;
							_wasFinished = false;
							_isFinished = true;
						}
					}
					else if( x < _prevPos.x - _delta )
					{
						if( isAbleToProceed( _levelDesign.getPixel( Math.floor(x/GameSettings.GRID_SIZE +1), uint(y/GameSettings.GRID_SIZE) ) ) )
						{
							++x;
							_isFinished = false;						
						}
						else
						{
							_delta = 0;
							x = roundToNearestGrid( x );
							y = roundToNearestGrid( y );
							_prevPos.x = x;
							_wasFinished = false;
							_isFinished = true;
						}
					}
					else
					{
						_delta = 0;
						x = roundToNearestGrid( x );
						y = roundToNearestGrid( y );
						_prevPos.x = x;
						_isFinished = true;
					}
				}	
	
				if( _isFinished && !_wasFinished ) movedFinished();
			}
			
			_wasFinished = _isFinished;
			
			if( _levelDesign.getPixel( x/GameSettings.GRID_SIZE, y/GameSettings.GRID_SIZE ) == ColorCode.HOLE ) 
			{
				if( !_isSecTime )
				{
					dispatchEvent( new GameEvent( GameEvent.DEAD ) );
					_delta = 0;
					movedFinished();
				}
				_isSecTime = true;
			}
			else _isSecTime = false;
			
			
		}
		
		private function roundToNearestGrid(value:uint):uint{
			var grid : uint = GameSettings.GRID_SIZE;
			return Math.round(value/grid)*grid;
		}
		
		private function isAbleToProceed( color:uint ): Boolean
		{
			switch( color )
			{	
				case ColorCode.WALL:
					trace( 'I will hit a WALL');
					return false;
					break;
				
				case ColorCode.LASER_RIGHT:
					trace( 'I will hit a RIGHT LASER');
					return false;					
					break;
				
				case ColorCode.LASER_LEFT:
					trace( 'I will hit a LEFT LASER');
					return false;					
					break;
				
				case ColorCode.LASER_UP:
					trace( 'I will hit a UP LASER');
					return false;					
					break;
				
				case ColorCode.LASER_DOWN:
					trace( 'I will hit a DOWN LASER');
					return false;					
					break;

				default:
					return true;
					
			}
		}
		
		

		private function levelFunctionFinished(): void
		{
			_prevPos.x = x;
			_prevPos.y = y;
			_functionDelay.start();	
		}
		
		private function dispatchFunctionFinished( e:TimerEvent ): void
		{
			_functionDelay.reset();
			_isPushed = false;
			trace( 'robot Function DISPATCHES' );
			dispatchEvent( new GameEvent(GameEvent.LEVEL_FUNCTIONS) );			
		}

		private function movedFinished(): void
		{
			_dispatchDelay.start();	
		}
		
		private function dispatchMoved( e:TimerEvent ): void
		{
			_dispatchDelay.reset();
			_isPushed = false;
			trace( 'robot DISPATCHES' );
			dispatchEvent( new GameEvent(GameEvent.MOVED) );			
		}
	}
}