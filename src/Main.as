package{
	import flash.display.Sprite;
	
	[SWF(width="640",height="400", frameRate="30",backgroundColor="0x2D2D2D")]
	public class Main extends Sprite{
		
		public function Main()
		{
			var game:Game = new Game();
			addChild(game);
		}
	}
}