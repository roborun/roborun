package se.antonstrand.fla11.labyrint.views.menus
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import se.antonstrand.fla11.labyrint.models.LevelData;
	import se.antonstrand.fla11.labyrint.utils.Settings;
	import se.antonstrand.fla11.labyrint.views.gui.buttons.LevelButton;
	
	/**
	 * LevelMenu
	 * extends MenuBase
	 * 
	 * Show Levels
	 * 
	 * author Anton Strand.
	 **/
	
	
	public class LevelMenu extends MenuBase
	{
		public static const LEVEL_CHOSEN		:String = "levelChoosen";
		
		private var _stage			:Stage;
		
		private var _levelData		:Vector.<LevelData>;
		private var _buttons		:Vector.<LevelButton>;
		private var _levelSlides	:Vector.<Sprite>;
		
		private var _targetBtn			:LevelButton;
		
		private var _cur_level			:uint;
		private var _cur_slide			:uint;
		private var _offset				:uint;
		private var _original_x			:uint;
		
		public function LevelMenu(data:Vector.<LevelData>, stage:Stage)
		{
			super('The Labyrinth');
			
			_stage = stage;
			
			_levelData = data;
			_buttons = new Vector.<LevelButton>();
			_levelSlides = new Vector.<Sprite>;
			
			addLevelButtons();
		}

		public function get currentUrl(): String
		{
			return _buttons[_cur_level].url;
		}
		
		public function nextLevel(): void
		{
			if(_cur_level < _buttons.length -1)
			{
				_cur_level++;
			}
			else
			{
				_cur_level = 0;
			}
		}
		
		private function addLevelButtons(): void
		{
			var i : uint;
			var x_count : uint = 0;
			var y_count : uint = 0;
			var currentSlide : uint = 0;
			
			_levelSlides.push(new Sprite());
			
			for(i = 0; i < _levelData.length; ++i) 
			{
				_buttons.push(new LevelButton(_levelData[i]));
				_buttons[i].x = (_buttons[i].width + 10) * x_count;
				_buttons[i].y = (_buttons[i].height + 10) * y_count;
				
				_buttons[i].addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown_down);
				
				_levelSlides[currentSlide].addChild(_buttons[i]);
				
				x_count++;
				
				if(x_count == 7)
				{
					x_count = 0;
					y_count++;
					
					if(y_count == 3)
					{
						y_count = 0;
						currentSlide++;
						
						_levelSlides.push(new Sprite());
						_levelSlides[currentSlide].x = Settings.STAGE_W;
						addChild(_levelSlides[currentSlide]);
					}
				}
			}
			
			
			for (var j:int = 0; j < _levelSlides.length; j++) 
			{
				_levelSlides[j].width = Settings.STAGE_W * .95;
				_levelSlides[j].height = Settings.STAGE_H *.66;	
				_levelSlides[j].y = Settings.STAGE_H * .25;
			}
			
			
			_original_x = Settings.STAGE_W * .5 - _levelSlides[0].width * .5;
			_levelSlides[0].x = _original_x;
			addChild(_levelSlides[0]);
			
			
			
			
			trace('level:',_levelSlides[0].y/Settings.STAGE_H);
			trace(_levelSlides[0].height);
			
			_stage.addEventListener(MouseEvent.MOUSE_UP, onButtonUp_dispatch);
		}
		
		
		
		private function onButtonDown_down(e:MouseEvent): void
		{
			_targetBtn = LevelButton(e.target);
			_targetBtn.down();
			
			//Måste vara mer än 21 banor för att fungera.
			if(_levelSlides.length > 1) 
			{
				_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove_swipe);
				_offset =mouseX;
			}
			
		}
		
		private function onMouseMove_swipe(e:MouseEvent): void
		{
			_levelSlides[_cur_slide].x = mouseX - _offset;
			
		}
		
		private function onButtonUp_dispatch(e:MouseEvent): void
		{
			if(_targetBtn) _targetBtn.up();
			
			
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove_swipe);
			
			
			//om den har flyttats en bit ska inte banan starta, samt att den ska åka tillbaka. Har den åkt mer än ett visst antal pixlar ska den bytas ut.
			if(_levelSlides[_cur_slide].x < _original_x - Settings.MIN_SLIDE_DIFF || _levelSlides[_cur_slide].x > _original_x + Settings.MIN_SLIDE_DIFF)
			{
				if(_levelSlides[_cur_slide].x < _original_x - Settings.CHANGE_SLIDE_DIFF)
				{
					if(_cur_slide < _levelSlides.length -1)
					{
						_cur_slide++;
						tweenToLeft();
					}
					
				}
				else if(_levelSlides[_cur_slide].x > _original_x + Settings.CHANGE_SLIDE_DIFF)
				{
					if(_cur_slide > 0)
					{
						_cur_slide--;
						tweenToRight();
					}
				}
			
				tweenToCenter();
				

			}
			else
			{
				if(e.target is LevelButton)
				{
					_cur_level = _buttons.indexOf(_targetBtn);
					dispatchEvent(new Event(LEVEL_CHOSEN));
				}
				
			}
			
		}
		
		private function tweenToCenter():void
		{
			TweenMax.to(_levelSlides[_cur_slide], .4,{x: _original_x});
		}
		
		private function tweenToLeft():void
		{
			TweenMax.to(_levelSlides[_cur_slide -1], .4,{x: - _levelSlides[_cur_slide -1].width});
		}
		
		private function tweenToRight():void
		{
			TweenMax.to(_levelSlides[_cur_slide +1], .4,{x: Settings.STAGE_W});
		}
	}
}