//=============================================================================
// ROTab_Input
//=============================================================================
// The input config tab
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Mathieu Mallet
//=============================================================================

class ROTab_Input extends UT2K4Tab_IForceSettings;

event InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	super(Settings_Tabs).Initcomponent(MyController, MyOwner);

	RemoveComponent(ch_WeaponEffects);
	RemoveComponent(ch_PickupEffects);
	RemoveComponent(ch_DamageEffects);
	RemoveComponent(ch_GUIEffects);
	RemoveComponent(fl_DodgeTime);
	RemoveComponent(b_Controls);
	RemoveComponent(b_Speech);

	RemoveComponent(i_BG2);

    i_BG1.ManageComponent(ch_AutoSlope);
    i_BG1.ManageComponent(ch_InvertMouse);
    i_BG1.ManageComponent(ch_MouseSmoothing);
    i_BG1.ManageComponent(ch_MouseLag);
    i_BG1.ManageComponent(ch_Joystick);

    i_BG3.ManageComponent(fl_Sensitivity);
    i_BG3.ManageComponent(fl_MenuSensitivity);
    i_BG3.ManageComponent(fl_SmoothingStrength);
    i_BG3.ManageComponent(fl_MouseAccel);

    // Disable force feedback options on non-win32 platforms...  --ryan.
    if ( (!PlatformIsWindows()) || (PlatformIs64Bit()) )
    {
        ch_WeaponEffects.DisableMe();
        ch_PickupEffects.DisableMe();
        ch_DamageEffects.DisableMe();
        ch_GUIEffects.DisableMe();
    }
}

function InternalOnLoadINI(GUIComponent Sender, string s)
{
    local PlayerController player;
    player = PlayerOwner();
    switch (Sender)
	{
    	case fl_Sensitivity:
    	    if (player != none)
    	        fSens  = player.GetMouseSensitivity();
    	    else
                fSens = class'PlayerInput'.default.MouseSensitivity;
    		fl_Sensitivity.SetComponentValue(fSens,true);
    		break;

		case fl_MouseAccel:
		    if (player != none)
    		    fAccel = player.GetMouseAcceleration();
    	    else
    	        fAccel = class'PlayerInput'.Default.MouseAccelThreshold;
    		fl_MouseAccel.SetComponentValue(fAccel,true);
    		break;

    	case fl_SmoothingStrength:
    	    if (player != none)
    		    fSmoothing = player.GetMouseSmoothingStrength();
    	    else
    	        fSmoothing = class'PlayerInput'.Default.MouseSmoothingStrength;
    		fl_SmoothingStrength.SetComponentValue(fSmoothing,true);
    		break;

	    default:
	        super.InternalOnLoadINI(Sender, s);
	}
}

defaultproperties
{
    Begin Object class=GUISectionBackground Name=InputBK1
		WinWidth=0.381328
		WinHeight=0.5
		WinLeft=0.021641
		WinTop=0.25
		Caption="Options"
	End Object
	i_BG1=InputBK1

	Begin Object class=GUISectionBackground Name=InputBK3
		WinWidth=0.527812
		WinHeight=0.4
		WinLeft=0.451289
		WinTop=0.3
		Caption="Fine Tuning"
	End Object
	i_BG3=InputBK3
}
