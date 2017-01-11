package org.coreLinkGame
{
	import org.unify.Rectangle;

	/**
	 * ...2016-12-13
	 * @author vinson
	 * 有一个拐点
	 */
	public class CurveOneSeach extends BasicSearch
	{
		private var search:ISearch
		private var startRect:Rectangle;
		private var endRect:Rectangle;
		public function CurveOneSeach(_search:ISearch)
		{
			super(_search);
		}
		override public function goSeacher():void
		{
			//设置开头与结尾
			startRect=startPoint.clone;
			endRect=maps[startPoint.ynum][endPoint.xnum];
			//以真线搜索
			search=new CurveZeroSeach(null);
			search.maps=this.maps;
			//如果拐点（这个拐点是结束点）是空的才可以进行搜索
			if(endRect.index==0){
				seacherStart();
			}
			//第一种拐弯没有找到，开始找第二种拐弯
			if(search.result==false){
				//清空上次的残余数据
				clearPath();
				//设置开头与结尾
				startRect=startPoint.clone;
				endRect=maps[endPoint.ynum][startPoint.xnum];
				//如果拐点（这个拐点是结束点）是空的才可以进行搜索
				if(endRect.index==0){
					seacherStart();
				}
			}
			//最后结果公布
			paths=paths.concat(search.paths);
			result=search.result;
		}
		/**开始搜索*/
		private function seacherStart():void
		{
			//第一遍搜索
			seacherFirst();
			if(search.result){
				//如果第一遍搜索的路径是对的则保存下
				paths=paths.concat(search.paths);
				paths.push(endRect);
				//重新设置开头与结尾
				startRect=endRect.clone;
				endRect=endPoint.clone;	
				//第二遍搜索
				seacherSecond();
			}
		}
		/**第一遍搜索*/
		private function seacherFirst():void
		{
			search.setTwoPoint(startRect,endRect);
			search.start();
		}
		/**第二遍搜索*/
		private function seacherSecond():void
		{
			search.setTwoPoint(startRect,endRect);
			search.goSeacher();
		}
	}
}