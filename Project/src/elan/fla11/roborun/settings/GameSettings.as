package elan.fla11.roborun.settings
{
	import flash.display.Stage;

	public class GameSettings
	{
		public static const INSTRUCTIONS_URL	:String = 'http://www.eliasj.se/roborun/instructions/roboruninstructions.pdf';
		
		public static const LEVEL_URL			:String = 'http://www.eliasj.se/roborun/levels.xml';

		public static const STAGE_W				:uint = 1024;
		public static const STAGE_H				:uint = 750;
		public static const GRID_SIZE			:uint = 50;
		
		public static const BUTTON_COLOR		:uint = 0xE8D516;
		public static const BORDER_THICKNESS_Y	:uint = 80; // 70
	 	public static const BORDER_THICKNESS_X	:uint = 44; // 34

	 	public static const CHOOSE_CARD_TIME	:uint = 30; // Ange sekunder
		
		
	 	public static const ROTATION_SPEED		:uint = 5;

		/**
		 * instanse of the stage
		 **/
	 	public static var STAGE					:Stage;
		
		/**
		 * direction of LevelObject
		 **/
		public static const RIGHT				:uint = 0; 
		/**
		 * direction of LevelObject
		 **/
		public static const LEFT				:uint = 180; 
		/**
		 * direction of LevelObject
		 **/
		public static const DOWN				:uint = 90; 
		/**
		 * direction of LevelObject
		 **/
		public static const UP					:uint = 270; 
	
		
		// Camera view:  1000x500.  level: 2000x1000
		
		/**
		 * Robot Bull id
		 **/
		public static const	BULL				:uint = 0;
		/**
		 * Robot Giraffe id
		 **/
		public static const	GIRAFFE				:uint = 1;
		/**
		 * Robot Wheelie id
		 **/
		public static const	WHEELIE				:uint = 2;
		
		
		
		/**
		 * Card type back up
		 **/
		public static const	BACK_UP				:uint = 0;
		/**
		 * Card type move 1
		 **/
		public static const	MOVE_ONE			:uint = 1;
		/**
		 * Card type move 2
		 **/
		public static const	MOVE_TWO			:uint = 2;
		/**
		 * Card type move 3
		 **/
		public static const	MOVE_THREE			:uint = 3;
		/**
		 * Card type rotate left
		 **/
		public static const	TURN_LEFT			:uint = 4;
		/**
		 * Card type rotate right
		 **/
		public static const	TURN_RIGHT			:uint = 5;
		/**
		 * Card type u-turn
		 **/
		public static const	U_TURN				:uint = 6;
		
		
		
	}
}