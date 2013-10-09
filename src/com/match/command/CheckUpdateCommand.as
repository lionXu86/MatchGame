package com.match.command{
	import com.match.model.MatchModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class CheckUpdateCommand extends Command{
		
		[Inject]
		public var matchModel:MatchModel;
		
		public function CheckUpdateCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			matchModel.updata();
		}
	}
}