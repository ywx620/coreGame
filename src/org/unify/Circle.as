package org.unify
{
	import flash.text.TextField;

	/**
	 * ...2017-1-22
	 * @author vinson
	 */
	public class Circle extends Rectangle
	{
		protected var radius:Number
		public function Circle()
		{
			super();
		}
		public function resetCircle(i:int):void
		{
			clear();
			setCircle(radius,i,color);
		}
		/**
		 * r,i,c分别代表方圆的，半径，显示数字，颜色
		 * */
		public function setCircle(r:Number,i:int,c:uint):void
		{
			radius=r;
			_color=c;
			index=i;
			this.graphics.lineStyle(1);//带黑四边
			this.graphics.beginFill(_color);
			this.graphics.drawCircle(0,0,radius);
			centerTxt=new TextField;
			centerTxt.text=String(i);
			centerTxt.autoSize="left";
			centerTxt.x=-(centerTxt.width)>>1;
			centerTxt.y=-(centerTxt.height)>>1;
			centerTxt.selectable=false;
			centerTxt.filters=[glowFilter];
			this.addChild(centerTxt);
			debugger();
		}
		override public function showSeat():void
		{
			super.showSeat();
			seatTxt.x=-(seatTxt.width)>>1;
			seatTxt.y=0;
		}
	}
}