package org.unify
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	public class Rectangle extends Sprite
	{
		private var _xnum:int=0;
		private var _ynum:int=0;
		private var _index:int=0;
		private var _wnum:Number;
		private var _hnum:Number;
		private var _color:uint=0XCCCCCC;
		private var _type:int=0;
		private var centerTxt:TextField;
		private var seatTxt:TextField;
		public function Rectangle()
		{
			super();
			
		}
		public function resetRect(i:int):void
		{
			clear();
			setRect(wnum,hnum,i,color);
		}
		/**
		 * w,h,i,c分别代表方块，宽，高，显示数字，颜色
		 * */
		public function setRect(w:Number,h:Number,i:int,c:uint,b:Boolean=true):void
		{
			_wnum=w;
			_hnum=h;
			_color=c;
			index=i;
			this.graphics.lineStyle(1);//带黑四边
			this.graphics.beginFill(_color);
			this.graphics.drawRect(0,0,w,h);
			centerTxt=new TextField;
			centerTxt.text=String(i);
			centerTxt.autoSize="left";
			centerTxt.x=(w-centerTxt.width)>>1;
			centerTxt.y=(h-centerTxt.height)>>1;
			centerTxt.selectable=false;
			centerTxt.filters=[glowFilter];
			this.addChild(centerTxt);
			debugger();
		}
		/**debugger模式下可以看到每个方块所在数组中的位置*/
		private function debugger():void
		{
			var isDebugger:Boolean=true;
			if(isDebugger==false){
				setAlpha();
				clearTxt();
			}
		}
		public function setAlpha():void
		{
			if(index==0) this.alpha=0;
			else		 this.alpha=1;
		}
		public function clearTxt():void
		{
			if(centerTxt) centerTxt.text="";
			if(seatTxt) seatTxt.text="";
		}
		public function showSeat():void
		{
			var txtName:String="showSeat"
			if(this.getChildByName(txtName)){
				this.removeChild(this.getChildByName(txtName));
			}
			seatTxt=new TextField;
			seatTxt.name=txtName
			seatTxt.text=String("("+xnum+","+ynum+")");
			seatTxt.autoSize="left";
			seatTxt.selectable=false;
			seatTxt.y=this.height-seatTxt.height;
			seatTxt.x=this.width-seatTxt.width;
			seatTxt.filters=[glowFilter]
			this.addChild(seatTxt);
			debugger();
		}
		private function get glowFilter():GlowFilter
		{
			return new GlowFilter(0XFFFFFF,3,3,3);
		}
		public function setText(value:String):void
		{
			var txt:TextField=new TextField;
			txt.text=value;
			txt.autoSize="left";
			txt.selectable=false;
			txt.filters=[glowFilter]
			this.addChild(txt);
		}
		public function clear():void
		{
			this.graphics.clear();
			this.removeChildren();
		}

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}

		public function get ynum():int
		{
			return _ynum;
		}

		public function set ynum(value:int):void
		{
			_ynum = value;
		}

		public function get xnum():int
		{
			return _xnum;
		}

		public function set xnum(value:int):void
		{
			_xnum = value;
		}
		public function get clone():Rectangle
		{
			var rect:Rectangle=new Rectangle();
			rect.xnum=this.xnum;
			rect.ynum=this.ynum;
			rect.index=this.index;
			rect.x=this.x;
			rect.y=this.y;
			return rect;
		}
		override public function toString():String
		{
			return "[("+xnum+","+ynum+"),i="+index+"]";
//			return "("+xnum+","+ynum+")";
//			return index+"";
//			return this.y+"";
		}

		public function get wnum():Number
		{
			return _wnum;
		}

		public function get hnum():Number
		{
			return _hnum;
		}

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
		}

		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}


	}
}