package com.roborun.p2pupdate.views
{
	import com.roborun.p2pupdate.RobotConstants;
	
	import flash.display.Sprite;

	public class Card extends Sprite
	{	
		private var _types		:Vector.<String>;
		private var _type		:String;
		private var _gfx		:Sprite;
		private var _steps		:int;
		private var _rotation	:int;
		
		public function Card()
		{
			init();
		}
		
		private function init(): void
		{
			mouseChildren = false;
			buttonMode = true;
			useHandCursor = true;
			
			_gfx = new Sprite();
			setupTypes();
			setupCard();
		}
		
		public function get type(): String
		{
			trace( 'type:', _type );
			return _type;
		}

		public function get steps(): int
		{
			trace( 'steps:', _steps );
			return _steps;
		}
		
		public function get cardRotation(): int
		{
			trace( 'rotation:', _rotation );
			return _rotation;
		}
		
		private function setupCard(): void
		{
			_type = selectType();
			
			switch( _type )
			{
				case RobotConstants.MOVE_ONE:
					_steps = 1;
					_gfx = createGfx( 0xccff00 );
					break;
				
				case RobotConstants.MOVE_TWO:
					_steps = 2;
					_gfx = createGfx( 0xffcc00 );
					break;
				
				case RobotConstants.MOVE_THREE:
					_steps = 3;
					_gfx = createGfx( 0xff00cc );
					break;
				
				case RobotConstants.MOVE_BACK:
					_steps = -1;
					_gfx = createGfx( 0xcc00ff );
					break;
				
				case RobotConstants.ROTATE_LEFT:
					_rotation = -90;
					_gfx = createGfx( 0x00cccc );
					break;

				case RobotConstants.ROTATE_RIGHT:
					_rotation = 90;
					_gfx = createGfx( 0xcccc00 );
					break;
				
				case RobotConstants.ROTATE_UTURN:
					_rotation = 180;
					_gfx = createGfx( 0x000000 );
					break;
			}
			
			trace( 'Card:', _type, _steps, _rotation );
			
			addChild( _gfx );
		}
		
		private function createGfx( color:uint ): Sprite
		{
			var gfx : Sprite = new Sprite();
			gfx.graphics.beginFill( color );
			gfx.graphics.drawRect( 0, 0, 80, 100 );
			
			return gfx;
		}
		
		private function selectType(): String
		{
			var type_idx : uint = Math.random()* _types.length;
			return _types[ type_idx ];
		}
		
		private function setupTypes(): void
		{
			_types = new Vector.<String>();
			
			_types.push( RobotConstants.MOVE_ONE );
			_types.push( RobotConstants.MOVE_TWO );
			_types.push( RobotConstants.MOVE_THREE );
			_types.push( RobotConstants.MOVE_BACK );
			_types.push( RobotConstants.ROTATE_LEFT );
			_types.push( RobotConstants.ROTATE_RIGHT );
			_types.push( RobotConstants.ROTATE_UTURN );
		}
	}
}