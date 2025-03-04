//=============================================================================
// ROMeleeFire
//=============================================================================
// Base class for all Red Orchestra melee firing
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class ROMeleeFire extends ROWeaponFire
	abstract;

//=============================================================================
// Variables
//=============================================================================
var 		class<ROWeaponDamageType> 	DamageType;			// Bash damage type
var 		class<ROWeaponDamageType> 	BayonetDamageType;  // Bayo/stab damagetype
var() 		int 						DamageMin;          // Min damage from a bash
var() 		int 						DamageMax;          // Max damage from a bash
var() 		int 						BayonetDamageMin;   // Min damage from a bayo stab
var() 		int 						BayonetDamageMax;   // Max damage from a bayo stab
var() 		float 						TraceRange;         // How far to trace for a bash attack
var() 		float 						BayonetTraceRange;  // How far to trace for a bayo stab
var 		float 						MomentumTransfer;   // How much momentum to pass onto whatever we hit
var() 		float 						MinHoldTime;        // held for this time or less will do minimum damage/force. held for FullHeldTime will do max
var() 		float 						FullHeldTime;		// held for this long will do max damage
var()		float						MeleeAttackSpread;	// How "large" the impact area of the bayo strike is, the larger this is, the easier it is to hit, but the less precise the strike is

// Sounds
var()		sound						GroundStabSound;	// sound of stabbing the ground with the bayonet
var()		sound						GroundBashSound;	// sound of bashing the ground with the rifle butt
var()		sound						PlayerStabSound;	// sound of stabbing the player with the bayonet
var()		sound						PlayerBashSound;	// sound of bashing the player with the rifle butt

function float MaxRange()
{
	return TraceRange;
}

function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator R, Aim;

    Instigator.MakeNoise(1.0);

    // the to-hit trace always starts right in front of the eye
    StartTrace = Instigator.Location + Instigator.EyePosition();
    Aim = AdjustAim(StartTrace, AimError);
	R = rotator(vector(Aim) + VRand()*FRand()*Spread);
    DoTrace(StartTrace, R);
}

// Returns the Trace Range.
function float GetTraceRange()
{
	if( Weapon.bBayonetMounted )
    	return BayonetTraceRange;
    else
    	return TraceRange;
}

// Returns the Trace Range squared for cheaper comparisons.
function float GetTraceRangeSquared()
{
	if( Weapon.bBayonetMounted )
    	return BayonetTraceRange*BayonetTraceRange;
    else
    	return TraceRange*TraceRange;
}

