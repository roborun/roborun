package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.StartPageGfx;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.view.gui.Button;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class StartPage extends StartPageGfx
	{
		private var _newGameBtn:Button;
		private var _joinGameBtn:Button;
		private var _instructionsBtn:Button;
		
		public function StartPage()
		{
			super();
			addButtons();
			
		}
		
		private function handleNewGameClicked(evt:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.NEW_GAME));
		}

		private function handleJoinGameClicked(evt:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.JOIN_GAME));
		}
		
		private function handleInstructionsClicked(evt:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.INSTRUCTIONS));
		}
		
		private function addButtons():void
		{
			_newGameBtn = new Button();
			_newGameBtn.Label.text = 'New Game';
			_newGameBtn.x = (GameSettings.STAGE_W - _newGameBtn.width*2) -20;
			_newGameBtn.y = height/2 - _newGameBtn.height;
			_newGameBtn.rotation -= 58;
			addChild(_newGameBtn);
			_newGameBtn.addEventListener(MouseEvent.CLICK, handleNewGameClicked);
			
			_joinGameBtn = new Button(GameSettings.BUTTON_COLOR);
			_joinGameBtn.Label.text = 'Join Game';
			_joinGameBtn.x = _newGameBtn.x + 100;
			_joinGameBtn.y = _newGameBtn.y + _joinGameBtn.height*3;
			_joinGameBtn.rotation -= 53;
			addChild(_joinGameBtn);
			_joinGameBtn.addEventListener(MouseEvent.CLICK, handleJoinGameClicked);
			
			_instructionsBtn = new Button();
			_instructionsBtn.Label.text = 'Instructions';
			_instructionsBtn.x = _joinGameBtn.x +70;
			_instructionsBtn.y = _joinGameBtn.y + _joinGameBtn.height;
			_instructionsBtn.rotation -= 50;
			addChild(_instructionsBtn);
			_instructionsBtn.addEventListener(MouseEvent.CLICK, handleInstructionsClicked);
		}
	}
}