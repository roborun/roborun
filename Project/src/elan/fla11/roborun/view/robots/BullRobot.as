package elan.fla11.roborun.view.robots
{
	import elan.fla11.roborun.BullGfx;
	import elan.fla11.roborun.settings.GameSettings;

	public class BullRobot extends RobotBase
	{
		public function BullRobot( userID:String )
		{
			init();
			_userID = userID;
			super();
		}
		
		private function init(): void
		{
			_gfx = new BullGfx();
			_robotID = GameSettings.BULL;
		}
	}
}