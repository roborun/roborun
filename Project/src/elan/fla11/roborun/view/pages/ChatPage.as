package elan.fla11.roborun.view.pages
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	import com.reyco1.multiuser.data.UserObject;
	
	import elan.fla11.roborun.ChatPageGfx;
	import elan.fla11.roborun.events.ButtonEvent;
	import elan.fla11.roborun.events.ConnectionEvent;
	import elan.fla11.roborun.events.ScrollEvent;
	import elan.fla11.roborun.settings.GameSettings;
	import elan.fla11.roborun.utils.ConnectionManager;
	import elan.fla11.roborun.view.gui.Button;
	import elan.fla11.roborun.view.gui.Scroller;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;
	
	public class ChatPage extends Sprite
	{
		private var _chat:ChatPageGfx;
		private var _players:Array;
		private var _shader:Sprite;
		private var _sendBtn:Button;
		private var _scroller:Scroller;
		private var _chatPos:Number;
		private var _chatMask:Sprite;
		
		public function ChatPage()
		{
			super();
			
			ConnectionManager.dispatcher.addEventListener(ConnectionEvent.MESSAGE_RECEIVED, onChatMsgReceived);
									
			_shader = new Sprite();
			_shader.graphics.beginFill(0);
			_shader.graphics.drawRect(0,0, GameSettings.STAGE_W, GameSettings.STAGE_H);
			_shader.graphics.endFill();
			_shader.alpha = .5;
			addChildAt(_shader, 0);

			_chat = new ChatPageGfx();
			_chat.close_btn.addEventListener(MouseEvent.CLICK, handleCloseClicked);
			_chat.close_btn.buttonMode = true;
			_chat.x = this.width/2 - _chat.width/2;
			_chat.y = this.height/2 - _chat.height/2;
			addChild(_chat);
			
			_chatMask = new Sprite();
			_chatMask.graphics.beginFill(0);
			_chatMask.graphics.drawRect(0, 0, _chat.chatWindow.width, _chat.chatWindow.height);
			_chatMask.graphics.endFill();
			_chat.addChild(_chatMask);
			_chatMask.x = _chat.chatWindow.x;
			_chatMask.y = _chat.chatWindow.y;

			_chat.chatWindow.mask = _chatMask;
			
			_chat.chatWindow.autoSize = TextFieldAutoSize.LEFT;
			_chat.chatWindow.width = 470;
			
			_sendBtn = new Button(GameSettings.BUTTON_COLOR);
			_sendBtn.addEventListener(MouseEvent.CLICK, handleSendClicked);
			_sendBtn.Label.text = 'Send';
			_chat.addChild(_sendBtn);
			_sendBtn.x = 400;
			_sendBtn.y = 360;
			
			_scroller = new Scroller(_chatMask.height);
			_scroller.addEventListener(ScrollEvent.SCROLLING, handleScroll);
			_scroller.visible = false;
			_chat.addChild(_scroller);
			_scroller.x = _chatMask.x + _chatMask.width;
			_scroller.y = _chatMask.y;
			
			// MouseWheel ska bara aktiveras efter scrollen har startat.
			
		}
		
		private function handleScroll(evt:ScrollEvent):void
		{
			_chatPos = -_scroller.scrollPosition*(_chat.chatWindow.height - _chatMask.height) +_chatMask.y;
			TweenLite.from(_chat.chatWindow, .5, {y:_chat.chatWindow.y, ease:Quad.easeOut});
			TweenLite.to(_chat.chatWindow, .5, {y:_chatPos, ease:Quad.easeOut});
		}
		
		private function handleSendClicked(evt:MouseEvent):void
		{
			sendMsg();
		}
		
		private function sendMsg():void
		{
			ConnectionManager.sendChatMessage(_chat.chatInput.text);
			_chat.chatInput.text = '';
		}
		
		private function onChatMsgReceived(evt:ConnectionEvent):void
		{
			_chat.chatWindow.appendText(evt.message.user + ': ' +evt.message.text+'\n');
			if(_chat.chatWindow.height > _chatMask.height)
			{
				_scroller.visible = true;
				if(_chat.chatWindow.height > _chatMask.height)
					_scroller.msgScroll();
			}
			dispatchEvent( new Event(Event.CHANGE) );
		}
		
		private function handleCloseClicked(evt:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.CLOSE));
		}
		
		public function set players(pl:Array):void
		{
			_players = pl;
		}
		
		private function handleEnterClicked(evt:KeyboardEvent):void
		{
			if(evt.keyCode == Keyboard.ENTER)
				sendMsg();
		}
		
		public function activateEnter():void
		{
			addEventListener(KeyboardEvent.KEY_DOWN, handleEnterClicked);
		}
		
		public function deactivateEnter():void
		{
			removeEventListener(KeyboardEvent.KEY_DOWN, handleEnterClicked);
		}
	}
}