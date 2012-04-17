package elan.fla11.roborun.view.pages
{
	import elan.fla11.roborun.StartPageGfx;
	
	public class StartPage extends StartPageGfx
	{
		public function StartPage()
		{
			super();
			NewGameButton.Label.text = 'New Game';
			NewGameButton.mouseChildren = false;
			NewGameButton.buttonMode = true;
			
			JoinGameButton.Label.text = 'Join Game';
			JoinGameButton.Label.textColor = 0xD1B500;
			JoinGameButton.mouseChildren = false;
			JoinGameButton.buttonMode = true;
			
			InstructionsButton.Label.text = 'Instructions';
			InstructionsButton.mouseChildren = false;
			InstructionsButton.buttonMode = true;
		}
	}
}