package elan.fla11.roborun.controllers
{
	import elan.fla11.roborun.events.StartEvent;
	import elan.fla11.roborun.models.LevelData;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.LevelCamera;
	import elan.fla11.roborun.utils.LevelLoader;
	import elan.fla11.roborun.view.robots.BullRobot;
	import elan.fla11.roborun.view.robots.GiraffeRobot;
	import elan.fla11.roborun.view.robots.RobotBase;
	import elan.fla11.roborun.view.robots.WheelieRobot;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class GameController extends Sprite
	{
		private var _world			:Sprite;
		private var _level			:Sprite;
		private var _camera			:LevelCamera;
		
		private var _levelLoader	:LevelLoader;
		private var _robot			:RobotBase;
		
		public function GameController()
		{
			init();
		}
		
		private function init(): void
		{
			_levelLoader = new LevelLoader();
			_camera = new LevelCamera();
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
			_robot.x = _levelLoader.startPositions[0].x;
			_robot.y = _levelLoader.startPositions[0].y;			
			_camera.setWorld( _world );
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