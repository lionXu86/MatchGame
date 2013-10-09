package{
	import com.match.command.CheckUpdateCommand;
	import com.match.command.ExchangeCellCommand;
	import com.match.command.PrepareCommand;
	import com.match.command.StartupCommand;
	import com.match.model.MatchModel;
	import com.match.signal.CellExchangeSignal;
	import com.match.signal.CheckUpdateSignal;
	import com.match.signal.ExchangeCellSignal;
	import com.match.signal.MatchInitShowSignal;
	import com.match.signal.PrepareSignal;
	import com.match.signal.RemoveSignal;
	import com.match.signal.StartupSignal;
	import com.match.view.ui.IMatchView;
	import com.match.view.mediator.MatchMediator;
	
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.bender.framework.api.LogLevel;

	public class AppConfig implements IConfig{
		
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var commandMap:ISignalCommandMap;
		
		[Inject]
		public var midatorMap:IMediatorMap;
		
		public function AppConfig()
		{
		}
		
		public function configure():void
		{
			context.logLevel = LogLevel.FATAL;
			
			confiureSignal();
			configureModel();
			configureMediator();
			configureCommand();
			configureSingleton();
			
			(context.injector.getInstance(PrepareSignal) as Signal).dispatch();
		}
		
		private function confiureSignal():void
		{
			injector.map(MatchInitShowSignal).asSingleton();
			injector.map(CellExchangeSignal).asSingleton();
			injector.map(RemoveSignal).asSingleton();
		}
		
		private function configureModel():void
		{
			injector.map(MatchModel).asSingleton();
		}
		
		private function configureMediator():void
		{
			midatorMap.map(IMatchView).toMediator(MatchMediator);
		}
		
		private function configureCommand():void
		{
			commandMap.map(StartupSignal).toCommand(StartupCommand);
			commandMap.map(PrepareSignal).toCommand(PrepareCommand);
			commandMap.map(ExchangeCellSignal).toCommand(ExchangeCellCommand);
			commandMap.map(CheckUpdateSignal).toCommand(CheckUpdateCommand);
		}
		
		private function configureSingleton():void
		{
			injector.map(Layer).asSingleton();
		}
	}
}