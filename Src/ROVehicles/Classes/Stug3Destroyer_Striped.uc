//=============================================================================
// Stug3Destroyer_Striped
//=============================================================================
// Stug3 Destroyer (Striped)
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2007 Tripwire Interactive LLC
// - Dayle Flowers
//=============================================================================

class Stug3Destroyer_Striped extends Stug3Destroyer;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.Stug3_stripe_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treads');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Stug3_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.stug3_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.Stug3_stripe_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Stug3_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.stug3_int_s');

	super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
	Skins(0)=Texture'axis_vehicles_tex2.ext_vehicles.Stug3_stripe_ext'
	//Skins(1)=Texture'axis_vehicles_tex.Treads.Stug3_treadsnow'
	//Skins(2)=Texture'axis_vehicles_tex.Treads.Stug3_treadsnow'

	PassengerWeapons(0)=(WeaponPawnClass=class'Stug3CannonPawn_Striped',WeaponBone=Turret_Placement)
}
