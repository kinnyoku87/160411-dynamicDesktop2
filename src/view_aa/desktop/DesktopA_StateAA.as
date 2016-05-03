package view_aa.desktop
{
	import d2armor.activity.Touch;
	import d2armor.animate.ATween;
	import d2armor.animate.TweenMachine;
	import d2armor.animate.easing.Quad;
	import d2armor.display.FusionAA;
	import d2armor.display.ImageAA;
	import d2armor.display.NodeAA;
	import d2armor.display.Scale9ImageAA;
	import d2armor.display.StateAA;
	import d2armor.display.StateFusionAA;
	import d2armor.enum.EDirection;
	import d2armor.events.AEvent;
	import d2armor.events.NTouchEvent;
	import d2armor.gesture.GestureFacade;
	import d2armor.gesture.LongPressGestureRecognizer;
	import d2armor.gesture.SwipeGestureRecognizer;
	import d2armor.utils.AMath;
	
	import model.DesktopManager;
	import model.DesktopVo;
	
	import view_aa.Entry_ViewAA;
	import view_aa.ViewConfig;
	import view_aa.abs.Base_StateAA;
	
public class DesktopA_StateAA extends Base_StateAA {
	
	override public function onEnter():void{
		var stateFN:StateFusionAA;
		
		super.onEnter();

		
		
		if(!desktopImg){
			stateFN = new StateFusionAA;
			stateFN.setState(new Desktop_CompAA(DesktopManager.getDesktopVo(), false));
			desktopImg = stateFN.getState() as Desktop_CompAA;
			stateFN.x = 1080/ 2;
			stateFN.y = 1920/2
			m_fusion.addNode(stateFN);
		}
		
		
//		desk = new ImageAA;
//		desk.textureId = "common/img/desk.png";
//		this.getFusion().addNode(desk);
//		desk.touchable = false;
		
		
		m_hotspotA.addEventListener(NTouchEvent.PRESS, onShowTips);
		m_hotspotB.addEventListener(NTouchEvent.PRESS, onShowTips);
	}
	
	override public function onExit():void {
		//this.getFusion().removeEventListener(NTouchEvent.PRESS, onShowTips);
	}
	
	
	
	private const X_GAP:Number = 100;
	private const Y_GAP:Number = 100;
	private const Y_GAP2:Number = 255;
	
	public var desktopImg:Desktop_CompAA;
	public var m_tipFN:FusionAA;
//	public var desk:ImageAA;
	
	
	public var m_viewList:Vector.<Desktop_CompAA>;
	public var m_numItems:int;
	
	
	
	public var m_tipA:FusionAA;
	public var m_tipB:FusionAA;
	public var m_tipC:FusionAA;
	public var m_flagsTip:int; // 1gotoNext,2gotoPrev,3switch
	public var m_finished:Boolean;
	
	
	override protected function toHotspot( userData:Object ) : NodeAA {
		var s9img_A:Scale9ImageAA;
		var reco_A:SwipeGestureRecognizer;
		var reco_B:LongPressGestureRecognizer;
		
		s9img_A = super.toHotspot(userData) as Scale9ImageAA;

		reco_A = GestureFacade.recognize(s9img_A, SwipeGestureRecognizer) as SwipeGestureRecognizer;
		reco_A.addEventListener(AEvent.COMPLETE, onSwipe);
		SwipeGestureRecognizer.setDistance(15);
		SwipeGestureRecognizer.setTimeout(5);
		
//		reco_B = GestureFacade.recognize(s9img_A, LongPressGestureRecognizer) as  LongPressGestureRecognizer;
//		reco_B.addEventListener(AEvent.COMPLETE, onLongPress);
//		reco_B.setDelay(1);
		
		return s9img_A;
		
	}
	
	protected function onSwipe(e:AEvent):void {
		var node_A:NodeAA;
		var reco_A:SwipeGestureRecognizer;
		
		reco_A = e.target as SwipeGestureRecognizer;
		node_A = reco_A.getNode() as NodeAA;
		
		m_touchA = reco_A.getTouchList()[0];
		
		// 左右进入multi desktop
		if(reco_A.getDirection() == EDirection.RIGHT){
			if(node_A.userData == "A"){
				this.doGotoMultiSwitchDesktop();
			}
		}
		else if(reco_A.getDirection() == EDirection.LEFT){
			if(node_A.userData == "B"){
				this.doGotoMultiSwitchDesktop();
			}
		}
		// 上下直接进入新desktop
//		else if(reco_A.getDirection() == EDirection.UP){
//			this.doGotoNewDesktop(true);
//		}
//		else if(reco_A.getDirection() == EDirection.DOWN){
//			this.doGotoNewDesktop(false);
//		}
	}
	
	protected function onLongPress(e:AEvent):void{
		var node_A:NodeAA;
		var reco_B:LongPressGestureRecognizer
		
		reco_B = e.target as LongPressGestureRecognizer;
		node_A = reco_B.getNode() as NodeAA;
		
		m_touchA = reco_B.getTouchList()[0];
		
		this.doGotoMultiSwitchDesktop();
	}
	
	protected function doGotoMultiSwitchDesktop( ) : void {
		m_flagsTip = 3;
		
		m_finished = true;
		
//		this.getFusion().setState(new MultiA_StateAA());
//		this.getFusion().setState(new MultiB_StateAA());
//		this.getFusion().setState(new MultiC_StateAA());
		this.getFusion().setState(new Entry_ViewAA.multiStateType);
		
		this.doKillTipsAll();
	}
	
	private function onShowTips(e:NTouchEvent):void{
		var touch_A:Touch;
		var img_A:ImageAA;
		var target_A:NodeAA;
		
		touch_A = e.touch;
		target_A = e.target as NodeAA;
		
		
		DesktopManager.isLeft = (target_A.userData == "A");
//		trace(DesktopManager.isLeft);
		
		
		m_tipFN = new FusionAA;
		this.getFusion().addNode(m_tipFN);
		m_tipFN.x = touch_A.rootX < this.getRoot().getWindow().rootWidth / 2 ? X_GAP : this.getRoot().getWindow().rootWidth - X_GAP;
		m_tipFN.y = touch_A.rootY;
		
		
		// tip A
		m_tipA = new FusionAA;
		m_tipFN.addNode(m_tipA);
		m_tipA.y = -Y_GAP2
		TweenMachine.from(m_tipA, ViewConfig.DURA0, {y:0,alpha:0});
		
//		img_A = new ImageAA;
//		img_A.textureId = "common/img/arrow_up.png";
//		img_A.pivotX = img_A.sourceWidth / 2;
//		img_A.pivotY = img_A.sourceHeight / 2;
//		m_tipA.addNode(img_A);
//		img_A.y = -Y_GAP;
		
		img_A = new ImageAA;
		img_A.textureId = "common/img/email-icon.png";
		img_A.pivotX = img_A.sourceWidth / 2;
		img_A.pivotY = img_A.sourceHeight / 2;
//		img_A.scaleX = img_A.scaleY = 1.35;
		m_tipA.addNode(img_A);
		
		// tip B
		m_tipB = new FusionAA;
		m_tipFN.addNode(m_tipB);
		m_tipB.y = Y_GAP2
		TweenMachine.from(m_tipB, ViewConfig.DURA0, {y:0,alpha:0});
			
//		img_A = new ImageAA;
//		img_A.textureId = "common/img/arrow_down.png";
//		img_A.pivotX = img_A.sourceWidth / 2;
//		img_A.pivotY = img_A.sourceHeight / 2;
//		m_tipB.addNode(img_A);
//		img_A.y = Y_GAP;
		
		img_A = new ImageAA;
		img_A.textureId = "common/img/music-icon.png";
		img_A.pivotX = img_A.sourceWidth / 2;
		img_A.pivotY = img_A.sourceHeight / 2;
//		img_A.scaleX = img_A.scaleY = 1.35;
		m_tipB.addNode(img_A);
		
		// tip C
		m_tipC = new FusionAA;
		m_tipFN.addNode(m_tipC);
		if(DesktopManager.isLeft) {
			m_tipC.x = Y_GAP2/2;
		}
		else {
			m_tipC.x = -Y_GAP2/2;
		}
		//trace(m_tipC.x);
		TweenMachine.from(m_tipC, ViewConfig.DURA0, {x:0, alpha:0});
		
		//		img_A = new ImageAA;
		//		img_A.textureId = "common/img/arrow_down.png";
		//		img_A.pivotX = img_A.sourceWidth / 2;
		//		img_A.pivotY = img_A.sourceHeight / 2;
		//		m_tipB.addNode(img_A);
		//		img_A.y = Y_GAP;
		
		img_A = new ImageAA;
		img_A.textureId = "common/img/idle-icon.png";
		img_A.pivotX = img_A.sourceWidth / 2;
		img_A.pivotY = img_A.sourceHeight / 2;
		//		img_A.scaleX = img_A.scaleY = 1.35;
		m_tipC.addNode(img_A);
		
		// 层叠翻页
		this.doMakeDesktopList();
		
		touch_A.addEventListener(AEvent.COMPLETE, onHideTips);
		
		//trace(m_flagsTip);
	}
	
	private function onHideTips(e:AEvent):void {
		var tween_A:ATween;
		
		if(m_flagsTip == 0){
			this.doKillTipsAll();
		}
		
		
		if(!m_finished){
			this.doRemoveDesktopList();
		}
	}
	
	private function doKillTips(gotoNext:Boolean) : void{
		var node_A:NodeAA;
		var tween_A:ATween;
		
		node_A = gotoNext ? m_tipB : m_tipA;
		tween_A = TweenMachine.to(node_A, ViewConfig.DURA0, {alpha:0});
		tween_A.onComplete = function():void{
			node_A.kill();
		}
	}
	
	private function doKillTipsAll() : void{
		var tween_A:ATween;
		var tipFN:FusionAA;
		
		if(!m_tipFN){
			return;
		}
		tipFN = m_tipFN;
		m_tipFN = null;
		tween_A = TweenMachine.to(tipFN, ViewConfig.DURA0, {alpha:0});
		tween_A.onComplete = function():void{
			tipFN.kill();
		}
	}
	
	
	private function doMakeDesktopList() : void {
		var data:Array;
		var vo:DesktopVo;
		var i:int;
		var img:ImageAA;
		var tween_A:ATween;
		var prevValue:Number;
		var stateFN:StateFusionAA;
		var state_A:Desktop_CompAA;
		var prevX:Number;
		var baseScale:Number;
		var scale_A:Number;
		var ratio_A:Number;
		
		data = DesktopManager.getData();
		
		
		if(m_viewList==null) {
			m_viewList = new <Desktop_CompAA>[];
			m_numItems = data.length;
			
//			trace(m_numItems);
			
			while(i<m_numItems){
				vo = data[i];
				
				if(vo != desktopImg.m_vo){
					stateFN = new StateFusionAA;
					stateFN.setState(new Desktop_CompAA(vo, true));
					state_A = stateFN.getState() as Desktop_CompAA;
					//stateFN.scaleX = stateFN.scaleY = 1 - (m_numItems - 1 - i)*0.1;
					
					ratio_A = AMath.calcRatio(i,0,m_numItems-1);
					//state_A.initScale = stateFN.scaleY = ratio_A*0.05 + 0.95;
					stateFN.y = 1920/2;
					
				}
				else {
					stateFN = desktopImg.getFusion();
					state_A = desktopImg;
					//state_A.initScale = 1.0;
				}
				
				m_viewList[i] = state_A;
				m_fusion.addNode(stateFN);
				i++;
			}
			
			
			m_viewList.push(desktopImg);
		}
		
		i = 0;
		while(i<m_numItems){
			state_A = m_viewList[i];
			stateFN = state_A.getFusion();
			
			if(m_numItems == 1){
				ratio_A = 1;
			}
			else {
				ratio_A = AMath.calcRatio(i,0,m_numItems-1);
			}
			if(DesktopManager.isLeft){
//				state_A.initX = stateFN.x = -(m_numItems-1-i)*15*(ratio_A * 0.4+0.6) + 1080/2;
				state_A.initX = stateFN.x = 1080/2;
			}
			else {
//				state_A.initX = stateFN.x = (m_numItems-1-i)*15*(ratio_A * 0.4+0.6) + 1080/2;
				state_A.initX = stateFN.x = 1080/2;
			}
			
			
			i++;
		}
	
		//TweenMachine.to(m_fusion, 0.15, {x:DesktopManager.isLeft ? ViewConfig.DESKTOP_LIST_OFFSET_X: -ViewConfig.DESKTOP_LIST_OFFSET_X});
	}
	
	private function doRemoveDesktopList() : void {
		var data:Array;
		var vo:DesktopVo;
		var i:int;
		var img:ImageAA;
		
		var prevValue:Number;
		var stateFN:StateFusionAA;
		var state_A:Desktop_CompAA;
		var prevX:Number;
		var baseScale:Number;
		var scale_A:Number;
		var tween_A:ATween;
		
		TweenMachine.to(m_fusion, 0.15, {x:0});
		
			

	}
}
}