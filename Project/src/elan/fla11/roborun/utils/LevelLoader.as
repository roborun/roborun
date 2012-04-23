package elan.fla11.roborun.utils
{
	import elan.fla11.roborun.settings.ColorCode;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class LevelLoader
	{
		private var _levelLoader	:Loader;
		private var _level			:Sprite;
		
		public function LevelLoader()
		{
		}
		
		public function loadLevel( url:String ): void
		{
			_levelLoader = new Loader();
			
			_levelLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete_createLevel);
			_levelLoader.load( new URLRequest( url ));
		}
		
		private function onComplete_createLevel( e:Event ): void
		{
			var levelDesign : BitmapData = Bitmap( _levelLoader.content ).bitmapData;
			_level = new Sprite();
			
			for (var col:uint = 0; col < levelDesign.width; col++) 
			{
				for (var row:uint = 0; row < levelDesign.height; row++) 
				{
					switch( levelDesign.getPixel( col, row ) )
					{
						case ColorCode.FLOOR:
							_level.addChild( 
					}
				}
			}
			
			
		}
	}
}