package org.corePopStarGame
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import org.unify.Const;
	import org.unify.GameMap;
	import org.unify.Rectangle;

	/**
	 * ...2016-12-20
	 * @author vinson
	 * 填充动画
	 */
	public class FillAction extends EventDispatcher implements IFill
	{
		protected const INIT_SPEED:Number=3;
		protected var time:Timer;
		protected var _result:Boolean;
		protected var _maps:Array;
		protected var _map:Array;
		protected var searchs:Array;
		protected var speed:Number;
		protected var moveRects:Array;
		protected var _gameMap:GameMap;
		protected var max:Number;
		protected var mapClone:Array;
		protected var mapHead:Rectangle;
		public function FillAction()
		{
			time=new Timer(20,0);
			time.addEventListener(TimerEvent.TIMER,onLoop);
			searchs=new Array;
			moveRects=new Array;
			mapClone=new Array;
		}
		
		protected function onLoop(event:TimerEvent):void
		{
			if(moveRects.length==0){
				time.stop();
				return;
			}
			speed+=0.1;
			for(var i:int=0;i<moveRects.length;i++){
				var rect:Rectangle=moveRects[i];
				rect.y+=speed;
			}
			rect=moveRects[0];
			if(rect.y>mapHead.y-speed){
				time.stop();
				goSearch();
			}
		}
		public function start():void
		{
			var rect:Rectangle;
			var startRect:Rectangle;
			var endRect:Rectangle;
			var i:int;
			speed=INIT_SPEED;
			searchs.length=0;
			moveRects.length=0;
			mapClone.length=0;
			/**测试--------
			trace("map",map)
			for(i=0;i<map.length;i++){
				rect=map[i];
				rect.clear();
				if(i==1)			rect.setRect(Const.SIZE,Const.SIZE,2,Const.COLORS[2]);
//				else if(i==4)		rect.setRect(Const.SIZE,Const.SIZE,1,Const.COLORS[1]);
//				else if(i==5)		rect.setRect(Const.SIZE,Const.SIZE,1,Const.COLORS[1]);
//				else if(i==8)		rect.setRect(Const.SIZE,Const.SIZE,1,Const.COLORS[1]);
				else				rect.setRect(Const.SIZE,Const.SIZE,0,Const.COLORS[0]);
				rect.showSeat();
			}
			*/
			for(i=0;i<map.length;i++){
				rect=map[i];
				mapClone.push(rect.clone);
			}
			for(i=map.length-1;i>0;i--){
				startRect=map[i];
				endRect=map[i-1];
				if(startRect.index==0){
					pushRect(startRect);
					if(startRect.index==endRect.index){
						pushRect(endRect);
					}
				}else if(endRect.index==0){
					pushRect(endRect);
				}
			}
			
			reStart();
		}
		protected function reStart():void
		{
			pushMoveRect();
			if(moveRects.length>0){
				time.start();
			}else{
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		protected function getMapRectByRect(rect:Rectangle):Rectangle
		{
			for(var i:int=0;i<map.length;i++){
				var r:Rectangle=map[i];
				if(r.ynum==rect.ynum) return r;
			}
			return null;
		}
		protected function getCloneRectByRect(rect:Rectangle):Rectangle
		{
			for(var i:int=0;i<mapClone.length;i++){
				var r:Rectangle=mapClone[i];
				if(r.ynum==rect.ynum) return r;
			}
			return null;
		}
		protected function goSearch():void
		{
			var startRect:Rectangle;
			var endRect:Rectangle;
			//trace("maps",maps);
			for(var i:int=0;i<moveRects.length;i++){
				startRect=moveRects[i];
				for(var j:int=0;j<mapClone.length;j++){
					endRect=mapClone[j];
					var dis:Number=Math.abs(startRect.y-endRect.y)
					if(dis<speed*2){
						var ynum:int=startRect.ynum;
						var y:Number=getCloneRectByRect(startRect).y;//得到拷贝的数据
						endRect=getMapRectByRect(endRect);//得到地图上真实数据
						
						//把两个方块数据替换，数组中的也替换
						var sIndex:int=map.indexOf(startRect);
						var eIndex:int=map.indexOf(endRect);
						if(sIndex>=0){//原本地图中就有
							map.splice(sIndex,1,endRect);
						}else{//新加的方块
							var s:int=searchs.indexOf(startRect);
							searchs.splice(s,1);
						}
						map.splice(eIndex,1,startRect);
						
						startRect.ynum=endRect.ynum;
						endRect.ynum=ynum;
						startRect.xnum=endRect.xnum;
						
						startRect.y=endRect.y;
						endRect.y=y;
						
						startRect.showSeat();
						endRect.showSeat();
						
						break;
					}
				}
			}
			replaceMap()
			//trace("maps",maps);
			reStart();
		}
		/**替换地图*/
		protected function replaceMap():void
		{
			var rect:Rectangle=map[0];
			var xnum:int=rect.xnum;
			for(var i:int=0;i<maps.length;i++){
				maps[i][xnum]=map[i];
			}
		}
		/**查找需要移动的方块*/
		protected function pushMoveRect():void
		{
			max=map.length-1;
			moveRects.length=0;
			mapHead=null;
			for(var i:int=max;i>=0;i--){
				var rect:Rectangle=map[i];
				if(rect.index==0){	
					mapHead=rect;
					max=i;
					break;
				}
			}
			if(max!=map.length-1||mapHead!=null){//这两个不相等并且头方块是没有的才说明有需要补充方块
				for(i=max;i>=0;i--){
					rect=map[i];
					if(rect.index!=0){		
						rect.parent.setChildIndex(rect,rect.parent.numChildren-1);
						moveRects.push(rect);
					}
				}
			}
		}
		public function pushRect(rect:Rectangle):void
		{
			if(searchs.indexOf(rect)==-1){
				searchs.push(rect);
			}
		}
		public function get result():Boolean
		{
			return false;
		}
		
		public function get maps():Array
		{
			return _maps;
		}
		
		public function set maps(value:Array):void
		{
			_maps = value;
		}

		public function set map(value:Array):void
		{
			_map = value;
		}
		public function get map():Array
		{
			return _map;
		}
		
		public function set gameMap(value:GameMap):void
		{
			_gameMap = value;
		}
		public function dispose():void
		{
			time.removeEventListener(TimerEvent.TIMER,onLoop);
			time=null;
		}
	}
}