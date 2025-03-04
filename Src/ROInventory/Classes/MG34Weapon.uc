//=============================================================================
// MG34Weapon
//=============================================================================
// Weapon class for the German MG34 machinegun
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class MG34Weapon extends ROMGbase;

#exec OBJ LOAD FILE=..\Animations\Axis_Mg34_1st.ukx

// Overriden to prevent the exploit of freezing your animations after firing
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
    ItemName="MG34 Machine Gun"

	//** Display **//
    Mesh=mesh'Axis_Mg34_1st.MG_34_mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=45
    BobDamping=1.6
    Handtex = Texture'Weapons1st_tex.Arms.hands_gergloves'
//	HighDetailOverlay=Material'Weapons1st_tex.MG.mg34_s'
//	bUseHighDetailOverlayIndex=true
//	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=MG34AutoFire
    FireModeClass(1)=MG34SemiAutoFire
    InitialNumPrimaryMags=4
	MaxNumPrimaryMags=6
	CurrentMagIndex=0
	bPlusOneLoading=true
	bHasBayonet=false

	//** Weapon Functionality **//
	bCanRestDeploy=false

	//** MG Functionality **//
  	ROBarrelClass = class'MG34Barrel'
  	bTrackBarrelHeat = true
  	BarrelSteamBone = barrel
    bCanFireFromHip=true

	//** Inventory/Ammo **//
    PickupClass=class'MG34Pickup'
    AttachmentClass=class'MG34Attachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=Put_Away
	// Reloading
	MagEmptyReloadAnim=Bipod_Reload
	MagPartialReloadAnim=Bipod_Reload
  	// Ironsites
  	IronBringUp=Rest_2_Hip
  	IronIdleAnim=Bipod_Idle
	IronPutDown=Hip_2_Rest
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out
	// Idle
	IdleAnim=Rest_Idle
	// Bipod anims
	IdleToBipodDeploy=Rest_2_Bipod
	BipodDeployToIdle=Bipod_2_Rest
	BipodHipIdle=Hip_Idle
	BipodHipToDeploy=Hip_2_Bipod
	// Sprinting
	SprintStartAnim=Rest_Sprint_Start
	SprintLoopAnim=Rest_Sprint_Middle
	SprintEndAnim=Rest_Sprint_End
	// MG Anims
	BarrelChangeAnim=Bipod_Barrel_Change

     //** Zooming **//
    ZoomInTime=0.4
    ZoomOutTime=0.2

	//** Bot/AI **//
	AIRating=+0.4
    CurrentRating=0.4
    bSniping=true // So bots will use this weapon to take long range shots

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
}
