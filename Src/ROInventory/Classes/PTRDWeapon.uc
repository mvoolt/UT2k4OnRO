//===================================================================
// ROPTRDbase
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Russian PTRD anti tank rifle
//===================================================================
class PTRDWeapon extends ROBipodWeapon;

#exec OBJ LOAD FILE=..\Animations\Allies_Ptrd_1st.ukx

// Overriden because we don't want to allow reloading unless the weapon is out of
// ammo
simulated function bool AllowReload()
{
    if( AmmoAmount(0) > 0 )
    {
		return false;
	}

	return super.AllowReload();
}

// Implemented in various states to show whether the weapon is busy performing
// some action that normally shouldn't be interuppted. Overriden because we
// have no melee attack
simulated function bool IsBusy()
{
	return false;
}

simulated function ROIronSights()
{
	Deploy();
}

simulated function AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if (ClientState == WS_ReadyToFire)
    {
        // Every time the PTRD fires its out of ammo, so play the empty animation
		if (anim == FireMode[0].FireAnim )
        {
            LoopAnim(IronIdleEmptyAnim, IdleAnimRate, 0.2 );
        }
        else if (anim == FireMode[1].FireAnim)
        {
            LoopAnim(IronIdleEmptyAnim, IdleAnimRate, 0.2 );
        }
        else
        {
        	super.AnimEnd(channel);
        }
    }
}

// Overridden so we don't play idle empty anims after a reload
simulated state Reloading
{
	simulated function PlayIdle()
	{
		if( Instigator.bBipodDeployed  )
	    {
			LoopAnim(IronIdleAnim, IdleAnimRate, 0.2 );
	    }
		else
	    {
			LoopAnim(IdleAnim, IdleAnimRate, 0.2 );
	    }
	}
}

simulated function PlayIdle()
{
	if( Instigator.bBipodDeployed )
    {
	    if( AmmoAmount(0) > 0 )
	    {
			LoopAnim(IronIdleAnim, IdleAnimRate, 0.2 );
		}
		else
		{
			LoopAnim(IronIdleEmptyAnim, IdleAnimRate, 0.2 );
		}
    }
	else
    {
	    if( AmmoAmount(0) > 0 )
	    {
			LoopAnim(IdleAnim, IdleAnimRate, 0.2 );
		}
		else
		{
			LoopAnim(IdleEmptyAnim, IdleAnimRate, 0.2 );
		}
    }
}

simulated function Fire(float F)
{
    if ( Level.NetMode != NM_DedicatedServer && Instigator.bBipodDeployed)
    {
       if (!HasAmmo())
       {
          ROManualReload();
          return;
       }
    }

    super.Fire(F);
}

defaultproperties
{
	//** Info **//
    ItemName="PTRD AT Rifle"

	//** Display **//
    Mesh=mesh'Allies_Ptrd_1st.ptrd41_mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=35
    BobDamping=1.6
	HighDetailOverlay=Material'Weapons1st_tex.Rifles.PTRD_S'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=PTRDFire
    FireModeClass(1)=PTRDFire
    InitialNumPrimaryMags=15
	MaxNumPrimaryMags=20
	CurrentMagIndex=0
	bPlusOneLoading=false
	bHasBayonet=false

	//** Weapon Functionality **//
	bCanRestDeploy=false

	//** Inventory/Ammo **//
    PickupClass=class'PTRDPickup'
    AttachmentClass=class'PTRDAttachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	SelectEmptyAnim=Draw_Empty
	PutDownAnim=Put_Away
	PutDownEmptyAnim=Put_Away_Empty
	// Reloading
	MagEmptyReloadAnim=Reload
	MagPartialReloadAnim=none
  	// Ironsites
  	IronBringUp=Rest_2_Bipod
  	IronIdleAnim=Bipod_Idle
	IronPutDown=Bipod_2_Rest
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out
	CrawlForwardEmptyAnim=crawlF
	CrawlBackwardEmptyAnim=crawlB
	CrawlStartEmptyAnim=crawl_in
	CrawlEndEmptyAnim=crawl_out
	// Idle
	IdleAnim=Rest_Idle
	IdleEmptyAnim=Rest_Idle_Empty
	IronIdleEmptyAnim=Bipod_Idle_Empty
	// Bipod anims
	IdleToBipodDeploy=Rest_2_Bipod
	BipodDeployToIdle=Bipod_2_Rest
	IdleToBipodDeployEmpty=Rest_2_Bipod_Empty
	BipodDeployToIdleEmpty=Bipod_2_Rest_Empty
	// Sprinting
	SprintStartEmptyAnim=Sprint_Start_Empty
	SprintLoopEmptyAnim=Sprint_Middle_Empty
	SprintEndEmptyAnim=Sprint_End_Empty

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
