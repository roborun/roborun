package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GamePageGfx;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.view.gui.Button;
	import elan.fla11.roborun.view.slideshow.SlideShow;
	
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.text.TextFieldAutoSize;
	
	public class PageBase extends GamePageGfx
	{
		private var _backBtn:Button;
		protected var slideShow:SlideShow;
		protected var loader:URLLoader;
		
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
		}
		
		private function handleButtonClicked_back(evt:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.BACK));
		}
		
		public function restartSlideShow():void
		{
			slideShow = new SlideShow();
			slideShow.x = (GameSettings.STAGE_W - SlideShow.slideShow_width) - GameSettings.BORDER_THICKNESS_Y;
			slideShow.y = GameSettings.BORDER_THICKNESS_Y;
			addChild(slideShow);
		}
	}
}