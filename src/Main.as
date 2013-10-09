package{
	import flash.display.Sprite;
	
	[SWF(width="480",height="600", frameRate="30",backgroundColor="0x2D2D2D")]
	public class Main extends Sprite{
		
		public function Main()
		{
			var game:GameContextSprite = new GameContextSprite();
			addChild(game);
		}
	}
}