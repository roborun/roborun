package elan.fla11.roborun.controllers
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import elan.fla11.roborun.Embeder;
	import elan.fla11.roborun.events.StartEvent;
	import elan.fla11.roborun.models.LevelData;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.LevelCamera;
	import elan.fla11.roborun.utils.LevelLoader;
	import elan.fla11.roborun.utils.SpritePool;
	import elan.fla11.roborun.view.GameCard;
	import elan.fla11.roborun.view.pages.GameBackground;
	import elan.fla11.roborun.view.robots.BullRobot;
	import elan.fla11.roborun.view.robots.GiraffeRobot;
	import elan.fla11.roborun.view.robots.RobotBase;
	import elan.fla11.roborun.view.robots.WheelieRobot;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class GameController extends Sprite
	{
		private var _world			:Sprite;
		private var _level			:Sprite;
		private var _camera			:LevelCamera;
		
		private var _levelLoader	:LevelLoader;
		private var _robot			:RobotBase;
		
		private var _cardPool		:SpritePool;
		private var _numCard		:uint;
		private var _cards			:Array;
		
		private var _cardBanner		:Bitmap;
		private var _gameMenuGfx	:GameBackground;
		
		public function GameController()
		{
			init();
		}
		
		private function init(): void
		{
			_cardPool = new SpritePool( GameCard, 9 );
			_cards = [];
			_levelLoader = new LevelLoader();
			_camera = new LevelCamera();
			
			_cardBanner = new Embeder.CARD_BANNER();
			
			_gameMenuGfx = new GameBackground();
			addChild( _gameMenuGfx );
			
			_world = new Sprite();
			addChild( _world );
		}
		
		public function setCurrentLevel( level:LevelData ): void
		{
			_levelLoader.loadLevel( level.source );
			_levelLoader.addEventListener(Event.COMPLETE, onComplete_startGame);
			_level = _levelLoader.level;
			_world.addChild( _level );
			
		}
		
		public function startGame( e:StartEvent ): void
		{
			_robot = addRobot( e.userDetails.robot );
			_world.addChild( _robot );
		}
		
		private function onComplete_startGame( e:Event ): void
		{
			_numCard = 9;
			_robot.x = _levelLoader.startPositions[0].x;
			_robot.y = _levelLoader.startPositions[0].y;			
			_camera.setWorld( _world );
			
			_world.addEventListener(MouseEvent.CLICK, onClick_add);
			_gameMenuGfx.addEventListener(MouseEvent.CLICK, onClick_remove);
			
			//addCards();
		}
		
		private function onClick_add( e:MouseEvent ): void
		{
			_gameMenuGfx.addWarning();
		}
		private function onClick_remove( e:MouseEvent ): void
		{
			_gameMenuGfx.removeWarning();
		}
		
		
		private function addCards(): void
		{
			_cardBanner.x = GameSettings.STAGE_W;
			_cardBanner.y = 515;
			addChild( _cardBanner );
			TweenLite.to( _cardBanner, 1, {x: 0, delay: 1} );
			
			for (var i:int = 0; i < _numCard; ++i) 
			{
				_cards.push( _cardPool.getSprite() );
				_cards[i].shuffle();
				_cards[i].small();
				_cards[i].x = i * 105 + 40;
				_cards[i].y = 555;
				_cards[i].alpha = 0;
				addChild( _cards[i] );
			}
	
			TweenMax.allTo( _cards, .2, {alpha: 1, delay:  2}, .3);
			
		}
		
		private function addRobot( robotID:uint ): RobotBase
		{
			var robot : RobotBase;
			switch( robotID )
			{
				case GameSettings.BULL:
					robot = new BullRobot();
					break;
				
				case GameSettings.GIRAFFE:
					robot = new GiraffeRobot();
					break;
				
				case GameSettings.WHEELIE:
					robot = new WheelieRobot();
					break;
			}
			return robot;
		}
	}
}