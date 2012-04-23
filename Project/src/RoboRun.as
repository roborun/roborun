package
{
	
	
	import elan.fla11.roborun.controllers.PageController;
	import elan.fla11.roborun.models.LevelModel;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.view.levelobjects.LaserPlate;
	import elan.fla11.roborun.view.levelobjects.LeftRotationPlate;
	import elan.fla11.roborun.view.levelobjects.statics.HolePlate;
	import elan.fla11.roborun.view.levelobjects.tracks.LeftTrackPlate;
	import elan.fla11.roborun.view.levelobjects.tracks.RightTrackPlate;
	import elan.fla11.roborun.view.levelobjects.tracks.StraightTrackPlate;
	
	import flash.display.Sprite;
	
	[SWF(width="1024", height="750", frameRate="30")]
	public class RoboRun extends Sprite
	{
		private var _pageController		:PageController;
		
		public function RoboRun()
		{
			init();
		}
		
		private function init(): void
		{
			_pageController = new PageController();
			addChild( _pageController );
			
			var lvl : LevelModel = new LevelModel();
			
			var l: HolePlate = new HolePlate(  );
			addChild( l );

			var lrp: LeftRotationPlate = new LeftRotationPlate();
			lrp.x = GameSettings.GRID_SIZE;
			addChild( lrp );
		}
		
		
	}
}