package elan.fla11.roborun.models
{
	import elan.fla11.roborun.events.LvlsCompleteEvent;
	import elan.fla11.roborun.settings.GameSettings;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * Load in and store all levelinfo.
	 * 
	 * Get - levels 	:Vector.<LevelData>
	 * 
	 * @author Anton Strand.
	 **/
	
	public class LevelModel extends EventDispatcher
	{
		private var _levelLoader		:URLLoader;
		private static var _levels		:Vector.<LevelData>;
		
		public function LevelModel()
		{
			loadLevels();
		}
		
		private function loadLevels(): void
		{
			_levelLoader = new URLLoader();
			_levelLoader.addEventListener(Event.COMPLETE, onComplete_parse);
			_levelLoader.load( new URLRequest( GameSettings.LEVEL_URL ));
		}
		
		private function onComplete_parse( e:Event ): void
		{
			var level_xml : XML = new XML( _levelLoader.data );
			var level_xmlList : XMLList = new XMLList( level_xml.levels.level );
			
			_levels = new Vector.<LevelData>();
			
			for each (var level:XML in level_xmlList) 
			{
				_levels.push( new LevelData( level.title, level.source ));
			}
			
			dispatchEvent(new LvlsCompleteEvent(LvlsCompleteEvent.lvlsLoaded));
			
		}
		
		public function get levels(): Vector.<LevelData>
		{
			return _levels;
		}
	}
}