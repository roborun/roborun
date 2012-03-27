package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	public class CirrusConnectTest extends Sprite
	{
		private const SERVER			:String = 'rtmfp://p2p.rtmfp.net/';
		private const DEVELOPER_KEY		:String = 'c91a99ad1324c2e48ea04c05-6647b9ba2efd';
		
		private var _nc				:NetConnection;
		private var _netgroup		:NetGroup;
		
		private var _user			:String;
		private var _isConnected	:Boolean;
		private var _seq			:uint;
		private var _history_tf:TextField;
		private var _username_tf:TextField;
		private var _message_tf:TextField;
		
		public function CirrusConnectTest()
		{
			connect();
			initGui();
		}
		
		private function connect(): void
		{
			_nc = new NetConnection();
			_nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			_nc.connect( SERVER + DEVELOPER_KEY );
		}
		
		private function onNetStatus( e:NetStatusEvent ): void
		{
			trace(e.info.code);
			
			switch( e.info.code )
			{
				case 'NetConnection.Connect.Success':
					setupGroup();
					break;
				
				case 'NetGroup.Connect.Success':
					_isConnected = true;
					break;
				
				case 'NetGroup.Posting.Notify':
					receiveMessage( e.info.message );
					break;
			}
		}
		
		private function setupGroup(): void
		{
			var groupSpec : GroupSpecifier = new GroupSpecifier('myGroup/g1');
			groupSpec.serverChannelEnabled = true;
			groupSpec.postingEnabled = true;
			
			_netgroup = new NetGroup(_nc, groupSpec.groupspecWithAuthorizations());
			_netgroup.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			
			_user = 'user' + Math.round( Math.random()*10000 );
			
			_username_tf.text = _user;
		}
		
		private function sendMessage(): void
		{
			var message : Object = {};
			
			message.sender = _netgroup.convertPeerIDToGroupAddress( _nc.nearID );
			message.user = _username_tf.text;
			message.text = _message_tf.text;
			message.sequence = _seq++;
			
			_netgroup.post( message );
			receiveMessage( message );
			
		}
		
		private function receiveMessage( message:Object ): void
		{
			write(message.user +' : '+ message.text);
		}
		
		private function write( text:String ): void
		{
			_history_tf.appendText( text + '\n'); 
		}
		
		private function initGui(): void
		{
			_history_tf = new TextField();
			_history_tf.border = true;
			_history_tf.width = stage.stageWidth;
			_history_tf.height = 300;
			addChild( _history_tf );
			
			_username_tf = new TextField();
			_username_tf.type = TextFieldType.INPUT;
			_username_tf.border = true;
			_username_tf.height = 22;
			_username_tf.x = 10;
			_username_tf.y = 320;
			addChild( _username_tf );
			
			_message_tf = new TextField();
			_message_tf.type = TextFieldType.INPUT;
			_message_tf.border = true;
			_message_tf.width = 280;
			_message_tf.height = 40;
			_message_tf.x = 150;
			_message_tf.y = 320;
			addChild( _message_tf );
			
			var button : Sprite = new Sprite();
			button.graphics.beginFill( 0xff00cc );
			button.graphics.drawRoundRect(440, 320, 40, 40, 20);
			button.addEventListener(MouseEvent.CLICK, onButtonClick_sendMessage);
			addChild( button );
		}
		
		private function onButtonClick_sendMessage( e:MouseEvent ): void
		{
			sendMessage();
		}
	}
}