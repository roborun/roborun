package elan.fla11.roborun.view.gui
{
	import elan.fla11.roborun.ButtonGfx;
	
	import flash.text.TextFieldAutoSize;
	
	public class Button extends ButtonGfx
	{
		public function Button()
		{
			super();
			this.buttonMode = true;
			this.Tf.autoSize = TextFieldAutoSize.LEFT;
		}
		
		public function set buttonLabel(label:String):void
		{
			this.Tf.text = label;
			this.width = Tf.width +5;
		}
	}
}