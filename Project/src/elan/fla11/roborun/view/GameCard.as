package elan.fla11.roborun.view
{
	import elan.fla11.roborun.GameCardGfx;
	
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
		private var	_type	:uint;
		private var	_point	:uint;
		
		public function GameCard()
		{
			super();
		}
		
		public function get type(): uint
		{
			return _type;
		}

		public function get point(): uint
		{
			return _point;
		}
		
		public function small(): void
		{
			scaleX = scaleY = .8;
			buttonMode = true;
			useHandCursor = true;
		}

		public function original(): void
		{
			scaleX = scaleY = 1;
			buttonMode = false;
			useHandCursor = false;
		}
		
		
		public function shuffle(): void
		{
			leftArrow.visible = false;
			rightArrow.visible = false;
			forwardArrow.visible = false;
			backwardArrow.visible = false;
			uTurnArrow.visible = false;

			
			_type = Math.random() * 6;
			_point = uint(Math.random() * 9) * 100;
			
			point_tf.text = String(_point);
			
			
			switch( _type )
			{
				case 0:
					title_tf.text = 'BACK UP';
					backwardArrow.visible = true;
					break;

				case 1:
					title_tf.text = 'MOVE 1';
					forwardArrow.visible = true;
					break;

				case 2:
					title_tf.text = 'MOVE 2';
					forwardArrow.visible = true;
					break;

				case 3:
					title_tf.text = 'MOVE 3';
					forwardArrow.visible = true;
					break;

				case 4:
					title_tf.text = 'TURN LEFT';
					leftArrow.visible = true;
					break;

				case 5:
					title_tf.text = 'TURN RIGHT';
					rightArrow.visible = true;
					break;

				case 6:
					title_tf.text = 'U-TURN';
					uTurnArrow.visible = true;
					break;
			}
		}
	}
}