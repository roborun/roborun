package elan.fla11.roborun.view.robots
{
	import elan.fla11.roborun.WheelieGfx;
	import elan.fla11.roborun.settings.GameSettings;

	public class WheelieRobot extends RobotBase
	{
		public function WheelieRobot()
		{
			init();
			super();
		}
		
		private function init(): void
		{
			_gfx = new WheelieGfx();
			_robotID = GameSettings.WHEELIE;
		}
	}
}