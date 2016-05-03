package view_aa
{
	import d2armor.display.AAFacade;
	import d2armor.display.ViewAA;
	
	import view_aa.desktop.DesktopA_StateAA;
	import view_aa.desktop.Desktop_StateAA;
	import view_aa.desktop.MultiB_StateAA;
	import view_aa.desktop.MultiD_StateAA;
	import view_aa.res.Res_StateAA;
	import view_aa.transition.Desktop2MultiB_TransitionAA;
	import view_aa.transition.Desktop2MultiD_TransitionAA;
	import view_aa.transition.DesktopA2MultiD_TransitionAA;
	import view_aa.transition.MultiB2Desktop_TransitionAA;
	import view_aa.transition.MultiD2DesktopA_TransitionAA;
	import view_aa.transition.MultiD2Desktop_TransitionAA;

public class Entry_ViewAA extends ViewAA
{
	
	public static var desktopStateType:Class = Desktop_StateAA;
//	public static var multiStateType:Class = MultiB_StateAA;
	public static var multiStateType:Class = MultiD_StateAA;

	override public function onViewAdded():void {
		
//		AAFacade.setTransition(Desktop_StateAA, MultiA_StateAA, Desktop2MultiA_TransitionAA);
//		AAFacade.setTransition(MultiA_StateAA, Desktop_StateAA, MultiA2Desktop_TransitionAA);
		
		AAFacade.setTransition(Desktop_StateAA, MultiB_StateAA, Desktop2MultiB_TransitionAA);
		AAFacade.setTransition(MultiB_StateAA, Desktop_StateAA, MultiB2Desktop_TransitionAA);
		
//		AAFacade.setTransition(Desktop_StateAA, MultiC_StateAA, Desktop2MultiC_TransitionAA);
//		AAFacade.setTransition(MultiC_StateAA, Desktop_StateAA, MultiC2Desktop_TransitionAA);
		
		AAFacade.setTransition(Desktop_StateAA, MultiD_StateAA, Desktop2MultiD_TransitionAA);
		AAFacade.setTransition(MultiD_StateAA, Desktop_StateAA, MultiD2Desktop_TransitionAA);
		
//		AAFacade.setTransition(Desktop_StateAA, PageSelect_StateAA, Desktop2Page_TransitionAA);
//		AAFacade.setTransition(PageSelect_StateAA, Desktop_StateAA, Page2Desktop_TransitionAA);
		
		
		
		AAFacade.setTransition(DesktopA_StateAA, MultiD_StateAA, DesktopA2MultiD_TransitionAA);
		AAFacade.setTransition(MultiD_StateAA, DesktopA_StateAA, MultiD2DesktopA_TransitionAA);
		
		
		
		
		this.getViewFusion().setState(new Res_StateAA(new desktopStateType));
	}
	
	
}
}