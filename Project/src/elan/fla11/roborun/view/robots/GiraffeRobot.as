package elan.fla11.roborun.view.robots
{
	import elan.fla11.roborun.GiraffeGfx;
	import elan.fla11.roborun.settings.GameSettings;

	public class GiraffeRobot extends RobotBase
	{
		public function GiraffeRobot( userID:String )
		{
			init();
			_userID = userID;
			super();
		}
		
		private function init(): void
		{
			_gfx = new GiraffeGfx;
			_robotID = GameSettings.GIRAFFE;
		}
	}
}