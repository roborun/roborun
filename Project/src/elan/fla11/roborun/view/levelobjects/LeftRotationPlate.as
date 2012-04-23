package elan.fla11.roborun.view.levelobjects
{
	import elan.fla11.roborun.Embeder;
	import elan.fla11.roborun.settings.GameSettings;

	public class LeftRotationPlate extends LevelObject
	{	
		
		public function LeftRotationPlate()
		{
			super( Embeder.LEFT_ROTATION_ARROW );
		}
		
		override public function activate(): void
		{
			_object.rotation += GameSettings.ROTATION_SPEED;
		}
	}
}