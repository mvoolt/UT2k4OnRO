//=============================================================================
// DP28Weapon
//=============================================================================
// Weapon class for the Russian DP-28 machinegun
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class DP28Weapon extends ROMGbase;

#exec OBJ LOAD FILE=..\Animations\Allies_Dp28_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="DP28 Machine Gun"

	//** Display **//
    Mesh=mesh'Allies_Dp28_1st.DP28_Mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=45
    BobDamping=1.6
//	HighDetailOverlay=Material'Weapons1st_tex.MG.dp28_s'
//	bUseHighDetailOverlayIndex=true
//	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=DP28Fire
    FireModeClass(1)=ROEmptyFireClass
    InitialNumPrimaryMags=6
	MaxNumPrimaryMags=6
	CurrentMagIndex=0
	bPlusOneLoading=true
	bHasBayonet=false
	NumMagsToResupply=4

	//** Weapon Functionality **//
	bCanRestDeploy=false

	//** Inventory/Ammo **//
    PickupClass=class'DP28Pickup'
    AttachmentClass=class'DP28Attachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=Put_Away
	// Reloading
	MagEmptyReloadAnim=Bipod_Reload
	MagPartialReloadAnim=Bipod_Reload_Half
  	// Ironsites
  	IronBringUp=Rest_2_Hipped
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

     //** Zooming **//
    ZoomInTime=0.4
    ZoomOutTime=0.2

	//** Bot/AI **//
	AIRating=+0.4
    CurrentRating=0.4
    bSniping=true // So bots will use this weapon to take long range shots

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
 	bUsesFreeAim=true

     //** MG **//
 	InitialBarrels = 1
  	ROBarrelClass = class'DP28Barrel'
  	bTrackBarrelHeat = true
  	BarrelSteamBone = bipod
}
