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
			var flag : GoalPlateGfx = new GoalPlateGfx();
			flag.number_tf.text = String( _nr );
			addChild( flag );
		}
		
		public function get nr():uint
		{
			return _nr;
		}
	}
}