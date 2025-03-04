//===================================================================
// SU76CannonPawn
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// SU76 tank destroyer cannon pawn
//==================================================================

class  SU76CannonPawn extends AssaultGunCannonPawn;

// Overriden because the animation needs to play on the server for this vehicle for the commanders hit detection
function ServerChangeViewPoint(bool bForward)
{
	if (bForward)
	{
		if ( DriverPositionIndex < (DriverPositions.Length - 1) )
		{
			LastPositionIndex = DriverPositionIndex;
			DriverPositionIndex++;

			if(  Level.Netmode == NM_Standalone  || Level.NetMode == NM_ListenServer )
			{
				NextViewPoint();
			}

			if( Level.NetMode == NM_DedicatedServer )
			{
				AnimateTransition();
			}
		}
     }
     else
     {
		if ( DriverPositionIndex > 0 )
		{
			LastPositionIndex = DriverPositionIndex;
			DriverPositionIndex--;

			if(  Level.Netmode == NM_Standalone || Level.Netmode == NM_ListenServer )
			{
				NextViewPoint();
			}

			if( Level.NetMode == NM_DedicatedServer )
			{
				AnimateTransition();
			}
		}
     }
}

defaultproperties
{
	VehiclePositionString="in a SU76 cannon"
	VehicleNameString="SU76 Cannon"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=class'ROVehicles.SU76Cannon'
	CannonScopeOverlay=texture'Vehicle_Optic.Su76_sight'
	CameraBone=turret
	FPCamPos=(X=0,Y=0,Z=0)//(X=50,Y=-30,Z=11)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=true
	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	// Temp until we have a real attachment bone
	DrivePos=(X=0.0,Y=0.0,Z=0.0)
	bDrawDriverInTP=true//False
	bDrawMeshInFP=True
	DriverDamageMult=1.0
	bHasAltFire=False
	bPCRelativeFPRotation=true

	WeaponFov=34 // 2.5X
	PitchUpLimit=6000
	PitchDownLimit=64000

    RotateSound=Sound'Vehicle_Weapons.Turret.manual_gun_traverse'
    PitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    RotateAndPitchSound=Sound'Vehicle_Weapons.Turret.manual_gun_traverse'

    DriveAnim=VSU76_com_idle_close

 	bHasFireImpulse=True
	FireImpulse=(X=-70000,Y=0.0,Z=0.0)

	// Driver head positions
	DriverPositions(0)=(ViewLocation=(X=85,Y=-10.0,Z=11.0),ViewFOV=34,PositionMesh=Mesh'allies_su76_anm.SU76_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=6000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=3000,ViewNegativeYawLimit=-3000,bDrawOverlays=true,bExposed=true)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_su76_anm.SU76_turret_int',DriverTransitionAnim=VSU76_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=65536,ViewNegativeYawLimit=-65536,bDrawOverlays=false,bExposed=true)
	DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_su76_anm.SU76_turret_int',DriverTransitionAnim=VSU76_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=65536,ViewNegativeYawLimit=-65536,bDrawOverlays=false,bExposed=true)
	DriverPositions(3)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'allies_su76_anm.SU76_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=65536,ViewNegativeYawLimit=-65536,bDrawOverlays=True,bExposed=true)

	AmmoShellTexture=Texture'InterfaceArt_tex.Tank_Hud.T3476_SU76_Kv1shell'
	AmmoShellReloadTexture=Texture'InterfaceArt_tex.Tank_Hud.T3476_SU76_Kv1shell_reload'
}

