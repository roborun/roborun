package elan.fla11.roborun.view.levelobjects.statics
{
	import elan.fla11.roborun.GoalPlateGfx;
	import elan.fla11.roborun.view.levelobjects.LevelObject;
	
	public class FlagPlate extends LevelObject
	{
		private var _nr:uint;
		
		public function FlagPlate(nr:uint)
		{
			super(GoalPlateGfx, false);
			_object.numberTf.text = nr as String;
		}
		
		public function get nr():uint
		{
			return _nr;
		}
	}
}