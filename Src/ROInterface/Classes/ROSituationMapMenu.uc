//-----------------------------------------------------------
// ROSituationMapMenu
//-----------------------------------------------------------
// Basically a huge hack -- captures mouse events and
// adds/moves the current rally point. All the rendering
// is still done on the hud :)
//-----------------------------------------------------------
class ROSituationMapMenu extends GUIPage;

//var automated 	GUIButton	b_Close;

var string      ShowObjectivesExec; // Used to find keys associated with the 'showobjectives' keybind

function bool InternalOnClick(GUIComponent Sender)
{
    local ROHud hud;
	//if (Sender == Controls[0])
	//	Controller.CloseMenu();
	//else
	//{
        hud = getHud();
        if (hud != none)
            if (hud.HandleLevelMapClick(Controller.MouseX, Controller.MouseY))
                Controller.CloseMenu();
    //}

	return true;
}

/*function bool ButtonClick(GUIComponent Sender)
{
	if (Sender == Controls[0])
		Controller.CloseMenu();

	return true;
}*/

// hack: seems OnClose isn't called when you use CloseMenu()
function bool InternalOnCanClose(optional bool bCancelled)
{
    CloseHUDMenu();
    return true;
}

function ROHud getHud()
{
    if (ROPlayer(PlayerOwner()) != none && ROPlayer(PlayerOwner()).myHUD != none)
        return ROHud(ROPlayer(PlayerOwner()).myHUD);
    else
        return none;
}

function CloseHUDMenu()
{
    local ROHud hud;
    hud = getHud();
    if (hud != none)
        hud.HideObjectives();
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
    if (key == 0x1B ||    // IK_Escape
        isShowObjectivesKey(key))
    {
        Controller.CloseMenu();
        return true;
    }

    return false;
}

function bool isShowObjectivesKey(byte Key)
{
	local string BindStr;
	local array<string> Bindings;
	local int i, idx;
	local PlayerController ref;

	ref = PlayerOwner();

	BindStr = Ref.ConsoleCommand("BINDINGTOKEY" @ "\"" $ ShowObjectivesExec $ "\"");
	if ( BindStr != "" )
	{
		Split(BindStr, ",", Bindings);
		if ( Bindings.Length > 0 )
		{
			for ( i = 0; i < Bindings.Length; i++ )
			{
				idx = int(Ref.ConsoleCommand("KEYNUMBER"@Bindings[i]));
				if (idx == key)
				    return true;
			}
		}
	}

	return false;
}

defaultproperties
{
    /*
	Begin Object Class=GUIButton Name=CloseButton
		Caption="Close"
		WinWidth=0.2
		WinHeight=0.04
		WinLeft=0.4
		WinTop=0.9
		bBoundToParent=true
		OnClick=InternalOnClick
	End Object
	Controls(0)=GUIButton'CloseButton'
	*/

	OnClick=InternalOnClick
	OnCanClose=InternalOnCanClose
	OnKeyEvent=InternalOnKeyEvent

	WinLeft=0.0
	WinTop=0.0
	WinWidth=1.0
	WinHeight=1.0
	bRequire640x480=false
	bRenderWorld=true
	bAllowedAsLast=true

	ShowObjectivesExec="SHOWOBJECTIVES"
}