// TODO: Work out the hit effect and sound system for this
function DoTrace(Vector Start, Rotator Dir)
{
	local Vector End, HitLocation, HitNormal;
	local Actor Other;
	local ROPawn HitPawn;
	local int Damage;
	local class<DamageType> ThisDamageType;
	local array<int>	HitPoints;
	local array<int>	DamageHitPoint;
	local float scale;
	local int i;
	local vector TempVec;
	local Vector	X, Y, Z;

    GetAxes(Dir, X, Y, Z);

	// HitPointTraces don't really like very short traces, so we have to do a long trace first, then see
	// if the player we hit was within range
	End = Start + 10000 * X;

    //Instigator.ClearStayingDebugLines();

	// do precision hit point trace to see if we hit a player or something else
	Other = Instigator.HitPointTrace(HitLocation, HitNormal, End, HitPoints, Start);

	// Debugging
	//log("VSize(Start-HitLocation) ="$VSize(Start-HitLocation));
 	//Instigator.DrawStayingDebugLine(Start, Start+GetTraceRange()* X, 0,255,0);

	if( Other == none || VSizeSquared(Start-HitLocation) > GetTraceRangeSquared())
	{
		for( i = 0; i < 4; i++ )
		{
			switch(i)
			{
				// Lower Left
				case 0:
					TempVec = (Start - MeleeAttackSpread * Y) - MeleeAttackSpread * Z;
					break;
				// Upper Right
				case 1:
					TempVec = (Start + MeleeAttackSpread * Y) + MeleeAttackSpread * Z;
					break;
				// Upper Left
				case 2:
					TempVec = (Start - MeleeAttackSpread * Y) + MeleeAttackSpread * Z;
					break;
				// Lower Right
				case 3:
					TempVec = (Start + MeleeAttackSpread * Y) - MeleeAttackSpread * Z;
					break;
			}

	        End = TempVec + 10000 * X;

	        Other = Instigator.HitPointTrace(HitLocation, HitNormal, End, HitPoints, TempVec);

	        // Debugging
			//Instigator.DrawStayingDebugLine(TempVec, TempVec+GetTraceRange()* X, 255,255,0);

 	        if( Other != none )
	        {
				if(VSizeSquared(Start-HitLocation) < GetTraceRangeSquared())
				{
                 	break;
				}
				else
				{
					Other = none;
				}
			}
		}
	}

	if(Other != none && (VSizeSquared(Start-HitLocation) > GetTraceRangeSquared()))
	{
		Other=None;
		return;
	}

	if( Other == none )
	{
		Other = Instigator.Trace(HitLocation, HitNormal, End, Start, true, );
		if(VSizeSquared(Start-HitLocation) > GetTraceRangeSquared())
		{
			Other=None;
			return;
		}

		if(Other != none && !Other.bWorldGeometry )
		{
			if( Other.IsA('Vehicle') )
			{
				if( Weapon.bBayonetMounted )
				{
			 		Weapon.PlaySound(GroundStabSound,SLOT_None,FireVolume,,,,false);
			 	}
			 	else
			 	{
			 		Weapon.PlaySound(GroundBashSound,SLOT_None,FireVolume,,,,false);
			 	}
		 	}

			Other=None;
			return;
		}
	}

	if ( Other != None && Other != Instigator && Other.Base != Instigator )
	{

		if( Weapon.bBayonetMounted )
		{
    		scale = (FClamp(HoldTime, MinHoldTime, FullHeldTime) - MinHoldTime) / (FullHeldTime - MinHoldTime); // result 0 to 1
			Damage = BayonetDamageMin + scale * (BayonetDamageMax - BayonetDamageMin);
			//log("Damage scale = "$scale$" Damage is "$Damage);
			ThisDamageType = BayonetDamageType;
		}
		else
		{
    		scale = (FClamp(HoldTime, MinHoldTime, FullHeldTime) - MinHoldTime) / (FullHeldTime - MinHoldTime); // result 0 to 1
			Damage = DamageMin + scale * (DamageMax - DamageMin);
			//log("Damage scale = "$scale$" Damage is "$Damage);
			ThisDamageType = DamageType;
		}

		if (!Other.bWorldGeometry)
		{
			// Update hit effect except for pawns (blood) other than vehicles.
           	if ( Other.IsA('Vehicle') || (!Other.IsA('Pawn') && !Other.IsA('HitScanBlockingVolume')) )
				WeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(Other, HitLocation, HitNormal);


			HitPawn = ROPawn(Other);

	    	if ( HitPawn != none )
	    	{
                 // Hit detection debugging
				 /*log("PreLaunchTrace hit "$HitPawn.PlayerReplicationInfo.PlayerName);
				 HitPawn.HitStart = Start;
				 HitPawn.HitEnd = End;*/

                 if(!HitPawn.bDeleteMe)
                 {
				 	DamageHitPoint[0]= HitPoints[HitPawn.GetHighestDamageHitIndex(HitPoints)];
				 	HitPawn.ProcessLocationalDamage(Damage, Instigator, HitLocation, MomentumTransfer*X,ThisDamageType,DamageHitPoint);
					if( Weapon.bBayonetMounted )
					{
				 		Weapon.PlaySound(PlayerStabSound,SLOT_None,FireVolume,,,,false);
				 	}
				 	else
				 	{
				 		Weapon.PlaySound(PlayerBashSound,SLOT_None,1.0,,,,false);
				 	}
				 }
                 // Hit detection debugging
				 //if( Level.NetMode == NM_Standalone)
				 //	  HitPawn.DrawBoneLocation();
	    	}
	    	else
	    	{
				if( Weapon.bBayonetMounted )
				{
			 		Weapon.PlaySound(GroundStabSound,SLOT_None,FireVolume,,,,false);
			 	}
			 	else
			 	{
			 		Weapon.PlaySound(GroundBashSound,SLOT_None,FireVolume,,,,false);
			 	}
				Other.TakeDamage(Damage, Instigator, HitLocation, MomentumTransfer*X, ThisDamageType);
			}

			HitNormal = Vect(0,0,0);
		}
		else
		{
			if( RODestroyableStaticMesh(Other) != none )
			{
				Other.TakeDamage(Damage, Instigator, HitLocation, MomentumTransfer*X, ThisDamageType);
			}

			if ( WeaponAttachment(Weapon.ThirdPersonActor) != None )
			{
				WeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(Other,HitLocation,HitNormal);
			}

			if( Weapon.bBayonetMounted )
			{
		 		Weapon.PlaySound(GroundStabSound,SLOT_None,FireVolume,,,,false);
		 	}
		 	else
		 	{
		 		Weapon.PlaySound(GroundBashSound,SLOT_None,FireVolume,,,,false);
		 	}
		}
	} // end of if ( Other != None && (Other != Instigator || ReflectNum > 0) )
	else
	{
		 HitLocation = End;
		 HitNormal = Vect(0,0,0);
	}

	return;
}

