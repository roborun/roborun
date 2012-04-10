package com.roborun.p2pupdate.utils
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	/**
	 * KeyboardManager
	 * 
	 * isKeyDown(keyCode:int)
	 * 
	 * author Anton Strand.
	 **/
	
	public class KeyboardManager
	{
		private static var key		:Object;
		private static var _isInit	:Boolean;
		private static var _stage	:Stage;
		
		// Måste skicka in stage för att man ska kunna lyssna på stagen
		public function KeyboardManager(stage:Stage)
		{
			_stage = stage;
		}
		
		private static function init(): void
		{
			if( !_isInit )
			{
				key = {};
				_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
				_stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
				
				_isInit = true;
			}
		}
		
		private static function keyHandler(e:KeyboardEvent): void
		{
			// Beroende om man trycker ner eller upp ska den tryckta knappen bli true eller false
			// Den skapar en plats i objektet efter vilken keyCode det är
			if(e.type == KeyboardEvent.KEY_DOWN) key[e.keyCode] = true;
			if(e.type == KeyboardEvent.KEY_UP) key[e.keyCode] = false;		
		}
		
		public static function isKeyDown(keyCode:int): Boolean
		{
			init();
			trace( key[keyCode] );
			return key[keyCode];
		}
	}
}