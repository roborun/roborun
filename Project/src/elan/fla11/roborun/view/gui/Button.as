package elan.fla11.roborun.view.gui
{
	import elan.fla11.roborun.ButtonGfx;
	import elan.fla11.roborun.sound.Sounds;
	import elan.fla11.roborun.utils.SoundManager;
	
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class Button extends ButtonGfx
	{
		private var _color:uint;
		
		public function Button(color:uint = 0)
		{
			super();
			Label.autoSize = TextFieldAutoSize.LEFT;
			Label.textColor = color;
			_color = color;
			mouseChildren = false;
			buttonMode = true;
			useHandCursor = true;
			
			addEventListener(MouseEvent.MOUSE_OVER, handleMouseOver);
			addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		private function handleClick(evt:MouseEvent):void
		{
			SoundManager.playSound(Sounds.BUTTON, .1);
		}
		
		private function handleMouseOver(evt:MouseEvent):void
		{
			addEventListener(MouseEvent.MOUSE_OUT, handleMouseOut)
			Label.textColor = 0xFFFFFF;
		}
		
		private function handleMouseOut(evt:MouseEvent):void
		{
			Label.textColor = _color;
		}
		
	}
}