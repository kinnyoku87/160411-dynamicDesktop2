package view_aa.transition
{
	import d2armor.activity.Touch;
	import d2armor.animate.ATween;
	import d2armor.animate.TweenMachine;
	import d2armor.animate.easing.Cubic;
	import d2armor.animate.easing.Quad;
	import d2armor.display.TransitionAA;
	
	import model.DesktopManager;
	
	import view_aa.ViewConfig;
	import view_aa.desktop.Desktop_CompAA;
	import view_aa.desktop.Desktop_StateAA;
	import view_aa.desktop.PageSelect_StateAA;

	public class Page2Desktop_TransitionAA extends TransitionAA
	{
		
		public var stateA:PageSelect_StateAA;
		public var stateB:Desktop_StateAA;
		
		
		public var m_touchA:Touch;
		
		
		override public function onTransfer() : void
		{
			
			this.stateA = this.getA() as PageSelect_StateAA;
			this.stateB = this.getB() as Desktop_StateAA;
			
			
			this.stateB.m_fusion = this.stateA.m_fusion;
			this.stateB.m_touchA = m_touchA = this.stateA.m_touchA;
			
			if(this.stateA.isGotoNext) {
				if(m_touchA.velocityY < -80 || this.stateA.desktopImg.getFusion().y < 0) {
					DesktopManager.index++;
					m_desktopKilled = this.stateA.desktopImg;
					this.stateB.desktopImg = this.stateA.desktopImg2;
					m_flags = 1;
				}
				else {
					m_desktopKilled = this.stateA.desktopImg2;
					this.stateB.desktopImg = this.stateA.desktopImg;
					m_flags = 0;
				}
			}
			else {
				if(m_touchA.velocityY > 80 || this.stateA.desktopImg.getFusion().y > 1920) {
					DesktopManager.index--;
					m_desktopKilled = this.stateA.desktopImg;
					this.stateB.desktopImg = this.stateA.desktopImg2;
					m_flags = -1;
				}
				else {
					m_desktopKilled = this.stateA.desktopImg2;
					this.stateB.desktopImg = this.stateA.desktopImg;
					m_flags = 0;
				}
			}
			
			//trace(m_flags);
		}
		
		override public function onAnimate():void {
			var tween_A:ATween;
			
			this.stateA.getRoot().getWindow().getTouch().touchEnabled = false;
			if(m_flags == -1) {
				tween_A = TweenMachine.to(this.m_desktopKilled.getFusion(), ViewConfig.DURA3, {y:1920 + 1920/2, alpha:0.03});
			}
			else if(m_flags == 1) {
				tween_A = TweenMachine.to(this.m_desktopKilled.getFusion(), ViewConfig.DURA3, {y:0 - 1920/2, alpha:0.03});
			}
			else if(m_flags == 0) {
				tween_A = TweenMachine.to(this.stateB.desktopImg.getFusion(), ViewConfig.DURA3, {y:1920/2, alpha:1.0});
			}
			tween_A.onComplete = function() : void {
				
				m_desktopKilled.getFusion().kill();
				stateA.m_tipFN.kill();
				
				stateA.getRoot().getWindow().getTouch().touchEnabled = true;
			}
			tween_A.easing = Cubic.easeOut;
			
			tween_A = TweenMachine.to(stateA.m_tipFN, ViewConfig.DURA0, {alpha:0});
		}
		
		
		// prev -1
		// next 1
		// revert 0
		private var m_flags:int;
		private var m_desktopKilled:Desktop_CompAA;
		
		
		private function doPrev() : void {
			
		}
		
		private function doNext() : void {
			
		}
		
		private function doRevert() : void {
			
		}
	}
}