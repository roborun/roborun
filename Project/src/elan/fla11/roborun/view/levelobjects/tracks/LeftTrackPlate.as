package elan.fla11.roborun.view.levelobjects.tracks
{
	import elan.fla11.roborun.Embeder;
	import elan.fla11.roborun.view.levelobjects.LevelObject;
	
	public class LeftTrackPlate extends LevelObject
	{
		public function LeftTrackPlate( r:uint )
		{
			super( Embeder.LEFT_TRACK, false );
			_object.rotation = r;
		}
	}
}