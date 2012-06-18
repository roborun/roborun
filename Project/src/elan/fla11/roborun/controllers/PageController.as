package elan.fla11.roborun.controllers
{
	import flash.display.Sprite;
	
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.events.ConnectionEvent;
	import elan.fla11.roborun.utils.ConnectionManager;
	import elan.fla11.roborun.view.pages.InstructionsPage;
	import elan.fla11.roborun.view.pages.JoinGamePage;
	import elan.fla11.roborun.view.pages.NewGamePage;
	import elan.fla11.roborun.view.pages.StartPage;
	
	public class PageController extends Sprite
	{
		private var _startPage:StartPage;
		private var _newGamePage:NewGamePage;
		private var _joinGamePage:JoinGamePage;
		private var _instructionsPage:InstructionsPage;
		
		public function PageController()
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
			
			_instructionsPage = new InstructionsPage();
			_instructionsPage.addEventListener(ButtonEvent.BACK, handleButtonClicked_back);
			
			restart();
		}
		
		private function restart():void
		{			
			_newGamePage.visible = false;
			addChild(_newGamePage);
			
			_joinGamePage.visible = false;
			addChild(_joinGamePage);
			
			_instructionsPage.visible = false;
			addChild(_instructionsPage);
			
			_startPage.visible = true;
		}
		
		private function startNewGame(evt:ButtonEvent):void
		{
			restartSlideShows();
			_startPage.visible = false;
			_newGamePage.visible = true;
		}
		
		private function joinGame(evt:ButtonEvent):void
		{
			restartSlideShows();
			_startPage.visible = false;
			_joinGamePage.visible = true;
		}
		
		private function showInstructions(evt:ButtonEvent):void
		{
			_startPage.visible = false;
			_instructionsPage.visible = true;
		}
		
		private function handleButtonClicked_back(evt:ButtonEvent):void
		{
			removeChild(_newGamePage);
			removeChild(_joinGamePage);
			removeChild(_instructionsPage);
			restart();
		}
		
		private function restartSlideShows():void
		{
			_joinGamePage.restartSlideShow();
			_newGamePage.restartSlideShow();
		}
	}
}