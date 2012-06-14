package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GameBackgroundGfx;
	import elan.fla11.roborun.WarningGfx;
	
	/**
	 * powerDown_btn (enable, disable) - button states
	 * 
	 * diod_1	- light
	 * diod_2	- light
	 * diod_3	- light
	 * 
	 * @author Anton S
	 **/
	
	
	public class GameBackground extends GameBackgroundGfx
	{
		private var _warnings	:Vector.<WarningGfx>;
		private var _w_count	:uint = 9;
		
		public function GameBackground()
		{
			super();
			posWarnings();
		}
		
		/**
		 * Get the number of warnings left before the robot dies.
		 **/
		public function get numWarningsLeft(): uint
		{
			return _w_count;
		}
		
		/**
		 * add warning
		 **/
		public function addWarning(): void
		{
			_warnings[ --_w_count ].visible = true;
			trace( _w_count );
			if( _w_count == 0 )
				trace( 'dispatch DIE' );
		}
		
		/**
		 * remove warning
		 **/
		public function removeWarning(): void
		{
			if( _w_count < 9 )
			{
				_warnings[ _w_count ].visible = false;
				_w_count++;
			}
		}
		
		private function posWarnings(): void
		{
			_warnings = new Vector.<WarningGfx>();
			for (var i:int = 0; i < _w_count; ++i) 
			{
				_warnings.push( new WarningGfx() );
				_warnings[i].x = (110 * i) + 38;
				_warnings[i].y = 527;
				_warnings[i].visible = false;
				addChild( _warnings[i] );
				
			}
		}
		
	}
}