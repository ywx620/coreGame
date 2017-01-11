package org.corePopStarGame
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.unify.GameMap;
	import org.unify.Rectangle;

	/**
	 * ...2016-12-16
	 * @author vinson
	 * 全图横向填充
	 */
	public class MapFillRow extends EventDispatcher implements IFill
	{
		private var _result:Boolean;
		private var _maps:Array;
		private var actions:Array;
		private var _gameMap:GameMap;
		private var comNum:int;
		private var emptyMap:Array;
		private var isTest:Boolean=true;
		public function MapFillRow()
		{
			actions=new Array;
		}
		/**开始*/
		public function start():void
		{

			if(hasEmptyColumn){
				comNum=0;
				for(var i:int=0;i<maps.length;i++){
					var mapHead:Rectangle=emptyMap[i];
					var map:Array=maps[i];
					var isAction:Boolean=false;
					for(var j:int=mapHead.xnum+1;j<map.length;j++){
						if(map[j].index!=0) isAction=true;
					}
					if(isAction==true){
						var action:FillActionRow=new FillActionRow;
						action.setMapHead(mapHead);
						action.maps=maps;
						action.map=map;
						action.gameMap=_gameMap;
						action.start();
						action.addEventListener(Event.COMPLETE,onComple);
						actions.push(action);
					}
				}
				//trace("actions.length=="+actions.length);
				if(actions.length==0){
					this.dispatchEvent(new Event(Event.COMPLETE));
				}
			}else{
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		/**完成*/
		protected function onComple(event:Event):void
		{
			comNum++;
			if(comNum==actions.length){
				for(var i:int=0;i<actions.length;i++){
					var action:FillAction=actions[i];
					action.removeEventListener(Event.COMPLETE,onComple);
					action.dispose();
					action=null;
				}
				actions.length=0;
				start();
			}
		}
		/**查找是否有空的列存在*/
		private function get hasEmptyColumn():Boolean
		{
			//全图竖着来搜索一次
			for(var i:int=0;i<maps[0].length;i++){
				var map:Array=new Array;
				for(var j:int=0;j<maps.length;j++){
					map.push(maps[j][i]);
				}
				if(goSearchColumn(map)){
					emptyMap=map;
					return true;//有空列
				}
			}
			return false;
		}
		/**搜索空列*/
		private function goSearchColumn(map:Array):Boolean
		{
			var num:int=0;
			for(var i:int=0;i<map.length;i++){
				var rect:Rectangle=map[i];
				if(rect.index==0) num++;
			}
			//trace(num,map.length)
			if(num==map.length) return true;
			return false;
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

		public function set gameMap(value:GameMap):void
		{
			_gameMap = value;
		}

	}
}