package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GamePageGfx;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.view.gui.Button;
	
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class NewGamePage extends PageBase
	{
		private var _startBtn:Button;
		
		public function NewGamePage()
		{
			super();
			HeadTf.text = 'New Game';
			
			_startBtn = new Button(GameSettings.BUTTON_COLOR);
			_startBtn.Label.text = 'Start';
			_startBtn.x = (GameSettings.STAGE_W - _startBtn.width) - GameSettings.BORDER_THICKNESS_X;
			_startBtn.y = GameSettings.STAGE_H - GameSettings.BORDER_THICKNESS_Y;
			addChild(_startBtn);
			_startBtn.addEventListener(MouseEvent.CLICK, handleStartClicked);
		}
		
		private function handleStartClicked(evt:MouseEvent):void
		{
			trace('Start Clicked');
		}
	}
}