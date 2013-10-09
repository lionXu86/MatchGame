package com.match.command{
	import com.match.model.MatchModel;
	
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ExchangeCellCommand extends Command{
		
		[Inject]
		public var data:Array;
		
		[Inject]
		public var matchModel:MatchModel;
		
		override public function execute():void
		{
			matchModel.exchange(data[0], data[1],data[2], data[3]);
		}
		
	}
}