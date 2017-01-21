package org.coreMstchingGame
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.unify.GameMap;
	import org.unify.Rectangle;

	/**
	 * ...2016-12-16
	 * @author vinson
	 * 全图填充
	 */
	public class MapFill extends EventDispatcher implements IFill
	{
		private var _result:Boolean;
		private var _maps:Array;
		private var actions:Array;
		private var _gameMap:GameMap;
		private var comNum:int;
		public function MapFill()
		{
			actions=new Array;
		}
		public function start():void
		{
			comNum=0;
			actions.length=0;
			//全图竖着来搜索一次
			for(var i:int=0;i<maps[0].length;i++){
				var map:Array=new Array;
				for(var j:int=0;j<maps.length;j++){
					map.push(maps[j][i]);
				}
				goSearch(map);
			}
		}
		/**搜索*/
		private function goSearch(map:Array):void
		{
			var rect:Rectangle;
			for(var i:int=0;i<map.length;i++){
				rect=map[i];
				if(rect.index==0){//发现有空的方块
					var action:FillAction=new FillAction;
					action.maps=maps;
					action.map=map;
					action.gameMap=_gameMap;
					action.start();
					action.addEventListener(Event.COMPLETE,onComple);
					actions.push(action);
					break;
				}
			}
			if(actions.length>0){
				_result=true;
			}else{
				_result=false;
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		protected function onComple(event:Event):void
		{
			comNum++;
			if(comNum==actions.length){
				for(var i:int=0;i<actions.length;i++){
					var action:FillAction=actions[i]
					action.removeEventListener(Event.COMPLETE,onComple);
					action.dispose();
					action=null;
				}
				actions.length=0;
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
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