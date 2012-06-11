package elan.fla11.roborun.view.pages
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import elan.fla11.roborun.GamePageGfx;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.events.StartEvent;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.ConnectionManager;
	import elan.fla11.roborun.view.gui.Button;
	import elan.fla11.roborun.view.slideshow.SlideCollection;
	import elan.fla11.roborun.view.slideshow.SlideShow;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class NewGamePage extends PageBase
	{
		private var _startBtn:Button;
		private var _lvlBtn:Button;
		private var _shader:Sprite;
		private var _lvlPage:LevelPage;
		
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
			
			_lvlBtn = new Button(GameSettings.BUTTON_COLOR);
			_lvlBtn.Label.text = 'Choose level';
			_lvlBtn.x = slideShow.x + slideShow.width/2 - _lvlBtn.width/2;
			_lvlBtn.y = slideShow.y + slideShow.height + _lvlBtn.height;
			addChild(_lvlBtn);
			_lvlBtn.addEventListener(MouseEvent.CLICK, handleChooseLvlClicked);
			
			_shader = new Sprite();
			_shader.graphics.beginFill(0);
			_shader.graphics.drawRect(0,0, this.width, this.height);
			_shader.graphics.endFill();
			_shader.alpha = 0;
			_shader.visible = false;
			addChild(_shader);
			
			_lvlPage = new LevelPage();
			_lvlPage.visible = false;
			_lvlPage.x = (this.width/2 - _lvlPage.width/2)+_lvlPage._offset;
			_lvlPage.y = (this.height/2 - _lvlPage.height/2)+_lvlPage._offset;
			_lvlPage.addEventListener(ButtonEvent.CLOSE, handleCloseClicked);
			addChild(_lvlPage);
			trace( SlideCollection.robotIndex );
			
			
		}

		private function handleChooseLvlClicked(evt:MouseEvent):void
		{
			_shader.visible = true;
			_lvlPage.visible = true;
			TweenLite.to(_shader, .5, {alpha:.7});
		}
		
		private function handleCloseClicked(event:Event):void
		{
			_shader.alpha = 0;
			_shader.visible = false;
			_lvlPage.visible = false;
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