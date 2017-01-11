package org.coreLinkGame
{
	import org.unify.Rectangle;

	/**
	 * ...2016-12-13
	 * @author vinson
	 * 有两个拐点
	 */
	public class CurveTwoSeach extends BasicSearch
	{
		private var search:ISearch
		private var startRect:Rectangle;
		private var endRect:Rectangle;
		public function CurveTwoSeach(_search:ISearch)
		{
			super(_search);
		}
		override public function goSeacher():void
		{
			search=new CurveOneSeach(null);
			search.maps=this.maps;
			/**情况1--|__*/
			startNum=this.startPoint.xnum+1;
			endNum=this.maps[0].length;
			map=new Array;
			for(var i:int=startNum;i<endNum;i++){
				map.push(this.maps[this.startPoint.ynum][i])
			}
			extract();
			/**情况2|--__*/
			if(result==false){
				map.length=0;
				startNum=this.startPoint.ynum+1;
				endNum=this.maps.length;
				for(i=startNum;i<endNum;i++){
					map.push(this.maps[i][this.startPoint.xnum])
				}
				extract();
			}
			/**情况3|--|*/
			if(result==false){
				map.length=0;
				startNum=this.startPoint.ynum-1;
				endNum=0;
				for(i=startNum;i>=endNum;i--){
					map.push(this.maps[i][this.startPoint.xnum])
				}
				extract();
			}
			/**情况4|__|*/
			if(result==false){
				map.length=0;
				startNum=this.startPoint.xnum-1;
				endNum=0;
				map=new Array;
				for(i=startNum;i>=endNum;i--){
					map.push(this.maps[this.startPoint.ynum][i])
				}
				extract();
			}
		}
		/**提取符合情况的块*/
		private function extract():void
		{
			paths.length=0;
			for(var i:int=0;i<map.length;i++){
				startRect=map[i];
				if(startRect.index==0){
					endRect=this.endPoint.clone;
					search.setTwoPoint(startRect,endRect);
					search.goSeacher();
					paths.push(startRect);
					if(search.result){
						paths=paths.concat(search.paths);
						result=search.result;
						break;
					}else{
						search.clearPath();
					}
				}else{
					break;
				}
			}
		}
	}
}