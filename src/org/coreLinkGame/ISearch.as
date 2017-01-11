package org.coreLinkGame
{
	/**
	 * ...2016-12-13
	 * @author vinson
	 * 接口
	 */
	public interface ISearch
	{
		function set maps(value:Array):void;
		function get maps():Array;
		function set result(value:Boolean):void;
		function get result():Boolean;
		function set paths(value:Array):void;
		function get paths():Array;
		function get completePaths():Array;
		function clearPath():void;
		function setTwoPoint(startPoint:Object,endPoint:Object):void
		function start():void;
		function goSeacher():void;
	}
}