package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	
	import org.unify.Const;
	import org.unify.GameMap;
	import org.unify.Rectangle;
	
	/**
	 * ...2016-12-14
	 * @author vinson
	 */
	public class BasicGame extends Sprite
	{
		protected var gameMap:GameMap;
		protected var maps:Array=new Array;
		protected var size:Number=75;//每个小块大小
		protected var row:int=10;//行总个数
		protected var column:int=10;//列总个数
		protected var colorNum:int=10;
		protected var colors:Array=new Array;
		protected var result:Boolean;//结果
		protected var background:Rectangle;
		public function BasicGame()
		{
			super();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event=null):void
		{
			initData();
			initGame();
		}
		
		protected function initData():void
		{
			colors=Const.COLORS;
			size=Const.SIZE;
			row=Const.ROW;
			column=Const.COLUMN;
			colorNum=Const.COLOR_NUM;
			//colors.push(0XCCCCCC,0XFF000,0XFF60AF,0XB15BFF,0X7D7DFF,0X46A3FF,0X00FFFF,0X00BB00,0X9AFF02,0XFFFF37,0XFFBB77);
			//for(var i:int=1;i<=10;i++) colors.push(Math.random()*0XFFFFFF);
		}
		
		protected function initGame():void
		{
			
		}
		public function createBackground():void
		{
			background=new Rectangle;
			background.setRect(this.width,this.height,1,0X999999);
			this.addChildAt(background,0);
			
			var bgMap:GameMap=new GameMap;
			bgMap.setValue(size,row,column);
			bgMap.start(1,0XFFFFFF);
			background.addChild(bgMap);
		}
		/**创建地图*/
		protected function createMap():void
		{
			gameMap=new GameMap
			gameMap.setValue(size,row,column);
			gameMap.start();
			this.addChild(gameMap);
			maps=gameMap.maps;
		}
		/**创建关卡*/
		protected function createLevel():void
		{
			
		}
		
		/**给方块设置滤镜*/
		protected function setFilters(rect:Rectangle,boo:Boolean):void
		{
			rect.filters=null;
			if(boo){
				rect.filters=[new GlowFilter(0XFFFFFF,1,6,6,2,1,true)];
			}
		}
	}
}