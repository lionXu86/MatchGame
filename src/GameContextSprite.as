package{
	import flash.display.Sprite;
	
	import robotlegs.bender.bundles.SignalCommandMapBundle;
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.impl.Context;
	
	public class GameContextSprite extends Sprite{
		
		private var _context:Context;
		
		
		
		public function GameContextSprite()
		{
			init();
		}
		
		private function init():void
		{
			_context = new Context();
			_context.install(MVCSBundle, SignalCommandMapBundle);
			_context.configure(AppConfig, new ContextView(this));
			
			addChild(Layer.getInstance());
		}
	}
}