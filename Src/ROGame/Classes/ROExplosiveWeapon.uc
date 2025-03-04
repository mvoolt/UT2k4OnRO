class ROExplosiveWeapon extends ROOneShotWeapon
	abstract;

var name	PreFireHoldAnim;	// Animation for holding the arm back ready to fire

var bool 	bPrimed;			// The nade is primed
var bool 	bHasReleaseLever;	// This explosive has a lever that must be released to arm the weapon
var bool 	bAlreadyExploded;	// The nade already blew up in your hands
var	float	FuzeLength;			// How long this grenade will take to go off
var	float	CurrentFuzeTime;	// How much fuse time is left

// sound
var() sound LeverReleaseSound;  // The sound of the lever being released on this weapon
var	  float	LeverReleaseVolume; // Volume of the lever being release
var	  float	LeverReleaseRadius; // Radius of the lever being release

var   int 	StartFireAmmoAmount;// Little hack so that we don't decrement ammo count client side if we've already recieved a net update from the server after firing

//=============================================================================
// replication
//=============================================================================

replication
{
	reliable if (bNetDirty && bNetOwner && Role == ROLE_Authority)
		bPrimed;

	reliable if (Role < ROLE_Authority)
		ServerArmExplosive, ServerCheckPawnCanFire;

	reliable if (Role == ROLE_Authority)
		ClientForcePawnCanFire;
}

// A couple of hacks to prevent the grenades getting stuck unable to fire when the
// PutWeaponAway state gets interrupted on the ROPawn. Remove these if we ever
// rip out and redo that system or come up with a better fix - Ramm
function ServerCheckPawnCanFire()
{
	//log("ROGrenadeWeapon::ServerCheckPawnCanFire() bPreventWeaponFire was "$ROPawn(Instigator).bPreventWeaponFire);
	if( !ROPawn(Instigator).bPreventWeaponFire )
		ClientForcePawnCanFire();
}

simulated function ClientForcePawnCanFire()
{
	//log("ROGrenadeWeapon::ClientForcePawnCanFire() setting bPreventWeaponFire to false bPreventWeaponFire was "$ROPawn(Instigator).bPreventWeaponFire);
	ROPawn(Instigator).bPreventWeaponFire = false;
}

function bool FillAmmo()
{
	local int InitialAmount;

	if( AmmoAmount(0) > 1 )
		return false;

    InitialAmount = FireMode[0].AmmoClass.Default.InitialAmount;

	AddAmmo(InitialAmount,0);

	return true;
}


simulated function AltFire(float F)
{
    //log("FireMode 0 is firing = "$FireMode[0].bIsFiring);

	if( bHasReleaseLever && FireMode[0].bIsFiring)
		ArmExplosive();
}

simulated function Fire(float F)
{
    //log("FireMode 0 is firing = "$FireMode[0].bIsFiring);

	if( bHasReleaseLever && FireMode[1].bIsFiring)
		ArmExplosive();
}

// called on the client to arm the explosive and play the lever release sounds
simulated function ArmExplosive()
{
 	if(Role == ROLE_Authority)
 	{
		if( !bPrimed)
		{

			bPrimed = true;

	        if( bHasReleaseLever )
		    	PlayOwnedSound(LeverReleaseSound,SLOT_None,LeverReleaseVolume,,LeverReleaseRadius,,false);
		}
 	}
 	else
 	{
        if( bHasReleaseLever )
	    	PlayOwnedSound(LeverReleaseSound,SLOT_None,LeverReleaseVolume,,LeverReleaseRadius,,false);

		if( !bPrimed)
		{
          	ServerArmExplosive();
        }
 	}
}

// Called on the server to arm the explosive, and play the lever release sound
function ServerArmExplosive()
{
	if( !bPrimed)
	{
		bPrimed = true;

	    if( bHasReleaseLever )
	 		PlayOwnedSound(LeverReleaseSound,SLOT_None,LeverReleaseVolume,,LeverReleaseRadius,,True);
	}
}

