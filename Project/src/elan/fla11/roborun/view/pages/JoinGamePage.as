package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GamePageGfx;
	import elan.fla11.roborun.GameSettings;
	import elan.fla11.roborun.view.gui.Button;
	
	import flash.events.MouseEvent;
	
	public class JoinGamePage extends PageBase
	{
		private var _joinBtn:Button;
		
		public function JoinGamePage()
		{
			super();
			HeadTf.text = 'Join Game';
			
			_joinBtn = new Button(GameSettings.BUTTON_COLOR);
			_joinBtn.Label.text = 'Join';
			_joinBtn.x = (GameSettings.STAGE_W - _joinBtn.width) - GameSettings.BORDER_THICKNESS_X;
			_joinBtn.y = GameSettings.STAGE_H - GameSettings.BORDER_THICKNESS_Y;
			addChild(_joinBtn);
			_joinBtn.addEventListener(MouseEvent.CLICK, handleJoinClicked);
		}
		
		private function handleJoinClicked(evt:MouseEvent):void
		{
			trace('Join clicked');
		}
	}
}