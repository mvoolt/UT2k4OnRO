//===================================================================
// ROPanzerFaustbase
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// The panzerfaust 60 weapon
//===================================================================
class PanzerFaustWeapon extends RORocketWeapon;

#exec OBJ LOAD FILE=..\Animations\Axis_Panzerfaust_1st.ukx

var() 	int 		Ranges[3];				// The angle to launch the projectile at different ranges (30,60,80 meters)
var 	int 		RangeIndex;             // Current range setting
var 	name		IronIdleAnimOne;        // Iron idle animation for range setting one
var 	name		IronIdleAnimTwo;        // Iron idle animation for range setting two
var 	name		IronIdleAnimThree;      // Iron idle animation for range setting three

//=============================================================================
// replication
//=============================================================================
replication
{
	reliable if( Role<ROLE_Authority )
		ServerSetRange;

}

// Overridden to support cycling the panzerfaust aiming ranges
simulated exec function Deploy()
{
	if( IsBusy() )
		return;

	CycleRange();
}

// switch the panzerfaust aiming ranges
simulated function CycleRange()
{
	if( RangeIndex < 2 )
	{
		RangeIndex++;
	}
	else
	{
		RangeIndex=0;
	}

	ROProjectileFire(FireMode[0]).AddedPitch = Ranges[RangeIndex];

	if(Instigator.IsLocallyControlled())
	{
		PlayIdle();
	}

	if( Role < ROLE_Authority)
		ServerSetRange(RangeIndex);
}

// Switch the panzerfaust aiming ranges on the server
function ServerSetRange(int NewIndex)
{
	RangeIndex=NewIndex;

	ROProjectileFire(FireMode[0]).AddedPitch = Ranges[RangeIndex];
}

