package org.coreLinkGame
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import org.coreLinkGame.CurveOneSeach;
	import org.coreLinkGame.CurveTwoSeach;
	import org.coreLinkGame.CurveZeroSeach;
	import org.coreLinkGame.ISearch;
	import org.unify.GameMap;
	import org.unify.Rectangle;
	import org.unify.ShowTime;

	/**
	 * ...2016-12-13
	 * @author vinson
	 * 连连看的核心算法
	 * 本程序只是用来测试核心算法，所以不是完成游戏，因此关卡和画线部分都没有分离出来。
	 * 想要制作完成连连看的同学需要重新将关卡和画线部分离出来，然后在自行优化。
	 * 方块的图案也请自行处理，本程序只是简单填充色块而已
	 * 算法的核心是化繁为简把2个拐点转为1个拐点处理，把1个拐点转为没有拐点处理。
	 */
	public class LinkGame extends BasicGame
	{
		
		private var checkRects:Vector.<Rectangle>=new Vector.<Rectangle>;
		private var zero:ISearch//没有拐点
		private var one:ISearch//一个拐点
		private var two:ISearch;//两个拐点
		private var search:ISearch;
		private var completePaths:Array=new Array;
		private var point:Sprite;
		public function LinkGame()
		{			
			super();
		}
		override protected function initGame():void
		{
			createMap();
			createLevel();
			createSearch();
			this.addEventListener(Event.ENTER_FRAME,onLoop);
			
			point=new Sprite;
			point.graphics.beginFill(0);
			point.graphics.drawCircle(0,0,10);
			this.addChild(point);
				
			
		}
		
		/**创建关卡*/
		override protected function createLevel():void
		{
			var levels:Array=new Array;
			for(var i:int=1;i<row-1;i++){
				for(var j:int=1;j<column-1;j++){
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
					rect.buttonMode=true;
					rect.addEventListener(MouseEvent.CLICK,onClick);
					levels.splice(levelIndex,1);
					if(i>0) i--;
				}
			}
		}
		/**创建装饰者模式的搜索方向*/
		private function createSearch():void
		{
			zero=new CurveZeroSeach(null);//没有拐点层
			one=new CurveOneSeach(zero);//一个拐点层
			two=new CurveTwoSeach(one);//两个拐点层
			search=two;//测试那一层就给那一层
			search.maps=this.maps;
		}
		/**点击后处理*/
		private function onClick(e:MouseEvent):void
		{
			var rect:Rectangle=e.currentTarget as Rectangle;
			if(checkRects.length<2){
				setFilters(rect,true);
				checkRects.push(rect);
				if(checkRects.length==2){
					result=false;
					ShowTime.getIns().start();
					if(checkRects[0].index==checkRects[1].index){
						search.clearPath();
						search.setTwoPoint(checkRects[0],checkRects[1]);
						search.start();
						if(zero.result){
							completePaths=zero.completePaths;
							result=zero.result;
							trace("0个转弯路径")
						}else if(one.result){
							completePaths=one.completePaths
							result=one.result;
							trace("1个转弯路径")
						}else if(two.result){
							completePaths=two.completePaths
							result=two.result;
							trace("2个转弯路径")
						}else{
							trace("未找到路径");
						}
					}
					ShowTime.getIns().show("搜索");
					if(result){
						drawLine();
					}else{
						restore();
					}
					trace(result,completePaths);
				}
			}
		}
		/**画线*/
		private function drawLine():void
		{
			line=new Sprite;
			gameMap.addChild(line);
			lineIndex=0;
			ww=checkRects[lineIndex].width/2;
			lx=checkRects[lineIndex].x+ww;
			ly=checkRects[lineIndex].y+ww;
			line.graphics.lineStyle(8,0XFF0000);
			line.graphics.moveTo(lx,ly);
		}
		private var lineIndex:int=0;
		private var line:Sprite;
		private var lx:Number;
		private var ly:Number;
		private var ww:Number;
		/**循环画线*/
		protected function onLoop(event:Event):void
		{
			maps=completePaths;
			if(lineIndex<maps.length-1){
				//line.graphics.lineStyle(8,Math.random()*0XFFFFFF);
				var prevPoint:Point=new Point(maps[lineIndex].x,maps[lineIndex].y);
				var nextPoint:Point=new Point(maps[lineIndex+1].x,maps[lineIndex+1].y);
				var dx:Number=nextPoint.x-prevPoint.x;
				var dy:Number=nextPoint.y-prevPoint.y;
				var speed:Number=5;
				lx+=dx/speed;
				ly+=dy/speed;
				//point.x=lx;//跟踪路径
				//point.y=ly;
				
				dx=nextPoint.x+ww-lx;
				dy=nextPoint.y+ww-ly;
				var dis:Number=Math.sqrt((dx*dx)+(dy*dy));
				//trace(dis)
				if(speed>=dis){
					//trace("--------")
					lineIndex++;
					lx=maps[lineIndex].x+ww;
					ly=maps[lineIndex].y+ww;
					line.graphics.lineTo(lx,ly);
					if(lineIndex==maps.length-1){
						clear();
					}
				}else{
					line.graphics.lineTo(lx,ly);
				}
			}
		}
		/**清理*/
		private function clear():void
		{
			if(line){
				gameMap.removeChild(line);
				line=null;
			}
			for(var i:int=0;i<checkRects.length;i++){
				var rect:Rectangle=checkRects[i];
				rect.buttonMode=false;
				rect.removeEventListener(MouseEvent.CLICK,onClick);
				rect.color=colors[0];
				rect.resetRect(0);
				rect.showSeat();
			}
			restore();
		}
		/**恢复原样*/
		private function restore():void
		{
			for(var i:int=0;i<checkRects.length;i++){
				var rect:Rectangle=checkRects[i];
				setFilters(rect,false);
			}
			checkRects.length=0;
		}
		
	}
}