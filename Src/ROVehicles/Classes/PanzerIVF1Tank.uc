//===================================================================
// PanzerIVF1Tank
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Panzer 4 F1 tank class
//===================================================================
class PanzerIVF1Tank extends PanzerIVF2Tank;

#exec OBJ LOAD FILE=..\Animations\axis_panzer4F1_anm.ukx

static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Panzer4F1_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4F2_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.panzer4F1_treads');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Panzer4F1_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4F2_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.panzer4F1_treads');

	Super.UpdatePrecacheMaterials();
}

defaultproperties
{
	// Display

	Skins(0)=Texture'axis_vehicles_tex.ext_vehicles.Panzer4F1_ext'
	Skins(1)=Texture'axis_vehicles_tex.Treads.panzer4F1_treads'
	Skins(2)=Texture'axis_vehicles_tex.Treads.panzer4F1_treads'
	Skins(3)=Texture'axis_vehicles_tex.int_vehicles.Panzer4F2_int'

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.panzer4F1_body'
	VehicleHudTurret=TexRotator'InterfaceArt_tex.Tank_Hud.panzer4F1_turret_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt_tex.Tank_Hud.panzer4F1_turret_look'
	VehicleHudOccupantsX(0)=0.45
	VehicleHudOccupantsX(1)=0.50
	VehicleHudOccupantsX(2)=0.55

	// Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=class'PanzerIVF1CannonPawn',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'PanzerIVF1MountedMGPawn',WeaponBone=MG_Placement)

	VehiclePositionString="in a Panzer IV F1"
	VehicleNameString="Panzer IV F1"

	GearRatios(0)=-0.200000
	GearRatios(1)=0.200000
	GearRatios(2)=0.350000
	GearRatios(3)=0.550000
	GearRatios(4)=0.670000

	// Destruction
	DestroyedVehicleMesh=StaticMesh'axis_vehicles_stc.Panzer4F1_Destroyed'
}

