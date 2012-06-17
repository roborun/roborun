package elan.fla11.roborun.settings
{
	import flash.display.Stage;

	public class GameSettings
	{
		public static const LEVEL_URL			:String = 'levels.xml';

		public static const STAGE_W				:uint = 1024;
		public static const STAGE_H				:uint = 750;
		public static const GRID_SIZE			:uint = 50;
		
		public static const BUTTON_COLOR		:uint = 0xE8D516;
		public static const BORDER_THICKNESS_Y	:uint = 80; // 70
	 	public static const BORDER_THICKNESS_X	:uint = 44; // 34

	 	public static const CHOOSE_CARD_TIME	:uint = 10; // Ange sekunder
		
		
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
		
	}
}