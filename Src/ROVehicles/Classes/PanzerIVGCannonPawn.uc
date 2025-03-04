//=============================================================================
// PanzerIVGCannonPawn
//=============================================================================
// Panzer IVG Cannon Pawn
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2007 Tripwire Interactive LLC
// - Dayle Flowers
//=============================================================================

class  PanzerIVGCannonPawn extends PanzerIVF2CannonPawn;

defaultproperties
{
	VehiclePositionString="in a Panzer IV G cannon"
	VehicleNameString="Panzer IV G Cannon"
	GunClass=class'ROVehicles.PanzerIVGCannon'
	CameraBone=Turret

	// Driver head positions
	DriverPositions(0)=(ViewLocation=(X=95,Y=-15.0,Z=10.0),ViewFOV=30,PositionMesh=Mesh'axis_panzer4H_anm.panzer4H_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=6000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=19000,ViewNegativeYawLimit=-20000,bDrawOverlays=true,bExposed=false)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'axis_panzer4H_anm.panzer4H_turret_int',DriverTransitionAnim=VPanzer4_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=false)
	DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'axis_panzer4H_anm.panzer4H_turret_int',DriverTransitionAnim=VPanzer4_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=true)
	DriverPositions(3)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'axis_panzer4H_anm.panzer4H_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=True,bExposed=true)
}

