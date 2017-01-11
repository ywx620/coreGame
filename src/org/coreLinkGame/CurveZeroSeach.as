package org.coreLinkGame
{
	/**
	 * ...2016-12-13
	 * @author vinson
	 * 有零个拐点
	 */
	public class CurveZeroSeach extends BasicSearch
	{
		public function CurveZeroSeach(_search:ISearch)
		{
			super(_search);
		}
		override public function goSeacher():void
		{
			//trace("sx="+this.startPoint.xnum+","+"sy="+this.startPoint.ynum+","+"ex="+this.endPoint.xnum+","+"ey="+this.endPoint.ynum)
			map=new Array;
			var isReverse:Boolean=false;//是否要反转路径中的数组
			if(this.startPoint.xnum==this.endPoint.xnum){//X轴相等
				//trace("X轴相同");
				if(this.endPoint.ynum>this.startPoint.ynum){
					startNum=this.startPoint.ynum+1;
					endNum=this.endPoint.ynum-1;
				}else{
					startNum=this.endPoint.ynum+1;
					endNum=this.startPoint.ynum-1;
					isReverse=true;
				}
				for(var i:int=0;i<maps.length;i++){
					map.push(this.maps[i][this.startPoint.xnum]);
				}
				result=seacherResult(map);
				
			}else if(this.startPoint.ynum==this.endPoint.ynum){//Y轴相等
				//trace("Y轴相同")
				if(this.endPoint.xnum>this.startPoint.xnum){
					startNum=this.startPoint.xnum+1;
					endNum=this.endPoint.xnum-1;
				}else{
					startNum=this.endPoint.xnum+1;
					endNum=this.startPoint.xnum-1;
					isReverse=true;
				}
				map=this.maps[this.startPoint.ynum];
				result=seacherResult(map);
			}
			if(isReverse){
				_paths.reverse();
			}
		}
	}
}