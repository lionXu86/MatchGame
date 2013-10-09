package{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IConfig;

	public class Layer extends Sprite{
		
		private var _root:DisplayObjectContainer;
		
		public var topLayer:Sprite;
		
		public var uiLayer:Sprite;
		
		public var gameLayer:Sprite;
		
		public var bgLayer:Sprite;
		
		private static var _instance:Layer;
		
		public function Layer()
		{
			if(_instance)
			{
				_instance = this;
				return;
			}
			build();
		}
		
		public static function  getInstance():Layer
		{
			if(!_instance)
				_instance = new Layer();
			return _instance;
		}
		
		public function build():void
		{
			bgLayer = new Sprite();
			this.addChild(bgLayer);
			gameLayer = new Sprite();
			this.addChild(gameLayer);
			uiLayer = new Sprite();
			this.addChild(uiLayer);
			topLayer = new Sprite();
			this.addChild(topLayer);
		}
		
		
	}
}