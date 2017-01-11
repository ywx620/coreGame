package org.coreLinkGame
{
	import org.unify.Rectangle;
	/**
	 * ...2016-12-13
	 * @author vinson
	 * 基类(抽像类直接实例化后用来搜索会报错)
	 */
	public class BasicSearch implements ISearch
	{
		private var _maps:Array;
		private var _result:Boolean;
		protected var _search:ISearch
		protected var _paths:Array;
		protected var startPoint:Rectangle;
		protected var endPoint:Rectangle;
		protected var startNum:int;
		protected var endNum:int;
		protected var map:Array;
		public function BasicSearch(_search:ISearch)
		{
			this._search=_search;
			_paths=new Array();
		}
		
		public function setTwoPoint(startPoint:Object,endPoint:Object):void
		{
			this.startPoint=startPoint as Rectangle;
			this.endPoint=endPoint as Rectangle;
		}
		public function start():void
		{
			result=false;
			if(_search){
				_search.maps=this.maps;
				_search.setTwoPoint(this.startPoint,this.endPoint);
				_search.start();
				result=_search.result;
			}
			if(result==false){
				goSeacher();
			}
		}
		public function clearPath():void
		{
			if(_search){
				_search.clearPath();
			}
			_paths.length=0;
		}
		public function goSeacher():void
		{
			throw(new Error("不能使用抽像类 BasicSearch"));
		}
		protected function seacherResult(map:Array):Boolean
		{
			var temps:Array=new Array;
			var boo:Boolean;
			for(var i:int=startNum;i<=endNum;i++){
				if(map[i].index==0) temps.push(map[i]);
			}
			if(temps.length==((endNum-startNum)+1)){
				//_paths=_paths.concat(temps);
				_paths=temps;
				boo=true;
			}
			return boo;
		}
		public function get result():Boolean
		{
			return _result;
		}
		
		public function set result(value:Boolean):void
		{
			_result = value;
		}

		public function get maps():Array
		{
			return _maps;
		}

		public function set maps(value:Array):void
		{
			_maps = value;
		}
		
		public function set paths(value:Array):void
		{
			_paths = value;
		}
		
		public function get paths():Array
		{
			return _paths;
		}
		public function get completePaths():Array
		{
			_paths.unshift(startPoint);
			_paths.push(endPoint);
			return _paths;
		}
		
	}
}