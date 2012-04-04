package com.roborun.p2pupdate.views
{
	import flash.display.Sprite;
	
	public class Robot extends Sprite
	{
		private var _id 	:String;
		private var _gfx	:Sprite;

		public function Robot( id:String )
		{
			_id = id;
			_gfx = new Sprite();
			initGfx();
		}
		
		public function get id(): String
		{
			return _id;
		}

		public function get robotRotation(): int
		{
			return _gfx.rotation;
		}
		
		public function set rotate( value:int ): void
		{
			_gfx.rotation += value;
		}
		
		public function set moveX( value:int ): void
		{
			x += value;
		}

		public function set moveY( value:int ): void
		{
			y += value;
		}
		
		private function initGfx(): void
		{
			_gfx.graphics.beginFill( 0xFFcc00 );
			_gfx.graphics.drawRect( -25, -25, 50, 50 );
			_gfx.graphics.lineStyle( 1 );
			_gfx.graphics.moveTo( 0,0 );
			_gfx.graphics.lineTo( 25,0 );
			
			
			_gfx.x = 25;
			_gfx.y = 25;
			
			addChild( _gfx );
		}
	}
}