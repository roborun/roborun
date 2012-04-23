package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GamePageGfx;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class InstructionsPage extends PageBase
	{		
		public function InstructionsPage()
		{
			super();
			UserNameInput.visible = false;
			GroupNameInput.visible = false;
			UserTf.visible = false;
			GroupTf.visible = false;
			removeChild(slideShow);
			
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, handleLoaderComplete);
			loader.load(new URLRequest('TextFiles/Instructions.txt'));
		}
		
		private function handleLoaderComplete(evt:Event):void
		{
			HeadTf.text = loader.data;
		}
	}
}