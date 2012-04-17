package
{
	import elan.fla11.roborun.utils.ConnectionManager;
	import elan.fla11.roborun.view.pages.NewGamePage;
	import elan.fla11.roborun.view.pages.StartPage;
	
	import flash.display.Sprite;
	
	[SWF(width="1024", height="750", frameRate="30")]
	public class RoboRun extends Sprite
	{
		private var _page:StartPage;
		public function RoboRun()
		{
			_page = new StartPage();
			addChild(_page);
		}
	}
}