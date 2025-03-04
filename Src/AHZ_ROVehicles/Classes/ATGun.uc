//==============================================================================
// ATGun
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// ATGun base class for large calibar weapons (guns, howizters, mortars, and turreted pill-boxes)
//==============================================================================
//==============================================================================
// Note: I realize that an AT-Gun does not have treads, but I extend off ROTreadCraft because
//       there are parts in there that I need and it is easier to over-ride those parts and
//       make empty functions. In a perfect world, I would actually create a
//       set of gun specific classes at a much lower level, so I could get rid of much of the extra code.
//       I may decide to do this at a later date, but for now why reinvent the wheel.
//==============================================================================
class ATGun extends ROTreadCraft
    abstract;

//==============================================================================
// Variables
//==============================================================================
var   float                   GunThreatFactor;                    //allow the threat to be specific based on the type of gun.  A pill-box would have a lower factor than a mortar.
var	  ATCannonDamagedEffect	  DamagedGunEffect;                   //replaces the RO:OST VehicleDamagedEffect class to over-ride the fire and brimstone effect.

//==============================================================================
// Functions
//==============================================================================

//The following functions are empty functions
simulated function UpdateMovementSound();          //removed due to no movement sound needed
simulated function SetupTreads();                  //removed due to no need to setup treads
simulated function DestroyTreads();                //removed due to no need to setup treads
function DamageTrack(bool bLeftTrack);             //removed due to no need to damage treads
function DamageEngine(int Damage, Pawn instigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> DamageType);   //removed due to no need to damage engine
function MaybeDestroyVehicle();                    //removed, we do not want to destroy the gun when the player leaves. Overrides ROWheeledVehicle.
function bool ResupplyAmmo();                      //removed due to no need to resupply the gun
function EnteredResupply();                        //removed due to no need to resupply the gun
function LeftResupply();                           //removed due to no need to resupply the gun

// Returns true, an AT-Gun is always disabled (i.e. can not move)
simulated function bool IsDisabled()
{
	return true; //for now just return true.
}

// Overriden to bypass attaching as a driver and go straight to the gun.
simulated function ClientKDriverEnter(PlayerController PC)
{
    //Make sure there is a least one WeaponPawn.
    if ( WeaponPawns.length > 0 )
    {
        WeaponPawns[0].ClientKDriverEnter(PC);            //attach to the first WeaponPawn, do not pass "Go".  :-)
    }
}

// Overriden to bypass attaching as a driver and go straight to the gun.
function KDriverEnter(Pawn P)
{
    //Make sure there is a least one WeaponPawn.
    if ( WeaponPawns.length > 0 )
    {
        WeaponPawns[0].KDriverEnter(P);                   //attach to the first WeaponPawn, do not pass "Go".  :-)
	}
}

simulated function PostBeginPlay()
{
    //do not need to setup treads and sounds.
    super(ROWheeledVehicle).PostBeginPlay();
}

// DriverLeft() called by KDriverLeave()
function DriverLeft()
{
    super(ROWheeledVehicle).DriverLeft();      //Skip ROTreadCraft.
}

simulated function Destroyed()
{
    super(ROVehicle).Destroyed();       //Skip ROTreadCraft
}

simulated function Tick(float DeltaTime)
{
	// Only need these effects client side
	// Reworked from the original code in ROTreadCraft to drop evaluations
    if( Level.Netmode == NM_DedicatedServer && SoundVolume != default.SoundVolume)
        SoundVolume = default.SoundVolume;

	Super(ROWheeledVehicle).Tick( DeltaTime );
}

