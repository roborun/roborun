package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GamePageGfx;
	
	public class InstructionsPage extends PageBase
	{
		public function InstructionsPage()
		{
			super();
			HeadTf.text = 'Instructions';
			UserNameTf.visible = false;
			GroupNameTf.visible = false;
		}
	}
}