package com.match.view.match{
	import com.match.signal.CellExchangeSignal;
	import com.match.signal.CheckUpdateSignal;
	import com.match.signal.ExchangeCellSignal;
	import com.match.signal.MatchInitShowSignal;
	import com.match.signal.RemoveSignal;
	import com.match.signal.StartupSignal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class MatchMediator extends Mediator{
		
		[Inject]
		public var startupSignal:StartupSignal;
		
		[Inject]
		public var view:MatchView;
		
		[Inject]
		public var matchInitShowSignal:MatchInitShowSignal;
		
		[Inject]
		public var cellExchangeSignal:CellExchangeSignal;
		
		[Inject]
		public var exchangeCellSignal:ExchangeCellSignal;
		
		[Inject]
		public var removeSignal:RemoveSignal;
		
		[Inject]
		public var checkSignal:CheckUpdateSignal;
		
		public function MatchMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			trace("");
			matchInitShowSignal.add(initShow);
			cellExchangeSignal.add(cellExchange);
			removeSignal.add(remove);
			
			view.exchangeCallBack = exchangeCell;
			view.checkCallBack = check;
			
			startupSignal.dispatch();
			
		}
		
		private function initShow(data:Array):void
		{
			view.initShow(data);
		}
		
		private function cellExchange(data:Array):void
		{
			view.cellExchange(data);
		}
		
		private function remove(data1:Array, data2:Array):void
		{
			view.remove(data1, data2);
		}
		
		private function exchangeCell(data:Array):void
		{
			exchangeCellSignal.dispatch(data);
		}
		
		private function check():void
		{
			checkSignal.dispatch();
		}
		
		override public function destroy():void
		{
			
		}
	}
}