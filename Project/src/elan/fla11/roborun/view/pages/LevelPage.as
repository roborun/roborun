package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.LevelPageGfx;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.view.gui.Button;
	import elan.fla11.roborun.view.gui.Scroller;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class LevelPage extends LevelPageGfx
	{
		private var _closeBtn:Button;
		private var _chooseBtn:Button;
		private var _scroller:Scroller;
		
		public function LevelPage()
		{
			super();
			
			_closeBtn = new Button(GameSettings.BUTTON_COLOR);
			_closeBtn.x = 20;
			_closeBtn.y = _closeBtn.height/2;
			_closeBtn.Label.text = 'X';
			_closeBtn.addEventListener(MouseEvent.CLICK, handleCloseClicked);
			addChild(_closeBtn);
			
			_chooseBtn = new Button(GameSettings.BUTTON_COLOR);
			_chooseBtn.x = this.width/2 - _chooseBtn.width/2;
			_chooseBtn.y = this.height - (_chooseBtn.height+10);
			_chooseBtn.Label.text = 'Choose';
			_chooseBtn.addEventListener(MouseEvent.CLICK, handleChooseClicked);
			addChild(_chooseBtn);
			
			_scroller = new Scroller(410);
			_scroller.x = this.width - (_scroller.width+20);
			_scroller.y = 20;
			addChild(_scroller);
		}
		
		private function handleChooseClicked(evt:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.LVLCHOSEN));
		}
		
		private function handleCloseClicked(evt:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.CLOSE));
		}
	}
}