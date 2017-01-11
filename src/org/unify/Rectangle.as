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
		
		public function Rectangle()
		{
			super();
			
		}
		public function resetRect(i:int):void
		{
			clear();
			setRect(wnum,hnum,i,color);
		}
		public function setRect(w:Number,h:Number,i:int,c:uint):void
		{
			_wnum=w;
			_hnum=h;
			_color=c;
			this.graphics.lineStyle(1);//带黑四边
			this.graphics.beginFill(_color);
			this.graphics.drawRect(0,0,w,h);
			var txt:TextField=new TextField;
			txt.text=String(i);
			txt.autoSize="left";
			txt.x=(w-txt.width)>>1;
			txt.y=(h-txt.height)>>1;
			txt.selectable=false;
			txt.filters=[glowFilter];
			this.addChild(txt);
			index=i;
			//setAlpha();
		}
		
		private function setAlpha():void
		{
			if(index==0) this.alpha=0;
			else		 this.alpha=1;
		}
		public function showSeat():void
		{
			var txtName:String="showSeat"
			if(this.getChildByName(txtName)){
				this.removeChild(this.getChildByName(txtName));
			}
			var txt:TextField=new TextField;
			txt.name=txtName
			txt.text=String("("+xnum+","+ynum+")");
			txt.autoSize="left";
			txt.selectable=false;
			txt.y=this.height-txt.height;
			txt.x=this.width-txt.width;
			txt.filters=[glowFilter]
			this.addChild(txt);
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