// used for when you throw a nade with a release lever, but you didn't release the lever
simulated function InstantPrime()
{
	if( !bPrimed)
	{
		bPrimed = true;

	    if( bHasReleaseLever )
	    {
	 		if( Instigator.IsLocallyControlled() )
	 		{
				PlayOwnedSound(LeverReleaseSound,SLOT_None,LeverReleaseVolume,,LeverReleaseRadius,,false);
			}
			else
			{
				PlayOwnedSound(LeverReleaseSound,SLOT_None,LeverReleaseVolume,,LeverReleaseRadius,,true);
			}
	 	}
	}
}


simulated function PostBeginPlay()
{
 	 super.PostBeginPlay();

	 CurrentFuzeTime = default.FuzeLength;
}

//// client & server ////
// Overriden to prevent another nade from being thrown instantly after the previous
// nade by pressing alternating fire/altfire buttons
simulated function bool StartFire(int Mode)
{
    local int alt;

    if (!ReadyToFire(Mode))
        return false;

    if (Mode == 0)
        alt = 1;
    else
        alt = 0;

    if (Instigator.IsLocallyControlled() && Level.Netmode == NM_Client )
    {
        StartFireAmmoAmount=AmmoAmount(Mode);
	}

    FireMode[Mode].bIsFiring = true;
    FireMode[Mode].NextFireTime = Level.TimeSeconds + FireMode[Mode].PreFireTime;

    if (FireMode[alt].bModeExclusive)
    {
        // prevents rapidly alternating fire modes
        FireMode[Mode].NextFireTime = FMax(FireMode[Mode].NextFireTime, FireMode[alt].NextFireTime);

        // Prevent rapidly fire/alt firing nades right after each other
        FireMode[alt].NextFireTime = Level.TimeSeconds + FireMode[Mode].FireRate;
    }

    if (Instigator.IsLocallyControlled())
    {
        if (FireMode[Mode].PreFireTime > 0.0 || FireMode[Mode].bFireOnRelease)
        {
            FireMode[Mode].PlayPreFire();
        }
        FireMode[Mode].FireCount = 0;
    }

    return true;
}

// Overriden because we manually set the fire time to right now each time an
// explosive weapon is drawn. This helps prevent grenades from getting
// thrown instantly after another one was thrown when rapidly alternating
// fire/altfire buttons
simulated state RaisingWeapon
{
	simulated function bool CanStartCrawlMoving()
	{
		return false;
	}

    simulated function BeginState()
    {
	   local int Mode;

	   super.BeginState();

	    for(Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
	    {
            FireMode[Mode].NextFireTime = Level.TimeSeconds;
	    }
    }

    simulated function EndState()
    {
		local int Mode;

		// Clear any prevent weapon fire flags after the weapon is completely raised
		if( Role < ROLE_Authority )
		{
			if( Instigator != none && ROPawn(Instigator) != none && AmmoAmount(0) < 1)
			{
				ROPawn(Instigator).bPreventWeaponFire = false;
			}
			else if( Instigator != none && ROPawn(Instigator) != none )
			{
				ServerCheckPawnCanFire();
			}
		}

	    if (ClientState == WS_BringUp)
	    {
			for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
		       FireMode[Mode].InitEffects();
	    }
    }
}

simulated function PostFire()
{
	bPrimed = false;
    CurrentFuzeTime = default.FuzeLength;
    bAlreadyExploded = false;

 	GotoState('PostFiring');
}

simulated state PostFiring
{
	simulated function bool IsBusy()
	{
		return true;
	}

	simulated function bool CanStartCrawlMoving()
	{
		return false;
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

	simulated function bool WeaponCanBusySwitch()
	{
		if( ClientState == WS_PutDown )
			return true;

		return super.WeaponCanSwitch();
	}

	simulated function bool CanStartCrawlMoving()
	{
		return false;
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
	        }

	        ClientState = WS_PutDown;
	    }

	    SetTimer(0.01,false);

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
}

// Overriden to fix the problem where a client would start switching weapons before
// the server finished auto lowering the weapon. Now delete his weapon here if
// autolowerweapno has been interupped by a weapon switch
simulated state LoweringWeapon
{
    simulated function BeginState()
    {
	    local int Mode;

		if( Role == ROLE_Authority && AmmoAmount(0) < 1 && !bDeleteMe)
		{
		    Gotostate('Idle');
			SelfDestroy();
		}

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
					PlayAnim(PutDownAnim, PutDownAnimRate, 0.0);
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

		if( bDeleteMe)
			return;

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
				if ( Instigator.Weapon == self )
				{
					PlayIdle();
					ClientState = WS_ReadyToFire;
				}
				else
				{
					for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
						FireMode[Mode].DestroyEffects();
				}
			}
	    }
    }
}

