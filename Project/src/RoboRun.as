package
{
	import elan.fla11.roborun.controllers.PageController;
	
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
		}
		
	}
}