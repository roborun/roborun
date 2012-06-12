package
{
	import elan.fla11.roborun.controllers.GameController;
	import elan.fla11.roborun.controllers.PageController;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.events.LvlsCompleteEvent;
	import elan.fla11.roborun.events.StartEvent;
	import elan.fla11.roborun.models.LevelModel;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.LevelLoader;
	import elan.fla11.roborun.view.levelobjects.LaserPlate;
	import elan.fla11.roborun.view.levelobjects.LeftRotationPlate;
	import elan.fla11.roborun.view.levelobjects.statics.HolePlate;
	import elan.fla11.roborun.view.levelobjects.tracks.LeftTrackPlate;
	import elan.fla11.roborun.view.levelobjects.tracks.RightTrackPlate;
	import elan.fla11.roborun.view.levelobjects.tracks.StraightTrackPlate;
	
	import flash.display.Sprite;
	
	[SWF(width="1024", height="750", frameRate="30")]
	public class RoboRun extends Sprite
	{
		private var _pageController		:PageController;
		private var _gameController		:GameController;
		
		private var _levelMdb			:LevelModel;
		
		public function RoboRun()
		{
			GameSettings.STAGE = stage;
			init();
		}
		
		private function init(): void
		{
			_levelMdb = new LevelModel();
			_levelMdb.addEventListener(LvlsCompleteEvent.lvlsLoaded, onLevelsLoaded_startPages);
		}
		
		private function onLevelsLoaded_startPages( e:LvlsCompleteEvent ): void
		{
			_gameController = new GameController();

			_pageController = new PageController();
			addChild( _pageController );
			
			
			addEventListener(StartEvent.START_GAME, onStartGame);
			
		}
		
		
		
		private function onStartGame( e:StartEvent ): void
		{
			trace(' start new game ');
			removeChild( _pageController );
			_gameController.setCurrentLevel( _levelMdb.levels[e.levelId] );
			_gameController.startGame( e );
			addChild( _gameController );
		}
		
	}
}