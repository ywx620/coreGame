package org.unify
{
	/**
	 * ...2016-12-15
	 * @author vinson
	 */
	public class ShowTime
	{
		private static var instance:ShowTime;
		private var date:Date;
		private var timePrev:Number;
		private var timeNext:Number;
		public static function getIns():ShowTime
		{
			if(instance==null) instance=new ShowTime;
			return instance;
		}
		public function start():void
		{
			date=new Date;
			timePrev=date.getTime();
		}
		public function show(str:String=""):void
		{
			date=new Date;
			timeNext=date.getTime();
			var time:Number=timeNext-timePrev;
			trace(str+"使用"+time+"毫秒")
		}
	}
}