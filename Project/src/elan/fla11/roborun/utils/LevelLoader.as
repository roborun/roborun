package elan.fla11.roborun.utils
{
	import elan.fla11.roborun.settings.ColorCode;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.view.levelobjects.LaserPlate;
	import elan.fla11.roborun.view.levelobjects.LeftRotationPlate;
	import elan.fla11.roborun.view.levelobjects.LevelObject;
	import elan.fla11.roborun.view.levelobjects.RightRotationPlate;
	import elan.fla11.roborun.view.levelobjects.statics.HolePlate;
	import elan.fla11.roborun.view.levelobjects.statics.StartPlate;
	import elan.fla11.roborun.view.levelobjects.statics.WallPlate;
	import elan.fla11.roborun.view.levelobjects.tracks.LeftTrackPlate;
	import elan.fla11.roborun.view.levelobjects.tracks.RightTrackPlate;
	import elan.fla11.roborun.view.levelobjects.tracks.StraightTrackPlate;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.net.URLRequest;

	public class LevelLoader extends EventDispatcher
	{
		private var _levelLoader	:Loader;
		private var _level			:Sprite;
		
		private var _startPositions	:Vector.<Point>;
		private var _flagPositions	:Vector.<Point>;
		
		public function LevelLoader()
		{
			_level = new Sprite();
		}
		
		public function loadLevel( url:String ): void
		{
			_levelLoader = new Loader();
			
			_levelLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete_createLevel);
			_levelLoader.load( new URLRequest( url ));
		}
		
		public function get level(): Sprite
		{
			return _level;
		}

		public function get startPositions(): Vector.<Point>
		{
			return _startPositions;
		}

		public function get flagPositions(): Vector.<Point>
		{
			return _flagPositions;
		}
		
		private function onComplete_createLevel( e:Event ): void
		{
			var levelDesign : BitmapData = Bitmap( _levelLoader.content ).bitmapData;
			
			_startPositions = new Vector.<Point>();
			_flagPositions = new Vector.<Point>();
			
			trace( 'creating level' );
			
			for (var col:uint = 0; col < levelDesign.width; col++) 
			{
				for (var row:uint = 0; row < levelDesign.height; row++) 
				{
					var levelObject : LevelObject;
					
					trace( levelDesign.getPixel( col, row ), 0x000000, levelDesign.getPixel( col, row ) ==  0x000000 );
				
					switch( levelDesign.getPixel( col, row ) )
					{
						case ColorCode.FLOOR:
							levelObject = new LevelObject();
							break;
						
						case ColorCode.HOLE:
							levelObject = new HolePlate();
							break;

						case ColorCode.WALL:
							levelObject = new WallPlate();
							break;

						case ColorCode.LASER_RIGHT:
							levelObject = new LaserPlate( GameSettings.RIGHT );
							break;

						case ColorCode.LASER_LEFT:
							levelObject = new LaserPlate( GameSettings.LEFT );
							break;

						case ColorCode.LASER_UP:
							levelObject = new LaserPlate( GameSettings.UP );
							break;

						case ColorCode.LASER_DOWN:
							levelObject = new LaserPlate( GameSettings.DOWN );
							break;

						case ColorCode.BAND_PLATE_RIGHT:
							levelObject = new StraightTrackPlate( GameSettings.RIGHT );
							break;

						case ColorCode.BAND_PLATE_LEFT:
							levelObject = new StraightTrackPlate( GameSettings.LEFT );
							break;

						case ColorCode.BAND_PLATE_UP:
							levelObject = new StraightTrackPlate( GameSettings.UP );
							break;

						case ColorCode.BAND_PLATE_DOWN:
							levelObject = new StraightTrackPlate( GameSettings.DOWN );
							break;

						case ColorCode.BAND_LEFT_TURN_RIGHT:
							levelObject = new LeftTrackPlate( GameSettings.RIGHT );
							break;

						case ColorCode.BAND_LEFT_TURN_LEFT:
							levelObject = new LeftTrackPlate( GameSettings.LEFT );
							break;

						case ColorCode.BAND_LEFT_TURN_UP:
							levelObject = new LeftTrackPlate( GameSettings.UP );
							break;

						case ColorCode.BAND_PLATE_DOWN:
							levelObject = new LeftTrackPlate( GameSettings.DOWN );
							break;

						case ColorCode.BAND_RIGHT_TURN_RIGHT:
							levelObject = new RightTrackPlate( GameSettings.RIGHT );
							break;

						case ColorCode.BAND_RIGHT_TURN_LEFT:
							levelObject = new RightTrackPlate( GameSettings.LEFT );
							break;

						case ColorCode.BAND_RIGHT_TURN_UP:
							levelObject = new RightTrackPlate( GameSettings.UP );
							break;

						case ColorCode.BAND_RIGHT_TURN_DOWN:
							levelObject = new RightTrackPlate( GameSettings.DOWN );
							break;

						case ColorCode.LEFT_ROTATION:
							levelObject = new LeftRotationPlate();
							break;

						case ColorCode.RIGHT_ROTATION:
							levelObject = new RightRotationPlate();
							break;

						case ColorCode.START_PLATE:
							levelObject = new StartPlate();
							_startPositions.push( new Point( col * GameSettings.GRID_SIZE, row * GameSettings.GRID_SIZE ));
							break;

						case ColorCode.FLAG_PLATE:
							levelObject = new StartPlate();
							_flagPositions.push( new Point( col * GameSettings.GRID_SIZE, row * GameSettings.GRID_SIZE ));
							break;
						
						default:
							levelObject = new LevelObject();
							
					}
					
					levelObject.x = col * GameSettings.GRID_SIZE;
					levelObject.y = row * GameSettings.GRID_SIZE;
					_level.addChild( levelObject );
				}
			}
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
}