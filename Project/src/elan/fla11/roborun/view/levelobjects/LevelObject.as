package elan.fla11.roborun.view.levelobjects
{
	import elan.fla11.roborun.Embeder;
	import elan.fla11.roborun.settings.GameSettings;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * BaseClass for all LevelObjects
	 * 
	 * @author Anton Strand.
	 **/
	
	public class LevelObject extends Sprite
	{
		/**
		 * Sprite that contains the graphics of the object. Need to send in objectSrc
		 **/
		protected var _object		:Sprite;
		private var _objectGfx		:Bitmap;
		
		public function LevelObject( objectSrc:Class = null, withPlate:Boolean = true )
		{
			init( objectSrc, withPlate );	
		}
		
		/**
		 * initialize the LevelObject
		 **/
		protected function init( objectSrc:Class = null, withPlate:Boolean = true ): void
		{
			if( withPlate )
			{
				var plate : Bitmap = new Embeder.FLOOR;
				addChild( plate );
			}
			
			if( objectSrc != null )
			{
				_object = new Sprite();
				_object.x = _object.y = GameSettings.GRID_SIZE * .5;
				addChild( _object );
				
				_objectGfx = new objectSrc;
				_objectGfx.x = _objectGfx.y = - GameSettings.GRID_SIZE * .5;
				_object.addChild( _objectGfx );
			}
		}
		
		
		/**
		 * Make the object to it thing
		 **/ 
		public function activate(): void
		{
		}
		
		/**
		 * Stop the object
		 **/
		public function deactivate(): void
		{
			
		}
	}
}