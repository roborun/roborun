package com.reyco1.multiuser.channel
{
	import flash.net.NetConnection;
	import flash.net.NetStream;

	/**
	 * Creates a DIRECT_CONNECTION NetStream instance between 2 peers
	 * @author Reynaldo
	 * 
	 */	
	public class RealtimeChannel
	{
		public  var peerID:String;
		
		private var receiveStream:NetStream;		
		private var myPeerID:String;		
		private var client:Object;
		
		public function RealtimeChannel(connection:NetConnection, peerID:String, myPeerID:String, client:Object)
		{
			this.peerID 	= peerID;
			this.myPeerID 	= myPeerID;
			this.client 	= client;
			
			receiveStream = new NetStream(connection, peerID);
			receiveStream.client = client;
			receiveStream.play("media");
		}
		
		/**
		 * Closes this NetStream connection 
		 * 
		 */		
		public function close():void
		{
			receiveStream.close();
		}
	}
}