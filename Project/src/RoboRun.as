package
{
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.events.ConnectionEvent;
	import elan.fla11.roborun.utils.ConnectionManager;
	import elan.fla11.roborun.view.pages.JoinGamePage;
	import elan.fla11.roborun.view.pages.NewGamePage;
	import elan.fla11.roborun.view.pages.StartPage;
	
	import flash.display.Sprite;
	
	[SWF(width="1024", height="750", frameRate="30")]
	public class RoboRun extends Sprite
	{
		private var _startPage:StartPage;
		private var _newGamePage:NewGamePage;
		private var _joinGamePage:JoinGamePage;
		
		public function RoboRun()
		{
			init();
		}
		
		private function init():void
		{
			_startPage = new StartPage();
			_startPage.addEventListener(ButtonEvent.NEW_GAME, startNewGame);
			_startPage.addEventListener(ButtonEvent.JOIN_GAME, joinGame);
			_startPage.addEventListener(ButtonEvent.INSTRUCTIONS, showInstructions);
			addChild(_startPage);
			
			_newGamePage = new NewGamePage();
			_newGamePage.addEventListener(ButtonEvent.BACK, handleButtonClicked_back);
			
			_joinGamePage = new JoinGamePage();
			_joinGamePage.addEventListener(ButtonEvent.BACK, handleButtonClicked_back);
			
			restart();
		}
		
		private function restart():void
		{
			_newGamePage.visible = false;
			addChild(_newGamePage);
			
			_joinGamePage.visible = false;
			addChild(_joinGamePage);
			
			_startPage.visible = true;
		}
		
		private function startNewGame(evt:ButtonEvent):void
		{
			_startPage.visible = false;
			_newGamePage.visible = true;
			trace('startNewGame');
		}
		
		private function joinGame(evt:ButtonEvent):void
		{
			_startPage.visible = false;
			_joinGamePage.visible = true;
			trace('join game');
		}
		
		private function showInstructions(evt:ButtonEvent):void
		{
			_startPage.visible = false;
			trace('instructions');
		}
		
		private function handleButtonClicked_back(evt:ButtonEvent):void
		{
			restart();
		}
	}
}