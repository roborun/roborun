package elan.fla11.roborun.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class SoundBase
	{
		
		protected var _sound:Sound;
		protected var _channel:SoundChannel;
		private var _transform:SoundTransform;
		
		public function SoundBase()
		{
			_channel = new SoundChannel();
			_transform = new SoundTransform();
		}
		
		public function play(volume : Number):void
		{
			_transform.volume = volume;
			_channel = _sound.play();
			_channel.soundTransform = _transform;
		}
	}
}