// Overridden due to the Onslaught team lock not working in RO
// Changed the logic to prevent tank crew from using.  You do not want a tank to sit beside an AT-GUN,
//       take a few hits, then abandon the tank and start using the AT-Gun.  You know some tard will do it
//       like they do in COD:UO.  It will be a tad unrealistic.  This is for game play.
function bool TryToDrive(Pawn P)
{
	local int x;

	//don't allow vehicle to be stolen when somebody is in a turret
	if (!bTeamLocked && P.GetTeamNum() != VehicleTeam)
	{
		for (x = 0; x < WeaponPawns.length; x++)
			if (WeaponPawns[x].Driver != None)
			{
				DenyEntry( P, 2 );
				return false;
			}
	}

    //Removed "P.bIsCrouched" to allow players to connect while crouched.
	if ( bNonHumanControl || (P.Controller == None) || (Driver != None) || (P.DrivenVehicle != None) || !P.Controller.bIsPlayer
	     || P.IsA('Vehicle') || Health <= 0 )
		return false;

	if ( !Level.Game.CanEnterVehicle(self, P) )
		return false;

	// Check vehicle Locking....
	if ( bTeamLocked && ( P.GetTeamNum() != VehicleTeam ))
	{
		DenyEntry( P, 1 );
		return false;
	}
    // Tank Crew is not allowed to use the gun.
	else if( !bMustBeTankCommander && ROPlayerReplicationInfo(P.Controller.PlayerReplicationInfo).RoleInfo.bCanBeTankCrew )
	{
       DenyEntry( P, 0 );
	   return false;
	}
	else
	{
	    //At this point we know the pawn is not a tanker, so let's see if they can use the gun
    	if ( bEnterringUnlocks && bTeamLocked )
			bTeamLocked = false;

        //The gun is manned and it is a human - deny entry
        if ( WeaponPawns[0].Driver != none && WeaponPawns[0].IsHumanControlled() )
		{
            DenyEntry( P, 3 );
			return false;
		}
        //The gun is manned by a bot and the requesting pawn is human controlled - kick the bot off the gun
        else if ( WeaponPawns[0].Driver != none && !WeaponPawns[0].IsHumanControlled() && p.IsHumanControlled() )
        {
            WeaponPawns[0].KDriverLeave(true);

            KDriverEnter( P );
		    return true;
        }
        //The gun is manned by a bot and a bot is trying to use it, deny entry.
        else if ( WeaponPawns[0].Driver != none && !WeaponPawns[0].IsHumanControlled() && !p.IsHumanControlled() )
        {
            DenyEntry( P, 3 );
			return false;
		}
		//The gun is unmanned, so let who ever is there first can use it.
        else
		{
            KDriverEnter( P );
		    return true;
        }
	}

}

// Send a message on why they can't get in the vehicle
function DenyEntry( Pawn P, int MessageNum )
{
	P.ReceiveLocalizedMessage(class'ATCannonMessage', MessageNum);
}

// TakeDamage - overloaded to prevent bayonet and bash attacks from damaging vehicles
//				for Tanks, we'll probably want to prevent bullets from doing damage too
function TakeDamage(int Damage, Pawn instigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex)
{
    local int i;
    local float VehicleDamageMod;
    local int HitPointDamage;
	local int InstigatorTeam;
	local controller InstigatorController;

	// Fix for suicide death messages
    if (DamageType == class'Suicided')
    {
	    DamageType = Class'ROSuicided';
	    Super(ROVehicle).TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
	}
	else if (DamageType == class'ROSuicided')
	{
		super(ROVehicle).TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
	}

	// Quick fix for the thing giving itself impact damage
	if(instigatedBy == self)
		return;

	// Don't allow your own teammates to destroy vehicles in spawns (and you know some jerks would get off on doing that to thier team :) )
	if( !bDriverAlreadyEntered )
	{
		if ( InstigatedBy != None )
			InstigatorController = instigatedBy.Controller;

		if ( InstigatorController == None )
		{
			if ( DamageType.default.bDelayedDamage )
				InstigatorController = DelayedDamageInstigatorController;
		}

		if ( InstigatorController != None )
		{
			InstigatorTeam = InstigatorController.GetTeamNum();

			if ( (GetTeamNum() != 255) && (InstigatorTeam != 255) )
			{
				if ( GetTeamNum() == InstigatorTeam )
				{
					return;
				}
			}
		}
	}

    // Modify the damage based on what it should do to the vehicle
	if (DamageType != none)
	{
	   if(class<ROWeaponDamageType>(DamageType) != none)
       		VehicleDamageMod = class<ROWeaponDamageType>(DamageType).default.TankDamageModifier;
       else if(class<ROVehicleDamageType>(DamageType) != none)
	   		VehicleDamageMod = class<ROVehicleDamageType>(DamageType).default.TankDamageModifier;
    }

	for(i=0; i<VehHitpoints.Length; i++)
	{
    	HitPointDamage=Damage;

		if ( VehHitpoints[i].HitPointType == HP_Driver )
		{
       	// Damage for large weapons
			if(	class<ROWeaponDamageType>(DamageType) != none && class<ROWeaponDamageType>(DamageType).default.VehicleDamageModifier > 0.25 )
			{
				if ( Driver != none && DriverPositions[DriverPositionIndex].bExposed && IsPointShot(Hitlocation,Momentum, 1.0, i))
				{
					//Level.Game.Broadcast(self, "HitDriver");
					Driver.TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
				}
			}
			// Damage for small (non penetrating) arms
			else
			{
				if ( Driver != none && DriverPositions[DriverPositionIndex].bExposed && IsPointShot(Hitlocation,Momentum, 1.0, i, DriverHitCheckDist))
				{
					//Level.Game.Broadcast(self, "HitDriver");
					Driver.TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
				}
			}
		}

		//An At-Gun does not have an engine. We will however, leave the ammo store because we need it to get around a
		//  collision issue with the gunner (player).
        else if ( IsPointShot(Hitlocation,Momentum, 1.0, i))
		{
			HitPointDamage *= VehHitpoints[i].DamageMultiplier;
			HitPointDamage *= VehicleDamageMod;

            //log("We hit "$GetEnum(enum'EPawnHitPointType',VehHitpoints[i].HitPointType));

            if ( VehHitpoints[i].HitPointType == HP_AmmoStore )
			{
				Damage *= VehHitpoints[i].DamageMultiplier;
				break;
			}
		}

	}

    // Add in the Vehicle damage modifier for the actual damage to the vehicle itself
    Damage *= VehicleDamageMod;

    super(ROVehicle).TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
}

