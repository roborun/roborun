package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.CloseButtonGfx;
	import elan.fla11.roborun.LevelPageGfx;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.models.LevelModel;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.view.gui.Button;
	import elan.fla11.roborun.view.gui.List;
	import elan.fla11.roborun.view.gui.Scroller;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class LevelPage extends LevelPageGfx
	{
		
		public const _offset:Number = 32;
		
		private var _chooseBtn:Button;
		private var _list:List;
		private var _idx:uint;
		
		public function LevelPage()
		{
			super();

			close_btn.mouseChildren = false;
			close_btn.buttonMode = true;
			close_btn.addEventListener(MouseEvent.CLICK, handleCloseClicked);
	
			_list = new List(new LevelModel);
			_list.addEventListener(ButtonEvent.LVLCHOSEN, handleLevelChosen);
			_list.x = 10;
			_list.y = 20;
			addChild(_list);
		
		}
		
		private function handleLevelChosen(evt:ButtonEvent):void
		{
			_idx = _list.targetIdx;
			dispatchEvent(evt.clone());
		}
		
		private function handleCloseClicked(evt:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.CLOSE));
		}
		
		public function get targetIdx():uint
		{
			return _idx;
		}
	}
}