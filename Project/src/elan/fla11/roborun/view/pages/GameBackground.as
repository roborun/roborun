package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.GameBackgroundGfx;
	import elan.fla11.roborun.WarningGfx;
	import elan.fla11.roborun.events.GameEvent;
	
	import flash.events.MouseEvent;
	
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
		
		private var _lifes		:uint = 3;
		
		public function GameBackground()
		{
			init();
		}
		
		private function init(): void
		{
			posWarnings();
			reboot();
		}
		
		
		/**
		 * turn of a lamp and reboot warnings
		 **/
		public function die(): void
		{
			--_lifes;
			
			switch( _lifes ) 
			{
				case 2:
					diod_1.light.visible = false;
					diod_1.darkness.visible = true;
					removeAllWarning();
					break;
				
				case 1:
					diod_2.light.visible = false;
					diod_2.darkness.visible = true;
					removeAllWarning();
					break;

				case 0:
					diod_3.light.visible = false;
					diod_3.darkness.visible = true;
					removeAllWarning();
					break;
					
			}
		}
		
		
		/**
		 * reactivate the robot after power down
		 **/
		public function reboot(): void
		{
			powerDown_btn.gotoAndStop( 'enable' );
			powerDown_btn.addEventListener(MouseEvent.CLICK, onPwrDownBtn_powerDown);
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
			{
				trace( 'dispatch DIE' );
				die();
				dispatchEvent( new GameEvent( GameEvent.DEAD ));
			}
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

		/**
		 * remove all warning
		 **/
		public function removeAllWarning( num:uint = 9): void
		{
			trace( num );
			
			for (var i:int = 0; i < num; i++) 
			{
				_warnings[ i ].visible = false;				
			}
			
				_w_count = num;
			
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
		
		
		private function onPwrDownBtn_powerDown( e:MouseEvent ): void
		{
			powerDown_btn.removeEventListener(MouseEvent.CLICK, onPwrDownBtn_powerDown);
			powerDown_btn.gotoAndStop( 'disable' );
			
			trace( _w_count )
			
			if( _w_count < 7 ) removeAllWarning( 6 );
			else removeAllWarning();
			
			trace( 'Dispatch power down' );
			dispatchEvent( new GameEvent( GameEvent.POWER_DOWN ));
		}
		
	}
}