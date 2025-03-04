//-----------------------------------------------------------
//
//-----------------------------------------------------------
class VehicleWeapon extends Actor
	native
	nativereplication
	abstract;

cpptext
{
	INT* GetOptimizedRepList(BYTE* Recent, FPropertyRetirement* Retire, INT* Ptr, UPackageMap* Map, UActorChannel* Channel);
	virtual UBOOL Tick(FLOAT DeltaTime, enum ELevelTick TickType);
	virtual void PostNetReceive();
	FVector GetAimStart() const;
	virtual UBOOL SetAim(FVector HitLocation, FRotator ForwardRotation);
	INT LimitPitch(INT Pitch, FRotator ForwardRotation, INT WeaponYaw);
	void PostRender(FLevelSceneNode* SceneNode, FRenderInterface* RI);
	virtual FLOAT GetAmbientVolume(FLOAT Attenuation);
	INT CustomLimitPitch(INT Pitch);
	INT LimitYaw(INT Yaw);
}

// Weapon Bone Rotation System
var()   name                                YawBone;
var()   float                               YawStartConstraint;
var()   float                               YawEndConstraint;
var     float                               YawConstraintDelta;
var()   name                                PitchBone;
var()   int                                 PitchUpLimit;
var()   int                                 PitchDownLimit;
var     rotator                             CurrentAim;
var     vector                              WeaponFireLocation;
var     rotator                             WeaponFireRotation;

var()   name                                WeaponFireAttachmentBone;
var()   name                                GunnerAttachmentBone;
var()   float                               WeaponFireOffset;
var()   float                               DualFireOffset;
var     vector                              WeaponOffset;
var()	vector								AltFireOffset;				// Fire offset for the alt fire mode

var     rotator         LastRotation;
var     float           RotationsPerSecond;

// Bools
var	    bool	bInstantRotation; //NOTE: Gradual rotation via RotationsPerSecond still used for non-owning net clients to smooth rotation changes
var     bool    bActive;
var()   bool    bInstantFire;
var()   bool    bDualIndependantTargeting;  // When using a DualFireOffset each shot will be independantly targeted at the crosshair
var     bool    bShowChargingBar;
var     bool    bCallInstigatorPostRender; //if Instigator exists, during this actor's native PostRender(), call Instigator->PostRender() (used when weapon is visible but owner is bHidden)
var     bool    bForceCenterAim;
var()   bool    bAimable;
var	    bool    bDoOffsetTrace; //trace from outside vehicle's collision back towards weapon to determine firing offset
var()   bool    bAmbientFireSound;
var()   bool    bAmbientAltFireSound;
var()   bool    bInheritVelocity;
var		bool	bIsAltFire;
var		bool	bIsRepeatingFF;
var()   bool    bReflective;
var()   bool    bShowAimCrosshair; // Show the crosshair that indicates whether aim is good or not
var	const bool	bCorrectAim;	// output variable - set natively - means gun can hit what controller is aiming at

// Aiming
var()	float	FireIntervalAimLock; //fraction of FireInterval/AltFireInterval during which you can't move the gun
var	float		AimLockReleaseTime; //when this time is reached gun can move again
var vector      CurrentHitLocation;
var float		Spread;
var float		AltFireSpread;
var float       AimTraceRange;

// Impact/Damage
var     vector                              LastHitLocation; // Location of the last hit effect
var     byte                                FlashCount;      // Incremented each frame of firing
var     byte                                OldFlashCount;   // Stores the last FlashCount received
var     byte                                HitCount;        // Incremented each time a hit effect occurs
var     byte                                OldHitCount;     // Stores the last HitCount received
var		byte								FiringMode;		 // replicated to identify what type of firing effects to play
// Timing
var()   float           FireInterval, AltFireInterval;
var     float           FireCountdown;

// Effects
var()   class<Emitter>					FlashEmitterClass;
var     Emitter							FlashEmitter;
var()   class<Emitter>					EffectEmitterClass;
var     Emitter							EffectEmitter;
var()   class<WeaponAmbientEmitter>  	AmbientEffectEmitterClass;
var     WeaponAmbientEmitter			AmbientEffectEmitter;
var()	bool							bAmbientEmitterAltFireOnly; // Only use the ambient emitter for altfire

// Sound
var()   sound           FireSoundClass;
var()   float           FireSoundVolume;
var()   float           FireSoundRadius;
var()	float           FireSoundPitch;
var()   sound           AltFireSoundClass;
var()   float           AltFireSoundVolume;
var()   float           AltFireSoundRadius;
var()	float			AltFireSoundScaling;
var()   sound           RotateSound;
var		float			RotateSoundThreshold;		// threshold in rotator units for RotateSound to play
var()   float           AmbientSoundScaling;
var()	sound			FireEndSound;				// Fire sound tail for ambient firing sounds
var()	sound			AltFireEndSound;			// Fire sound tail for ambient altfiring sounds

// Force Feedback //
var()	string			FireForce;
var()	string			AltFireForce;

// Instant Fire Stuff
var class<DamageType>   DamageType;
var int                 DamageMin, DamageMax;
var float               TraceRange;
var float               Momentum;

// Projectile Fire Stuff
var()   class<Projectile>   ProjectileClass;
var()   class<Projectile>   AltFireProjectileClass;
var	array<Projectile> Projectiles; //ignore these when doing third person aiming trace (only necessary if projectiles fired have bProjTarget==true)

