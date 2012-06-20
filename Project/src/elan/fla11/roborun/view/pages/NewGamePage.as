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
		private var _lvlIdx:uint;
		
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
			_lvlBtn.x = 569.75;
			_lvlBtn.y = 502.65;
			addChild(_lvlBtn);
			_lvlBtn.addEventListener(MouseEvent.CLICK, handleChooseLvlClicked);
			trace(_lvlBtn.x, _lvlBtn.y);
			
			_shader = new Sprite();
			_shader.addEventListener(MouseEvent.CLICK, handleCloseClicked);
			_shader.graphics.beginFill(0);
			_shader.graphics.drawRect(0,0, this.width, this.height);
			_shader.graphics.endFill();
			
			_lvlPage = new LevelPage();
			_lvlPage.x = (this.width/2 - _lvlPage.width/2)+_lvlPage._offset;
			_lvlPage.y = (this.height/2 - _lvlPage.height/2)+_lvlPage._offset;
			_lvlPage.addEventListener(ButtonEvent.CLOSE, handleCloseClicked);
			_lvlPage.addEventListener(ButtonEvent.LVLCHOSEN, handleLevelChosen);
			
			trace( SlideCollection.robotIndex );
		}

		private function handleChooseLvlClicked(evt:MouseEvent):void
		{
			_shader.alpha = 0;
			addChild(_shader);
			addChild(_lvlPage);
			TweenLite.to(_shader, .5, {alpha:.7});
		}
		
		private function handleLevelChosen(evt:ButtonEvent):void
		{
			_lvlIdx = _lvlPage.targetIdx;
			trace(_lvlIdx);
		}
		
		private function handleCloseClicked(event:Event):void
		{
			removeChild(_lvlPage);
			removeChild(_shader);
		}		
		
		private function handleStartClicked(evt:MouseEvent):void
		{
			trace('Start Clicked');
			trace( 'Index', SlideCollection.robotIndex );
			if(GroupNameInput.Tf.length > 2)
			{
				
				trace( 'groupName', GroupNameInput.Tf.text );
				trace( 'userName', UserNameInput.Tf.text );	
			
				ConnectionManager.connect(GroupNameInput.Tf.text, {userName: UserNameInput.Tf.text, robot: SlideCollection.robotIndex, level: _lvlIdx, playerOrder:0});
				dispatchEvent( new Event( StartEvent.START_GAME, true ) );
				
			}
			else
				trace('Please insert a username and groupname');
		}
	}
}