package elan.fla11.roborun.view.levelobjects.tracks
{
	import elan.fla11.roborun.Embeder;
	import elan.fla11.roborun.view.levelobjects.LevelObject;
	
	public class RightTrackPlate extends LevelObject
	{
		public function RightTrackPlate( r:uint )
		{
			super( Embeder.RIGHT_TRACK, false );
			_object.rotation = r;
		}
	}
}