// Ovveriden to play the panzerfaust animations for different ranges
simulated function PlayIdle()
{
	local name Anim;

	if( bUsingSights )
	{
		switch(RangeIndex)
		{
			case 0:
				Anim = IronIdleAnimOne;
				break;
			case 1:
				Anim = IronIdleAnimTwo;
				break;
			case 2:
				Anim = IronIdleAnimThree;
				break;
		}

		LoopAnim(Anim, IdleAnimRate, 0.2 );
	}
	else
	{
		LoopAnim(IdleAnim, IdleAnimRate, 0.2 );
	}
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	local int m;
	local weapon w;
	local bool bPossiblySwitch, bJustSpawned;

	Instigator = Other;
	W = Weapon(Instigator.FindInventoryType(class));
	if ( W == None || W.Class != Class ) // added class check because somebody made FindInventoryType() return subclasses for some reason
	{
		bJustSpawned = true;
		super(Inventory).GiveTo(Other);
		bPossiblySwitch = true;
		W = self;
	}
	else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;

	if ( Pickup == None )
		bPossiblySwitch = true;

	for (m = 0; m < NUM_FIRE_MODES; m++)
	{
		if ( FireMode[m] != None )
		{
			FireMode[m].Instigator = Instigator;

			if( Ammo(Pickup) != none )
			{
				PanzerFaustWeapon(W).GiveAmmoPickupAmmo(m,Ammo(Pickup),bJustSpawned);
			}
			else
			{
				W.GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
			}
		}
	}

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);

	if ( !bJustSpawned )
	{
		for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

function GiveAmmoPickupAmmo(int m, Ammo AP, bool bJustSpawned)
{
	local bool bJustSpawnedAmmo;
	local int addAmount, InitialAmount, i;

	if ( FireMode[m] != None && FireMode[m].AmmoClass != None )
	{
		Ammo[m] = Ammunition(Instigator.FindInventoryType(FireMode[m].AmmoClass));
		bJustSpawnedAmmo = false;

		if ( (FireMode[m].AmmoClass == None) || ((m != 0) && (FireMode[m].AmmoClass == FireMode[0].AmmoClass)) )
			return;

		InitialAmount = FireMode[m].AmmoClass.Default.InitialAmount;

		if( bJustSpawned && AP == None)
		{
			PrimaryAmmoArray.Length = MaxNumPrimaryMags;
			for( i=0; i<PrimaryAmmoArray.Length; i++ )
			{
				PrimaryAmmoArray[i] = InitialAmount;
			}
			CurrentMagIndex=0;
			CurrentMagCount = PrimaryAmmoArray.Length - 1;
		}

		if ( (AP != None)  )
		{
			InitialAmount = AP.AmmoAmount;
			PrimaryAmmoArray[PrimaryAmmoArray.Length] = InitialAmount;
		}

		if ( Ammo[m] != None )
		{
			addamount = InitialAmount + Ammo[m].AmmoAmount;
			Ammo[m].Destroy();
		}
		else
			addAmount = InitialAmount;

		AddAmmo(addAmount,m);
	}
}

function DropFrom(vector StartLocation)
{
	local int m, i;
	local Pickup Pickup;
	local rotator R;

	if (!bCanThrow )
		return;

	if( Instigator != none && bUsingSights )
	{
		bUsingSights = false;
		ROPawn(Instigator).SetIronSightAnims(false);
	}

	ClientWeaponThrown();

	for (m = 0; m < NUM_FIRE_MODES; m++)
	{
		if (FireMode[m].bIsFiring)
			StopFire(m);
	}

	if ( Instigator != None )
	{
		DetachFromPawn(Instigator);
	}

	// Destroy empty weapons without pickups if needed (panzerfaust, etc)
	if( AmmoAmount(0) < 1 )
	{
	 	Destroy();
	}
	else
	{
		for ( i=0; i<AmmoAmount(0); i++ )
		{
			R.Yaw = rand(65536);
			Pickup = Spawn(PickupClass,,, StartLocation,R);
			if ( Pickup != None )
			{
		    	Pickup.InitDroppedPickupFor(self);
			    Pickup.Velocity = Velocity >> R;

		        if (Instigator.Health > 0)
		            WeaponPickup(Pickup).bThrown = true;

		        Pickup = none;
		    }
		}

	   	Destroy();
	}
}

function bool HandlePickupQuery( pickup Item )
{
	local WeaponPickup wpu;
	local int i;

	if ( bNoAmmoInstances )
	{
		// handle ammo pickups
		for ( i=0; i<2; i++ )
		{
			if ( (item.inventorytype == AmmoClass[i]) && (AmmoClass[i] != None) )
			{
				if ( AmmoCharge[i] >= MaxAmmo(i) )
					return true;

				item.AnnouncePickup(Pawn(Owner));
				AddAmmo(Ammo(item).AmmoAmount, i);
				item.SetRespawn();
				return true;
			}
			else if ( WeaponPickup(item) != none && item.inventorytype == class && (AmmoClass[i] != None) )
			{
				if ( AmmoCharge[i] >= MaxAmmo(i) || WeaponPickup(item).AmmoAmount[i] < 1 )
					return true;

				item.AnnouncePickup(Pawn(Owner));
				AddAmmo(WeaponPickup(item).AmmoAmount[i], i);
				item.SetRespawn();
				return true;
			}
		}
	}

	if (class == Item.InventoryType)
	{
		wpu = WeaponPickup(Item);
		if (wpu != None)
			return !wpu.AllowRepeatPickup();
		else
			return false;
	}

	// Avoid multiple weapons in the same slot
	if (Item.InventoryType.default.InventoryGroup == InventoryGroup)
		return true;

	if ( Inventory == None )
		return false;

	return Inventory.HandlePickupQuery(Item);
}

simulated function PostBeginPlay()
{
	local Vector RocketLoc;

	super.PostBeginPlay();

	if ( Level.NetMode != NM_DedicatedServer )
	{

	   RocketLoc = GetBoneCoords('Warhead').Origin;

   	   RocketAttachment = Spawn(class 'ROFPAmmoRound',self,, RocketLoc);

	   AttachToBone(RocketAttachment, 'Warhead');
	}
}


simulated function BringUp(optional Weapon PrevWeapon)
{
	local Vector RocketLoc;

	super.BringUp(PrevWeapon);

	if ( Level.NetMode != NM_DedicatedServer )
	{
		if (/*WP != None && WP.AmmoAmount[m] < 1 && */AmmoAmount(0) < 1)
		{
			//log("Destroyed the fp ammoround");
			if (RocketAttachment != None)
				RocketAttachment.Destroy();
		}
		else
		{

		   //log("didnt Destroyed the fp ammoround");
		   if (RocketAttachment == None)
		   {

	           RocketLoc = GetBoneCoords('Warhead').Origin;

   	           RocketAttachment = Spawn(class 'ROFPAmmoRound',self,, RocketLoc);

			   AttachToBone(RocketAttachment, 'Warhead');
		   }
		}
	}
}

simulated function int GetHudAmmoCount()
{
	return AmmoAmount(0);
}

// Get the coords for the muzzle bone. Used for free-aim projectile spawning
function coords GetMuzzleCoords()
{
	// have to update the location of the weapon before getting the coords
	SetLocation( Instigator.Location + Instigator.CalcDrawOffset(self) );
	return GetBoneCoords('Warhead');
}

simulated state PostFiring
{
	simulated function bool IsBusy()
	{
		return true;
	}

	simulated function Timer()
	{
		GotoState('AutoLoweringWeapon');
	}

	simulated function BeginState()
	{
	    SetTimer(GetAnimDuration(FireMode[0].FireAnim, 1.0),false);
	}

	simulated function EndState()
	{
		if (ROWeaponAttachment(ThirdPersonActor) != None)
		{
			ROWeaponAttachment(ThirdPersonActor).AmbientSound = None;
		}

	    OldWeapon = None;
	}
}


simulated function PostFire()
{
 	GotoState('PostFiring');
}


//------------------------------------------------------------------------------
// SelfDestroy(RO) - This is run server-side, it will destroy a weapon in a
//	player's inventory without spawning a pickup.
//------------------------------------------------------------------------------
function SelfDestroy()
{
	local int m;

	for(m = 0; m < NUM_FIRE_MODES; m++)
	{
		if (FireMode[m].bIsFiring)
			StopFire(m);
	}

	if( Instigator != none )
	{
		DetachFromPawn(Instigator);
	}

	ClientWeaponThrown();
	Destroy();
}


simulated state AutoLoweringWeapon
{
	simulated function bool WeaponCanSwitch()
	{
		if( ClientState == WS_PutDown )
			return true;

		if( IsBusy() || Instigator.bBipodDeployed )
		{
			return false;
		}

		return super.WeaponCanSwitch();
	}

	simulated function bool IsBusy()
	{
		return true;
	}

	simulated function Timer()
	{
    	local inventory Inv;
		local int i;
		local bool bFoundOtherWeapon;

		if (AmmoAmount(0) > 0)
		{
			Instigator.PendingWeapon = self;
			BringUp(self);

			if ( Role == ROLE_Authority && ThirdPersonActor != None)
			{
				ThirdPersonActor.LinkMesh( ThirdPersonActor.default.Mesh );
			}
		}
		else
		{
			for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
			{
				if ( (Weapon(Inv) != None) )
				{
					if( Inv != self )
					{
						bFoundOtherWeapon = true;
						break;
					}
				}
				i++;
				if ( i > 500 )
					break;
			}

			if (bFoundOtherWeapon && Instigator.IsLocallyControlled())
	        {
	        	Instigator.Controller.SwitchToBestWeapon();
			}
			else
			{
			 	GotoState('Idle');
			}
		}
	}

	simulated function BeginState()
	{
	    local int Mode;

	    if (ClientState == WS_BringUp || ClientState == WS_ReadyToFire)
	    {
/*	        if ( (Instigator.PendingWeapon != None) && !Instigator.PendingWeapon.bForceSwitch )
	        {
	            for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
	            {
	                //if ( FireMode[Mode].bFireOnRelease && FireMode[Mode].bIsFiring )
	                //    return false;
	                if ( FireMode[Mode].NextFireTime > Level.TimeSeconds + FireMode[Mode].FireRate*(1.f - MinReloadPct))
						DownDelay = FMax(DownDelay, FireMode[Mode].NextFireTime - Level.TimeSeconds - FireMode[Mode].FireRate*(1.f - MinReloadPct));
	            }
	        }*/

	        if (Instigator.IsLocallyControlled())
	        {

	            for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
	            {
	                if ( FireMode[Mode].bIsFiring )
	                    ClientStopFire(Mode);
	            }

				if ( ClientState == WS_BringUp )
					TweenAnim(SelectAnim,PutDownTime);
				else if ( HasAnim(PutDownAnim) )
					PlayAnim(PutDownAnim, PutDownAnimRate, FastTweenTime);
	        }

	        ClientState = WS_PutDown;
	    }

	    SetTimer(GetAnimDuration(PutDownAnim, PutDownAnimRate),false);

	    for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
	    {
			FireMode[Mode].bServerDelayStartFire = false;
			FireMode[Mode].bServerDelayStopFire = false;
		}
	}

	simulated function EndState()
	{
		local int Mode;

		if (ClientState == WS_PutDown)
	    {
			if ( Instigator.PendingWeapon == none )
			{
				PlayIdle();
				ClientState = WS_ReadyToFire;
			}
			else
			{
				ClientState = WS_Hidden;
				Instigator.ChangedWeapon();
				for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
					FireMode[Mode].DestroyEffects();
			}
	    }

		if( Role == ROLE_Authority && AmmoAmount(0) < 1 && !bDeleteMe)
		{
		    Gotostate('Idle');
			SelfDestroy();
		}
	}
// Take the player out of iron sights if they are in ironsights
Begin:
	if( bUsingSights )
	{
		if( Role == ROLE_Authority)
			ServerZoomOut(false);
		else
			ZoomOut(False);

		if( Instigator.IsLocallyControlled() && Instigator.IsHumanControlled())
		{
			SmoothZoom(false);
		}
	}
}



//
//simulated function bool AllowClientStartFire(int mode)
//{
//    local bool canFire;
//
//    canFire = True;
//
//    if(RocketAttachment == None)
//    {
//        canFire = False;
//    }
//
//	return canFire;
//}
//
//
///*simulated state FireAnimPlay
//{
//	simulated function BeginState()
//	{
//		SetServerWeaponState( GetStateName() );
//	}
//
//    simulated function EndState()
//    {
//        ClientState = WS_ReadyToFire;
//        bWeaponAllowsSprint = true;
//
//    }
//}*/

simulated state RaisingWeapon
{
	simulated function BeginState()
	{
		local ROPlayer player;

		super.BeginState();

		// Hint check
		player = ROPlayer(Instigator.Controller);
		if (player != none)
			player.CheckForHint(12);
	}
}

function float GetAIRating()
{
	local Bot B;
	local float ZDiff, dist, Result;

	B = Bot(Instigator.Controller);

	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	if (Vehicle(B.Enemy) == None)
		return 0;

	result = AIRating;
	ZDiff = Instigator.Location.Z - B.Enemy.Location.Z;
	if ( ZDiff > -300 )
		result += 0.2;
	dist = VSize(B.Enemy.Location - Instigator.Location);
	if ( dist > 400 && dist < 6000)
		return ( FMin(2.0,result + (6000 - dist) * 0.0001) );

	return result;
}

defaultproperties
{
	//** Info **//
	ItemName="Panzerfaust"

	//** Display **//
	Mesh=mesh'Axis_Panzerfaust_1st.Panzerfaust_mesh'
	DrawScale=1.0
	DisplayFOV=70
	IronSightDisplayFOV=25
	BobDamping=1.6
	BayonetBoneName=Bayonet
	HighDetailOverlay=Material'Weapons1st_tex.Grenades.Panzerfaust_S'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2

	//** Weapon Firing **//
	FireModeClass(0)=PanzerFaustFire
	FireModeClass(1)=PanzerFaustMeleeFire
	MaxNumPrimaryMags=1
	CurrentMagIndex=0
	bPlusOneLoading=false
	bHasBayonet=false
	Ranges(0)=-100
	Ranges(1)=800
	Ranges(2)=1400
	RangeIndex=0

	//** Weapon Functionality **//
	bCanRestDeploy=false

	//** Inventory/Ammo **//
	PickupClass=class'PanzerFaustPickup'
	AttachmentClass=class'PanzerFaustAttachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
	PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=PutAway
  	// Ironsites
  	IronBringUp=iron_in
	IronPutDown=iron_out
	IronIdleAnimOne=Iron_idle30
	IronIdleAnimTwo=Iron_idle
	IronIdleAnimThree=Iron_idle90
	IronSwitchAnimRate=1.0
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out

	 //** Zooming **//
	ZoomInTime=0.4
	ZoomOutTime=0.2

	//** Bot/AI **//
	AIRating=+0.6
	CurrentRating=0.6
	bSniping=false // So bots will use this weapon to take long range shots

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
}
