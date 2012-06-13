package elan.fla11.roborun.utils
{
	import flash.display.Sprite;

	public class SpritePool
	{
		private var _pool		:Array;
		private	var _counter	:int;
		private	var _type		:Class;
		
		public function SpritePool( type:Class, len:uint )
		{
			_pool = [];
			_counter = len;
			_type = type;
			
			for (var i:int = 0; i < len; ++i) 
			{
				_pool.push( new type() );
			}
		}
		
		public function getSprite(): Sprite
		{
			if( _counter > 0 )
				return _pool[ --_counter ];
			else
			{
				_pool.push( new _type() );
				trace( 'new', _type );	
				return _pool[ _pool.length -1 ];
			}	
		}
		
		public function returnSprite( s:Sprite ): void
		{
			_pool[++_counter] = s;
		}
	}
}