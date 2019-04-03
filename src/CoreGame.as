package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.coreLinkGame.LinkGame;
	import org.coreMstchingGame.MstchingGame;
	import org.corePopStarGame.PopStarGame;
	import org.unify.Circle;
	import org.unify.Stats;

	/**
	 * ...2016-12-13
	 * @author vinson
	 * 这个工程只是放经典游戏的核心算法
	 * 目前有连连看、对对碰、消灭星星
	 */
	[SWF(width='800',height='700',frameRate="30")]
	public class CoreGame extends Sprite
	{
		public function CoreGame()
		{
//			this.addChild(new LinkGame);//连连看
//			this.addChild(new MstchingGame);//对对碰
			this.addChild(new PopStarGame);//消灭星星
			
			var circle:Circle=new Circle();
			circle.setCircle(20,1,0XFFFF00);
			circle.x=circle.y=40;
			circle.xnum=circle.ynum=9;
			circle.resetCircle(5);
			circle.showSeat();
			this.addChild(circle);

			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event=null):void
		{
			var stats:Stats=new Stats();
			stats.x=this.stage.stageWidth-stats.width;
			this.addChild(stats);
		}
	}
}