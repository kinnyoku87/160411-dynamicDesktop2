package view_aa.desktop
{
	import com.greensock.easing.FastEase;
	
	import d2armor.Armor;
	import d2armor.activity.Touch;
	import d2armor.animate.ATween;
	import d2armor.animate.TweenMachine;
	import d2armor.animate.easing.Quad;
	import d2armor.display.FusionAA;
	import d2armor.display.ImageAA;
	import d2armor.display.NodeAA;
	import d2armor.display.StateAA;
	import d2armor.display.StateFusionAA;
	import d2armor.events.AEvent;
	import d2armor.events.TickEvent;
	import d2armor.utils.AMath;
	import d2armor.utils.MathUtil;
	
	import model.DesktopManager;
	import model.DesktopVo;
	
	import view_aa.Entry_ViewAA;
	import view_aa.ViewConfig;

	// 多桌面切换，两侧加入自动滚屏功能
	public class MultiC_StateAA extends StateAA
	{
		
		public function get value() : Number {
			return m_currValue;
		}
		
		public function set value( v:Number ) : void {
		
			this.setValue(v);
		}
		
		public function setValue( v:Number ) : void {
			var i:int;
			var ratio_A:Number;
			var index_A:int;
			var value_B:Number;
			var node_A:NodeAA;
			var state_A:Desktop_CompAA;
			var scale_A:Number;
			var prevX:Number;
			var currX:Number;
			var startIndex:int;
			var baseScale:Number;
			var offset_A:Number;
			
//			if(v > 8){
//				trace("!");
//			}
			//trace(v);
			
			m_currValue = v;

			//trace(v, m_currValue);
			
			index_A = AMath.clamp(int(v), 0, m_numItems - 1);
			
			if(DesktopManager.index != index_A) {
				
				DesktopManager.index = index_A;
			}
			
			
			//ratio_A = AMath.calcRatio(m_currValue, 0, m_numItems);
			baseScale = 1 - m_currValue * 0.03;
			
			//trace(baseScale);
			//trace(m_currValue);
			
			i = 0;
			while(i<m_numItems){
				state_A = m_viewList[i];
				state_A.prevScale = state_A.getFusion().scaleX;
				scale_A = (baseScale + i * 0.03) * BASE_ITEM_SCALE;
				state_A.getFusion().scaleX = state_A.getFusion().scaleY = scale_A;
				
//				TweenMachine.to(state_A.getFusion(), , {scaleX:scale_A, scaleY:scale_A});
				
				// 偏移值
				offset_A = i-m_currValue + 0.55;
				
				// 当前选中item
//				if(offset_A < -3){
//					currX =  -2000;
//				}
				if(offset_A < -3 || offset_A > 2){
					state_A.getFusion().visible = false;
				}
				else {
					state_A.getFusion().visible = true;
					if(offset_A >= -3 && offset_A < -2){
						ratio_A = AMath.calcRatio(offset_A, -3, -2);
						currX = ratio_A * 50 + 50;
					}
					else if(offset_A >= -2 && offset_A < -1){
						ratio_A = AMath.calcRatio(offset_A, -2, -1);
						currX = ratio_A * 50 + 100;
					}
					else if(offset_A >= -1 && offset_A <= 0){
						ratio_A = AMath.calcRatio(offset_A, -1, 0);
						currX = ratio_A * 200 + 150;
						//trace(ratio_A);
					}
					else if(offset_A > 0 && offset_A <= 1){
						ratio_A = AMath.calcRatio(offset_A, 0, 1);
						currX = ratio_A * 750 + 350;
					}
					else if(offset_A > 1){
						ratio_A = AMath.calcRatio(offset_A, 1, 2);
						currX = ratio_A * 500 +  1100;
					}
					else if(offset_A <= 2) {
						ratio_A = AMath.calcRatio(offset_A, 1, 2);
						currX = ratio_A * 500 +  1100;
					}
					
					state_A.getFusion().x = DesktopManager.isLeft ? currX + 220 : -currX + 620 + 220;
				}
				
//				else if(offset_A > 2){
//					currX = 2000;
//				}
				
				//prevX = currX;
//				state_A.getFusion().x = DesktopManager.isLeft ? currX + 220 : -currX + 620 + 220;
				
				i++;
			}
			
			this.desktopImg = (m_viewList[index_A] as Desktop_CompAA);
			
//			ratio_A = (m_currValue / (m_numItems - 1));
//			ratio_A = AMath.clamp(ratio_A, 0, 1);
			
			//trace(ratio_A);
			//m_fusion.x = m_startX - (ratio_A) * m_totalW;
			
			
		}
		
		
		private const ITEM_GAP_X:int = 200;
		private const ITEM_SCALE:Number = 0.7;
		private const BASE_ITEM_SCALE:Number = 0.7;
		
		public var m_bg:ImageAA;
		
		override public function onEnter() : void {
			var data:Array;
			var vo:DesktopVo;
			var i:int;
			var img:ImageAA;
			var tween_A:ATween;
			var prevValue:Number;
			var stateFN:StateFusionAA;
			var state_A:Desktop_CompAA;
			
			
			m_bg = new ImageAA;
			m_bg.textureId = "common/img/BG.png";
			this.getFusion().addNodeAt(m_bg, 0);
			m_bg.touchable = false;
			
			
			if(!m_fusion){
				m_fusion = new FusionAA;
				this.getFusion().addNode(m_fusion);
			}
			
			m_totalW = ITEM_GAP_X * m_numItems - this.getRoot().getWindow().rootWidth + 300;
			
//			TweenMachine.to(m_fusion, 0.15, {x:m_startX});
			TweenMachine.to(m_fusion, 0.15, {x:0});
			
			m_fusion.y = (this.getRoot().getWindow().rootHeight) / 2;
			
			
			prevValue = DesktopManager.index;
			
			stateFN = this.desktopImg.getFusion();
			
			DesktopManager.index = -1;
			
			m_currValue = m_numItems;
			m_baseValue = m_numItems - m_maxItems;
			
			this.doUpdateTouch(true);
			
			//trace(m_viewList[0].getFusion().scaleX);
			
			while(i<m_numItems){
				state_A = m_viewList[i];
				state_A.getFusion().y = 0;
				
				tween_A = TweenMachine.from(state_A.getFusion(), ViewConfig.DURA4, {scaleX:state_A.prevScale, scaleY:state_A.prevScale});
				i++;
			}
			
//			tween_A = TweenMachine.from(stateFN, ViewConfig.DURA1, {scaleX:1.0,scaleY:1.0});
			//tween_A.easing = Quad.easeOut;
				
			//TweenMachine.from(this, ViewConfig.DURA1, {value:prevValue}, ViewConfig.DURA1);
			
			
//			trace(m_baseValue);
			
			m_touchA.addEventListener(AEvent.CHANGE, onTouchChanged);
			m_touchA.addEventListener(AEvent.COMPLETE, onTouchCompleted);
			
			Armor.getTick().addEventListener(TickEvent.TICKING, ____onTicking);
			
			m_inited = true;
		}
		
		override public function onExit():void {
			Armor.getTick().removeEventListener(TickEvent.TICKING, ____onTicking);
		}
		
		
		
		public var m_fusion:FusionAA;
		public var m_touchA:Touch;
		public var desktopImg:Desktop_CompAA;
		//public var m_tipFN:FusionAA;
		
		
		public var m_viewList:Vector.<Desktop_CompAA> = new <Desktop_CompAA>[];
		public var m_numItems:int;
		
		private var m_totalW:Number;
		private var m_startX:Number = 230;
		private var m_currValue:Number;
		private var m_inited:Boolean;
		
		private var m_maxItems:int = 7;
		private var m_scrollVelocityX:Number = 0;
		
		private var m_baseValue:Number;
		
		
		
		private function onTouchChanged(e:AEvent):void{
			this.doUpdateTouch(false);
		}
		
		
		private const START_X:Number = 150;
		private const SPEED_A:Number = 1.0;
		private const SPEED_B:Number = 1.35;
		
		private function doUpdateTouch( forInit:Boolean ): void{
			var index_A:int;
			var value_A:Number;
			var ratio_A:Number;
			
//			trace(m_baseValue);
			
			if(DesktopManager.isLeft) {
				ratio_A = AMath.calcRatio(m_touchA.rootX, 1080 - START_X, START_X);
				
				// value越来越小
				if(ratio_A < 0) {
					if(m_touchA.rootX > 1080 - START_X * .5) {
						m_scrollVelocityX = -SPEED_B;
					}
					else {
						m_scrollVelocityX = -SPEED_A;
					}
					//TweenMachine.getInstance().stopTarget(this);
				}
				// value越来越大
				else if(ratio_A > 1) {
					if(m_touchA.rootX < START_X * .5) {
						m_scrollVelocityX = SPEED_B;
					}
					else {
						m_scrollVelocityX = SPEED_A;
					}
					//TweenMachine.getInstance().stopTarget(this);
				}
				else {
					m_scrollVelocityX = 0;
					
					if(m_numItems > m_maxItems) {
						value_A = m_baseValue + ratio_A * m_maxItems;
					}
					else {
						value_A = ratio_A * m_numItems;
					}
					
//					trace(value_A);
					
				}
			}
			else {
				ratio_A = AMath.calcRatio(m_touchA.rootX, START_X, 1080 - START_X);
				
				// value越来越小
				if(ratio_A < 0) {
					if(m_touchA.rootX < START_X * .5) {
						m_scrollVelocityX = -SPEED_B;
					}
					else {
						m_scrollVelocityX = -SPEED_A;
					}
					//TweenMachine.getInstance().stopTarget(this);
				}
				// value越来越大
				else if(ratio_A > 1) {
					if(m_touchA.rootX > 1080 - START_X * .5) {
						m_scrollVelocityX = SPEED_B;
					}
					else {
						m_scrollVelocityX = SPEED_A;
					}
//					TweenMachine.getInstance().stopTarget(this);
				}
				else {
					m_scrollVelocityX = 0;
					
					if(m_numItems > m_maxItems) {
						value_A = m_baseValue + ratio_A * m_maxItems;
					}
					else {
						value_A = ratio_A * m_numItems;
					}
				}
			}
			
			if(m_scrollVelocityX == 0) {
				if(forInit){
					this.setValue(value_A);
				}
				else {
					TweenMachine.to(this, ViewConfig.DURA0, {value:value_A});
				}
				
			}
			else if(forInit){
				this.setValue(m_numItems);
			}
		}
		
		private function onTouchCompleted(e:AEvent):void{
			
			this.getFusion().setState(new Entry_ViewAA.desktopStateType);
			
			DesktopManager.setDesktopVoToLast(desktopImg.m_vo);
			
		}
		
		private function ____onTicking(e:TickEvent):void {
			var value_A:Number;
			
			if(m_scrollVelocityX == 0) {
				return;
			}
			value_A = this.value + m_scrollVelocityX * 0.03;
			if(value_A < 0 || value_A > m_numItems) {
				return;
			}
			
			//TweenMachine.to(this, ViewConfig.DURA0, {value:value_A});
			this.value = value_A;
			
			if(value_A > m_numItems - m_maxItems) {
				m_baseValue = m_numItems - m_maxItems;
			}
			else {
				m_baseValue = value_A;
			}
		}
		
	}
}