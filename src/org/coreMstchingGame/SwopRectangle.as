package org.coreMstchingGame
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import org.unify.Rectangle;

	/**
	 * ...2016-12-14
	 * @author vinson
	 * 两个方块兑换位置
	 */
	public class SwopRectangle extends EventDispatcher implements ISearch
	{
		private var time:Timer;
		private var startRect:Rectangle;
		private var endRect:Rectangle;
		private var _result:Boolean;
		private var startPoint:Point;
		private var endPoint:Point;
		private var _maps:Array;
		private var speed:Number=3;
		private var startNum:int;
		public function SwopRectangle()
		{
			time=new Timer(50,0);
			time.addEventListener(TimerEvent.TIMER,onLoop);
		}
		
		protected function onLoop(event:TimerEvent):void
		{
			startRect.x+=(endPoint.x-startPoint.x)/speed;
			startRect.y+=(endPoint.y-startPoint.y)/speed;
			
			endRect.x+=(startPoint.x-endPoint.x)/speed;
			endRect.y+=(startPoint.y-endPoint.y)/speed;
			
			var dx:Number=startRect.x-endPoint.x
			var dy:Number=startRect.y-endPoint.y
			var dis:Number=Math.sqrt((dx*dx)+(dy*dy));
			if(speed>=dis){
				startRect.x=endPoint.x;
				startRect.y=endPoint.y;
				endRect.x=startPoint.x;
				endRect.y=startPoint.y;
				
				var temp:Point=new Point(startPoint.x,startPoint.y);
				startPoint=new Point(endPoint.x,endPoint.y);
				endPoint=new Point(temp.x,temp.y);
				
				//trace(maps[startRect.ynum][startRect.xnum],maps[endRect.ynum][endRect.xnum]);
				var tempRect:Rectangle=startRect.clone;
				maps[startRect.ynum][startRect.xnum]=endRect;
				maps[endRect.ynum][endRect.xnum]=startRect;
				startRect.xnum=endRect.xnum;
				startRect.ynum=endRect.ynum;
				endRect.xnum=tempRect.xnum;
				endRect.ynum=tempRect.ynum;
				startRect.clear();
				startRect.resetRect(startRect.index);
				startRect.showSeat();
				endRect.clear();
				endRect.resetRect(endRect.index);
				endRect.showSeat();
				
				//trace(maps[endRect.ynum][endRect.xnum],maps[startRect.ynum][startRect.xnum])
				time.stop();
				this.dispatchEvent(new Event(Event.COMPLETE));
				if(startNum==3){
					clear();
				}
			}
		}
		public function setTwoRect(startRect:Rectangle,endRect:Rectangle):void
		{
			startNum=0;
			_result=false;
			this.startRect=startRect;
			this.endRect=endRect;
			var num:int=0;
			if(this.startRect.xnum==this.endRect.xnum){//X轴相等
				num=this.startRect.ynum-this.endRect.ynum
			}else if(this.startRect.ynum==this.endRect.ynum){//Y轴相等
				num=this.startRect.xnum-this.endRect.xnum
			}
			if(Math.abs(num)==1){
				 _result=true;
			}
			if(result){
				startPoint=new Point(startRect.x,startRect.y);
				endPoint=new Point(endRect.x,endRect.y);
			}
		}
		public function clear():void
		{
			time.stop();
			startRect=endRect=null;
		}
		public function get hasStart():Boolean
		{
			if(startRect&&endRect&&startNum<2) return true;
			return false;
		}
		public function start():void
		{
			if(startRect&&endRect){
				startNum++;
				time.start();
			}
		}
		public function stop():void
		{
			startRect=endRect=null;
			time.stop();
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