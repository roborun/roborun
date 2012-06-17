package elan.fla11.roborun.utils
{
	import elan.fla11.roborun.view.GameCard;
	
	import flash.display.Sprite;

	public class SpritePool
	{
		private static var _pool		:Array;
		private static var _choosenPool	:Array;
		private	static var _counter		:int;
		private	static var _type		:Class;

		private	static var _isInit		:Boolean;
		
		public function SpritePool()
		{
		}
		
		private static function init(): void
		{
			if( !_isInit )
			{
				_pool = [];
				_choosenPool = [];
				_counter = 9;
				_type = GameCard;
				
				for (var i:int = 0; i < _counter; ++i) 
				{
					_pool.push( new _type() );
				}			
				_isInit = true;
			}
		}
		
		public static function getCard(): Sprite
		{
			init();
			if( _counter > 0 )
				return _pool[ --_counter ];
			else
			{
				_pool.push( new _type() );
				trace( 'new', _type );	
				return _pool[ _pool.length -1 ];
			}	
		}
		
		public static function returnCard( s:Sprite ): void
		{
			_pool[++_counter] = s;
		}
		
		public static function choosenCard( s:Sprite ): void
		{
			_choosenPool.push( s );
		}

		public static function getChoosenCards(): Array
		{
			return _choosenPool;
		}
	}
}