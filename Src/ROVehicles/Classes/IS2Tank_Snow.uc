//===================================================================
// IS2Tank_Snow
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// IS2 tank, snow version
//===================================================================
class IS2Tank_Snow extends IS2Tank;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.IS2_int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.IS2_int_s');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.IS2snow_ext');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.IS2_treadsnow');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.IS2_int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.IS2_int_s');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.IS2snow_ext');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.IS2_treadsnow');

	super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
	Skins(0)=Texture'allies_vehicles_tex.ext_vehicles.IS2snow_ext'
	Skins(1)=Texture'allies_vehicles_tex.Treads.IS2_treadsnow'
	Skins(2)=Texture'allies_vehicles_tex.Treads.IS2_treadsnow'
	DestroyedVehicleMesh=StaticMesh'allies_vehicles_stc.IS2_Snow_destroyed'

	PassengerWeapons(0)=(WeaponPawnClass=class'IS2CannonPawn_Snow',WeaponBone=Turret_Placement)
}