// camera shakes //
var() vector            ShakeRotMag;           // how far to rot view
var() vector            ShakeRotRate;          // how fast to rot view
var() float             ShakeRotTime;          // how much time to rot the instigator's view
var() vector            ShakeOffsetMag;        // max view offset vertically
var() vector            ShakeOffsetRate;       // how fast to offset view vertically
var() float             ShakeOffsetTime;       // how much time to offset view

// Camera shake for alt fire mode
var() vector            AltShakeRotMag;        // how far to rot view
var() vector            AltShakeRotRate;       // how fast to rot view
var() float             AltShakeRotTime;       // how much time to rot the instigator's view
var() vector            AltShakeOffsetMag;     // max view offset vertically
var() vector            AltShakeOffsetRate;    // how fast to offset view vertically
var() float             AltShakeOffsetTime;    // how much time to offset view

// AI
struct native VehicleWeaponAIInfo
{
	var bool bTossed, bTrySplash, bLeadTarget, bInstantHit, bFireOnRelease;
	var float AimError, WarnTargetPct, RefireRate;
};
var VehicleWeaponAIInfo AIInfo[2];
var FireProperties SavedFireProperties[2];

//// DEBUGGING ////
var string  DebugInfo;

// if _RO_
var		bool	bRotateSoundFromPawn;	// This weapon gets its rotate sound from the pawn so don't play its own (unles bot controlled)
var()   int     CustomPitchUpLimit;   	// Local Space Pitch up limit used for tank cannons themselves. Independent of the view limits
var()   int     CustomPitchDownLimit;   // Local Space Pitch down limit used for tank cannons themselves. Independent of the view limits
var		bool	bUseTankTurretRotation;	// This weapon uses special tank turret rotation code

var() int MaxPositiveYaw; // Max angle the weapon can rotate in the positive yaw direction
var() int MaxNegativeYaw; // Max angle the weapon can rotate in the Negative yaw direction
var() bool bLimitYaw;     // We want to limit yaw for this weapon

// Special cannon aiming
var	  byte 	CurrentRangeIndex; 	// The current range setting for a tank cannon. Used for range settings for aiming
var	  name	BeginningIdleAnim;	// The animation to play when the vehicle is first spawned and when a player enter/exits the vehicle

// Ammunition
var int MainAmmoCharge[2];		// Ammo for this weapon.
var int AltAmmoCharge;  		// Alt Ammo for this weapon (Ammo consumed using Alt-Fire)

var()	int	InitialPrimaryAmmo; 	// Beginning ammo for the primary ammo type
var()	int	InitialSecondaryAmmo;   // Beginning ammo for the secondary ammo type
var()	int	InitialAltAmmo;         // Beginning ammo for the alt ammo type

// _RO_
var		bool				bMultipleRoundTypes; 		// This weapon has multiple projectile types (uses ProjectileClass if this is false)
var()   class<Projectile>   PrimaryProjectileClass; 	// Primary ProjectileClass that this weapon fires
var()   class<Projectile>   SecondaryProjectileClass;   // Secondary ProjectileClass that this weapon fires
var		bool 				bPrimaryIgnoreFireCountdown;// When true the primary weapon will fire regardless of fire countdown. Used for tank cannon with coaxial MGs.
var     bool                bFiredPendingPrimary;       // Have fired a pending primary shot


replication
{
	reliable if (bNetDirty && !bNetOwner && Role == ROLE_Authority)
		CurrentHitLocation, FlashCount, FiringMode;
	reliable if (bNetDirty && Role == ROLE_Authority)
		HitCount, LastHitLocation, bActive, bForceCenterAim, bCallInstigatorPostRender/*, AmbientSoundScaling*/;
	// if _RO_
	reliable if (bNetDirty && bNetOwner && Role == ROLE_Authority)
		ProjectileClass, CurrentRangeIndex, MainAmmoCharge, AltAmmoCharge;
	reliable if ( bNetInitial && Role==ROLE_Authority)
		bLimitYaw;
}

native function int LimitPitch(int Pitch, rotator ForwardRotation, optional int WeaponYaw);

// if _RO_
native function int CustomLimitPitch(int Pitch);
// Get a description of the round loaded in this weapon. Implemented in subclasses
simulated function string GetRoundDescription(){return "";}

// For tank cannon aiming. Returns the current range setting for this gun. Implemented in subclasses
simulated function int GetRange(){return 0;}
// For tank cannon aiming. Implemented in subclasses
function IncrementRange(){}
function DecrementRange(){}
// end _RO_

// Ammo Management

// Returns true if the weapon has ammo for this firing mode
simulated function bool HasAmmo(int Mode)
{
	switch(Mode)
	{
		case 0:
			return (MainAmmoCharge[0] > 0);
			break;
		case 1:
			return (MainAmmoCharge[1] > 0);
			break;
		case 2:
			return (AltAmmoCharge > 0);
			break;
		default:
			return false;
	}

	return false;
}

// Returns true if this weapon is ready to fire
simulated function bool ReadyToFire(bool bAltFire)
{
	local int Mode;

	if(	bAltFire )
		Mode = 2;
	else if (ProjectileClass == PrimaryProjectileClass)
		Mode = 0;
	else if (ProjectileClass == SecondaryProjectileClass)
		Mode = 1;

	if( HasAmmo(Mode) )
		return true;

	return false;
}

