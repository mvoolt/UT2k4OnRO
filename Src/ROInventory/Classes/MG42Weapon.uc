//=============================================================================
// MG42Weapon
//=============================================================================
// Weapon class for the German MG42 machinegun
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MG42Weapon extends ROMGbase;

#exec OBJ LOAD FILE=..\Animations\Axis_Mg42_1st.ukx

var 	ROFPAmmoRound   	MGBeltArray[10];	// An array of first person ammo rounds
var 	name   				MGBeltBones[10];	// An array of bone names to attach the belt to
var() class<ROFPAmmoRound> 	BeltBulletClass;    // The class to spawn for each bullet on the ammo belt

//=============================================================================
// functions
//=============================================================================

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	if( Level.Netmode != NM_DedicatedServer)
		SpawnAmmoBelt();
}

// Handles making ammo belt bullets disappear
simulated function UpdateAmmoBelt()
{
	local int i;

	if( AmmoAmount(0) > 9 )
	{
		return;
	}

    for ( i=AmmoAmount(0); i<10; i++ )
    {
    	MGBeltArray[i].SetDrawType(DT_None);
    }
}

// Spawn the first person linked ammobelt
simulated function SpawnAmmoBelt()
{
	local int i;

	for (i = 0; i < ArrayCount(MGBeltArray); i++)
	{
   	   MGBeltArray[i] = Spawn(BeltBulletClass,self);
       AttachToBone(MGBeltArray[i], MGBeltBones[i]);
	}
}

// Make the full ammo belt visible again. Called by anim notifies
simulated function RenewAmmoBelt()
{
	local int i;

	for (i = 0; i < ArrayCount(MGBeltArray); i++)
	{
		MGBeltArray[i].SetDrawType(DT_StaticMesh);
	}
}

// Overriden so we do faster net updated when we're down to the last few rounds
simulated function bool ConsumeAmmo(int Mode, float load, optional bool bAmountNeededIsMax)
{
	if( AmmoAmount(0) < 11 )
		NetUpdateTime = Level.TimeSeconds - 1;

	return super.ConsumeAmmo(Mode, load, bAmountNeededIsMax);
}


defaultproperties
{
	//** Info **//
    ItemName="MG42 Machine Gun"

	//** Display **//
    Mesh=mesh'Axis_Mg42_1st.MG42_mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=40
    BobDamping=1.6
    Handtex = Texture'Weapons1st_tex.Arms.hands_gergloves'

    //** Weapon Firing **//
    FireModeClass(0)=MG42Fire
    FireModeClass(1)=ROEmptyFireClass
    InitialNumPrimaryMags=2
	MaxNumPrimaryMags=4
	CurrentMagIndex=0
	bPlusOneLoading=true
	bHasBayonet=false

	//** Weapon Functionality **//
	bCanRestDeploy=false

	//** MG Functionality **//
  	ROBarrelClass = class'MG42Barrel'
  	bTrackBarrelHeat = true
  	BarrelSteamBone = barrel_switch
    bCanFireFromHip=false

	//** Inventory/Ammo **//
    PickupClass=class'MG42Pickup'
    AttachmentClass=class'MG42Attachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=PutAway
	// Reloading
	MagEmptyReloadAnim=Reload
	MagPartialReloadAnim=Reload
  	// Ironsites
  	IronBringUp=Rest_2_Bipod
  	IronIdleAnim=Bipod_Idle
	IronPutDown=Bipod_2_Rest
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

 	//** Ammo belt **//
    MGBeltBones(0)=Case09
    MGBeltBones(1)=Case08
    MGBeltBones(2)=Case07
    MGBeltBones(3)=Case06
    MGBeltBones(4)=Case05
    MGBeltBones(5)=Case04
    MGBeltBones(6)=Case03
    MGBeltBones(7)=Case02
    MGBeltBones(8)=Case01
    MGBeltBones(9)=Case
    BeltBulletClass=class'MG42BeltRound'
}
