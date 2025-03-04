//===================================================================
// ROT34Tank
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Mighty Russian T34 76 tank
//===================================================================
class T3476Tank extends T3485Tank;

#exec OBJ LOAD FILE=..\Animations\allies_t3476_anm.ukx

static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.T3476_ext');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T3476_treads');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3476_int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.t3476_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.T3476_ext');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T3476_treads');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3476_int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.t3476_int_s');

	Super.UpdatePrecacheMaterials();
}


defaultproperties
{
	// Display

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.T3476_body'
	VehicleHudTurret=TexRotator'InterfaceArt_tex.Tank_Hud.T3476_turret_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt_tex.Tank_Hud.T3476_turret_look'

	DriveAnim=VT3476_driver_idle_close

	Skins(0)=Texture'allies_vehicles_tex.ext_vehicles.T3476_ext'
	Skins(1)=Texture'allies_vehicles_tex.Treads.T3476_treads'
	Skins(2)=Texture'allies_vehicles_tex.Treads.T3476_treads'
	Skins(3)=Texture'allies_vehicles_tex.int_vehicles.T3476_int'

	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.t3476_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

	// Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=class'T3476TankCannonPawn',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'T3485MountedTankMGPawn',WeaponBone=MG_Placement)

	// Position Info
//	DriverAttachmentBone=driver_attachment
//	DriverPositions(0)=(PositionMesh=Mesh'allies_vehicles_anm.t3476_body_int',DriverTransitionAnim=VT3476_driver_close,TransitionUpAnim=driver_hatch_open,ViewPitchUpLimit=0,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,ViewFOV=85,bDrawOverlays=true)
//	DriverPositions(1)=(PositionMesh=Mesh'allies_vehicles_anm.t3476_body_int',DriverTransitionAnim=VT3476_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=5500,ViewPitchDownLimit=63500,ViewPositiveYawLimit=11000,ViewNegativeYawLimit=-12500,bExposed=true)

	VehiclePositionString="in a T34/76"
	VehicleNameString="T34/76"

	// Driver overlay
	HUDOverlayClass=class'ROVehicles.T3476DriverOverlay'
	HUDOverlayOffset=(X=0,Y=0,Z=0)
	HUDOverlayFOV=85

	// Destruction
	DestroyedVehicleMesh=StaticMesh'allies_vehicles_stc.T3476_Destroyed'
}
