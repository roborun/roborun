package elan.fla11.roborun.view
{
	import elan.fla11.roborun.GameCardGfx;
	
	/**
	 * leftArrow
	 * rightArrow
	 * forwardArrow
	 * backwardArrw
	 * 
	 * point_tf
	 * title_tf
	 **/
	
	public class GameCard extends GameCardGfx
	{
		private var	_type	:uint;
		private var	_point	:uint;
		
		public function GameCard()
		{
			super();
		}
		
		public function get type(): void
		{
			return _type;
		}

		public function get point(): void
		{
			return _point;
		}
		
		public function generate(): void
		{
			leftArrow.visible = false;
			rightArrow.visible = false;
			forwardArrow.visible = false;
			backwardArrow.visible = false;

			
			_type = Math.random() * 6;
			_point = (Math.random() * 8) * 100;
			
			point_tf = _point;
			
			
			switch( _type )
			{
				case 0:
					title_tf = 'BACK UP';
					backwardArrow.visible = true;
					break;

				case 1:
					title_tf = 'MOVE 1';
					forwardArrow.visible true;
					break;

				case 2:
					title_tf = 'MOVE 2';
					forwardArrow.visible true;
					break;

				case 3:
					title_tf = 'MOVE 3';
					forwardArrow.visible true;
					break;

				case 4:
					title_tf = 'TURN LEFT';
					leftArrow.visible true;
					break;

				case 5:
					title_tf = 'TURN RIGHT';
					rightArrow.visible true;
					break;

				case 6:
					title_tf = 'U-TURN';
					rightArrow.visible true;
					break;
			}
		}
	}
}