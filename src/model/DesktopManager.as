package model
{
	
	public class DesktopManager
	{
		
		public static var isLeft:Boolean;
		
		public static function getData() : Array {
			return m_data
		}
		
		public static function getDesktopVo() : DesktopVo {
			return m_data[m_index];
		}
		
		public static function get index() : int {
			return m_index;
		}
		
		public static function set index( v:int ) : void {
			m_index = v;
		}
		
		public static function getPrevVo() : DesktopVo {
			return m_data[m_index - 1] as DesktopVo;
		}
		
		public static function getNextVo() : DesktopVo {
			return m_data[m_index + 1] as DesktopVo;
		}
		
		public static function setDesktopVoToLast(v:DesktopVo):void{
			m_data = m_rawData.concat();
			
			m_index = m_data.indexOf(v);
			m_data.splice(m_index, 1);
			m_data.push(v);
			m_index = m_data.length - 1;
		}
		
		
		private static var m_rawData:Array =
			[
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
//				new DesktopVo("8"),
				
//				new DesktopVo("7"),
//				new DesktopVo("6"),
//				new DesktopVo("4"),
//				new DesktopVo("3"),
				new DesktopVo("7"),
				new DesktopVo("6"),
//				new DesktopVo("4"),
//				new DesktopVo("3"),
//				new DesktopVo("7"),
//				new DesktopVo("6"),
//				new DesktopVo("4"),
//				new DesktopVo("3"),
				new DesktopVo("4"),
				new DesktopVo("3"),
				new DesktopVo("2"),
//				new DesktopVo("1"),
//				new DesktopVo("2"),
//				new DesktopVo("1")
//				new DesktopVo("0", true)
				
			];
		
		private static var m_data:Array = m_rawData.concat();
		
		{
			//m_data.reverse();
		}
		private static var m_index:int = m_data.length - 1;
	}
}