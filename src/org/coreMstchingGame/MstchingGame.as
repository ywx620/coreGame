package org.coreMstchingGame
{	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.unify.Rectangle;

	/**
	 * ...2016-12-14
	 * @author vinson
	 * 对对碰的核心算法
	 */
	public class MstchingGame extends BasicGame
	{
		private var checkRects:Vector.<Rectangle>=new Vector.<Rectangle>;
		private var swopRectangle:SwopRectangle;
		private var mapSearch:MapSearch;
		private var mapFill:MapFill;
		private var destroyAction:DestroyAction;
		public function MstchingGame()
		{
			super();
		}
		override protected function initGame():void
		{
			createMap();
			createLevel();
			createBackground();
			//background.x=background.y=gameMap.x=gameMap.y=100;
			
			mapSearch=new MapSearch;
			mapSearch.maps=maps;
			mapSearch.addEventListener(Event.COMPLETE,onComplete);
			
			mapFill=new MapFill;
			mapFill.maps=maps;
			mapFill.addEventListener(Event.COMPLETE,onComplete);
			mapFill.gameMap=gameMap;
			
			swopRectangle=new SwopRectangle;
			swopRectangle.maps=maps;
			swopRectangle.addEventListener(Event.COMPLETE,onComplete);
			
			destroyAction=new DestroyAction;
			destroyAction.addEventListener(Event.COMPLETE,onComplete);
			
			//mapSearch.start();
			mapFill.start();
			//startFill();
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
					rect.addEventListener(MouseEvent.MOUSE_DOWN,onClick);
					rect.addEventListener(MouseEvent.MOUSE_UP,onClick);
					levels.splice(levelIndex,1);
					if(i>0) i--;
				}
			}
		}
		/**点击后处理*/
		private function onClick(e:MouseEvent):void
		{
			var rect:Rectangle=e.currentTarget as Rectangle;
			if(checkRects.length<2){
				//setFilters(rect,true);
				checkRects.push(rect);
				if(checkRects.length==2){
					result=false;
					swopRectangle.setTwoRect(checkRects[0],checkRects[1]);
					if(swopRectangle.result){
						addRemoveEvent(false);
						swopRectangle.start();
					}
					checkRects.length=0;
				}
			}
		}
		private function onComplete(e:Event):void
		{
			trace(e.currentTarget)
			switch(e.currentTarget){
				case swopRectangle://两个位置对换后
					if(swopRectangle.hasStart){
						mapSearch.start();
					}else{//两个位置对换之后又反转回来
						trace("两个位置对换之后又反转回来");
						addRemoveEvent(true);
					}
					break;
				case mapSearch://地图搜索结束后
					trace("mapSearch=",mapSearch.result)
					if(mapSearch.result==false){//全图搜索没有找到3个
						if(swopRectangle.hasStart){//两个方块反转
							swopRectangle.start();
						}else{
							addRemoveEvent(true);
						}
					}else{//找到3个在同一排或同一列后，消除它们
						swopRectangle.clear();
						addRemoveEvent(false);
						destroyAction.maps=mapSearch.destroys
						destroyAction.start();
					}
					break;
				case mapFill://地图填充结束后
					mapSearch.start();
					break;
				case destroyAction://消除结束后
					//消除之后开始填充
					mapFill.start();
					addRemoveEvent(false);
					break;
			}
			
		}
		private function addRemoveEvent(isAdd:Boolean):void
		{
			for(var i:int=0;i<row;i++){
				for(var j:int=0;j<column;j++){
					var rect:Rectangle=maps[i][j];
					if(isAdd){
						rect.addEventListener(MouseEvent.MOUSE_DOWN,onClick);
						rect.addEventListener(MouseEvent.MOUSE_UP,onClick);
					}else{
						rect.removeEventListener(MouseEvent.MOUSE_DOWN,onClick);
						rect.removeEventListener(MouseEvent.MOUSE_UP,onClick);
					}
				}
			}
		}
		/**消灭相连的3个以上方块*/
		private function destroyRect():void
		{
			
			for(var i:int=0;i<mapSearch.destroys.length;i++){
				var map:Array=mapSearch.destroys[i];
				for(var j:int=0;j<map.length;j++){
					var rect:Rectangle=map[j];
					rect.clear();
					rect.setRect(size,size,0,colors[0]);
					rect.showSeat();
				}
			}
			
		}
	}
}