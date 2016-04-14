package view_aa.desktop
{
	import d2armor.animate.ATween;
	import d2armor.animate.TweenMachine;
	import d2armor.display.ImageAA;
	import d2armor.display.StateAA;
	import d2armor.display.filters.BlurFilterAA;
	import d2armor.display.filters.DropShadowFilterAA;
	
	import model.DesktopVo;
	
	import view_aa.ViewConfig;

	public class Desktop_CompAA extends StateAA
	{
		public function Desktop_CompAA( vo:DesktopVo, isInitBlur:Boolean )
		{
			m_vo = vo;
			this.isInitBlur = isInitBlur;
		}
		
		public var m_vo:DesktopVo;
		
		public var imgBlur:ImageAA;
		public var imgRaw:ImageAA;
		public var isInitBlur:Boolean;
		
		public var prevScale:Number;
		
		
		
		public function setToRaw() : void {
			var tween_A:ATween;
			var img_A:ImageAA;
			
			imgRaw = new ImageAA;
			imgRaw.textureId = m_vo.textureRaw;
			imgRaw.pivotX = imgRaw.sourceWidth / 2;
			imgRaw.pivotY = imgRaw.sourceHeight / 2;
			this.getFusion().addNode(imgRaw);
			
			img_A = imgBlur;
			imgBlur = null;
			
			tween_A = TweenMachine.from(imgRaw, ViewConfig.DURA1, {alpha:0});
			tween_A.onComplete = function() : void {
				img_A.kill();
				
				//trace(imgRaw, imgBlur);
			}
				
			
		}
		
		public function setToBlur() : void {
			var tween_A:ATween;
			var img_A:ImageAA;
			
			imgBlur = new ImageAA;
			imgBlur.textureId = m_vo.textureBlur;
			imgBlur.pivotX = imgBlur.sourceWidth / 2;
			imgBlur.pivotY = imgBlur.sourceHeight / 2;
			this.getFusion().addNode(imgBlur);
			
			img_A = imgRaw;
			imgRaw = null;
			
			tween_A = TweenMachine.from(imgBlur, ViewConfig.DURA1, {alpha:0});
			tween_A.onComplete = function() : void {
				img_A.kill();
			}
		}
		
		
		
		override public function onEnter():void{
			var img_A:ImageAA;
			
			if(isInitBlur){
				img_A = imgBlur = new ImageAA;
				img_A.textureId = m_vo.textureBlur;
			}
			else {
				img_A = imgRaw = new ImageAA;
				img_A.textureId = m_vo.textureRaw;
			}
			
			img_A.pivotX = img_A.sourceWidth / 2;
			img_A.pivotY = img_A.sourceHeight / 2;
			this.getFusion().addNode(img_A);
			
//			this.getFusion().filters = [new DropShadowFilterAA(22)];
		}
		
		
		
	}
}