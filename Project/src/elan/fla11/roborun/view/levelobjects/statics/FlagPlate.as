package elan.fla11.roborun.view.levelobjects.statics
{
	import elan.fla11.roborun.GoalPlateGfx;
	import elan.fla11.roborun.view.levelobjects.LevelObject;
	
	public class FlagPlate extends LevelObject
	{
		private var _nr:uint;
		
		public function FlagPlate(nr:uint)
		{
			_nr = nr;
			super();
		}
		
		override protected function init(objectSrc:Class=null, withPlate:Boolean=true):void
		{
			_object = new GoalPlateGfx();
			GoalPlateGfx(_object).numberTf.text = String( _nr );
			trace( 'in flag, nr:', _object.numberTf.text );
			addChild( _object );
		}
		
		public function get nr():uint
		{
			return _nr;
		}
	}
}