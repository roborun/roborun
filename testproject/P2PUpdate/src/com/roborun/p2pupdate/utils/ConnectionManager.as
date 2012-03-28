package com.roborun.p2pupdate.utils
{
	import com.roborun.p2pupdate.events.ConnectionManagerEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;

	public class ConnectionManager extends EventDispatcher
	{
		private static const SERVER			:String = 'rtmfp://p2p.rtmfp.net/';
		private static const DEVELOPER_KEY	:String = 'c91a99ad1324c2e48ea04c05-6647b9ba2efd';
		
		private static var _nc				:NetConnection;
		private static var _netgroup		:NetGroup;
		private static var _isConnected		:Boolean;
		private static var _seq				:uint;
		private static var _cme				:ConnectionManagerEvent;
		private static var _eventDispatcher :EventDispatcher;
		
		public function ConnectionManager()
		{
		}
		
		public static function connect(): void
		{
			if( !_isConnected )
			{
				_nc = new NetConnection();
				_nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
				_nc.connect( SERVER + DEVELOPER_KEY );
				_eventDispatcher = new EventDispatcher();
			}
		}
		
		public static function get eventDispatcher(): EventDispatcher
		{
			return _eventDispatcher;
		}
		
		private static function onNetStatus( e:NetStatusEvent ): void
		{
			trace(e.info.code);
			
			switch( e.info.code )
			{
				case 'NetConnection.Connect.Success':
					setupGroup();
					break;
				
				case 'NetGroup.Connect.Success':
					_isConnected = true;
					_eventDispatcher.dispatchEvent( new ConnectionManagerEvent( ConnectionManagerEvent.CONNECTED ) );
					break;
				
				case 'NetGroup.Neighbor.Connect':
					_eventDispatcher.dispatchEvent( new ConnectionManagerEvent( ConnectionManagerEvent.CONNECTED ) );
					break;
				
				case 'NetGroup.Posting.Notify':
					receiveMessage( e.info.message );
					break;
			}
		}
		
		private static function setupGroup(): void
		{
			var groupSpec : GroupSpecifier = new GroupSpecifier('myGroup/g1');
			groupSpec.serverChannelEnabled = true;
			groupSpec.postingEnabled = true;
			
			_netgroup = new NetGroup(_nc, groupSpec.groupspecWithAuthorizations());
			_netgroup.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		
			
		}
		
		public static function sendMessage( message:Object ): void
		{
			trace( 'group:',_netgroup.estimatedMemberCount );	
			message.sender = _netgroup.convertPeerIDToGroupAddress( _nc.nearID );
			// För att varje meddelande ska vara unikt
			message.sequence = _seq++;
			
			// Man kan inte skicka något innan man har connectat.
			if( _isConnected )
			{
				_netgroup.post( message );
				receiveMessage( message );
			}
		}
		
		private static function receiveMessage( message:Object ): void
		{
			_cme = new ConnectionManagerEvent(ConnectionManagerEvent.MESSAGE_RECEIVED);
			_cme.message = message;
			
			_eventDispatcher.dispatchEvent( _cme );
			
			trace(message.xpos);
		}
	}
}