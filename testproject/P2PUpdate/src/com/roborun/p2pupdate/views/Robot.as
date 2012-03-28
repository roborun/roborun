package com.roborun.p2pupdate.views
{
	import flash.display.Sprite;
	
	public class Robot extends Sprite
	{
		private var _id 	:String;
		
		public function Robot( id:String )
		{
			_id = id;
			initGfx();
		}
		
		public function get id(): String
		{
			return _id;
		}
		
		private function initGfx(): void
		{
			graphics.beginFill( 0xffcc00 );
			graphics.drawRect( 0, 0, 50, 50 );
			graphics.lineStyle( 1 );
			graphics.moveTo( 25,25 );
			graphics.lineTo( 50,25 );
		}
	}
}