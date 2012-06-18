package elan.fla11.roborun.utils
{
	import elan.fla11.roborun.settings.GameSettings;
	
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
		private static var isInit	:Boolean;
		
		public function KeyboardManager()
		{
		}
		
		private static function init(): void
		{
			if( !isInit )
			{
				var stage : Stage = GameSettings.STAGE;
				key = {};
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
				stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);			
				isInit = true;
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
			return key[keyCode];
		}
	}
}