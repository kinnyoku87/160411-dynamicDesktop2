package {
	import flash.display.Sprite;
	
	import d2armor.Armor;
	import d2armor.logging.DebugLogger;
	import d2armor.logging.FlashTextLogger;
	import d2armor.logging.Logger;
	
	import launching.Launcher_AA;
	
	[SWF(width = "450", height = "800", backgroundColor = "0x0", frameRate = "60")]
public class Main extends Sprite {
	
	public function Main() {
		var logger:Logger;
		
		logger = new DebugLogger;
		//logger = new FlashTextLogger(stage, false, 200, 350, 350, true);
		Armor.startup(1080, 1920, stage, Launcher_AA, logger);
	}
}
}