simulated function bool ShouldPenetrate(vector HitLocation, vector HitRotation, int PenetrationNumber, optional class<DamageType> DamageType)
{
	local vector LocDir, HitDir;
	local float HitAngle,Side,InAngle;
    local vector X,Y,Z;
    local float InAngleDegrees;
    local rotator AimRot;

	if (HitPenetrationPoint(HitLocation, HitRotation))
	{
		return true;
	}

	// Figure out which side we hit
    LocDir = vector(Rotation);
    LocDir.Z = 0;
    HitDir =  Hitlocation - Location;
    HitDir.Z = 0;
    HitAngle = Acos( Normal(LocDir) dot Normal(HitDir));

	//  Penetration Debugging
    if( bDebugPenetration )
    {
        log("Raw hitangle = "$HitAngle$" Converted hitangle = "$(57.2957795131 * HitAngle));
    }

	// Convert the angle into degrees from radians
    HitAngle*=57.2957795131;
    GetAxes(Rotation,X,Y,Z);
    Side = Y dot HitDir;

    //  Penetration Debugging
    if( bDebugPenetration )
    {
        ClearStayingDebugLines();
        AimRot = Rotation;
        AimRot.Yaw += (FrontLeftAngle/360.0)*65536;
        DrawStayingDebugLine( Location, Location + 2000*vector(AimRot),0, 255, 0);
        AimRot = Rotation;
        AimRot.Yaw += (FrontRightAngle/360.0)*65536;
        DrawStayingDebugLine( Location, Location + 2000*vector(AimRot),255, 255, 0);
        AimRot = Rotation;
        AimRot.Yaw += (RearRightAngle/360.0)*65536;
        DrawStayingDebugLine( Location, Location + 2000*vector(AimRot),0, 0, 255);
        AimRot = Rotation;
        AimRot.Yaw += (RearLeftAngle/360.0)*65536;
        DrawStayingDebugLine( Location, Location + 2000*vector(AimRot),0, 0, 0);
    }

    if( side >= 0)
    {
       HitAngle = 360 + (HitAngle* -1);
    }

    if ( HitAngle >= FrontLeftAngle || Hitangle < FrontRightAngle )
    {
	   InAngle= Acos(Normal(-HitRotation) dot Normal(X));
       InAngleDegrees = 90-(InAngle * 57.2957795131);

        //  Penetration Debugging
        if( bDebugPenetration )
        {
            //ClearStayingDebugLines();
            DrawStayingDebugLine( HitLocation, HitLocation + 2000*Normal(X),0, 255, 0);
            DrawStayingDebugLine( HitLocation, HitLocation + 2000*Normal(-HitRotation),255, 255, 0);
            Spawn(class 'ROEngine.RODebugTracer',self,,HitLocation,rotator(HitRotation));
       		log ("We hit the front of the gun!!!!");
       		log("InAngle = "$InAngle$" degrees "$InAngleDegrees);
        	log("PenetrationNumber = "$PenetrationNumber);
        	log("FrontArmorFactor = "$FrontArmorFactor);
        	log("Probability % = "$GetPenetrationProbability(InAngleDegrees));
        	log("Total Power = "$(PenetrationNumber * GetPenetrationProbability(InAngleDegrees)));
        	log("Final Calc = "$(FrontArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees)))$" Penetrated = "$!( (FrontArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees))) >= 0.01 ));
        }

		if( (FrontArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees))) >= 0.01 )
			return false;
		else
		    return true;
    }
    else if ( HitAngle >= FrontRightAngle && Hitangle < RearRightAngle )
    {
	   	InAngle= Acos(Normal(-HitRotation) dot Normal(-Y));
        InAngleDegrees = 90-(InAngle * 57.2957795131);

		//  Penetration Debugging
        if( bDebugPenetration )
        {
            //ClearStayingDebugLines();
            DrawStayingDebugLine( HitLocation, HitLocation + 2000*Normal(-Y),0, 255, 0);
            DrawStayingDebugLine( HitLocation, HitLocation + 2000*Normal(-HitRotation),255, 255, 0);
            Spawn(class 'ROEngine.RODebugTracer',self,,HitLocation,rotator(HitRotation));
           	log ("We hit the left side of the gun!!!!");
       		log("InAngle = "$InAngle$" degrees "$InAngleDegrees);
        	log("PenetrationNumber = "$PenetrationNumber);
        	log("SideArmorFactor = "$SideArmorFactor);
        	log("Probability % = "$GetPenetrationProbability(InAngleDegrees));
        	log("Total Power = "$(PenetrationNumber * GetPenetrationProbability(InAngleDegrees)));
        	log("Final Calc = "$(SideArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees)))$" Penetrated = "$!( (FrontArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees))) >= 0.01 ));
        }

		if( (SideArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees))) >= 0.01 )
			return false;
		else
		    return true;
    }
    else if ( HitAngle >= RearRightAngle && Hitangle < RearLeftAngle )
    {
		InAngle= Acos(Normal(-HitRotation) dot Normal(-X));
        InAngleDegrees = 90-(InAngle * 57.2957795131);

		//  Penetration Debugging
		if( bDebugPenetration )
        {
            //ClearStayingDebugLines();
            DrawStayingDebugLine( HitLocation, HitLocation + 2000*Normal(-X),0, 255, 0);
            DrawStayingDebugLine( HitLocation, HitLocation + 2000*Normal(-HitRotation),255, 255, 0);
            Spawn(class 'ROEngine.RODebugTracer',self,,HitLocation,rotator(HitRotation));
    		log ("We hit the back of the gun!!!!");
       		log("InAngle = "$InAngle$" degrees "$InAngleDegrees);
        	log("PenetrationNumber = "$PenetrationNumber);
        	log("RearArmorFactor = "$RearArmorFactor);
        	log("Probability % = "$GetPenetrationProbability(InAngleDegrees));
        	log("Total Power = "$(PenetrationNumber * GetPenetrationProbability(InAngleDegrees)));
        	log("Final Calc = "$(RearArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees)))$" Penetrated = "$!( (FrontArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees))) >= 0.01 ));
        }

		if( (RearArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees))) >= 0.01 )
			return false;
		else
		    return true;
    }
    else if ( HitAngle >= RearLeftAngle && Hitangle < FrontLeftAngle )
    {
	   	InAngle= Acos(Normal(-HitRotation) dot Normal(Y));
        InAngleDegrees = 90-(InAngle * 57.2957795131);

		//  Penetration Debugging
		if( bDebugPenetration )
        {
            //ClearStayingDebugLines();
            DrawStayingDebugLine( HitLocation, HitLocation + 2000*Normal(Y),0, 255, 0);
            DrawStayingDebugLine( HitLocation, HitLocation + 2000*Normal(-HitRotation),255, 255, 0);
            Spawn(class 'ROEngine.RODebugTracer',self,,HitLocation,rotator(HitRotation));
           	log ("We hit the right side of the gun!!!!");
       		log("InAngle = "$InAngle$" degrees "$InAngleDegrees);
        	log("PenetrationNumber = "$PenetrationNumber);
        	log("SideArmorFactor = "$SideArmorFactor);
        	log("Probability % = "$GetPenetrationProbability(InAngleDegrees));
        	log("Total Power = "$(PenetrationNumber * GetPenetrationProbability(InAngleDegrees)));
        	log("Final Calc = "$(SideArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees)))$" Penetrated = "$!( (FrontArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees))) >= 0.01 ));
        }

		if( (SideArmorFactor - (PenetrationNumber * GetPenetrationProbability(InAngleDegrees))) >= 0.01 )
			return false;
		else
		    return true;
    }
    else
    {
       //log ("We shoulda hit something!!!!");
       return false;
    }
}

