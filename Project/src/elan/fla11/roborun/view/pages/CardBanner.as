package elan.fla11.roborun.view.pages
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import elan.fla11.roborun.Embeder;
	import elan.fla11.roborun.TimerTextField;
	import elan.fla11.roborun.events.GameEvent;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.SpritePool;
	import elan.fla11.roborun.view.GameCard;
	import elan.fla11.roborun.view.gui.CardOrderPlop;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class CardBanner extends Sprite
	{
		private var _cards		:Array;
		private var _plops		:Array;
		
		private var _offsetX	:Number;
		private var _offsetY	:Number;

		private var _prevX		:int;
		private var _prevY		:int;
		private var _prevCard	:int;
		
		private var _cur_plop	:CardOrderPlop;
		
		private var _timer		:Timer;
		private var _timer_tf	:TimerTextField;
		private var _timerCount	:uint;
		
		public function CardBanner()
		{
			init();
		}
		
		private function init(): void
		{
			var cardBanner : Bitmap = new Embeder.CARD_BANNER();
			addChild( cardBanner );
			_cards = [];
			_timer = new Timer( 1000, GameSettings.CHOOSE_CARD_TIME );
			
			_timer_tf = new TimerTextField();
			_timer_tf.x = width * .5;
			_timer_tf.y = height - 17;
			addChild( _timer_tf );
		}
		
		public function dealCards( numCards:uint ): void
		{
			_cards = [];
			SpritePool.clearChoosenCards();
			
			for (var i:int = 0; i < numCards; ++i) 
			{
				_cards.push( new GameCard() );
				_cards[i].shuffle();
				_cards[i].x = i * 105 + 40;
				trace( 'cards x', _cards[i].x );
				_cards[i].y = 41;
				_cards[i].alpha = 0;
				_cards[i].isOccupied = false;
				addChild( _cards[i] );
			}
			
			var numPlops : uint;
			
			if( numCards < 5 ) numPlops = numCards;
			else numPlops = 5;
			
			_plops = [];
			var label_num :uint = 1;
			for (var j:int = 0; j < numPlops; j++) 
			{
				_plops.push( new CardOrderPlop( label_num++ ));
				_plops[j].x = j * 105 + 60;
				_plops[j].y = 53;
				_plops[j].alpha = 0;
				_plops[j].index = j;
				_plops[j].addEventListener(MouseEvent.MOUSE_DOWN, onPlopMouseDown_startMove);
				_cards[j].isOccupied = true;
				addChild( _plops[j] );
				
			}
			
			trace( numPlops );
			
			
			TweenMax.allTo( _cards, .2, {alpha: 1, delay:  2}, .3);
			TweenMax.allTo( _plops, .2, {alpha: 1, delay:  2}, .3, startTimer);
			
			_timerCount = GameSettings.CHOOSE_CARD_TIME;
			_timer_tf.textfield.textColor = 0x363636;
			_timer_tf.textfield.text = '00:' + _timerCount;
			
		}
		
		private function startTimer(): void
		{
			_timer.addEventListener(TimerEvent.TIMER, onTimer_updateTimerTf);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete_timesUp);
			_timer.start();			
		}
		
		private function onTimer_updateTimerTf( e:TimerEvent ): void
		{
			_timerCount--;
			
			if( _timerCount < 10 )
			{
				_timer_tf.textfield.textColor = 0xbb2937;
				_timer_tf.textfield.text = '00:0' + _timerCount;			
			}
			else _timer_tf.textfield.text = '00:' + _timerCount;
				
		}
		
		private function onTimerComplete_timesUp( e:TimerEvent ): void
		{
			
			trace( 'Times Up' );
			_timer.reset();
			
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete_timesUp);
			removeEventListener(MouseEvent.MOUSE_UP, onPlopMouseUp_stopMove);
			removeEventListener(MouseEvent.MOUSE_MOVE, onPlopMouseMove_move);
			
			for (var i:int = 0; i < _plops.length; i++) 
			{
				_plops[i].removeEventListener(MouseEvent.MOUSE_DOWN, onPlopMouseDown_startMove);
				SpritePool.choosenCard( _cards[ _plops[i].index ] );
				removeChild( _plops[i] );
			}
			trace( _cards.length );
			
			for (var j:int = _cards.length -1; j >= 0; --j) 
			{
				trace(' remove card')
				if( contains( _cards[j] ) ) removeChild( _cards[j] );		
				SpritePool.returnCard( _cards[j] );
			}
			
			dispatchEvent( new GameEvent(GameEvent.TIMES_UP) );
			trace( _cards );
			
		}
	
		private function onPlopMouseDown_startMove( e:MouseEvent ): void
		{
			_cur_plop = e.target as CardOrderPlop;

			_offsetX = _cur_plop.x - mouseX;	
			_offsetY = _cur_plop.y - mouseY;
			
			_prevX = _cur_plop.x;
			_prevY = _cur_plop.y;
			
			
			addEventListener(MouseEvent.MOUSE_UP, onPlopMouseUp_stopMove);
			addEventListener(MouseEvent.MOUSE_MOVE, onPlopMouseMove_move);
		}

		private function onPlopMouseMove_move( e:MouseEvent ): void
		{	
			if( _cur_plop.y - _cur_plop.radius >= 0 )
			{
				_cur_plop.x = mouseX + _offsetX;	
				_cur_plop.y = mouseY + _offsetY;				
			}
			else
			{
				_cur_plop.y = _cur_plop.radius;
			}
		}

		private function onPlopMouseUp_stopMove( e:MouseEvent ): void
		{
			trace( 'plop idx', _cur_plop.index );
			for (var i:int = 0; i < _cards.length; i++) 
			{
		
				if( _cur_plop.x > _cards[i].x && _cur_plop.x < (_cards[i].x + _cards[i].width) )
				{
					_cards[ _cur_plop.index ].isOccupied = false;

					if( !_cards[i].isOccupied )
					{		
						TweenLite.to( _cur_plop, 0.2, {x: _cards[i].x + 20, y: _cards[i].y + 14}); 
						_cards[i].isOccupied = true;
						_cur_plop.index = i;
					}
					else
					{
						//_cards[ _prevCard ].isOccupied = true;
						TweenLite.to( _cur_plop, 0.2, {x: _prevX, y: _prevY}); 						
						_cards[ _cur_plop.index ].isOccupied = true;
					}

				}
				trace( 'is occupied?', _cards[i].isOccupied , i);
			}
			
			
			removeEventListener(MouseEvent.MOUSE_UP, onPlopMouseUp_stopMove);
			removeEventListener(MouseEvent.MOUSE_MOVE, onPlopMouseMove_move);
		}
	}
}