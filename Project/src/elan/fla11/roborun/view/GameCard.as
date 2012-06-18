package elan.fla11.roborun.view
{
	import elan.fla11.roborun.GameCardGfx;
	import elan.fla11.roborun.settings.GameSettings;
	
	/**
	 * leftArrow
	 * rightArrow
	 * forwardArrow
	 * backwardArrw
	 * uTurnArrow
	 * 
	 * point_tf
	 * title_tf
	 **/
	
	public class GameCard extends GameCardGfx
	{
		private var	_type		:uint;
		private var	_point		:uint;
		
		public var isOccupied	:Boolean;
		
		public function GameCard()
		{
			scaleX = scaleY = .8;
		}
		
		public function get type(): uint
		{
			return _type;
		}

		public function get point(): uint
		{
			trace( 'get points:',_point );
			return _point;
		}
		
		public function shuffle(): void
		{
			leftArrow.visible = false;
			rightArrow.visible = false;
			forwardArrow.visible = false;
			backwardArrow.visible = false;
			uTurnArrow.visible = false;
			
			_type = Math.random() * 7;
			_point = uint(Math.random() * 9) * 100;
			
			point_tf.text = String(_point);

			trace( 'points:',_point );
			
			
			switch( _type )
			{
				case GameSettings.BACK_UP:
					title_tf.text = 'BACK UP';
					backwardArrow.visible = true;
					break;

				case GameSettings.MOVE_ONE:
					title_tf.text = 'MOVE 1';
					forwardArrow.visible = true;
					break;

				case GameSettings.MOVE_TWO:
					title_tf.text = 'MOVE 2';
					forwardArrow.visible = true;
					break;

				case GameSettings.MOVE_THREE:
					title_tf.text = 'MOVE 3';
					forwardArrow.visible = true;
					break;

				case GameSettings.TURN_LEFT:
					title_tf.text = 'TURN LEFT';
					leftArrow.visible = true;
					break;

				case GameSettings.TURN_RIGHT:
					title_tf.text = 'TURN RIGHT';
					rightArrow.visible = true;
					break;

				case GameSettings.U_TURN:
					title_tf.text = 'U-TURN';
					uTurnArrow.visible = true;
					break;
			}
		}
	}
}