// Overriden to support our held back anims for throwing nades
simulated function AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if (ClientState == WS_ReadyToFire)
    {
        if (anim == FireMode[0].PreFireAnim && HasAnim(PreFireHoldAnim)) // grenade hack
        {
            LoopAnim(PreFireHoldAnim, IdleAnimRate, 0.2 );
        }
        else if (anim== FireMode[1].PreFireAnim && HasAnim(PreFireHoldAnim))
        {
            LoopAnim(PreFireHoldAnim, IdleAnimRate, 0.2 );
        }
    }

    super.AnimEnd(channel);
}

simulated function int GetHudAmmoCount()
{
	return AmmoAmount(0);
}


simulated function SetSprinting(bool bNewSprintStatus)
{
	local int mode;

	for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
	{
		if( FireMode[Mode] != none && FireMode[Mode].bIsFiring)
		{
			return;
		}
	}

	if( bNewSprintStatus && !IsInState('WeaponSprinting') && !IsInState('RaisingWeapon') &&
		!IsInState('LoweringWeapon') && ClientState != WS_PutDown && ClientState != WS_Hidden &&
		!IsInState('PostFiring') && !IsInState('AutoLoweringWeapon') )
	{
		GotoState('StartSprinting');
	}
	else if ( !bNewSprintStatus && IsInState('WeaponSprinting') ||
		IsInState('StartSprinting') )
	{
		GotoState('EndSprinting');
	}

}

simulated state WeaponSprinting
{
	simulated event ClientStartFire(int Mode)
	{
	    if ( Pawn(Owner).Controller.IsInState('GameEnded') || Pawn(Owner).Controller.IsInState('RoundEnded') )
	        return;

	    if (Role < ROLE_Authority)
	    {
	        if (StartFire(Mode))
	        {
	            ServerStartFire(Mode);
	        }
	    }
	    else
	    {
	        StartFire(Mode);
	    }
	}

	simulated function bool ReadyToFire(int Mode)
	{
		return global.ReadyToFire(Mode);
	}

    simulated function PlayIdle()
    {
		local float LoopSpeed;
		local float Speed2d;
		local name Anim;
		local int Mode;

		if( Instigator.IsLocallyControlled() )
		{
			// Make the sprinting animation match the sprinting speed
	        LoopSpeed=1.5;

			Speed2d = VSize(Instigator.Velocity);
			LoopSpeed = ((Speed2d/(Instigator.Default.GroundSpeed * Instigator.SprintPct))*1.5);

			Anim = SprintLoopAnim;

			for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
			{
				if( FireMode[Mode] != none && FireMode[Mode].bIsFiring)
				{
					Anim = PreFireHoldAnim;
				}
			}

			if( HasAnim(Anim) )
	    		LoopAnim( Anim, LoopSpeed, 0.2);
		}
	}

}

defaultproperties
{
	Priority=3
}
