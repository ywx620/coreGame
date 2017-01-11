package org.corePopStarGame
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.unify.Const;
	import org.unify.Rectangle;
	

	/**
	 * ...2016-12-27
	 * @author vinson
	 */
	public class DestroyAction extends EventDispatcher
	{
		private static const INIT_SPEED:Number=1;
		private var time:Timer;
		private var _result:Boolean;
		private var _maps:Array;
		private var speed:Number=0;
		public function DestroyAction()
		{
			time=new Timer(50,0);
			time.addEventListener(TimerEvent.TIMER,onLoop);
		}
		
		protected function onLoop(event:TimerEvent):void
		{
			speed-=0.2;
			for(var i:int=0;i<maps.length;i++){
				var rect:Rectangle=maps[i];
				rect.alpha=speed;
			}
			if(speed<=0){
				for(i=0;i<maps.length;i++){
					rect=maps[i];
					rect.alpha=1;
					rect.scaleX=rect.scaleY=1;
					rect.clear();
					rect.setRect(Const.SIZE,Const.SIZE,0,Const.COLORS[0]);
					rect.showSeat();
				}
				time.stop();
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		public function start():void
		{
			speed=INIT_SPEED;
			time.start();
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
		public function dispose():void
		{
			time.removeEventListener(TimerEvent.TIMER,onLoop);
			time=null;
		}
	}
}