// Returns the Primary ammo count (overriden in subclasses for multiple ammo types )
simulated function int PrimaryAmmoCount()
{
	if( bMultipleRoundTypes )
	{
		if (ProjectileClass == PrimaryProjectileClass)
	        return MainAmmoCharge[0];
	    else if (ProjectileClass == SecondaryProjectileClass)
	        return MainAmmoCharge[1];
	}
	else
	{
		return MainAmmoCharge[0];
	}
}

simulated function int AltAmmoCount()
{
	return AltAmmoCharge;
}

simulated function bool ConsumeAmmo(int Mode)
{
	if( !HasAmmo(Mode) )
		return false;

	switch(Mode)
	{
		case 0:
			MainAmmoCharge[0]--;
			return true;
		case 1:
			MainAmmoCharge[1]--;
			return true;
		case 2:
			AltAmmoCharge--;
			return true;
		default:
			return false;
	}

	return false;
}

// Fill the ammo up to the initial ammount. Returns false if this wasn't a resupply
function bool GiveInitialAmmo()
{
	// If we don't need any ammo return false
	if( MainAmmoCharge[0] == InitialPrimaryAmmo && MainAmmoCharge[1] == InitialSecondaryAmmo
		&& AltAmmoCharge == InitialAltAmmo)
	{
		return false;
	}

	MainAmmoCharge[0] = InitialPrimaryAmmo;
	MainAmmoCharge[1] = InitialSecondaryAmmo;
	AltAmmoCharge = InitialAltAmmo;

	return true;
}


simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
	local name  Sequence;
	local float Frame, Rate;

//	Super.DisplayDebug(Canvas, YL, YPos);

	Canvas.SetDrawColor(255,255,255);
	Canvas.DrawText("bActive: "$bActive@"bCorrectAim: "$bCorrectAim);
	YPos += YL;
	Canvas.SetPos(4, YPos);
	Canvas.DrawText("DebugInfo: "$DebugInfo);

	GetAnimParams( 0, Sequence, Frame, Rate );
	Canvas.DrawText(" Anim: Frame("@Frame@") Rate("@Rate@") Name("@Sequence@")");
	YPos += YL;
	Canvas.SetPos(4,YPos);

	Canvas.DrawText(" Mesh: "@Mesh);
	YPos += YL;
	Canvas.SetPos(4,YPos);
}

simulated function PostBeginPlay()
{
	YawConstraintDelta = (YawEndConstraint - YawStartConstraint) & 65535;
	if (AltFireInterval ~= 0.0) //doesn't have an altfire
	{
		AltFireInterval = FireInterval;
		AIInfo[1] = AIInfo[0];
	}

	if (bShowChargingBar && Owner != None)
		Vehicle(Owner).bShowChargingBar = true; //for listen/standalone clients

	if (Level.GRI != None && Level.GRI.WeaponBerserk > 1.0)
		SetFireRateModifier(Level.GRI.WeaponBerserk);

	// RO functionality
	if( BeginningIdleAnim != '' && HasAnim(BeginningIdleAnim))
	{
	    PlayAnim(BeginningIdleAnim);
	}

	if( Role == ROLE_Authority )
   		GiveInitialAmmo();
}

simulated function PostNetBeginPlay()
{
	if (bInstantFire)
		GotoState('InstantFireMode');
	else
		GotoState('ProjectileFireMode');

	InitEffects();

	MaxRange();

	Super.PostNetBeginPlay();
}

simulated function InitEffects()
{
	// don't even spawn on server
	if (Level.NetMode == NM_DedicatedServer)
		return;

	if ( (FlashEmitterClass != None) && (FlashEmitter == None) )
	{
		FlashEmitter = Spawn(FlashEmitterClass);
		FlashEmitter.SetDrawScale(DrawScale);
		if (WeaponFireAttachmentBone == '')
			FlashEmitter.SetBase(self);
		else
			AttachToBone(FlashEmitter, WeaponFireAttachmentBone);

		FlashEmitter.SetRelativeLocation(WeaponFireOffset * vect(1,0,0));
	}

	if (AmbientEffectEmitterClass != none && AmbientEffectEmitter == None)
	{
		AmbientEffectEmitter = spawn(AmbientEffectEmitterClass, self,, WeaponFireLocation, WeaponFireRotation);
		if (WeaponFireAttachmentBone == '')
			AmbientEffectEmitter.SetBase(self);
		else
			AttachToBone(AmbientEffectEmitter, WeaponFireAttachmentBone);


		if( bAmbientEmitterAltFireOnly )
		{
			AmbientEffectEmitter.SetRelativeLocation(AltFireOffset);
		}
		else
			AmbientEffectEmitter.SetRelativeLocation(WeaponFireOffset * vect(1,0,0));
	}
}

simulated function SetGRI(GameReplicationInfo GRI)
{
	if (GRI.WeaponBerserk > 1.0)
		SetFireRateModifier(GRI.WeaponBerserk);
}

