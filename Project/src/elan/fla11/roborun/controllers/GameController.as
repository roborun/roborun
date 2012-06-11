package elan.fla11.roborun.controllers
{
	import elan.fla11.roborun.models.LevelData;
	import elan.fla11.roborun.utils.LevelLoader;
	
	import flash.display.Sprite;

	public class GameController extends Sprite
	{
		private var _level			:Sprite;
		
		private var _levelLoader	:LevelLoader;
		
		public function GameController()
		{
			init();
		}
		
		private function init(): void
		{
			_levelLoader = new LevelLoader();
		}
		
		public function setCurrentLevel( level:LevelData ): void
		{
			_levelLoader.loadLevel( level.source );
			_level = _levelLoader.level;
			addChild( _level );
		}
	}
}