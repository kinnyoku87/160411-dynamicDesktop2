package view_aa.desktop
{
	import d2armor.activity.Touch;
	import d2armor.display.FusionAA;
	import d2armor.display.StateAA;
	import d2armor.display.StateFusionAA;
	import d2armor.events.AEvent;
	
	import model.DesktopManager;
	import model.DesktopVo;

	public class PageSelect_StateAA extends StateAA
	{
		public function PageSelect_StateAA( isGotoNext:Boolean, vo:DesktopVo ) {
			this.isGotoNext = isGotoNext;
			this.m_vo = vo;
		}
		
		override public function onEnter():void{
			var stateFN:StateFusionAA;
			
			stateFN = new StateFusionAA;
			stateFN.setState(new Desktop_CompAA(m_vo, false));
			this.desktopImg2 = stateFN.getState() as Desktop_CompAA;
			stateFN.x = 1080/ 2;
			stateFN.y = 1920/2
			m_fusion.addNodeAt(stateFN, 0);
			
			m_touchA.addEventListener(AEvent.CHANGE, onTouchChanged);
			m_touchA.addEventListener(AEvent.COMPLETE, onTouchCompleted);
		}
		
		
		public var desktopImg:Desktop_CompAA;
		public var m_fusion:FusionAA;
		public var m_touchA:Touch;
		public var m_tipFN:FusionAA;
		
		
		public var desktopImg2:Desktop_CompAA;
		public var isGotoNext:Boolean;
		public var m_vo:DesktopVo;
		
		
		
		private function onTouchChanged(e:AEvent):void{
			this.desktopImg.getFusion().y += m_touchA.rootY - m_touchA.prevRootY;
			if(this.isGotoNext) {
				if(this.desktopImg.getFusion().y > 1920 / 2) {
					this.desktopImg.getFusion().y = 1920 / 2;
				}
			}
			else {
				if(this.desktopImg.getFusion().y < 1920 / 2) {
					this.desktopImg.getFusion().y = 1920 / 2;
				}
			}
			if(this.isGotoNext) {
				this.desktopImg.getFusion().alpha = (1920 + (this.desktopImg.getFusion().y - 1920 / 2)) / 1920
			}
			else {
				this.desktopImg.getFusion().alpha = (1920 - (this.desktopImg.getFusion().y - 1920 / 2)) / 1920
			}
		}
		
		private function onTouchCompleted(e:AEvent):void{
			
			this.getFusion().setState(new Desktop_StateAA);
			
		}
										 
		
	}
}