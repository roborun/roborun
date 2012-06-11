package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GamePageGfx;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.events.StartEvent;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.ConnectionManager;
	import elan.fla11.roborun.view.gui.Button;
	import elan.fla11.roborun.view.slideshow.SlideCollection;
	import elan.fla11.roborun.view.slideshow.SlideShow;
	
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
			
			trace( SlideCollection.robotIndex );
			
			
		}
		
		private function handleStartClicked(evt:MouseEvent):void
		{
			trace('Start Clicked');
			trace( 'Index', SlideCollection.robotIndex );
			if(GroupNameInput.Tf.length > 2)
			{
				
				trace( 'groupName', GroupNameInput.Tf.text );
				trace( 'userName', UserNameInput.Tf.text );	
				
				var start_evt : StartEvent = new StartEvent( StartEvent.START_GAME, true );
				start_evt._groupName = GroupNameInput.Tf.text;
				start_evt._userDetails = {userName: UserNameInput.Tf.text, robot: SlideCollection.robotIndex, level: 0};
				start_evt._levelId = 0;
			
				ConnectionManager.connect(GroupNameInput.Tf.text, {userName: UserNameInput.Tf.text, robot: SlideCollection.robotIndex, level: 0});
				dispatchEvent( start_evt );
			}
			else
				trace('Please insert a username and groupname');
		}
	}
}