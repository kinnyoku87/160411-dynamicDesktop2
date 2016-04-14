package view_aa.res {
	import d2armor.Armor;
	import d2armor.display.ImageAA;
	import d2armor.display.StateAA;
	import d2armor.events.AEvent;
	import d2armor.resource.FilesBundle;
	import d2armor.resource.ResMachine;
	import d2armor.resource.ZipBundle;
	import d2armor.resource.handlers.TextureAA_BundleHandler;
	
public class Res_StateAA extends StateAA {
	
	public function Res_StateAA( nextState:StateAA ) {
		m_nextState = nextState;
	}
	
	override public function onEnter() : void {
		this.resA = new ResMachine("");
		
		//this.resA.addBundle(new ZipBundle("img.zip"), new TextureAA_BundleHandler(1.0, false, false, "image"));
		
		var AY:Vector.<String>;
		
		AY = new <String>
			[
//				"common/img/0.png",
				
				"common/img/blur1.png",
				"common/img/blur2.png",
				"common/img/blur3.png",
				"common/img/blur4.png",
				//"common/img/blur5.png",
				"common/img/blur6.png",
				"common/img/blur7.png",
				"common/img/blur8.png",
//				"common/img/blur9.png",
//				"common/img/blur10.png",
				
				"common/img/raw1.png",
				"common/img/raw2.png",
				"common/img/raw3.png",
				"common/img/raw4.png",
				///"common/img/raw5.png",
				"common/img/raw6.png",
				"common/img/raw7.png",
				"common/img/raw8.png",
//				"common/img/raw9.png",
//				"common/img/raw10.png",
				
				"common/img/arrow_up.png",
				"common/img/arrow_down.png",
				"common/img/email-icon.png",
				"common/img/music-icon.png",
				
				"common/img/BG.png",
				"common/img/block.png"
				
			];
		
		this.resA.addBundle(new FilesBundle(AY), new TextureAA_BundleHandler);
		
//		AY = new <String>
//			[
//				"common/img/block.png"
//			];
//		this.resA.addBundle(new FilesBundle(AY), new TextureAA_BundleHandler(0.35));
		
		this.resA.addEventListener(AEvent.COMPLETE, onComplete);
	}
	
	public var resA:ResMachine;
	private var m_nextState:StateAA;
	
	private function onComplete(e:AEvent):void {
		this.resA.removeEventListener(AEvent.COMPLETE, onComplete);
		
		this.getFusion().setState(m_nextState);
		
	}
}
}