// Send the weapon to meleeattacking state instead of doing a regular fire
event ModeDoFire()
{
    if (!AllowFire())
        return;

	GotoState('MeleeAttacking');
}

// This state handles the melee attack by doing the actual melee damage
// at the end of the strike animation, giving a more realistic feel
simulated state MeleeAttacking
{
	simulated function bool AllowFire()
	{
	    return false;
	}

    simulated function Timer()
    {
    	GotoState('');
    }

	simulated function PerformFire()
	{
	    if (MaxHoldTime > 0.0)
	        HoldTime = FMin(HoldTime, MaxHoldTime);

	    // server
	    if (Weapon.Role == ROLE_Authority)
	    {
	        Weapon.ConsumeAmmo(ThisModeNum, Load);
	        DoFireEffect();
			HoldTime = 0;	// if bot decides to stop firing, HoldTime must be reset first
	        if ( (Instigator == None) || (Instigator.Controller == None) )
				return;

	        if ( AIController(Instigator.Controller) != None )
	            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);

	        Instigator.DeactivateSpawnProtection();
	    }


	    Weapon.IncrementFlashCount(ThisModeNum);

	    // set the next firing time. must be careful here so client and server do not get out of sync
	    if (bFireOnRelease)
	    {
	        if (bIsFiring)
	            NextFireTime += MaxHoldTime + FireRate;
	        else
	            NextFireTime = Level.TimeSeconds + FireRate;
	    }
	    else
	    {
	        NextFireTime += FireRate;
	        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
	    }

	    Load = AmmoPerFire;
	    HoldTime = 0;

	    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
	    {
	        bIsFiring = false;
	        Weapon.PutDown();
	    }
	}
    simulated function EndState()
    {
     	PerformFire();
     	ROPawn(Instigator).SetMeleeHoldAnims(false);

		if( Instigator.bIsSprinting )
		{
			ROWeapon(Weapon).SetSprinting(True);
		}

	    if (Instigator.IsLocallyControlled())
	    {
	     	PlayFireEnd();
     	}
	}

    simulated function BeginState()
    {
        PlayFiring();
	}
}

