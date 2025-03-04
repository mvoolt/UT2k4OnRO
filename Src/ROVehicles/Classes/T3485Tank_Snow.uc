//===================================================================
// ROT34Tank
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Mighty Russian T34 tank
//===================================================================
class T3485Tank_Snow extends T3485Tank;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.T3485Snow_ext');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T3485_Treadsnow');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3485_int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3485_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.T3485Snow_ext');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T3485_Treadsnow');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3485_int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3485_int_s');

	super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
	Skins(0)=Texture'allies_vehicles_tex.ext_vehicles.T3485Snow_ext'
	Skins(1)=Texture'allies_vehicles_tex.Treads.T3485_Treadsnow'
	Skins(2)=Texture'allies_vehicles_tex.Treads.T3485_Treadsnow'
	DestroyedVehicleMesh=StaticMesh'allies_vehicles_stc.T3485_Snow_Destroyed'

	PassengerWeapons(0)=(WeaponPawnClass=class'T3485CannonPawn_Snow',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'T3485MountedMGPawn_Snow',WeaponBone=MG_Placement)
}
