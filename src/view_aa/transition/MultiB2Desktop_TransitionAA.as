package view_aa.transition
{
	import d2armor.animate.ATween;
	import d2armor.animate.TweenMachine;
	import d2armor.display.NodeAA;
	import d2armor.display.TransitionAA;
	
	import view_aa.ViewConfig;
	import view_aa.desktop.Desktop_StateAA;
	import view_aa.desktop.MultiB_StateAA;

	public class MultiB2Desktop_TransitionAA extends TransitionAA
	{
		
		public var stateA:MultiB_StateAA;
		public var stateB:Desktop_StateAA;
		
		override public function onTransfer():void {
			var index_A:int;
			var i:int;
			var l:int;
			var node_A:NodeAA;
			
			this.stateA = this.getA() as MultiB_StateAA;
			this.stateB = this.getB() as Desktop_StateAA;
			
			
			this.stateB.m_fusion = this.stateA.m_fusion;
			this.stateB.m_touchA = this.stateA.m_touchA;
			this.stateB.desktopImg = this.stateA.desktopImg;
			
			
			index_A = this.stateA.m_viewList.indexOf(this.stateA.desktopImg);
			this.stateA.m_viewList.splice(index_A, 1);
			l = this.stateA.m_viewList.length-1;
			while(i<l){
				this.stateA.m_viewList[i].getFusion().kill();
				i++;
			}
			
			
		}
		
		override public function onAnimate():void {
			var tween_A:ATween;
			
			TweenMachine.getInstance().stopAll(false,true);
			
			this.stateA.getRoot().getWindow().getTouch().touchEnabled = false;
			
			TweenMachine.to(this.stateB.m_fusion, ViewConfig.DURA1, {x:0,y:0});
			tween_A = TweenMachine.to(this.stateB.desktopImg.getFusion(), ViewConfig.DURA1, {scaleX:1.0,scaleY:1.0,x:1080/2,y:1920/2});
			
			tween_A.onComplete = function() : void {
				stateA.m_bg.kill();
				stateA.getRoot().getWindow().getTouch().touchEnabled = true;
			}
			
			this.stateB.desktopImg.setToRaw();
		}
	}
}