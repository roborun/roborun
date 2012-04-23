package elan.fla11.roborun.view.levelobjects
{
	import elan.fla11.roborun.Embeder;
	
	import flash.display.Bitmap;

	public class LaserPlate extends LevelObject
	{
		public function LaserPlate( r:uint )
		{
			super( Embeder.LASER );
			_object.rotation = r;
		}
	}
}