simulated function SetFireRateModifier(float Modifier)
{
	if (FireInterval == AltFireInterval)
	{
		FireInterval = default.FireInterval / Modifier;
		AltFireInterval = FireInterval;
	}
	else
	{
		FireInterval = default.FireInterval / Modifier;
		AltFireInterval = default.AltFireInterval / Modifier;
	}
}

function SpawnHitEffects(actor HitActor, vector HitLocation, vector HitNormal);
simulated event ClientSpawnHitEffects();

simulated function ShakeView(bool bWasAltFire)
{
	local PlayerController P;

	if (Instigator == None)
		return;

	P = PlayerController(Instigator.Controller);
	if (P != None )
	{
		if( bWasAltFire )
		{
			P.WeaponShakeView(AltShakeRotMag, AltShakeRotRate, AltShakeRotTime, AltShakeOffsetMag, AltShakeOffsetRate, AltShakeOffsetTime);
		}
		else
		{
			P.WeaponShakeView(ShakeRotMag, ShakeRotRate, ShakeRotTime, ShakeOffsetMag, ShakeOffsetRate, ShakeOffsetTime);
		}
	}
}

//ClientStartFire() and ClientStopFire() are only called for the client that owns the weapon (and not at all for bots)
simulated function ClientStartFire(Controller C, bool bAltFire)
{
	bIsAltFire = bAltFire;

	if (FireCountdown <= 0)
	{
		if (bIsRepeatingFF)
		{
			if (bIsAltFire)
				ClientPlayForceFeedback( AltFireForce );
			else
				ClientPlayForceFeedback( FireForce );
		}
		OwnerEffects();
	}
}

simulated function ClientStopFire(Controller C, bool bWasAltFire)
{
	if (bIsRepeatingFF)
	{
		if (bIsAltFire)
			StopForceFeedback( AltFireForce );
		else
			StopForceFeedback( FireForce );
	}

	if (Role < ROLE_Authority )
	{
		if( AmbientEffectEmitter != None)
			AmbientEffectEmitter.SetEmitterStatus(false);
	}
}

simulated function ClientPlayForceFeedback( String EffectName )
{
	local PlayerController PC;

	if (Instigator == None)
		return;

	PC = PlayerController(Instigator.Controller);
	if ( PC != None && PC.bEnableGUIForceFeedback )
	{
		PC.ClientPlayForceFeedback( EffectName );
	}
}

simulated function StopForceFeedback( String EffectName )
{
	local PlayerController PC;

	if (Instigator == None)
		return;

	PC = PlayerController(Instigator.Controller);
	if ( PC != None && PC.bEnableGUIForceFeedback )
	{
		PC.StopForceFeedback( EffectName );
	}
}

//do effects (muzzle flash, force feedback, etc) immediately for the weapon's owner (don't wait for replication)
simulated event OwnerEffects()
{
	// Stop the firing effects it we shouldn't be able to fire
	if( (Role < ROLE_Authority) && !ReadyToFire(bIsAltFire) )
	{
		VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bIsAltFire);
		return;
	}

	if (!bIsRepeatingFF)
	{
		if (bIsAltFire)
			ClientPlayForceFeedback( AltFireForce );
		else
			ClientPlayForceFeedback( FireForce );
	}
	ShakeView(bIsAltFire);

	if (Role < ROLE_Authority)
	{
		if (bIsAltFire)
			FireCountdown = AltFireInterval;
		else
			FireCountdown = FireInterval;

		AimLockReleaseTime = Level.TimeSeconds + FireCountdown * FireIntervalAimLock;

		FlashMuzzleFlash(bIsAltFire);

		if (AmbientEffectEmitter != None)
			AmbientEffectEmitter.SetEmitterStatus(true);

		// Play firing noise
		if (!bAmbientFireSound)
		{
			if (bIsAltFire)
				PlaySound(AltFireSoundClass, SLOT_None, FireSoundVolume/255.0,, AltFireSoundRadius,, false);
			else
				PlaySound(FireSoundClass, SLOT_None, FireSoundVolume/255.0,, FireSoundRadius,, false);
		}
		else if ( bIsAltFire && bAmbientAltFireSound )
		{
		    SoundVolume = AltFireSoundVolume;
			SoundRadius = AltFireSoundRadius;
			AmbientSoundScaling = AltFireSoundScaling;
		}
	}
}

event bool AttemptFire(Controller C, bool bAltFire)
{
  	if(Role != ROLE_Authority || bForceCenterAim)
		return False;

	if (FireCountdown <= 0)
	{
		CalcWeaponFire(bAltFire);
		if (bCorrectAim)
			WeaponFireRotation = AdjustAim(bAltFire);

		if( bAltFire )
		{
			if( AltFireSpread > 0 )
				WeaponFireRotation = rotator(vector(WeaponFireRotation) + VRand()*FRand()*AltFireSpread);
		}
		else if (Spread > 0)
		{
			WeaponFireRotation = rotator(vector(WeaponFireRotation) + VRand()*FRand()*Spread);
		}

		DualFireOffset *= -1;

		Instigator.MakeNoise(1.0);
		if (bAltFire)
		{
			if( !ConsumeAmmo(2) )
			{
				VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
				return false;
			}
			FireCountdown = AltFireInterval;
			AltFire(C);
		}
		else
		{
			if( bMultipleRoundTypes )
			{
				if (ProjectileClass == PrimaryProjectileClass)
				{
					if( !ConsumeAmmo(0) )
					{
						VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
						return false;
					}
			    }
			    else if (ProjectileClass == SecondaryProjectileClass)
			    {
					if( !ConsumeAmmo(1) )
					{
						VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
						return false;
					}
			    }
			}
			else if( !ConsumeAmmo(0) )
			{
				VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
				return false;
			}

			FireCountdown = FireInterval;
		    Fire(C);
		}
		AimLockReleaseTime = Level.TimeSeconds + FireCountdown * FireIntervalAimLock;

	    return True;
	}

	return False;
}

