package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.geom.Point;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	
	[SWF(width="300", height="180")]
	public class P2PGame extends Sprite
	{
		private const SERVER			:String = 'rtmfp://p2p.rtmfp.net/';
		private const DEVELOPER_KEY		:String = 'c91a99ad1324c2e48ea04c05-6647b9ba2efd';
		
		private var _nc				:NetConnection;
		private var _netgroup		:NetGroup;
		
		private var _seq			:uint;
		private var _level			:Array;
		
		
		private var _player			:Sprite;
		
		private var _update			:Object;
		
		public function P2PGame()
		{
			init();
		}
		
		private function init(): void
		{
			
			
			createLevel();
			showLevel();
			
			_player = createGrid(0);
			addChild(_player);
			
			connect();
			
			
			_update ={};
			addEventListener(Event.ENTER_FRAME, onLoop_move);
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
		//	trace(e.info);			
			switch( e.info.code )
			{
				case 'NetConnection.Connect.Success':
					setupGroup();
					break;
				
				case 'NetGroup.Connect.Success':
					break;
				
				case 'NetGroup.Posting.Notify':
					receiveUpdate( e.info.message );
					trace( e.info );
					break;
			}
		}
		
		private function setupGroup(): void
		{
			var groupSpec : GroupSpecifier = new GroupSpecifier('myGroup/g2');
			groupSpec.serverChannelEnabled = true;
			groupSpec.postingEnabled = true;
			
			_netgroup = new NetGroup(_nc, groupSpec.groupspecWithAuthorizations());
			_netgroup.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);

		}
		
		private function sendUpdate( newPos:Point ): void
		{
			var update : Object = {};
			
			update.sender = _netgroup.convertPeerIDToGroupAddress( _nc.nearID );
			update.user = 'user'+ uint(Math.random()*100);
			update.xpos = newPos.x;
			update.ypos = newPos.y;
			update.sequence = _seq++;
			
			_netgroup.post( update );
			receiveUpdate( update );
			
		}
		
		private function receiveUpdate( update:Object ): void
		{
			trace( update.xpos, update.ypos );
			_update = update;
			
		}
		
		private function onLoop_move( e:Event ): void
		{
			
			if( _update.xpos *20 < _player.x) _player.x --;
			else if ( _update.xpos *20 > _player.x) _player.x ++;

			if( _update.ypos *20 < _player.y) _player.y --;
			else if ( _update.ypos *20> _player.y) _player.y ++;
			
			
		}
		
		private function showLevel(): void
		{
			for (var y:uint = 0; y < _level.length; y++) 
			{
				for (var x:int = 0; x < _level[y].length; x++) 
				{
					var grid : Sprite;
					switch( _level[y][x] )
					{
						case 1:
							grid = createGrid(0xff00cc);
							break;
						
						case 0:
							grid = createGrid(0xffcc00);
							break;
					}
					grid.x = x*20;
					grid.y = y*20;
					addChild(grid);
				}
			}
			addEventListener(MouseEvent.CLICK, onClick_sendNewPos);	
		}
		
		private function createGrid(color:uint): Sprite
		{
			var target: Sprite = new Sprite();
			
			target.graphics.beginFill(color);
			target.graphics.drawRect(0,0, 20,20);
			target.graphics.endFill();
			
			return target;
		}
		
		private function createLevel():void
		{
			_level = [
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],					 
				[1,0,0,0,0,0,0,0,0,1,1,1,1,1,1],
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
				[1,1,1,1,1,1,1,1,0,1,1,1,1,1,1],
				[1,1,1,1,1,0,1,1,1,1,1,1,1,1,1],
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
				[1,1,1,1,0,1,1,1,1,1,1,0,1,1,1],
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
			]
		}
		
		private function onClick_sendNewPos ( e:MouseEvent ):void
		{
			sendUpdate( new Point( uint(mouseX/20), uint(mouseY/20) ) );
		}
	}
}