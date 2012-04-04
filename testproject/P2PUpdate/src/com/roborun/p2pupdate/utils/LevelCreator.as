package com.roborun.p2pupdate.utils
{
	import flash.display.Sprite;

	public class LevelCreator
	{
		private var _level			:Sprite;
		private var _levelDesign	:Array;
		
		public function LevelCreator()
		{
			init();
		}
		
		private function init(): void
		{
			_level = new Sprite();
			createLevelDesign();
			createLevel();
		}
		
		public function get level(): Sprite
		{
			return _level;
		}

		public function get levelDesign(): Array
		{
			return _levelDesign;
		}
		
		private function createLevel(): void
		{
			var row : uint;
			var col : uint;
			
			for (row = 0; row < _levelDesign.length; row++) 
			{
				for (col = 0; col < _levelDesign[row].length; col++) 
				{
					var grid : Sprite;
					switch( _levelDesign[row][col] )
					{
						case 0:
							grid = createGrid( 0xffffff );
							break;

						case 1:
							grid = createGrid( 0xaaaaaa );
							break;
					}
					
					grid.x = col * 50;
					grid.y = row * 50;
					_level.addChild( grid );
				}
				
			}
			
		}
		
		
		private function createGrid( color:uint ): Sprite
		{
			var newGrid : Sprite = new Sprite();
			
			newGrid.graphics.lineStyle(1);
			newGrid.graphics.beginFill( color );
			newGrid.graphics.drawRect( 0, 0, 48, 48 );
			
			return newGrid;
		}
		
		private function createLevelDesign(): void
		{
			_levelDesign = [
						   [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
						   [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
						   [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
						   [1,0,0,0,0,1,0,0,0,0,0,0,0,0,1],
						   [1,0,0,0,0,0,1,0,0,0,0,0,0,0,1],
						   [1,0,0,0,0,0,0,1,1,1,0,0,0,0,1],
						   [1,0,0,0,0,0,0,0,0,1,0,0,0,0,1],
						   [1,0,0,0,0,0,0,0,0,1,0,0,0,0,1],
						   [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
						   [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
						   [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
						   ]
		}
	}
}