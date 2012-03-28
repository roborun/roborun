package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width="300", height="180")]
	public class GridGround extends Sprite
	{
		private var _level 			:Array;
		private var _isOverStage	:Boolean;
		
		public function GridGround()
		{
			init();
		}
		
		private function init(): void
		{
			createLevel();
			showLevel();
			
			// för att man inte ska hamna utanför indexvärdet om musen inte är på scenen
			addEventListener(MouseEvent.MOUSE_OVER, onOver_isOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut_isNotOver);
		}
		
		private function onOver_isOver( e:MouseEvent ):void
		{
			_isOverStage = true;
		}
		
		private function onOut_isNotOver( e:MouseEvent ):void
		{
			_isOverStage = false;
		}
		
		
		private function onLoop_tellGridValue( e:Event ):void
		{
			
			
			var x :uint = mouseX/20;
			var y :uint = mouseY/20;
			
			//trace(x, y);penis
			if( _isOverStage ) trace('value:',_level[y][x]);	
		}
		
		private function showLevel(): void
		{
			for (var y:uint = 0; y < _level.length; y++) 
			{
				for (var x:int = 0; x < _level[y].length; x++) 
				{
					var grid : Sprite;
					switch( _level[y][x] )
					{
						case 1:
							grid = createGrid(0xff00cc);
							break;
						
						case 0:
							grid = createGrid(0xffcc00);
							break;
					}
					grid.x = x*20;
					grid.y = y*20;
					addChild(grid);
				}
			}
			addEventListener(Event.ENTER_FRAME, onLoop_tellGridValue);	
		}
		
		private function createGrid(color:uint): Sprite
		{
			var target: Sprite = new Sprite();
			
			target.graphics.beginFill(color);
			target.graphics.drawRect(0,0, 20,20);
			target.graphics.endFill();
			
			return target;
		}
		
		private function createLevel():void
		{
			_level = [
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],					 
				[1,0,0,0,0,0,0,0,0,1,1,1,1,1,1],
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
				[1,1,1,1,1,1,1,1,0,1,1,1,1,1,1],
				[1,1,1,1,1,0,1,1,1,1,1,1,1,1,1],
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
				[1,1,1,1,0,1,1,1,1,1,1,0,1,1,1],
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
			]
		}
	}
}