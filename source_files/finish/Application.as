package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Application extends MovieClip
	{
		public function Application():void
		{
			stage.align = "TL"
			
			var connect4:Connect4 = new Connect4(7,6);
			connect4.x = (stage.stageWidth - connect4.width)/2;
			connect4.y = (stage.stageHeight - connect4.height)/2 + 50;
			this.addChild(connect4);
		}
	}
}