function rotator AdjustAim(bool bAltFire)
{
	local rotator AdjustedAim, ControllerAim;
	local int n;

	if ( (Instigator == None) || (Instigator.Controller == None) )
		return WeaponFireRotation;

	if ( bAltFire )
		n = 1;

	if ( !SavedFireProperties[n].bInitialized )
	{
		SavedFireProperties[n].AmmoClass = class'Ammo_Dummy';
		if ( bAltFire )
			SavedFireProperties[n].ProjectileClass = AltFireProjectileClass;
		else
			SavedFireProperties[n].ProjectileClass = ProjectileClass;
		SavedFireProperties[n].WarnTargetPct = AIInfo[n].WarnTargetPct;
		SavedFireProperties[n].MaxRange = MaxRange();
		SavedFireProperties[n].bTossed = AIInfo[n].bTossed;
		SavedFireProperties[n].bTrySplash = AIInfo[n].bTrySplash;
		SavedFireProperties[n].bLeadTarget = AIInfo[n].bLeadTarget;
		SavedFireProperties[n].bInstantHit = AIInfo[n].bInstantHit;
		SavedFireProperties[n].bInitialized = true;
	}

	ControllerAim = Instigator.Controller.Rotation;

	AdjustedAim = Instigator.AdjustAim(SavedFireProperties[n], WeaponFireLocation, AIInfo[n].AimError);
	if (AdjustedAim == Instigator.Rotation || AdjustedAim == ControllerAim)
		return WeaponFireRotation; //No adjustment
	else
	{
		AdjustedAim.Pitch = Instigator.LimitPitch(AdjustedAim.Pitch);
		return AdjustedAim;
}
}

//AI: return the best fire mode for the situation
function byte BestMode()
{
	return 0;
}

function Fire(Controller C)
{
	log(self$": Fire has been called outside of a state!");
}

function AltFire(Controller C)
{
	log(self$": AltFire has been called outside of a state!");
}

// return false if out of range, can't see target, etc.
function bool CanAttack(Actor Other)
{
	local float Dist, CheckDist;
	local vector HitLocation, HitNormal, projStart;
	local actor HitActor;
	local Bot B;

	if ( (Instigator == None) || (Instigator.Controller == None) )
		return false;

	// check that target is within range
	Dist = VSize(Instigator.Location - Other.Location);
	if (Dist > MaxRange())
		return false;

	// check that can see target
	if (!Instigator.Controller.LineOfSightTo(Other))
		return false;

	// make sure bot should still shoot this target
	B = Bot(Instigator.Controller);
	if (B.Squad.AssessThreat(B,Pawn(Other),True) < 0)
	{
		B.Squad.FindNewEnemyFor(B, True);
		return False;
	}

	if (ProjectileClass != None)
	{
		CheckDist = FMax(CheckDist, 0.5 * ProjectileClass.Default.Speed);
		CheckDist = FMax(CheckDist, 300);
		CheckDist = FMin(CheckDist, VSize(Other.Location - Location));
	}
	if (AltFireProjectileClass != None)
	{
		CheckDist = FMax(CheckDist, 0.5 * AltFireProjectileClass.Default.Speed);
		CheckDist = FMax(CheckDist, 300);
		CheckDist = FMin(CheckDist, VSize(Other.Location - Location));
	}

	// check that would hit target, and not a friendly
	CalcWeaponFire(FiringMode != 0);

	projStart = WeaponFireLocation;
	if (bInstantFire)
	{
		HitActor = Trace(HitLocation, HitNormal, Other.Location + Other.CollisionHeight * vect(0,0,0.8), projStart, true);
		if ( (HitActor == None) || (HitActor == Other)
		 || (Pawn(HitActor) != none && (Pawn(HitActor).Controller != None) && !Instigator.Controller.SameTeamAs(Pawn(HitActor).Controller)))
		   return true;
	}
	else
	{

		// for non-instant hit, only check partial path (since others may move out of the way)
      foreach TraceActors(class'Actor', HitActor, HitLocation, HitNormal,
				projStart + CheckDist * Normal(Other.Location + Other.CollisionHeight * vect(0,0,0.8) - Location),
				projStart)
		{
		   if ( HitActor.bWorldGeometry || (Pawn(HitActor) != None && ( (Pawn(HitActor).Controller == None) || Instigator.Controller.SameTeamAs(Pawn(HitActor).Controller))
         || (Pawn(HitActor.Base) != none && ( (Pawn(HitActor.Base).Controller == None) || Instigator.Controller.SameTeamAs(Pawn(HitActor.Base).Controller) ) ) ) )
         {
            ROBot(B).NotifyIneffectiveAttack();
            return false;
         }
		}
      return true;
	}

	return false;
}

