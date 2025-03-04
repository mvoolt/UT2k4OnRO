//=============================================================================
// SVT40ScopedWeapon
//=============================================================================
// Weapon class for the Russian SVT 40 Semi automatic sniper rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class SVT40ScopedWeapon extends ROSniperWeapon;

#exec OBJ LOAD FILE=..\Animations\Allies_Svt40_1st.ukx

// Overriden to prevent the exploit of freezing your animations after firing
simulated function AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if (ClientState == WS_ReadyToFire)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim) && !FireMode[0].bIsFiring )
        {
            PlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, FastTweenTime);
        }
        else if (anim == ROProjectileFire(FireMode[0]).FireIronAnim && !FireMode[0].bIsFiring )
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
    ItemName="SVT40 Semi-Auto Sniper Rifle"

	//** Display **//
    Mesh=mesh'Allies_Svt40_1st.svt40_scoped_mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=60
    BobDamping=1.6
    BayonetBoneName=Bayonet
    LenseMaterialID = 4
	HighDetailOverlay=Material'Weapons1st_tex.Rifles.SVT40_S'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=SVT40ScopedFire
    FireModeClass(1)=SVT40ScopedMeleeFire
    InitialNumPrimaryMags=7
	MaxNumPrimaryMags=7
	CurrentMagIndex=0
	bPlusOneLoading=true
	bHasBayonet=false

	//** Weapon Functionality **//
	bCanRestDeploy=true

	//** Inventory/Ammo **//
    PickupClass=class'SVT40ScopedPickup'
    AttachmentClass=class'SVT40ScopedAttachment'

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
  	IronBringUp=Scope_in
  	IronIdleAnim=Scope_Idle
	IronPutDown=Scope_out
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out

     //** Zooming **//
    ZoomInTime=0.4
    ZoomOutTime=0.2
    PlayerFOVZoom = 24    // The will be the PlayerFOV when using the scope in iron sight mode - 3.5x

	//** 3d Scope **//
  	scopePortalFOV = 8// 3.5x
  	XoffsetScoped = (X=0.0,Y=0.0,Z=0.0)
  	scopePitch= -10
  	scopeYaw= 40
  	scopePortalFOVHigh = 15 // 3.5x
  	IronSightDisplayFOVHigh = 32
  	XoffsetHighDetail = (X=0.0,Y=0.0,Z=0.0)
  	scopePitchHigh= 0
  	scopeYawHigh= 35

	//** Bot/AI **//
	AIRating=+0.4
    CurrentRating=0.4
    bSniping=true // So bots will use this weapon to take long range shots

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"

	TexturedScopeTexture=Texture'Weapon_overlays.Scopes.Rus_sniperscope_overlay'
}
