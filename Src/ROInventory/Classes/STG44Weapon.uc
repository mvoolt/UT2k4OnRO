//=============================================================================
// STG44Weapon
//=============================================================================
// Weapon class for the Germant STG44 assault rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class STG44Weapon extends ROAutoWeapon;

#exec OBJ LOAD FILE=..\Animations\Axis_Stg44_1st.ukx

var name SelectFireAnim;	// Animation for selecting the firing mode
var name SelectFireIronAnim;// Animation for selecting the firing mode in ironsights


//=============================================================================
// replication
//=============================================================================
replication
{
    reliable if( Role<ROLE_Authority )
    	ServerChangeFireMode;
}

simulated exec function SwitchFireMode()
{
	if( IsBusy() )
		return;

    GotoState('SwitchingFireMode');
}

function ServerChangeFireMode()
{
	FireMode[0].bWaitForRelease = !FireMode[0].bWaitForRelease;
}

simulated state SwitchingFireMode extends Busy
{
	simulated function bool ReadyToFire(int Mode)
	{
		return false;
	}

	simulated function bool ShouldUseFreeAim()
	{
		return false;
	}

    simulated function Timer()
    {
    	GotoState('Idle');
    }

    simulated function BeginState()
    {
		local name Anim;

		if( bUsingSights )
		{
			Anim = SelectFireIronAnim;
		}
		else
		{
			Anim = SelectFireAnim;
		}

		if( Instigator.IsLocallyControlled() )
		{
	    	PlayAnim(Anim, 1.0, FastTweenTime );
		}

	    SetTimer(GetAnimDuration(SelectAnim, 1.0) + FastTweenTime,false);

  		ServerChangeFireMode();

	    if( Role < ROLE_Authority )
  		{
  			FireMode[0].bWaitForRelease = !FireMode[0].bWaitForRelease;
  		}
	}
}

// used by the hud icons for select fire
simulated function bool UsingAutoFire()
{
	if( FireMode[0].bWaitForRelease )
	{
		return false;
	}
	else
	{
		return true;
	}
}

simulated function AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if (ClientState == WS_ReadyToFire)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim) && (!FireMode[0].bIsFiring || !UsingAutoFire()) )
        {
            PlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, FastTweenTime);
        }
        else if (anim == ROProjectileFire(FireMode[0]).FireIronAnim && (!FireMode[0].bIsFiring || !UsingAutoFire()) )
        {
            PlayIdle();
        }
        else if (anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
        {
            PlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        }
        else if ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))
        {
            PlayIdle();
        }
    }
}

// Overriden to handle the stop firing anims especially for the STG
simulated event StopFire(int Mode)
{
	if ( FireMode[Mode].bIsFiring )
	    FireMode[Mode].bInstantStop = true;
    if (Instigator.IsLocallyControlled() && !FireMode[Mode].bFireOnRelease)
    {
     	if( !IsAnimating(0) )
     	{
     		PlayIdle();
     	}
    }

    FireMode[Mode].bIsFiring = false;
    FireMode[Mode].StopFiring();
    if (!FireMode[Mode].bFireOnRelease)
        ZeroFlashCount(Mode);
}


defaultproperties
{
	//** Info **//
    ItemName="STG44"

	//** Display **//
    Mesh=mesh'Axis_Stg44_1st.STG44-Mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=25
    BobDamping=1.6
	HighDetailOverlay=Material'Weapons1st_tex.SMG.STG44_S'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=STG44Fire
    FireModeClass(1)=STG44MeleeFire
    InitialNumPrimaryMags=6
	MaxNumPrimaryMags=6
	CurrentMagIndex=0
	bPlusOneLoading=true
	bHasBayonet=false
	FreeAimRotationSpeed=7.0
	bHasSelectFire=true

	//** Weapon Functionality **//
	bCanRestDeploy=true

	//** Inventory/Ammo **//
    PickupClass=class'STG44Pickup'
    AttachmentClass=class'STG44Attachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=Put_Away
	// Reloading
	MagEmptyReloadAnim=reload_empty
	MagPartialReloadAnim=reload_half
  	// Ironsites
  	IronBringUp=iron_in
  	IronIdleAnim=Iron_idle
	IronPutDown=iron_out
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out
	// selectfire
	SelectFireAnim=select_fire
	SelectFireIronAnim=iron_select_fire

     //** Zooming **//
    ZoomInTime=0.4
    ZoomOutTime=0.1

	//** Bot/AI **//
	AIRating=+0.7
    CurrentRating=0.7
    bSniping=true

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
}