function float ModifyThreat(float current, Pawn Threat)
{
	local vector to, t;
	local float r;

	if (Vehicle(Threat) != None)
	{
		current += 0.2;

        if (ROTreadCraft(Threat) != None)
		{
			current += 0.2;
			// big bonus points for perpendicular tank targets
			to = Normal(Threat.Location - Location);
			to.z = 0;
			t = Normal(vector(Threat.Rotation));
			t.z = 0;
			r = to dot t;
			if ( (r >= 0.90630 && r < -0.73135) || (r >= -0.73135 && r < 0.90630) )
				current += 0.3;
		}
		else if (ROWheeledVehicle(Threat) != None && ROWheeledVehicle(Threat).bIsAPC)
			current += 0.1;
		//Added for at-guns, this may be a little high, but generally if you hit an at-gun
        //       with any large caliber weapon it should cease to exist.
		else if (ATGun(Threat) != none)
            current += GunThreatFactor;
	}
	else
		current += 0.25;
	return current;
}

function exec DamageTank()
{
    Health /= 2;
}

//==============================================================================
// defaultproperties
//==============================================================================
defaultproperties
{
    GunThreatFactor=0.4

    // Hud stuff
	VehicleHudThreadsPosX(0)=0.35
	VehicleHudThreadsPosX(1)=0.65
	VehicleHudThreadsPosY=0.5
	VehicleHudThreadsScale=0.65
    VehicleHudEngine=none
	VehicleHudEngineX=0.0
	VehicleHudEngineY=0.0
	bVehicleHudUsesLargeTexture=false

	// Make the vehicle hud not be drawn
	bSpecialHUD=false  //true - turns on the driver HUD

	AmmoResupplySound=none

	// Positioning
    TouchMessage="Use the "
    VehiclePositionString="using an AT-Gun"
    VehicleNameString="AT-Gun"

    bMustBeTankCommander=false     //allow any player role to use it.
 	bMultiPosition=false

    // Engine and Movement stuff
    bDisableThrottle=true
 	EngineHealth=1

    // Default armor
    FrontArmorFactor=1
	SideArmorFactor=1
	RearArmorFactor=1

	ViewShakeRadius=100.0
	ViewShakeOffsetMag=(X=0.2,Y=0.0,Z=1.0)
	ViewShakeOffsetFreq=3.0

	// Physics and movement
    VehicleMass=5

    bHasHandbrake=True
	IdleRPM=0
	EngineRPMSoundRange=0
    SteerBoneAxis=none
    bMakeBrakeLights=False

	// Effects
    DestructionLinearMomentum=(Min=0.000000,Max=0.000000)
    DestructionAngularMomentum=(Min=0.000000,Max=0.000000)

    bSpecialTankTurning=false

    WaterDamage=0
    VehicleDrowningDamType=none
    RanOverDamageType=none
    CrushedDamageType=none
    StolenAnnouncement=none
	StolenSound=none
    RanOverSound=none
    DestroyedRoadKillDamageType=none

	BulletSounds(0)=sound'ProjectileSounds.Bullets.Impact_Metal'

    CollisionRadius=75.000000
    CollisionHeight=100.000000

    //Damage Effects
    DamagedEffectClass=class'ATCannonDamagedEffect'

    // Karma params
    Begin Object Class=KarmaParamsRBFull Name=KParams0
        KInertiaTensor(0)=1.000000
        KInertiaTensor(3)=3.000000
        KInertiaTensor(5)=3.000000
        KCOMOffset=(X=-0.0000,Z=-0.50000)
        KLinearDamping=0.050000
        KAngularDamping=0.050000
        KStartEnabled=True
        bKNonSphericalInertia=True
        bHighDetailOnly=False
        bClientOnly=False
        bKDoubleTickRate=True
        bDestroyOnWorldPenetrate=True
        bDoSafetime=True
        KFriction=0.500000
        KImpactThreshold=700.000000
        KMaxAngularSpeed=0.0
    End Object
    KParams=KarmaParamsRBFull'AHZ_ROVehicles.ATGun.KParams0'

    TreadVelocityScale=0.000000

    //Teuf - Turn off for the release
    bDebugPenetration=false //true
}
