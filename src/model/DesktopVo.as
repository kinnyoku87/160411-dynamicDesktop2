package model
{
	public class DesktopVo
	{
		public function DesktopVo( img:String, isApp:Boolean = false )
		{
			if(isApp){
				this.textureRaw = "common/img/"+img+".png";
				this.textureBlur = "common/img/"+img+".png";
			}
			else {
				this.textureRaw = "common/img/raw"+img+".png";
				this.textureBlur = "common/img/blur"+img+".png";
			}
			
		}
		
		
		
		public var textureRaw:String;
		public var textureBlur:String;
	}
}