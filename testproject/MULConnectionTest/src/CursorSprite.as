package
{
	import flash.display.Sprite;
	
	public class CursorSprite extends Sprite
	{
		private var _userName	:String;
		
		public function CursorSprite( userName :String, color :uint )
		{
			_userName = userName;
			init( color );
		}
		
		private function init( color : uint ): void
		{
			graphics.beginFill( color );
			graphics.drawCircle(0,0, 10);
		}
		
		public function update( xpos:int, ypos:int ):void
		{
			x = xpos;
			y = ypos;
		}
	}
}