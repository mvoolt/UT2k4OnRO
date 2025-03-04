//=============================================================================
// M38Weapon
//=============================================================================
// Weapon class for the Russian Mosin Nagant M38 bolt action rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class M38Weapon extends ROBoltActionWeapon;

#exec OBJ LOAD FILE=..\Animations\Allies_Nagant_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="M38 Rifle"

	//** Display **//
    Mesh=mesh'Allies_Nagant_1st.Mosin_Nagant_Carbine_mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=25
    BobDamping=1.6
    BayonetBoneName=Bayonet
	HighDetailOverlay=Material'Weapons1st_tex.Rifles.MN9138_S'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=M38Fire
    FireModeClass(1)=M38MeleeFire
    InitialNumPrimaryMags=10
	MaxNumPrimaryMags=10
	CurrentMagIndex=0
	bPlusOneLoading=false
	bHasBayonet=false

	//** Weapon Functionality **//
	bCanRestDeploy=true
	FreeAimRotationSpeed=7.0

	//** Inventory/Ammo **//
    PickupClass=class'M38Pickup'
    AttachmentClass=class'M38Attachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=Put_Away
	// Reloading
	MagEmptyReloadAnim=Reload
	MagPartialReloadAnim=none
  	// Ironsites
  	IronBringUp=iron_in
  	IronBringUpRest=iron_inrest
  	IronIdleAnim=Iron_idle
	IronPutDown=iron_out
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out
	// Bolt anims
	PostFireIronIdleAnim=iron_idlerest
	PostFireIdleAnim=Idle
    BoltHipAnim=bolt
    BoltIronAnim=iron_boltrest

     //** Zooming **//
    ZoomInTime=0.4
    ZoomOutTime=0.35

	//** Bot/AI **//
	AIRating=+0.4
    CurrentRating=0.4
    bSniping=true // So bots will use this weapon to take long range shots

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
}
