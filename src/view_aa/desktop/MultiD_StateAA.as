package view_aa.desktop
{
	import d2armor.activity.Touch;
	import d2armor.animate.ATween;
	import d2armor.animate.TweenMachine;
	import d2armor.display.FusionAA;
	import d2armor.display.ImageAA;
	import d2armor.display.NodeAA;
	import d2armor.display.StateAA;
	import d2armor.display.StateFusionAA;
	import d2armor.events.AEvent;
	import d2armor.utils.AMath;
	
	import model.DesktopManager;
	import model.DesktopVo;
	
	import view_aa.Entry_ViewAA;
	import view_aa.ViewConfig;

	// 多桌面切换，迭代版本
	public class MultiD_StateAA extends StateAA
	{
		
		public function get value() : Number {
			return m_currValue;
		}
		
		public function set value( v:Number ) : void {
			this.setValue(v, false);
		}
		
		public function setValue( v:Number, hasTween:Boolean ) : void {
			var i:int;
			var ratio_A:Number;
			var index_A:int;
			var value_B:Number;
			var node_A:NodeAA;
			var state_A:Desktop_CompAA;
			var scale_X:Number;
			var scale_Y:Number;
			var prevX:Number;
			var currX:Number;
			var startIndex:int;
			var baseScale:Number;
			var offset_A:Number;
			var ratio_B:Number;
			
			m_currValue = v;

//			trace(v, m_currValue);
			
			index_A = AMath.clamp(int(v), 0, m_numItems - 1);
			
			if(DesktopManager.index != index_A) {
				
				DesktopManager.index = index_A;
			}
			
			
			//ratio_A = AMath.calcRatio(m_currValue, 0, m_numItems);
			baseScale = 1 - m_currValue * 0.03;
			
			//trace(baseScale);
			//trace(m_currValue);
			
			ratio_B = AMath.calcRatio(m_currValue, m_numItems - 1, m_numItems);
			ratio_B = AMath.clamp(ratio_B, 0, 1);
//			trace(ratio_B);
			i = 0;
			while(i<m_numItems){
				state_A = m_viewList[i];
				state_A.prevScale = state_A.getFusion().scaleX;
				scale_X = scale_Y = (baseScale + i * 0.03) * BASE_ITEM_SCALE;
				if(m_currValue > m_numItems - 1) {
					scale_X = scale_X + ratio_B * (1 - scale_X);
					scale_Y = scale_Y + ratio_B * (state_A.initScale - scale_Y);
				}
				
				if(hasTween){
					TweenMachine.to(state_A.getFusion(), ViewConfig.DURA5, {scaleX:scale_X, scaleY:scale_Y});
				}
				else {
					state_A.getFusion().scaleX = scale_X;
					state_A.getFusion().scaleY = scale_Y;
				}
				
				// 偏移值
				offset_A = i-m_currValue + 0.55;
				
				
				// 当前选中item
//				if(offset_A < -3){
//					currX =  -2000;
//				}
				if(offset_A < -5 || offset_A > 2){
					state_A.getFusion().visible = false;
				}
				else {
					state_A.getFusion().visible = true;
					if(offset_A >= -5 && offset_A < -4){
						ratio_A = AMath.calcRatio(offset_A, -5, -4);
						currX = ratio_A * 25 + 0;
					}
					if(offset_A >= -4 && offset_A < -3){
						ratio_A = AMath.calcRatio(offset_A, -4, -3);
						currX = ratio_A * 25 + 25;
					}
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
					else if(offset_A > 1 && offset_A <= 2){
						ratio_A = AMath.calcRatio(offset_A, 1, 2);
						currX = ratio_A * 500 +  1100;
					}
					currX = DesktopManager.isLeft ? currX + 220 : -currX + 620 + 220;
					if(m_currValue > m_numItems - 1) {
						currX = currX + ratio_B * (state_A.initX - currX);
//						currX = currX + ratio_B * (state_A.initX - currX + (DesktopManager.isLeft ? ViewConfig.DESKTOP_LIST_OFFSET_X : -ViewConfig.DESKTOP_LIST_OFFSET_X));
					}
					
					if(hasTween){
						TweenMachine.to(state_A.getFusion(), ViewConfig.DURA5, {x:currX});
					}
					else {
						state_A.getFusion().x = currX;
					}
					
				}
				i++;
			}
			
			this.desktopImg = (m_viewList[index_A] as Desktop_CompAA);
			
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
//			TweenMachine.to(m_fusion, ViewConfig.DURA0, {x:0});
			
//			m_fusion.x = 0;
			m_fusion.y = (this.getRoot().getWindow().rootHeight) / 2;
			
			prevValue = DesktopManager.index;
			
			stateFN = this.desktopImg.getFusion();
			
			DesktopManager.index = -1;
			this.doUpdateTouch(false);
			
			while(i<m_numItems){
				state_A = m_viewList[i];
				state_A.getFusion().y = 0;
				
//				tween_A = TweenMachine.from(state_A.getFusion(), ViewConfig.DURA4, {scaleX:state_A.prevScale, scaleY:state_A.prevScale});
				i++;
			}
			
//			tween_A = TweenMachine.from(stateFN, ViewConfig.DURA1, {scaleX:1.0,scaleY:1.0});
			//tween_A.easing = Quad.easeOut;
				
			//TweenMachine.from(this, ViewConfig.DURA1, {value:prevValue}, ViewConfig.DURA1);
			
			m_touchA.addEventListener(AEvent.CHANGE, onTouchChanged);
			m_touchA.addEventListener(AEvent.COMPLETE, onTouchCompleted);
			
			
			m_inited = true;
		}
		
		override public function onExit():void {
			
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
		
		private var m_lastValue:Number = 0.475;
		
		
		
		private function onTouchChanged(e:AEvent):void{
			this.doUpdateTouch(true);
		}
		
		
		private const START_X:Number = 70;
		
		private function doUpdateTouch( hasTween:Boolean ): void{
			var index_A:int;
			var value_A:Number;
			var ratio_A:Number;
			
			if(DesktopManager.isLeft) {
				ratio_A = AMath.calcRatio(m_touchA.rootX, 1080 - START_X, START_X);
			}
			else {
				ratio_A = AMath.calcRatio(m_touchA.rootX, START_X, 1080 - START_X);
			}
			value_A = ratio_A * (m_numItems + 1);
			if(value_A > m_numItems - 1) {
				value_A = m_numItems - 1 + AMath.calcRatio(value_A, m_numItems - 1, m_numItems + 1) * 1;
			}
			if(!hasTween){
				this.setValue(value_A, true);
			}
			else {
				//trace(value_A);
				
				if(value_A < m_lastValue){
					value_A = m_lastValue + (value_A - m_lastValue) * 0.15;
				}
				else if(value_A > m_numItems) {
//					value_A = m_numItems + (value_A - m_numItems) * 0.3;
					value_A = m_numItems;
				}
				
				
				TweenMachine.to(this, ViewConfig.DURA0, {value:value_A});
			}
			
		}
		
		private function onTouchCompleted(e:AEvent):void{
			
			this.getFusion().setState(new Entry_ViewAA.desktopStateType);
			
			DesktopManager.setDesktopVoToLast(desktopImg.m_vo);
			
		}
		
	}
}