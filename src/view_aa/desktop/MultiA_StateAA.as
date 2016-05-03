package view_aa.desktop
{
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
	import d2armor.utils.AMath;
	
	import model.DesktopManager;
	import model.DesktopVo;
	
	import view_aa.Entry_ViewAA;
	import view_aa.ViewConfig;

	// 初版
	public class MultiA_StateAA extends StateAA
	{
		
		public function get value() : Number {
			return m_currValue;
		}
		
		public function set value( v:Number ) : void {
			this.setValue(v, true);
		}
		
		public function setValue( v:Number, hasTween:Boolean ) : void {
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
			
//			if(v < 0 || v > m_numItems -1){
//				return;
//			}
			
			//trace(v);
			
			m_currValue = v;
			index_A = AMath.clamp(int(v), 0, m_numItems - 1);
			
			if(DesktopManager.index != index_A) {
				DesktopManager.index = index_A;
				
				//trace(index_A);
				if(index_A > m_numItems - 4 ){
					startIndex = m_numItems - 4;
				}
				else {
					startIndex = index_A;
				}
				
				while(i<m_numItems) {
					state_A = m_viewList[i];
					if(i <= startIndex) {
						//TweenMachine.to(state_A.getFusion(), ViewConfig.DURA1, {x:i*ITEM_GAP_X}).easing = Quad.easeOut;
						if(i == 0) {
							currX = 0;
						}
						else {
							currX = prevX + ITEM_GAP_X;
						}
					}
					else if(i == index_A + 1) {
						//TweenMachine.to(state_A.getFusion(), ViewConfig.DURA1, {x:i*ITEM_GAP_X + 400}).easing = Quad.easeOut;
						if(i == 0) {
							currX = 0;
						}
						else {
							currX = prevX + ITEM_GAP_X + 450;
						}
					}
					else if(i < startIndex + 1 + 4){
//						TweenMachine.to(state_A.getFusion(), ViewConfig.DURA1, {x:i*ITEM_GAP_X + 400 + (i-index_A)*100}).easing = Quad.easeOut;
						currX = prevX + ITEM_GAP_X + 160;
					}
//					else if(index_A == m_numItems - 1){
//						currX = prevX + ITEM_GAP_X + 150;
//					}
					else {
						//TweenMachine.to(state_A.getFusion(), ViewConfig.DURA1, {x:i*ITEM_GAP_X + 400}).easing = Quad.easeOut;
						currX = prevX + ITEM_GAP_X + 0;
					}
					
					if(hasTween){
						TweenMachine.to(state_A.getFusion(), ViewConfig.DURA1, {x:currX}).easing = Quad.easeOut;
					}
					else {
						state_A.getFusion().x = currX;
					}
					prevX = currX;
					i++;
				}
			}
			
			//trace(index_A);
			
			i = 0;
			while(i<m_numItems){
				
				
				state_A = m_viewList[i];
				
				value_B = Math.abs(i - m_currValue);
				
				scale_A = (m_numItems - 1 - value_B + (m_numItems - 1)*5) / (m_numItems - 1) / 6 * ITEM_SCALE;
				//scale_A = (m_numItems - value_B) / (m_numItems / 2) * ITEM_SCALE
				
				state_A.getFusion().scaleX = state_A.getFusion().scaleY = scale_A;
				
//				state_A.getFusion().scaleX = state_A.getFusion().scaleY = ITEM_SCALE;
				
				//m_fusion.setNodeIndex(state_A.getFusion(), m_numItems - 1 - int(value_B));
				i++;
			}
			
			this.desktopImg = (m_viewList[index_A] as Desktop_CompAA);
			
//			m_fusion.setNodeIndex(this.desktopImg.getFusion(), m_fusion.numNodes-1);
			
			//trace(m_fusion.getNodeAt(m_fusion.numNodes - 1))
			
			ratio_A = (m_currValue / (m_numItems - 1));
			
			ratio_A = AMath.clamp(ratio_A, 0, 1);
			
			//trace(ratio_A);
			//m_fusion.x = m_startX - (ratio_A) * m_totalW;
			
			

			
			
			
		}
		
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
			var prevX:Number;
			
			
			m_bg = new ImageAA;
			m_bg.textureId = "common/img/BG.png";
			this.getFusion().addNodeAt(m_bg, 0);
			m_bg.touchable = false;
			
			
			if(!m_fusion){
				m_fusion = new FusionAA;
				this.getFusion().addNode(m_fusion);
			}
			
			prevX = this.desktopImg.getFusion().x;
			
			data = DesktopManager.getData();
			m_numItems = data.length;
			while(i<m_numItems){
				vo = data[i];
				if(i == DesktopManager.index){
					stateFN = this.desktopImg.getFusion();
					state_A = this.desktopImg;
					stateFN.y = 0;
//					TweenMachine.to(stateFN, ViewConfig.DURA1, {x:i*ITEM_GAP_X}).easing = Quad.easeOut;
				}
				else {
					
					stateFN = new StateFusionAA;
					stateFN.setState(new Desktop_CompAA(vo, true));
					state_A = stateFN.getState() as Desktop_CompAA;
//					stateFN.x = i*ITEM_GAP_X;
					stateFN.y = 0;
				}
				m_fusion.addNode(stateFN);
				m_viewList[i] = state_A;
				i++;
			}
			
			//trace(DesktopManager.index);
			
			m_totalW = ITEM_GAP_X * m_numItems - this.getRoot().getWindow().rootWidth + 300;
			
			m_fusion.x = m_startX;
			m_fusion.y = (this.getRoot().getWindow().rootHeight) / 2;
			
			
			prevValue = DesktopManager.index;
			
			stateFN = this.desktopImg.getFusion();
			
			DesktopManager.index = -1;
			this.doUpdateTouch(false);
			
			tween_A = TweenMachine.from(stateFN, ViewConfig.DURA1, {x:prevX, scaleX:1.0,scaleY:1.0});
			tween_A.easing = Quad.easeOut;
				
			//TweenMachine.from(this, ViewConfig.DURA1, {value:prevValue}, ViewConfig.DURA1);
			
			m_touchA.addEventListener(AEvent.CHANGE, onTouchChanged);
			m_touchA.addEventListener(AEvent.COMPLETE, onTouchCompleted);
			
			
			m_inited = true;
		}
		
		override public function onExit():void {
			
		}
		
		
		
		private const ITEM_GAP_X:int = 15;
		private const ITEM_SCALE:Number = 0.5;
		
		
		public var m_fusion:FusionAA;
		public var m_touchA:Touch;
		public var desktopImg:Desktop_CompAA;
		//public var m_tipFN:FusionAA;
		
		
		public var m_viewList:Vector.<Desktop_CompAA> = new <Desktop_CompAA>[];
		
		private var m_numItems:int;
		private var m_totalW:Number;
		private var m_startX:Number = 230;
		private var m_currValue:Number;
		private var m_inited:Boolean;
		
		
		
		private function onTouchChanged(e:AEvent):void{
			this.doUpdateTouch(true);
		}
		
		
		private function doUpdateTouch( hasTween:Boolean ): void{
			var index_A:int;
			var value_A:Number;
			
			value_A = m_touchA.rootX / (1080 / (m_numItems));
			
			
			if(!hasTween){
				this.setValue(value_A, false);
			}
			else {
				TweenMachine.to(this, 0.1, {value:value_A});
			}
			
		}
		
		private function onTouchCompleted(e:AEvent):void{
			this.getFusion().setState(new Entry_ViewAA.desktopStateType);
		}
		
	}
}