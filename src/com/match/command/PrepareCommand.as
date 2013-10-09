package com.match.command{
	import com.match.view.ui.MatchView;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class PrepareCommand extends Command{
		public function PrepareCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			trace("游戏初始化");
			var matchView:MatchView = new MatchView();
			Layer.getInstance().gameLayer.addChild(matchView);
		}
	}
}