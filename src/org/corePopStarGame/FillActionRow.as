package org.corePopStarGame
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	import org.unify.Rectangle;

	/**
	 * ...2016-12-28
	 * @author vinson
	 */
	public class FillActionRow extends FillAction
	{
		public function FillActionRow()
		{
			super();
		}
		public function setMapHead(rect:Rectangle):void
		{
			this.mapHead=rect;
		}
		override protected function onLoop(event:TimerEvent):void
		{
			if(moveRects.length==0){
				time.stop();
				return;
			}
			//speed+=0.1;
			for(var i:int=0;i<moveRects.length;i++){
				var rect:Rectangle=moveRects[i];
				rect.x-=speed;
			}
			rect=moveRects[0];
			if(rect.x<mapHead.x+speed){
				time.stop();
				goSearch();
			}
		}
		override public function start():void
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
			/*
			for(i=0;i<map.length-1;i++){
				startRect=map[i];
				endRect=map[i+1];
				if(startRect.index==0){
					pushRect(startRect);
					if(startRect.index==endRect.index){
						pushRect(endRect);
					}
				}else if(endRect.index==0){
					pushRect(endRect);
				}
			}
			
			*/
			reStart()
		}
		override protected function goSearch():void
		{
			var startRect:Rectangle;
			var endRect:Rectangle;
			//trace("maps",maps);
			for(var i:int=0;i<moveRects.length;i++){
				startRect=moveRects[i];
				for(var j:int=0;j<mapClone.length;j++){
					endRect=mapClone[j];
					var dis:Number=Math.abs(startRect.x-endRect.x)
					if(dis<speed*2){
						var xnum:int=startRect.xnum;
						var x:Number=getCloneRectByRect(startRect).x;//得到拷贝的数据
						endRect=getMapRectByRect(endRect);//得到地图上真实数据
						
						//把两个方块数据替换，数组中的也替换
						var sIndex:int=map.indexOf(startRect);
						var eIndex:int=map.indexOf(endRect);
						
						map.splice(sIndex,1,endRect);
						map.splice(eIndex,1,startRect);
						
						startRect.xnum=endRect.xnum;
						endRect.xnum=xnum;
						
						startRect.x=endRect.x;
						endRect.x=x;
						
						startRect.showSeat();
						endRect.showSeat();
						
						break;
					}
				}
			}
			replaceMap()
			//trace("maps",maps);
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		override protected function getCloneRectByRect(rect:Rectangle):Rectangle
		{
			for(var i:int=0;i<mapClone.length;i++){
				var r:Rectangle=mapClone[i];
				if(r.xnum==rect.xnum) return r;
			}
			return null;
		}
		override protected function getMapRectByRect(rect:Rectangle):Rectangle
		{
			for(var i:int=0;i<map.length;i++){
				var r:Rectangle=map[i];
				if(r.xnum==rect.xnum) return r;
			}
			return null;
		}
		/**查找需要移动的方块*/
		override protected function pushMoveRect():void
		{
			max=mapHead.xnum;
			moveRects.length=0;
			for(var i:int=max;i<map.length;i++){
				var rect:Rectangle=map[i];
				if(rect.index!=0){	
					mapHead=map[i-1];
					max=i-1;
					break;
				}
			}
			if(max!=map.length-1||mapHead!=null){//这两个不相等并且头方块是没有的才说明有需要补充方块
				for(i=max;i<map.length;i++){
					rect=map[i];
					if(rect.index!=0){		
						rect.parent.setChildIndex(rect,rect.parent.numChildren-1);
						moveRects.push(rect);
					}
				}
			}
		}
		/**替换地图*/
		override protected function replaceMap():void
		{
			var rect:Rectangle=map[0];
			var ynum:int=rect.ynum;
			for(var i:int=0;i<maps[0].length;i++){
				maps[ynum][i]=map[i];
			}
			//trace(maps[ynum])
			//trace("---")
		}
	}
}