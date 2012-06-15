package elan.fla11.roborun.view.robots
{
	import elan.fla11.roborun.settings.GameSettings;
	
	import flash.display.Sprite;
	
	public class RobotBase extends Sprite
	{
		protected var _userID		:String;
		protected var _robotID		:uint;
		protected var _gfx			:Sprite;
		
		public function RobotBase()
		{
			_gfx.x = GameSettings.GRID_SIZE *.5;
			_gfx.y = GameSettings.GRID_SIZE *.5;
			addChild( _gfx );
			
			trace( 'Init robot', _userID );
		}

		public function get userID(): String
		{
			return _userID;
		}
	}
}