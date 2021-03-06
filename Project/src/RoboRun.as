package
{
	import elan.fla11.roborun.controllers.GameController;
	import elan.fla11.roborun.controllers.PageController;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.events.LvlsCompleteEvent;
	import elan.fla11.roborun.events.StartEvent;
	import elan.fla11.roborun.models.LevelModel;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.sound.ButtonSound;
	import elan.fla11.roborun.sound.CardBannerSound;
	import elan.fla11.roborun.sound.ChatSound;
	import elan.fla11.roborun.sound.Sounds;
	import elan.fla11.roborun.utils.LevelLoader;
	import elan.fla11.roborun.utils.SoundManager;
	import elan.fla11.roborun.view.levelobjects.LaserPlate;
	import elan.fla11.roborun.view.levelobjects.LeftRotationPlate;
	import elan.fla11.roborun.view.levelobjects.statics.HolePlate;
	import elan.fla11.roborun.view.levelobjects.tracks.LeftTrackPlate;
	import elan.fla11.roborun.view.levelobjects.tracks.RightTrackPlate;
	import elan.fla11.roborun.view.levelobjects.tracks.StraightTrackPlate;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
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
			
			initSounds();
		}
		
		private function initSounds():void
		{
			SoundManager.addSound(Sounds.BUTTON, new ButtonSound);
			SoundManager.addSound(Sounds.CARD_BANNER, new CardBannerSound);
			SoundManager.addSound(Sounds.CHAT, new ChatSound);
		}
		
		private function onLevelsLoaded_startPages( e:LvlsCompleteEvent ): void
		{

			_pageController = new PageController();
			addChild( _pageController );
			
			addEventListener(StartEvent.START_GAME, onActivate_StartGame);
			
		}
		
		
		private function onActivate_StartGame( e:Event ): void
		{
			_gameController = new GameController();
			removeChild( _pageController );
			addChild( _gameController );
		}
		
	}
}