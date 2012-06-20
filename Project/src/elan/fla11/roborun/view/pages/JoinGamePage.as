package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GamePageGfx;
	import elan.fla11.roborun.events.StartEvent;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.ConnectionManager;
	import elan.fla11.roborun.view.gui.Button;
	import elan.fla11.roborun.view.slideshow.SlideCollection;
	
	import flash.events.Event;
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
			ConnectionManager.connect(GroupNameInput.Tf.text, {userName: UserNameInput.Tf.text, robot: SlideCollection.robotIndex, playerOrder:1});
			dispatchEvent( new Event( StartEvent.START_GAME, true ) );
		}
	}
}