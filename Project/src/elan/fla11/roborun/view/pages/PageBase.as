package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GamePageGfx;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.view.gui.Button;
	import elan.fla11.roborun.view.slideshow.SlideShow;
	
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class PageBase extends GamePageGfx
	{
		private var _backBtn:Button;
		private var _slideShow:SlideShow;
		
		public function PageBase()
		{
			super();
			HeadTf.autoSize = TextFieldAutoSize.LEFT;
			_backBtn = new Button(GameSettings.BUTTON_COLOR);
			_backBtn.x = GameSettings.BORDER_THICKNESS_X;
			_backBtn.y = GameSettings.STAGE_H - GameSettings.BORDER_THICKNESS_Y;
			_backBtn.Label.text = 'Back';
			addChild(_backBtn);
			_backBtn.addEventListener(MouseEvent.CLICK, handleButtonClicked_back);
			
			_slideShow = new SlideShow();
			_slideShow.x = (GameSettings.STAGE_W - _slideShow.slideShow_width) - GameSettings.BORDER_THICKNESS_Y;
			_slideShow.y = GameSettings.BORDER_THICKNESS_Y;
			addChild(_slideShow);
		}
		
		private function handleButtonClicked_back(evt:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.BACK));
		}
	}
}