package org.corePopStarGame
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.unify.Const;
	import org.unify.Rectangle;
	import org.unify.ShowTime;

	/**
	 * ...2016-12-14
	 * @author vinson
	 * 是否结束的搜索
	 */
	public class OverSearch extends EventDispatcher implements ISearch
	{
		
		private var _result:Boolean;
		private var _maps:Array;
		public function OverSearch()
		{
			
		}
		public function start():void
		{
			ShowTime.getIns().start();
			
			goSearch();
			
			ShowTime.getIns().show("游戏结束的全图搜索");
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		/**搜索*/
		private function goSearch():void
		{
			_result=true;
			for(var j:int=0;j<maps.length;j++){
				var tempmaps:Array=maps[j]
				for(var k:int=0;k<tempmaps.length;k++){
					var rect:Rectangle=tempmaps[k];
					var map:Array=getmap(rect)
					for(var i:int=0;i<map.length;i++){
						var r:Rectangle=map[i];
						if(r!=rect){
							if(r.type==0&&r.index==rect.index){
								_result=false;
								return;
							}
						}
					}
				}
			}
		}
		
		private function getmap(rect:Rectangle):Array
		{
			var map:Array=new Array;
			var minx:int=rect.xnum-1;
			var miny:int=rect.ynum-1;
			var maxx:int=rect.xnum+1;
			var maxy:int=rect.ynum+1;
			minx=minx==-1?0:minx;
			miny=miny==-1?0:miny;
			maxx=maxx==Const.COLUMN?Const.COLUMN-1:maxx;
			maxy=maxy==Const.ROW?Const.ROW-1:maxy;
			map.push(maps[miny][rect.xnum]);
			map.push(maps[maxy][rect.xnum]);
			map.push(maps[rect.ynum][minx]);
			map.push(maps[rect.ynum][maxx]);
			//trace(map);
			return map;
		}
		public function get result():Boolean
		{
			return _result;
		}
		
		public function get maps():Array
		{
			return _maps;
		}
		
		public function set maps(value:Array):void
		{
			_maps = value;
		}
	}
}