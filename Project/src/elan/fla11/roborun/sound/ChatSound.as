package elan.fla11.roborun.sound
{
	import elan.fla11.roborun.soundassets.Chat_notification;

	public class ChatSound extends SoundBase
	{
		public function ChatSound()
		{
			_sound = new Chat_notification();
		}
	}
}