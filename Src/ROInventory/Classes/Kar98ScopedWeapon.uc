//=============================================================================
// Kar98ScopedWeapon
//=============================================================================
// Weapon class for the German Kar98k Sniper rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class Kar98ScopedWeapon extends ROBoltSniperWeapon;

#exec OBJ LOAD FILE=..\Animations\Axis_Kar98_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="Kar98k Rifle"

	//** Display **//
    Mesh=mesh'Axis_Kar98_1st.kar98k-scoped-mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=45
    BobDamping=1.6
    BayonetBoneName=Bayonet
	LenseMaterialID = 5
	HighDetailOverlay=Material'Weapons1st_tex.Rifles.k98_sniper_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=Kar98ScopedFire
    FireModeClass(1)=Kar98ScopedMeleeFire
    InitialNumPrimaryMags=7
	MaxNumPrimaryMags=10
	CurrentMagIndex=0
	bPlusOneLoading=false
	bHasBayonet=false

	//** Weapon Functionality **//
	bCanRestDeploy=true

	//** Inventory/Ammo **//
    PickupClass=class'Kar98ScopedPickup'
    AttachmentClass=class'Kar98ScopedAttachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=Put_Away
	// Reloading
	PreReloadAnim=Single_Open
	SingleReloadAnim=Single_insert
	PostReloadAnim=Single_Close
  	// Ironsites
  	IronBringUp=Scope_in
  	IronIdleAnim=Scope_Idle
	IronPutDown=Scope_out
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out
	// Bolt anims
	PostFireIronIdleAnim=Scope_Idle
	PostFireIdleAnim=Idle
    BoltHipAnim=bolt_scope
    BoltIronAnim=scope_bolt

     //** Zooming **//
    ZoomInTime=0.4
    ZoomOutTime=0.4
	PlayerFOVZoom = 21    // The will be the PlayerFOV when using the scope in iron sight mode - 4x

	//** 3d Scope **//
  	scopePortalFOV = 7// 4x
  	XoffsetScoped = (X=0.0,Y=0.0,Z=0.0)
  	scopePitch= -10
  	scopeYaw= 40
  	scopePortalFOVHigh = 13 // 4x
  	IronSightDisplayFOVHigh = 43//4
  	XoffsetHighDetail = (X=-5.0,Y=0.0,Z=0.0)
  	scopePitchHigh= 0
  	scopeYawHigh= 35

	//** Bot/AI **//
	AIRating=+0.4
    CurrentRating=0.4
    bSniping=true // So bots will use this weapon to take long range shots

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"

	TexturedScopeTexture=Texture'Weapon_overlays.Scopes.Ger_sniperscope_overlay'
}
