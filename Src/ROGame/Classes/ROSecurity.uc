// ====================================================================
//  Class:  UnrealGame.UnrealSecurity
//  Parent: Engine.Security
//
//  <Enter a description here>
// ====================================================================

class ROSecurity extends Security;


event ServerCallback(int SecType, string Data)	// Should be Subclassed
{
	Super.ServerCallback(SecType,Data);
}

auto state StartUp
{
	function Timer()
	{
		// Police the client by checking key packages for modifications

//		ClientPerform(0,"core","");							// Check the QuickMD5
//		ClientPerform(1,"engine.actor.setinitialstate","");	// Check a CodeMD5
//		ClientPerform(2,"core.u","");						// Do a full MD5
//		ClientPerform(3,"","");								// Get Package List

		ClientPerform(2, "ROGame.u", "");
		ClientPerform(2, "ROInventory.u", "");
		ClientPerform(2, "ROVehicles.u", "");
	}


begin:
	SetTimer(frand()+1,false);

}


defaultproperties
{

}