simulated function float MaxRange()
{
	if (bInstantFire)
	{
		if (Instigator != None && Instigator.Region.Zone != None && Instigator.Region.Zone.bDistanceFog)
			TraceRange = FClamp(Instigator.Region.Zone.DistanceFogEnd, 8000, default.TraceRange);
		else
			TraceRange = default.TraceRange;

		AimTraceRange = TraceRange;
	}
	else if ( ProjectileClass != None )
		AimTraceRange = ProjectileClass.static.GetRange();
	else
		AimTraceRange = 10000;

	return AimTraceRange;
}

state InstantFireMode
{
	function Fire(Controller C)
	{
		FlashMuzzleFlash(false);

		if (AmbientEffectEmitter != None)
		{
			AmbientEffectEmitter.SetEmitterStatus(true);
		}

		// Play firing noise
		if (bAmbientFireSound)
			AmbientSound = FireSoundClass;
		else
			PlayOwnedSound(FireSoundClass, SLOT_None, FireSoundVolume/255.0,, FireSoundRadius, FireSoundPitch, False);

		TraceFire(WeaponFireLocation, WeaponFireRotation);
	}

	function AltFire(Controller C)
	{
	}

	simulated event ClientSpawnHitEffects()
	{
		local vector HitLocation, HitNormal, Offset;
		local actor HitActor;

		// if standalone, already have valid HitActor and HitNormal
		if ( Level.NetMode == NM_Standalone )
			return;
		Offset = 20 * Normal(WeaponFireLocation - LastHitLocation);
		HitActor = Trace(HitLocation, HitNormal, LastHitLocation - Offset, LastHitLocation + Offset, False);
		SpawnHitEffects(HitActor, LastHitLocation, HitNormal);
	}

	simulated function SpawnHitEffects(actor HitActor, vector HitLocation, vector HitNormal)
	{
		local PlayerController PC;

		PC = Level.GetLocalPlayerController();
		if (PC != None && ((Instigator != None && Instigator.Controller == PC) || VSize(PC.ViewTarget.Location - HitLocation) < 5000))
		{
			// MergeTODO: Fix this
			//Spawn(class'HitEffect'.static.GetHitEffect(HitActor, HitLocation, HitNormal),,, HitLocation, Rotator(HitNormal));
			if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) )
			{
				// check for splash
				if ( Base != None )
				{
					Base.bTraceWater = true;
					HitActor = Base.Trace(HitLocation,HitNormal,HitLocation,Location + 200 * Normal(HitLocation - Location),true);
					Base.bTraceWater = false;
				}
				else
				{
					bTraceWater = true;
					HitActor = Trace(HitLocation,HitNormal,HitLocation,Location + 200 * Normal(HitLocation - Location),true);
					bTraceWater = false;
				}

				if ( (FluidSurfaceInfo(HitActor) != None) || ((PhysicsVolume(HitActor) != None) && PhysicsVolume(HitActor).bWaterVolume) )
					Spawn(class'BulletSplashEmitter',,,HitLocation,rot(16384,0,0));
			}
		}
	}
}

state ProjectileFireMode
{
	function Fire(Controller C)
	{
		SpawnProjectile(ProjectileClass, False);
	}

	function AltFire(Controller C)
	{
		if (AltFireProjectileClass == None)
			Fire(C);
		else
			SpawnProjectile(AltFireProjectileClass, True);
	}
}

function Projectile SpawnProjectile(class<Projectile> ProjClass, bool bAltFire)
{
	local Projectile P;
	local VehicleWeaponPawn WeaponPawn;
	local vector StartLocation, HitLocation, HitNormal, Extent;

	if (bDoOffsetTrace)
	{
	   	Extent = ProjClass.default.CollisionRadius * vect(1,1,0);
		Extent.Z = ProjClass.default.CollisionHeight;
	   	WeaponPawn = VehicleWeaponPawn(Owner);
		if (WeaponPawn != None && WeaponPawn.VehicleBase != None)
		{
			if (!WeaponPawn.VehicleBase.TraceThisActor(HitLocation, HitNormal, WeaponFireLocation, WeaponFireLocation + vector(WeaponFireRotation) * (WeaponPawn.VehicleBase.CollisionRadius * 1.5), Extent))
			StartLocation = HitLocation;
		else
			StartLocation = WeaponFireLocation + vector(WeaponFireRotation) * (ProjClass.default.CollisionRadius * 1.1);
	}
	else
	{
		if (!Owner.TraceThisActor(HitLocation, HitNormal, WeaponFireLocation, WeaponFireLocation + vector(WeaponFireRotation) * (Owner.CollisionRadius * 1.5), Extent))
			StartLocation = HitLocation;
		else
			StartLocation = WeaponFireLocation + vector(WeaponFireRotation) * (ProjClass.default.CollisionRadius * 1.1);
	}
	}
	else
		StartLocation = WeaponFireLocation;

	P = spawn(ProjClass, self, , StartLocation, WeaponFireRotation);

	if (P != None)
	{
		if (bInheritVelocity)
			P.Velocity = Instigator.Velocity;

		FlashMuzzleFlash(bAltFire);

		// Play firing noise
		if (bAltFire)
		{
			if (bAmbientAltFireSound)
			{
				AmbientSound = AltFireSoundClass;
				SoundVolume = AltFireSoundVolume;
				SoundRadius = AltFireSoundRadius;
				AmbientSoundScaling = AltFireSoundScaling;
			}
			else
				PlayOwnedSound(AltFireSoundClass, SLOT_None, FireSoundVolume/255.0,, AltFireSoundRadius,, false);
		}
		else
		{
			if (bAmbientFireSound)
				AmbientSound = FireSoundClass;
			else
				PlayOwnedSound(FireSoundClass, SLOT_None, FireSoundVolume/255.0,, FireSoundRadius,, false);
		}
	}

	return P;
}

