package org.coreMstchingGame
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import org.unify.Rectangle;
	import org.unify.ShowTime;

	/**
	 * ...2016-12-14
	 * @author vinson
	 * 全图搜索
	 */
	public class MapSearch extends EventDispatcher implements ISearch
	{
		
		private var searchs:Array;
		private var _result:Boolean;
		private var _maps:Array;
		public function MapSearch()
		{
			searchs=new Array;
		}
		public function start():void
		{
			searchs.length=0;
			//全图横着来搜索一次
			ShowTime.getIns().start();
			for(var i:int=0;i<maps.length;i++){
				var map:Array=maps[i];
				goSearch(map);
			}
			//trace(searchs)
			//全图竖着来搜索一次
			for(i=0;i<maps[0].length;i++){
				map=new Array;
				for(var j:int=0;j<maps.length;j++){
					map.push(maps[j][i]);
				}
				goSearch(map);
			}
			//trace(searchs)
			//全图竖着来搜索一次
//			for(i=0;i<searchs.length;i++){
//				map=searchs[i];
//				for(j=0;j<map.length;j++){
//					var r:Rectangle=map[j];
//					r.clear();
//					r.setRect(75,75,r.index,0xcccccc);
//					r.showSeat();
//				}
//			}
			
			ShowTime.getIns().show("全图搜索");
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		/**搜索*/
		private function goSearch(map:Array):void
		{
			var startRect:Rectangle;
			var endRect:Rectangle;
			var tempSearchs:Array=new Array;
			for(var j:int=0;j<map.length-1;j++){
				startRect=map[j];
				endRect=map[j+1];
				if(startRect.index!=0&&startRect.index==endRect.index){
					if(tempSearchs.indexOf(startRect)==-1){
						tempSearchs.push(startRect);
					}
					tempSearchs.push(endRect);
				}else{
					if(tempSearchs.length>=3){
						searchs.push(tempSearchs.concat());
					}
					tempSearchs.length=0;
				}
			}
			if(tempSearchs.length>=3){
				searchs.push(tempSearchs.concat());
			}
			tempSearchs.length=0;
		}
		public function get result():Boolean
		{
			if(searchs.length>0) return true;
			else				 return false;
		}
		/**需要消灭的方块数组*/
		public function get destroys():Array
		{
			return searchs;
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