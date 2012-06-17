package elan.fla11.roborun.view.gui
{
	import elan.fla11.roborun.CardOrderPloppGfx;
	
	public class CardOrderPlop extends CardOrderPloppGfx
	{
		private var _number		:uint;
		private var _radius		:uint;
		public var index		:uint;
		
		public function CardOrderPlop( number:uint )
		{
			number_tf.text = String( number );
			_radius = width *.5;
			mouseChildren = false;
			buttonMode = true;
			useHandCursor = true;
		}
		
		public function get number(): uint
		{
			return _number;
		}
		
		public function get radius(): uint
		{
			return _radius;
		}
	}
}