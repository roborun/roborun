package elan.fla11.roborun.view.robots
{
	import elan.fla11.roborun.settings.GameSettings;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class RobotBase extends Sprite
	{
		protected var _userID		:String;
		protected var _robotID		:uint;
		
		protected var _gfx			:Sprite;
		
		protected var _delta		:int;
		protected var _rot			:int;

		protected var _prevPos		:Point;
		protected var _prevRot		:uint;

		public function RobotBase()
		{
			_prevPos = new Point();
			_prevRot = GameSettings.RIGHT;
			
			_gfx.x = GameSettings.GRID_SIZE *.5;
			_gfx.y = GameSettings.GRID_SIZE *.5;
			addChild( _gfx );
			
			trace( 'Init robot', _userID );
		}

		public function get userID(): String
		{
			return _userID;
		}
		
		public function move( d:int = 0 ): void
		{
			_prevPos.x = x;
			_prevPos.y = y;
			_delta = d * GameSettings.GRID_SIZE;
		}
		
		public function rotate( rot:int = 0 ): void
		{
			_rot = rot;
		}
		
		public function update(): void
		{
			
			if( _gfx.rotation == GameSettings.UP )
			{
				if( y > _prevPos.y - _delta ) y--;
				else _delta = 0;
				
				if( _rot != 0 && _prevRot == GameSettings.UP )  _gfx.rotation += _rot;
				else 
				{
					_rot = 0;
					_prevRot = GameSettings.UP;
				}
			}
			else if(  _gfx.rotation == GameSettings.DOWN )
			{
				if( y < _prevPos.y + _delta ) y++;
				else _delta = 0;

				if( _rot != 0 && _prevRot == GameSettings.DOWN )  _gfx.rotation += _rot;
				else 
				{
					_rot = 0;
					_prevRot = GameSettings.DOWN;
				}
			}
			else if(  _gfx.rotation == GameSettings.RIGHT )
			{
				if( x < _prevPos.x + _delta ) x++;
				else _delta = 0;		
				
				if( _rot != 0 && _prevRot == GameSettings.RIGHT )
				{
					trace( 'rotate');
					_gfx.rotation += _rot;
				}
				else 
				{
					_rot = 0;
					_prevRot = GameSettings.RIGHT;
				}
			}
			else if(  _gfx.rotation == GameSettings.LEFT )
			{
				if( x > _prevPos.x - _delta ) x--;
				else _delta = 0;				

				if( _rot != 0 && _prevRot == GameSettings.LEFT )  _gfx.rotation += _rot;
				else 
				{
					_rot = 0;
					_prevRot = GameSettings.LEFT;
				}
			}
		}
	}
}