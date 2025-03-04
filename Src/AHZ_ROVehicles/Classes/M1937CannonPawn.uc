//==============================================================================
// M1937CannonPawn
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// M-1937 45mm AT Gun Cannon Pawn class
//==============================================================================
class M1937CannonPawn extends ATGunCannonPawn;

//==============================================================================
// defaultproperties
//==============================================================================
defaultproperties
{
	HudName="Gunner"
    VehiclePositionString="Using a M-1937 Gun"
	VehicleNameString="M-1937 AT-Gun"

    EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0

    ExitPositions(0)=(X=-60,Y=-5,Z=50)
    ExitPositions(1)=(X=-60,Y=-5,Z=60)
    ExitPositions(2)=(X=-60,Y=25,Z=50)
    ExitPositions(3)=(X=-60,Y=-25,Z=50)
    ExitPositions(4)=(X=0,Y=68,Z=50)
    ExitPositions(5)=(X=0,Y=-68,Z=50)
    ExitPositions(6)=(X=0,Y=68,Z=25)
    ExitPositions(7)=(X=0,Y=-68,Z=25)
    ExitPositions(8)=(X=-60,Y=-5,Z=25)
    ExitPositions(9)=(X=-90,Y=0,Z=50)
    ExitPositions(10)=(X=-90,Y=-45,Z=50)
    ExitPositions(11)=(X=-90,Y=45,Z=50)
    ExitPositions(12)=(X=-90,Y=0,Z=20)
    ExitPositions(13)=(X=-90,Y=0,Z=75)
    ExitPositions(14)=(X=-125,Y=0,Z=60)
    ExitPositions(15)=(X=-250,Y=0,Z=75)


    GunClass=class'M1937Cannon'
	CameraBone=Barrel
	FPCamPos=(X=0,Y=0,Z=0)  //(X=-50,Y=0,Z=50)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=false //true
	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=50,Z=120)
	TPCamDistance=300
	DrivePos=(X=0.0,Y=0.0,Z=0.0)

    bDrawDriverInTP=true
    bDrawMeshInFP=True

	DriverDamageMult=1.0
	bPCRelativeFPRotation=true
 	bHasAltFire=False

	WeaponFov=34 // X2.5
	PitchUpLimit=6000
	PitchDownLimit=64000

    RotateSound=Sound'Vehicle_Weapons.Turret.manual_gun_traverse'
    PitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    RotateAndPitchSound=Sound'Vehicle_Weapons.Turret.manual_gun_traverse'

    CannonScopeOverlay=texture'InterfaceArt_ahz_tex.Scopes.M1937_optics'
    CannonScopeCenter=texture'Vehicle_Optic.T3476_sight_mover'
	ScopePositionX=0.075
	ScopeCenterScaleX=2.0

    DriveAnim=crouch_idle_binoc

 	DriverPositions(0)=(ViewLocation=(X=-30.0,Y=-5.5,Z=3.0),ViewFOV=35,PositionMesh=Mesh'allies_ahz_45mm_anm.45mm_turret',DriverTransitionAnim=crouch_idle_binoc,ViewPitchUpLimit=6000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=3000,ViewNegativeYawLimit=-3000,bDrawOverlays=true,bExposed=true)   //On the sight
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_ahz_45mm_anm.45mm_turret',DriverTransitionAnim=crouch_idleiron_binoc,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=65536,ViewNegativeYawLimit=-65536,bDrawOverlays=false,bExposed=true)     //Looking over the gun shield
	DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'allies_ahz_45mm_anm.45mm_turret',DriverTransitionAnim=crouch_idleiron_binoc,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=65536,ViewNegativeYawLimit=-65536,bDrawOverlays=true,bExposed=true)       //Looking through binos                                                     //Bill - Looking over the gun shield with binos

    bMustBeTankCrew=false
 	bHasFireImpulse=True

    BinocPositionIndex=2

    // Use the custom 45mm textures.
    AmmoShellTexture=Texture'InterfaceArt_ahz_tex.Tank_Hud.45mmShell'
    AmmoShellReloadTexture=Texture'InterfaceArt_ahz_tex.Tank_Hud.45mmShell_reload'
}


