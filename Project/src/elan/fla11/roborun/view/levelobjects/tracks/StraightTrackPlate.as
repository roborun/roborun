package elan.fla11.roborun.view.levelobjects.tracks
{
	import elan.fla11.roborun.Embeder;
	import elan.fla11.roborun.view.levelobjects.LevelObject;
	
	public class StraightTrackPlate extends LevelObject
	{
		public function StraightTrackPlate( r:uint )
		{
			super( Embeder.STRAIGHT_TRACK, false );
			_object.rotation = r;
		}
	}
}