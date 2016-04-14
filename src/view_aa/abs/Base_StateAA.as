package view_aa.abs
{
	import d2armor.activity.Touch;
	import d2armor.display.FusionAA;
	import d2armor.display.ImageAA;
	import d2armor.display.NodeAA;
	import d2armor.display.Scale9ImageAA;
	import d2armor.display.StateAA;
	import d2armor.display.StateFusionAA;
	import d2armor.events.AEvent;
	import d2armor.gesture.GestureFacade;
	import d2armor.gesture.LongPressGestureRecognizer;
	import d2armor.gesture.SwipeGestureRecognizer;
	
	import model.DesktopManager;
	
	import view_aa.desktop.Desktop_CompAA;

	public class Base_StateAA extends StateAA
	{
	

		
		override public function onEnter():void{
			var stateFN:StateFusionAA;
			
			if(!m_fusion){
				m_fusion = new FusionAA;
				this.getFusion().addNode(m_fusion);
			}
			
			
			this.doInitHotspot();
		}
		
		
		
		
		protected const HOTSPOT_W:int = 85;
		
		
		
		public var m_fusion:FusionAA;
		public var m_touchA:Touch;
		
		
		
		public var m_hotspotA:NodeAA;
		public var m_hotspotB:NodeAA;
		
		
		
		
		protected function doInitHotspot() : void {
			
			m_hotspotA = this.toHotspot("A");
			this.getFusion().addNode(m_hotspotA);
			
			m_hotspotB = this.toHotspot("B");
			this.getFusion().addNode(m_hotspotB);
			m_hotspotB.x = this.getRoot().getWindow().rootWidth - HOTSPOT_W;
		}
		
		
		protected function toHotspot( userData:Object ) : NodeAA {
			var s9img_A:Scale9ImageAA;
			var reco_A:SwipeGestureRecognizer;
			var reco_B:LongPressGestureRecognizer;
			
			s9img_A = new Scale9ImageAA;
			s9img_A.textureId = "common/img/block.png";
			
			s9img_A.width = HOTSPOT_W;
			s9img_A.height = this.getRoot().getWindow().rootHeight ;
			s9img_A.alpha = 0.0;
			
			s9img_A.userData = userData;
			
			
			return s9img_A;
			
		}
		
	}
}