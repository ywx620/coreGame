package org.unify
{
	import flash.display.Sprite;

	/**
	 * ...2016-12-14
	 * @author vinson
	 */
	public class GameMap extends Sprite
	{
		private var _maps:Array;
		private var size:Number;//每个小块大小
		private var row:int;//行总个数
		private var column:int;//列总个数
		public function GameMap()
		{
			
		}
		public function setValue(s:Number,r:int,c:int):void
		{
			size=s;
			row=r;
			column=c;
		}
		public function start():void
		{
			var w:Number=size;
			_maps=new Array;
			var rect:Rectangle;
			var interval:Number=Const.INTERVAL;
			for(var i:int=0;i<row;i++){
				var map:Array=new Array;
				for(var j:int=0;j<column;j++){
					rect=new Rectangle();
					rect.setRect(w,w,0,0XCCCCCC);
					rect.xnum=j;
					rect.ynum=i;
					rect.x=rect.xnum*(w+interval);
					rect.y=rect.ynum*(w+interval);
					rect.showSeat();
					this.addChild(rect);
					map.push(rect);
				}
				_maps.push(map);
			}
		}

		public function get maps():Array
		{
			return _maps;
		}

	}
}