function CeaseFire(Controller C, bool bWasAltFire)
{
	FlashCount = 0;
	HitCount = 0;

	if (AmbientEffectEmitter != None)
	{
		AmbientEffectEmitter.SetEmitterStatus(false);
	}

	if (bAmbientFireSound || bAmbientAltFireSound)
	{
		if( AmbientSound != none )
		{
			if( AmbientSound == FireSoundClass && FireEndSound != none)
			{
				PlaySound(FireEndSound,SLOT_None,(SoundVolume/255.0) * AmbientSoundScaling,,SoundRadius);
			}
			else if( AmbientSound == AltFireSoundClass && AltFireEndSound != none)
			{
				PlaySound(AltFireEndSound,SLOT_None,(AltFireSoundVolume/255.0) * AltFireSoundScaling,,AltFireSoundRadius);
			}
		}

		AmbientSound = None;
		SoundVolume = default.SoundVolume;
		SoundRadius = default.SoundRadius;
		AmbientSoundScaling = default.AmbientSoundScaling;
	}
}

function WeaponCeaseFire(Controller C, bool bWasAltFire);

simulated event FlashMuzzleFlash(bool bWasAltFire)
{
	if (Role == ROLE_Authority)
	{
		FlashCount++;
		NetUpdateTime = Level.TimeSeconds - 1;
	}
	else
		CalcWeaponFire(bWasAltFire);

	if (FlashEmitter != None)
		FlashEmitter.Trigger(Self, Instigator);

	if ( (EffectEmitterClass != None) && EffectIsRelevant(Location,false) )
		EffectEmitter = spawn(EffectEmitterClass, self,, WeaponFireLocation, WeaponFireRotation);
}

simulated function Destroyed()
{
	DestroyEffects();

	Super.Destroyed();
}

simulated function DestroyEffects()
{
	if (FlashEmitter != None)
		FlashEmitter.Destroy();
	if (EffectEmitter != None)
		EffectEmitter.Destroy();
	if (AmbientEffectEmitter != None)
		AmbientEffectEmitter.Destroy();
}

/* simulated TraceFire to get precise start/end of hit */
simulated function SimulateTraceFire( out vector Start, out Rotator Dir, out vector HitLocation, out vector HitNormal )
{
	local Vector			X, End;
	local Actor				Other;
	local VehicleWeaponPawn WeaponPawn;
	local Vehicle			VehicleInstigator;

	if ( bDoOffsetTrace )
	{
		WeaponPawn = VehicleWeaponPawn(Owner);
	    if ( WeaponPawn != None && WeaponPawn.VehicleBase != None )
		{
			if ( !WeaponPawn.VehicleBase.TraceThisActor(HitLocation, HitNormal, Start, Start + vector(Dir) * (WeaponPawn.VehicleBase.CollisionRadius * 1.5)))
				Start = HitLocation;
		}
		else
			if ( !Owner.TraceThisActor(HitLocation, HitNormal, Start, Start + vector(Dir) * (Owner.CollisionRadius * 1.5)))
				Start = HitLocation;
	}

	X = Vector(Dir);
	End = Start + TraceRange * X;

	// skip past vehicle driver
	VehicleInstigator = Vehicle(Instigator);
	if ( VehicleInstigator != None && VehicleInstigator.Driver != None )
	{
		VehicleInstigator.Driver.bBlockZeroExtentTraces = false;
		Other = Trace(HitLocation, HitNormal, End, Start, true);
		VehicleInstigator.Driver.bBlockZeroExtentTraces = true;
	}
	else
		Other = Trace(HitLocation, HitNormal, End, Start, True);

	if ( Other != None && Other != Instigator )
	{
		if ( !Other.bWorldGeometry )
		{
 			if ( Vehicle(Other) != None || Pawn(Other) == None )
 			{
 				LastHitLocation = HitLocation;
			}
			HitNormal = vect(0,0,0);
		}
		else
		{
			LastHitLocation = HitLocation;
		}
	}
	else
	{
		HitLocation = End;
		HitNormal = Vect(0,0,0);
	}
}

