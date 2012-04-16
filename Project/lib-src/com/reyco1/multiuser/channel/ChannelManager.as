package com.reyco1.multiuser.channel
{
	import com.reyco1.multiuser.core.Session;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.media.Camera;
	import flash.net.NetStream;
	
	/**
	 * Manages all RealtimeChannel instances 
	 * @author Reynaldo
	 * 
	 */	
	public class ChannelManager extends EventDispatcher
	{
		public var channels:Vector.<RealtimeChannel>;
		
		private var session:Session;
		public  var sendStream:NetStream;
		public  var streamMethod:String;
		public  var myCamera:Camera;
		
		/**
		 * Creates an instance of the ChannelManager class 
		 * @param session
		 * @param streamMethod
		 * 
		 */		
		public function ChannelManager(session:Session, streamMethod:String = NetStream.DIRECT_CONNECTIONS)
		{
			this.session 	  = session;
			this.streamMethod = streamMethod;
			this.channels  	  = new Vector.<RealtimeChannel>();
			
			initializeSendStream();
		}
		
		private function initializeSendStream():void
		{
			sendStream = new NetStream(session.connection, streamMethod);
			sendStream.publish("media");
			
			var sendStreamClient:Object = new Object();
			sendStreamClient.onPeerConnect = function(callerns:NetStream):Boolean
			{
				return true;
			}
			
			sendStream.client = sendStreamClient;
		}
		
		/**
		 * @private 
		 * @param value
		 * 
		 */		
		public function set sendCamera(value:Boolean):void
		{
			if(value)
				myCamera = Camera.getCamera();
			else
				myCamera = null;
			
			sendStream.attachCamera( myCamera );			
		}
		
		/**
		 * Adds a RealtimeChannel instance 
		 * @param peerID
		 * @param clientObject
		 * 
		 */		
		public function addChannel(peerID:String, clientObject:Object):void
		{
			var realtimeChannel:RealtimeChannel = new RealtimeChannel(session.connection, peerID, session.group.myUser.id, clientObject);
			channels.push(realtimeChannel);
		}
		
		/**
		 * Removes a RealtimeChannel instance 
		 * @param peerID
		 * 
		 */		
		public function removeChannel(peerID:String):void
		{
			for(var i:uint = 0; i<channels.length; i++)
			{
				if(channels[i].peerID == peerID)
				{
					channels[i].close();
					channels.splice(i, 1);
					break;
				}
			}
		}
	}
}