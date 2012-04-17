package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GamePageGfx;
	import elan.fla11.roborun.GameSettings;
	
	import flash.text.TextFieldAutoSize;
	
	public class NewGamePage extends GamePageGfx
	{
		public function NewGamePage()
		{
			super();
			this.width = GameSettings.STAGE_W;
			this.height = GameSettings.STAGE_H;
			this.HeadTf.autoSize = TextFieldAutoSize.LEFT;
			this.UserNameTf.maxChars = 10;
			this.UserNameTf.background = true;
			this.UserNameTf.backgroundColor = 0xFFFFFF;
			this.UserNameTf.restrict = 'A-Za-z0-9';
			this.GroupNameTf.maxChars = 10;
			this.GroupNameTf.background = true;
			this.GroupNameTf.backgroundColor = 0xFFFFFF;
			this.GroupNameTf.restrict = 'A-Za-z0-9';
		}
	}
}