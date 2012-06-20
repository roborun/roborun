package elan.fla11.roborun.utils
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
		private var key		:Object;
		
		// Måste skicka in stage för att man ska kunna lyssna på stagen
		public function KeyboardManager(stage:Stage)
		{
			key = {};
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
		}
		
		private function keyHandler(e:KeyboardEvent): void
		{
			// Beroende om man trycker ner eller upp ska den tryckta knappen bli true eller false
			// Den skapar en plats i objektet efter vilken keyCode det är
			if(e.type == KeyboardEvent.KEY_DOWN) key[e.keyCode] = true;
			if(e.type == KeyboardEvent.KEY_UP) key[e.keyCode] = false;		
		}
		
		public function isKeyDown(keyCode:int): Boolean
		{
			return key[keyCode];
		}
	}
}