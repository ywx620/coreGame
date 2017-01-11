package org.corePopStarGame
{	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.unify.Rectangle;

	/**
	 * ...2016-12-14
	 * @author vinson
	 * 消灭星星的核心算法
	 */
	public class PopStarGame extends BasicGame
	{
		private var mapSearch:MapSearch;
		private var overSearch:OverSearch;
		private var mapFill:MapFill;
		private var mapFillRow:MapFillRow;
		private var destroyAction:DestroyAction;
		public function PopStarGame()
		{
			super();
		}
		override protected function initGame():void
		{
			createMap();
			createLevel();
			createBackground();
			background.x=background.y=gameMap.x=gameMap.y=50;
			
			mapSearch=new MapSearch;
			mapSearch.maps=maps;
			mapSearch.addEventListener(Event.COMPLETE,onComplete);
			
			overSearch=new OverSearch;
			overSearch.maps=maps;
			overSearch.addEventListener(Event.COMPLETE,onComplete);
			
			mapFill=new MapFill;
			mapFill.maps=maps;
			mapFill.addEventListener(Event.COMPLETE,onComplete);
			mapFill.gameMap=gameMap;
			
			mapFillRow=new MapFillRow;
			mapFillRow.maps=maps;
			mapFillRow.addEventListener(Event.COMPLETE,onComplete);
			mapFillRow.gameMap=gameMap;
			
			destroyAction=new DestroyAction;
			destroyAction.addEventListener(Event.COMPLETE,onComplete);

			//overSearch.start();
		}
		override protected function createLevel():void
		{
			var levels:Array=new Array;
			for(var i:int=0;i<row;i++){
				for(var j:int=0;j<column;j++){
					levels.push(maps[i][j]);
				}
			}
			for(i=0;i<levels.length;i++){
				var index:int=Math.ceil(Math.random()*colorNum);
				for(j=0;j<2;j++){
					var levelIndex:int=Math.floor(levels.length*Math.random());
					var rect:Rectangle=levels[levelIndex];
					rect.color=colors[index];
					rect.resetRect(index);
					rect.showSeat();
					//rect.buttonMode=true;
					rect.addEventListener(MouseEvent.CLICK,onClick);
					levels.splice(levelIndex,1);
					if(i>0) i--;
				}
			}
		}
		/**点击后处理*/
		private function onClick(e:MouseEvent):void
		{
			addRemoveEvent(false);
			var rect:Rectangle=e.currentTarget as Rectangle;
			mapSearch.setStartRect(rect);
			mapSearch.start();
		}
		private function onComplete(e:Event):void
		{
			switch(e.currentTarget){
				case mapSearch://地图搜索结束后
					if(mapSearch.result==true){//全图搜索没有找到3个
						destroyAction.maps=mapSearch.destroys
						destroyAction.start();
					}else{
						addRemoveEvent(true);
					}
					break;
				case mapFill://地图填充结束后
					//addRemoveEvent(true);
					mapFillRow.start();
					break;
				case destroyAction://消除结束后
					//消除之后开始填充
					mapFill.start();
					break;
				case mapFillRow://地图横向填充结束后
					//addRemoveEvent(true);
					overSearch.start();
					break;
				case overSearch://全图搜索是否没有可消除方块
					if(overSearch.result==true){//true代表没有方块可以消除了
						trace("游戏结束");
					}else{//还有方块可消除
						addRemoveEvent(true);
					}
					
					break;
			}
			
		}
		private function addRemoveEvent(isAdd:Boolean):void
		{
			for(var i:int=0;i<row;i++){
				for(var j:int=0;j<column;j++){
					var rect:Rectangle=maps[i][j];
					if(isAdd)	rect.addEventListener(MouseEvent.CLICK,onClick);
					else		rect.removeEventListener(MouseEvent.CLICK,onClick);
				}
			}
		}
	}
}