function PlayPreFire()
{
	if( Weapon.bBayonetMounted )
	{
		Weapon.PlayAnim(BayoBackAnim, 1.0, TweenTime);
	}
	else
	{
	    if( Weapon.AmmoAmount(0) < 1 && Weapon.HasAnim(BashBackEmptyAnim) )
	    {
			Weapon.PlayAnim(BashBackEmptyAnim, 1.0, TweenTime);
		}
		else
		{
			Weapon.PlayAnim(BashBackAnim, 1.0, TweenTime);
		}
    }
}

// Not using this for now
//simulated function PlayStartHold()
//{
//	if( Weapon.bBayonetMounted )
//	{
//		Weapon.LoopAnim(BayoHoldAnim, 1.0, TweenTime);
//	}
//	else
//	{
//	    if( Weapon.AmmoAmount(0) < 1 && Weapon.HasAnim(BashHoldEmptyAnim) )
//	    {
//			Weapon.PlayAnim(BashHoldEmptyAnim, 1.0, TweenTime);
//		}
//		else
//		{
//			Weapon.LoopAnim(BashHoldAnim, 1.0, TweenTime);
//		}
//    }
//}

function PlayFiring()
{
	local name Anim;

	if( Weapon.bBayonetMounted )
	{
		Anim = BayoStabAnim;
	}
	else
	{
	    if( Weapon.AmmoAmount(0) < 1 && Weapon.HasAnim(BashEmptyAnim) )
	    {
			Anim = BashEmptyAnim;
		}
		else
		{
			Anim = BashAnim;
		}
    }

	SetTimer(Weapon.GetAnimDuration(Anim, 1.0) + TweenTime,false);

    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
		Weapon.PlayAnim(Anim, FireAnimRate, TweenTime);
		// Put this back in if/when we get a bash sound
		//Weapon.PlayOwnedSound(FireSounds[Rand(FireSounds.Length)],SLOT_None,FireVolume,,,,false);

	    ClientPlayForceFeedback(FireForce);  // jdf
    }
    else // server
    {
        // Put this back in if/when we get a bash sound
		//ServerPlayFiring();
    }
}

function PlayFireEnd()
{
	if( Weapon.bBayonetMounted )
	{
		Weapon.PlayAnim(BayoFinishAnim, FireEndAnimRate, TweenTime);
	}
	else
	{
	    if( Weapon.AmmoAmount(0) < 1 && Weapon.HasAnim(BashFinishEmptyAnim))
	    {
			Weapon.PlayAnim(BashFinishEmptyAnim, FireEndAnimRate, TweenTime);
		}
		else
		{
			Weapon.PlayAnim(BashFinishAnim, FireEndAnimRate, TweenTime);
		}
    }
}

//// server propagation of firing ////
function ServerPlayFiring()
{
    Weapon.PlayOwnedSound(FireSounds[Rand(FireSounds.Length)],SLOT_None,FireVolume,,,,false);
}

defaultproperties
{
// RO Variables
	DamageMin = 25//55
  	DamageMax = 85//65
  	BayonetDamageMin=85
  	BayonetDamageMax=100
	MomentumTransfer = 100
	MinHoldtime=0.15
	FullHeldTime=0.6
	MeleeAttackSpread=2.5
	bMeleeMode=true
	GroundStabSound=sound'Inf_Weapons_Foley.melee.bayo_hit_ground'
	GroundBashSound=sound'Inf_Weapons_Foley.melee.butt_hit_ground'
	PlayerStabSound=sound'Inf_Weapons_Foley.melee.bayo_hit'
	PlayerBashSound=sound'Inf_Weapons_Foley.melee.butt_hit'

// UT Variables
	bInstantHit = true
	bFireOnRelease=true
	MaxHoldtime=0.0
  	AmmoPerFire = 0
  	FireRate = 0.5
  	Spread = 0
  	SpreadStyle = SS_Random
  	FireEndAnim = none
  	FireLoopAnim = none
  	bPawnRapidFireAnim = false
  	PreFireTime = 0.0
  	bModeExclusive = true
  	FireAnimRate=1.0
}

