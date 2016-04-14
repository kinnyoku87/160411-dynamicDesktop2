package launching {
	import flash.display.Stage;
	import flash.ui.Multitouch;
	
	import d2armor.Armor;
	import d2armor.activity.AWindow;
	import d2armor.display.AAFacade;
	import d2armor.display.IRootDelegate;
	import d2armor.display.RootAA;
	import d2armor.enum.ETouchMode;
	import d2armor.launch.DesktopPlatform;
	import d2armor.launch.ILauncher;
	import d2armor.launch.IPlatform;
	import d2armor.launch.MobilePlatform;
	import d2armor.resource.ResMachine;
	import d2armor.resource.converters.AtlasAssetConvert;
	import d2armor.utils.Stats;
	
	import view_aa.Entry_ViewAA;
	
public class Launcher_AA implements ILauncher, IRootDelegate {
	
	public function platform() : IPlatform {
		if(Multitouch.maxTouchPoints == 0){
			return new DesktopPlatform(false);
		}
		return new MobilePlatform(false);
	}
	
	public function onLaunch( stage:Stage ) : void {
		//stage.addChild(new Stats());
		
		ResMachine.activate(AtlasAssetConvert);
		
		m_winA = Armor.createWindow(stage, false);
		m_winA.getTouch().touchMode = ETouchMode.SINGLE;
		m_winA.getTouch().velocityEnabled = true;
		m_rootA = AAFacade.createRoot(m_winA, this);
	}
	
	public function onCreated( root:RootAA ) : void {
		m_rootA.addView(new Entry_ViewAA);
	}
	
	public function onReset( root:RootAA ) : void {
		
	}
	
	protected var m_winA:AWindow;
	protected var m_rootA:RootAA;
	
}
}