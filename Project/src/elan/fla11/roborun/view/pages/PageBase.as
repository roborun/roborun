package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GamePageGfx;
	import elan.fla11.roborun.GameSettings;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.view.gui.Button;
	
	import flash.events.MouseEvent;
	
	public class PageBase extends GamePageGfx
	{
		private var _backBtn:Button;
		
		public function PageBase()
		{
			super();
		
			_backBtn = new Button(GameSettings.BUTTON_COLOR);
			_backBtn.x = GameSettings.BORDER_THICKNESS_X;
			_backBtn.y = GameSettings.STAGE_H - GameSettings.BORDER_THICKNESS_Y;
			_backBtn.Label.text = 'Back';
			addChild(_backBtn);
			_backBtn.addEventListener(MouseEvent.CLICK, handleButtonClicked_back);
		}
		
		private function handleButtonClicked_back(evt:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.BACK));
		}
	}
}