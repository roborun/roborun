package elan.fla11.roborun.view.robots
{
	import elan.fla11.roborun.settings.GameSettings;
	
	import flash.display.Sprite;
	
	public class RobotBase extends Sprite
	{
		protected var _robotID		:uint;
		protected var _gfx			:Sprite;
		
		public function RobotBase()
		{
			_gfx.x = GameSettings.GRID_SIZE *.5;
			_gfx.y = GameSettings.GRID_SIZE *.5;
			addChild( _gfx );
		}
		
		public function get robotID(): uint
		{
			return _robotID;
		}
	}
}