package com.match.command{
	
	import com.match.model.MatchModel;
	
	import robotlegs.bender.extensions.contextView.ContextView;

	public class StartupCommand{
		
		[Inject]
		public var matchModel:MatchModel;
		
		public function StartupCommand()
		{
		}
		
		public function execute():void
		{
			matchModel.initData();
		}
	}
}