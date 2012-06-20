package elan.fla11.roborun.utils
{
	import elan.fla11.roborun.sound.SoundBase;

	public class SoundManager
	{
		private static var _sounds:Object;
		private static var _isInitialized:Boolean;
		private static var _isMute:Boolean;
		
		public function SoundManager()
		{
		}
		
		private static function init():void
		{
			if(!_isInitialized)
			{
				_sounds = {};
				_isInitialized = true;
			}
		}
		
		public static function addSound(id:String, sound:SoundBase):void
		{
			init();
			_sounds[id] = sound;
		}
		
		public static function playSound(id:String, volume:Number):void
		{
			if(!_isMute)
				_sounds[id].play(volume);
		}
		
		public static function get isMute():Boolean
		{
			return _isMute;
		}
		
		public static function set isMute(bool:Boolean):void
		{
			_isMute = bool;
		}
	}
}