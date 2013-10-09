package com.match.view.match{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class MatchView extends Sprite implements IMatchView{
		
		public var assets:Assets;
		
		private var _layout:MatchLayout;
		
		public var exchangeCallBack:Function;
		
		public var checkCallBack:Function;
		
		public function MatchView()
		{
			
			assets = new Assets();
			
			_layout = new MatchLayout(this);
			addChild(_layout);
		}
		
		public function initShow(data:Array):void
		{
			_layout.layout(data);
		}
		
		public function cellExchange(data:Array):void
		{
			_layout.exchange(new Point(data[0], data[1]), new Point(data[2], data[3]));
		}
		
		public function remove(data1:Array, data2:Array):void
		{
			_layout.remove(data1, data2);
		}
		
	}
}