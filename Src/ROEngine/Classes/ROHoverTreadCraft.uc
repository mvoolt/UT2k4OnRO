//===================================================================
// ROHoverTreadCraft
//
// Copyright (C) 2006 Tripwire Interactive LLC
//
// Base Class for "hovertank" type hover vehicles - essentially the old
// ONSTreadCraft class
//===================================================================
class ROHoverTreadCraft extends ROVehicle
	abstract
	native
	nativereplication;

cpptext
{
	INT* GetOptimizedRepList(BYTE* Recent, FPropertyRetirement* Retire, INT* Ptr, UPackageMap* Map, UActorChannel* Channel);

#ifdef WITH_KARMA
	// Actor interface.
	virtual UBOOL Tick(FLOAT DeltaTime, enum ELevelTick TickType);
	virtual void PostNetReceive();

	// SVehicle interface.
	virtual void UpdateVehicle(FLOAT DeltaTime);

	// SHover interface.
	virtual void PackState();
#endif
}

var		array<vector>		ThrusterOffsets;

var()	float				HoverSoftness;
var()	float				HoverPenScale;
var()	float				HoverCheckDist;

var()	float				UprightStiffness;
var()	float				UprightDamping;

var()	float				MaxThrust;
var()	float				MaxSteerTorque;
var()	float				ForwardDampFactor;
var()   float               TurnDampFactor;
var()	float				LateralDampFactor;
var()   float               ParkingDampFactor;
var()	float				SteerDampFactor;
var()	float				PitchTorqueFactor;
var()	float				PitchDampFactor;
var()	float				BankTorqueFactor;
var()	float				BankDampFactor;

var()	float				InvertSteeringThrottleThreshold;

// Internal
var		float				BikeMPH;

var		float				OutputThrust;
var		float				OutputTurn;

// Replicated
struct native TreadCraftState
{
	var vector				ChassisPosition;
	var Quat				ChassisQuaternion;
	var vector				ChassisLinVel;
	var vector				ChassisAngVel;

	var byte				ServerThrust;
	var	byte				ServerTurn;
	var int                 ServerViewPitch;
	var int                 ServerViewYaw;
};

var		TreadCraftState		TreadState, OldTreadState;
var		KRigidBodyState		ChassisState;
var		bool				bNewTreadState;

replication
{
	reliable if (Role == ROLE_Authority)
		TreadState;
}

simulated event bool KUpdateState(out KRigidBodyState newState)
{
	// This should never get called on the server - but just in case!
	if(Role == ROLE_Authority || !bNewTreadState)
		return false;

	newState = ChassisState;
	bNewTreadState = false;

	return true;
	//return false;
}

simulated function PostNetBeginPlay()
{
	local vector RotX, RotY, RotZ;
	local KarmaParams kp;
	local KRepulsor rep;
	local int i;

    GetAxes(Rotation,RotX,RotY,RotZ);

	// Spawn and assign 'repulsors' to hold bike off the ground
	kp = KarmaParams(KParams);
	kp.Repulsors.Length = ThrusterOffsets.Length;

	for(i=0;i<ThrusterOffsets.Length;i++)
	{
    	rep = spawn(class'KRepulsor', self,, Location + ThrusterOffsets[i].X * RotX + ThrusterOffsets[i].Y * RotY + ThrusterOffsets[i].Z * RotZ);
    	rep.SetBase(self);
    	rep.bHidden = true;
    	kp.Repulsors[i] = rep;
    }

    Super.PostNetBeginPlay();
}

simulated event Destroyed()
{
	local KarmaParams kp;
	local int i;

	// Destroy repulsors
	kp = KarmaParams(KParams);
	for(i=0;i<kp.Repulsors.Length;i++)
    	kp.Repulsors[i].Destroy();

	Super.Destroyed();
}

simulated event SVehicleUpdateParams()
{
	local KarmaParams kp;
	local int i;

	Super.SVehicleUpdateParams();

	kp = KarmaParams(KParams);

    for(i=0;i<kp.Repulsors.Length;i++)
	{
        kp.Repulsors[i].Softness = HoverSoftness;
        kp.Repulsors[i].PenScale = HoverPenScale;
        kp.Repulsors[i].CheckDist = HoverCheckDist;
    }

	KSetStayUprightParams( UprightStiffness, UprightDamping );
}

//function DrawHUD(Canvas Canvas)
//{
//	local Color WhiteColor;
//	local float XL, YL;
//
//	Super.DrawHUD(Canvas);
//
//	WhiteColor = class'Canvas'.Static.MakeColor(255,255,255);
//	Canvas.DrawColor = WhiteColor;
//
//	Canvas.Style = ERenderStyle.STY_Normal;
//	Canvas.StrLen("TEST", XL, YL);
//
//	// Draw rev meter
//	Canvas.SetPos(MPHMeterPosX * Canvas.ClipX, MPHMeterPosY * Canvas.ClipY);
//	Canvas.DrawTileStretched(MPHMeterMaterial, (BikeMPH/MPHMeterScale) * Canvas.ClipX, MPHMeterSizeY * Canvas.ClipY);
//
//	Canvas.SetPos( MPHMeterPosX * Canvas.ClipX, (MPHMeterSizeY + MPHMeterPosY) * Canvas.ClipY + YL );
//    Canvas.Font = class'HUD'.Static.GetConsoleFont(Canvas);
//	Canvas.DrawText(BikeMPH);
//}

defaultproperties
{
	bSpecialHUD=true
}
