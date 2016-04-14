package view_aa.transition
{
	import d2armor.display.TransitionAA;
	
	import view_aa.desktop.Desktop_StateAA;
	import view_aa.desktop.MultiB_StateAA;

	public class Desktop2MultiB_TransitionAA extends TransitionAA
	{

		public var stateA:Desktop_StateAA;
		public var stateB:MultiB_StateAA;
		
		
		override public function onTransfer():void {
			this.stateA = this.getA() as Desktop_StateAA;
			this.stateB = this.getB() as MultiB_StateAA;
			
			
			this.stateB.m_fusion = this.stateA.m_fusion;
			this.stateB.m_touchA = this.stateA.m_touchA;
			this.stateB.desktopImg = this.stateA.desktopImg;
			this.stateB.m_viewList = this.stateA.m_viewList;
			this.stateB.m_numItems = this.stateA.m_numItems;
			//this.stateB.m_tipFN = this.stateA.m_tipFN;
			
			this.stateA.m_hotspotA.kill();
			this.stateA.m_hotspotB.kill();
			//this.stateA.desk.kill();
			
			//TweenMachine.getInstance().stopAll();
		}
		
		
		override public function onAnimate():void {
			this.stateA.desktopImg.setToBlur();
		}
	}
}