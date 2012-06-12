package elan.fla11.roborun.view.gui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import elan.fla11.roborun.ChosenLvlGfx;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.events.LvlsCompleteEvent;
	import elan.fla11.roborun.events.ScrollEvent;
	import elan.fla11.roborun.models.LevelModel;
	import elan.fla11.roborun.settings.GameSettings;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class List extends Sprite
	{
		private const _maskerWidth:uint = 555;
		private const _maskerHeight:uint = 410;
		private var _listItems:Vector.<Button>;
		private var _scroller:Scroller;
		private var _listMasker:Sprite;
		private var _listContainer:Sprite;
		private var _idx:uint;
		private var _listPos:Number;
		private var _symb:ChosenLvlGfx;
		
		public function List(model:LevelModel)
		{
			init();
		}
		
		private function init():void
		{
			_listMasker = new Sprite();
			_listMasker.graphics.beginFill(0xFF000000);
			_listMasker.graphics.drawRect(0, 0, _maskerWidth, _maskerHeight);
			_listMasker.graphics.endFill();
			addChild(_listMasker);
			
			_listContainer = new Sprite();
			_listContainer.mask = _listMasker;
			addChild(_listContainer);
			
			_symb = new ChosenLvlGfx();
			_symb.visible = false;
			_listContainer.addChild(_symb);
			
			addListItems();
		}
		
		
		/*skapar ListItems och skickar in infon*/
		private function addListItems():void
		{
			_listItems = new Vector.<Button>();
			for (var i:int = 0; i < LevelModel.levels.length; i++) 
			{
				_listItems.push(new Button(GameSettings.BUTTON_COLOR));
				_listItems[i].Label.text = LevelModel.levels[i].title;
				_listItems[i].addEventListener(MouseEvent.CLICK, handleListItemClicked_showDetails);
				_listItems[i].x = 5;
				_listItems[i].y = i*(_listItems[i].height+10);
				_listContainer.addChild(_listItems[i]);
			}
			
			/*lägger till scrollern ifall den behövs*/
			if(_listContainer.height >= _listMasker.height)
			{
				_scroller = new Scroller(397);
				_scroller.x = _maskerWidth + _scroller.width;
				_scroller.y = 12;
				addChild(_scroller);
				_scroller.addEventListener(ScrollEvent.SCROLLING, handleScrollEvent);
			}
		}
		
		private function handleListItemClicked_showDetails(evt:MouseEvent):void
		{
			_idx = _listItems.indexOf(evt.currentTarget);
			_symb.x = _listMasker.width - _symb.width;
			_symb.y = _listItems[_idx].y + _symb.height/2;
			_symb.visible = true;
			dispatchEvent(new ButtonEvent(ButtonEvent.LVLCHOSEN));
		}
		
		private function handleScrollEvent(evt:Event):void
		{
			_listPos = -_scroller.scrollPosition*(_listContainer.height - _listMasker.height);
			TweenLite.from(_listContainer, .5, {y:_listContainer.y, ease:Quad.easeOut});
			TweenLite.to(_listContainer, .5, {y:_listPos, ease:Quad.easeOut});
		}
		/*returnerar den klickade kontaktens index, så jag kan få tag i rätt info i main*/
		public function get targetIdx():uint
		{
			return _idx;
		}
		
	}
}