//===================================================================
// BT7CannonPawn
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// BT7 tank cannon pawn class
//===================================================================
class BT7CannonPawn extends RussianTankCannonPawn;

var ROTreadCraftWithRiders           TankRider;

//==============================================================================
// Functions
//==============================================================================

replication
{
    reliable if (Role == ROLE_Authority)
        TankRider;
}


function bool TryToDrive(Pawn P)
{
	local int x;

    if (VehicleBase != None)
	{
		if (VehicleBase.NeedsFlip())
		{
			VehicleBase.Flip(vector(P.Rotation), 1);
			return false;
		}

		if (P.GetTeamNum() != Team)
		{
			if (VehicleBase.Driver == None)
				return VehicleBase.TryToDrive(P);

			VehicleLocked(P);
			return false;
		}
	}

	if( bMustBeTankCrew && !ROPlayerReplicationInfo(P.Controller.PlayerReplicationInfo).RoleInfo.bCanBeTankCrew && P.IsHumanControlled())
	{
	   	TankRider = ROTreadCraftWithRiders(GetVehicleBase());

        //They mut be a non-tanker role so let's go through the available rider positions and find a place for them to sit.
        //Check first to ensure riders are allowed.
        if (TankRider != None)
        {
            if ( !TankRider.bAllowRiders )
            {
                DenyEntry( P, 3 );
                return false;
            }
        }
        else
        {
            log("BT7CannonPawn-TryToDrive, TankRider = none");

            DenyEntry( P, 3 );
            return false;
        }

        //cycle through the available passanger positions.  Check the class type to see if it is ROPassengerPawn
        for (x = 1; x < VehicleBase.WeaponPawns.length; x++)    //skip over the turret
        {
            //If riders are allowed, the WeaponPawn is free and it is a passenger pawn class then climb aboard.
            if ( VehicleBase.WeaponPawns[x].Driver == none && VehicleBase.WeaponPawns[X].IsA('ROPassengerPawn') )
			{
                VehicleBase.WeaponPawns[x].KDriverEnter(P);
                return true;
			}
        }

        DenyEntry( P, 4 );
	    return false;
    }

    //Over-ride ROVehicleWeaponPawn "TryToDrive"
	return super(VehicleWeaponPawn).TryToDrive(P);
}


//==============================================================================
// Default Properties
//==============================================================================
defaultproperties
{
	VehiclePositionString="in a BT7 cannon"
	VehicleNameString="BT7 Cannon"
    EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=200,Z=100)
	ExitPositions(1)=(X=0,Y=-200,Z=100)
    GunClass=class'BT7Cannon'
    CameraBone=Turret
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0) //was 0
	bFPNoZFromCameraPitch=False
	TPCamLookat=(X=-25,Y=0,Z=0)  //was 0
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=8.0,Y=-3.0,Z=-5.0)    //adjusted to move right and down
    bDrawDriverInTP=True //False
	bDrawMeshInFP=True
	DriverDamageMult=1.0
	bPCRelativeFPRotation=true

    WeaponFov=34 // 2.5X
	PitchUpLimit=6000
    PitchDownLimit=64000

    RotateSound=Sound'Vehicle_Weapons.Turret.manual_turret_traverse'
    PitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    RotateAndPitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_traverse'
    SoundVolume=140

    CannonScopeOverlay=texture'InterfaceArt_ahz_tex.Scopes.M1937_optics'
    CannonScopeCenter=texture'Vehicle_Optic.T3476_sight_mover'
	ScopePositionX=0.075
	ScopeCenterScaleX=2.0

    DriveAnim=VPanzer4_com_idle_close                                                                                                                                                                                                                                                                                                                                                                                //teuf

    // Driver positions                                                                                                            //VT3476_com_close
	DriverPositions(0)=(ViewLocation=(X=55,Y=-10,Z=1),ViewFOV=34,PositionMesh=Mesh'allies_ahz_bt7_anm.BT7_turret_int',DriverTransitionAnim=VPanzer4_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=6000,ViewPitchDownLimit=64500,ViewPositiveYawLimit=19000,ViewNegativeYawLimit=-20000,bDrawOverlays=true,bExposed=false)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_ahz_bt7_anm.BT7_turret_int',DriverTransitionAnim=VT3476_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=62000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=true)
	DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'allies_ahz_bt7_anm.BT7_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=5000,ViewPitchDownLimit=62000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=true,bExposed=true)

    BinocPositionIndex=2

    // Use the custom 45mm textures.
    AmmoShellTexture=Texture'InterfaceArt_ahz_tex.Tank_Hud.45mmShell'
    AmmoShellReloadTexture=Texture'InterfaceArt_ahz_tex.Tank_Hud.45mmShell_reload'

    PositionInArray=0
}

