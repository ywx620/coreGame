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
	 * 点搜索
	 */
	public class MapSearch extends EventDispatcher implements ISearch
	{
		
		private var searchs:Array;
		private var _result:Boolean;
		private var _maps:Array;
		private var startRect:Rectangle;
		public function MapSearch()
		{
			searchs=new Array;
		}
		public function start():void
		{
			ShowTime.getIns().start();
			
			searchs.length=0;
			startRect.type=1;
			searchs.push(startRect);			
			goSearch(startRect);
			
			//ShowTime.getIns().show("全图搜索");
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		/**搜索*/
		private function goSearch(rect:Rectangle):void
		{
			var map:Array=getmap(rect)
			for(var i:int=0;i<map.length;i++){
				var r:Rectangle=map[i];
				if(r!=rect){
					if(r.type==0&&r.index==rect.index){
						searchs.push(r);
						r.type=1;
						goSearch(r);
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
			if(searchs.length>=2)	return true;
			else				 	return false;
		}
		/**需要消灭的方块数组*/
		public function get destroys():Array
		{
			return searchs;
		}
		public function setStartRect(rect:Rectangle):void
		{
			this.startRect=rect;
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