function TraceFire(Vector Start, Rotator Dir)
{
	local Vector X, End, HitLocation, HitNormal, RefNormal;
	local Actor Other;
	local VehicleWeaponPawn WeaponPawn;
	local Vehicle VehicleInstigator;
	local int Damage;
	local bool bDoReflect;
	local int ReflectNum;

	MaxRange();

	if ( bDoOffsetTrace )
	{
		WeaponPawn = VehicleWeaponPawn(Owner);
	    if ( WeaponPawn != None && WeaponPawn.VehicleBase != None )
		{
			if ( !WeaponPawn.VehicleBase.TraceThisActor(HitLocation, HitNormal, Start, Start + vector(Dir) * (WeaponPawn.VehicleBase.CollisionRadius * 1.5)))
				Start = HitLocation;
		}
		else
			if ( !Owner.TraceThisActor(HitLocation, HitNormal, Start, Start + vector(Dir) * (Owner.CollisionRadius * 1.5)))
				Start = HitLocation;
	}

	ReflectNum = 0;
	while ( true )
	{
		bDoReflect = false;
		X = Vector(Dir);
		End = Start + TraceRange * X;

		//skip past vehicle driver
		VehicleInstigator = Vehicle(Instigator);
		if ( ReflectNum == 0 && VehicleInstigator != None && VehicleInstigator.Driver != None )
		{
			VehicleInstigator.Driver.bBlockZeroExtentTraces = false;
			Other = Trace(HitLocation, HitNormal, End, Start, true);
			VehicleInstigator.Driver.bBlockZeroExtentTraces = true;
		}
		else
			Other = Trace(HitLocation, HitNormal, End, Start, True);

		if ( Other != None && (Other != Instigator || ReflectNum > 0) )
		{
			if (bReflective && Other.IsA('xPawn') && xPawn(Other).CheckReflect(HitLocation, RefNormal, DamageMin*0.25))
			{
				bDoReflect = True;
				HitNormal = vect(0,0,0);
			}
			else if (!Other.bWorldGeometry)
			{
				Damage = (DamageMin + Rand(DamageMax - DamageMin));
 				if ( Vehicle(Other) != None || Pawn(Other) == None )
 				{
 					HitCount++;
 					LastHitLocation = HitLocation;
					SpawnHitEffects(Other, HitLocation, HitNormal);
				}
			   	Other.TakeDamage(Damage, Instigator, HitLocation, Momentum*X, DamageType);
				HitNormal = vect(0,0,0);
			}
			else
			{
				HitCount++;
				LastHitLocation = HitLocation;
				SpawnHitEffects(Other, HitLocation, HitNormal);
	    }
		}
		else
		{
			HitLocation = End;
			HitNormal = Vect(0,0,0);
			HitCount++;
			LastHitLocation = HitLocation;
		}

		SpawnBeamEffect(Start, Dir, HitLocation, HitNormal, ReflectNum);

		if ( bDoReflect && ++ReflectNum < 4 )
		{
			//Log("reflecting off"@Other@Start@HitLocation);
			Start	= HitLocation;
			Dir		= Rotator(RefNormal); //Rotator( X - 2.0*RefNormal*(X dot RefNormal) );
		}
		else
		{
			break;
		}
	}

	NetUpdateTime = Level.TimeSeconds - 1;
}

function SpawnBeamEffect(Vector Start, Rotator Dir, Vector HitLocation, Vector HitNormal, int ReflectNum);

simulated function CalcWeaponFire(bool bWasAltFire)
{
	local coords WeaponBoneCoords;
	local vector CurrentFireOffset;

	// Calculate fire offset in world space
	WeaponBoneCoords = GetBoneCoords(WeaponFireAttachmentBone);
	if( bWasAltFire )
		CurrentFireOffset = AltFireOffset + (WeaponFireOffset * vect(1,0,0));
	else
		CurrentFireOffset = (WeaponFireOffset * vect(1,0,0)) + (DualFireOffset * vect(0,1,0));

	// Calculate rotation of the gun
	WeaponFireRotation = rotator(vector(CurrentAim) >> Rotation);

	// Calculate exact fire location
	WeaponFireLocation = WeaponBoneCoords.Origin + (CurrentFireOffset >> WeaponFireRotation);

	// Adjust fire rotation taking dual offset into account
	if (bDualIndependantTargeting)
		WeaponFireRotation = rotator(CurrentHitLocation - WeaponFireLocation);
}

function DoCombo();

simulated function float ChargeBar();

static function StaticPrecache(LevelInfo L);

DefaultProperties
{
   DrawType=DT_Mesh
   Physics=PHYS_None
   RemoteRole=ROLE_SimulatedProxy
   bAimable=True
   bIgnoreEncroachers=True
   RotationsPerSecond=0.75
   bAmbientFireSound=False
   FireInterval=0.5
   FireSoundVolume=160.0
   FireSoundPitch=1.0
   FireSoundRadius=300.0
   AltFireSoundVolume=160.0
   AltFireSoundRadius=300.0
   AmbientSoundScaling=1.0
   TraceRange=10000
   Momentum=1
   DamageType=none//class'DamTypeMinigunBullet'
   DamageMin=6
   DamageMax=6
   bInheritVelocity=False
   bInstantFire=False
   YawStartConstraint=0
   YawEndConstraint=65535
   PitchUpLimit=5000
   PitchDownLimit=60000
   bReplicateInstigator=True
   DualFireOffset=0
   bDualIndependantTargeting=False
   SoundVolume=255
   SoundRadius=100
   NetUpdateFrequency=5
   bBlockZeroExtentTraces=false
   bBlockNonZeroExtentTraces=false
   bIsRepeatingFF=false
   bCorrectAim=true
   AIInfo(0)=(AimError=600,RefireRate=0.90)
   AIInfo(1)=(AimError=600,RefireRate=0.90)
   bNoRepMesh=true
   bShowAimCrosshair=true
   RotateSoundThreshold=50.0
}
