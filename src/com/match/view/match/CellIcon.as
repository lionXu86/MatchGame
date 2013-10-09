package com.match.view.match{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class CellIcon extends Sprite{
		
		private var _icon:Bitmap;
		
		public function CellIcon(bmd:BitmapData)
		{
			_icon = new Bitmap(bmd);
			addChild(_icon);
		}
		
		public function remove():void
		{
			if(this.parent)
				this.parent.removeChild(this);
		}
	}
}