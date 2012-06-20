package elan.fla11.roborun.view.levelobjects
{
	import com.greensock.TweenLite;
	
	import elan.fla11.roborun.Embeder;
	import elan.fla11.roborun.settings.GameSettings;

	public class RightRotationPlate extends LevelObject
	{	
		
		public function RightRotationPlate()
		{
			super( Embeder.RIGHT_ROTATION_ARROW );
		}
		
		override public function activate(): void
		{
			TweenLite.to( _object, 1, {rotation: _object.rotation + 90});
		}
	}
}