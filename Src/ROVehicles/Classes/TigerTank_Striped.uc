//=============================================================================
// TigerTank_Striped
//=============================================================================
// Tiger Tank (Striped)
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2007 Tripwire Interactive LLC
// - Dayle Flowers
//=============================================================================

class TigerTank_Striped extends TigerTank;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.Tiger_stripe_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Tiger1_treads');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.Tiger_stripe_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Tiger1_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int_s');

	super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
	Skins(0)=Texture'axis_vehicles_tex2.ext_vehicles.Tiger_stripe_ext'
	//Skins(1)=Texture'axis_vehicles_tex.Treads.Tiger1_treadsnow'
	//Skins(2)=Texture'axis_vehicles_tex.Treads.Tiger1_treadsnow'

	PassengerWeapons(0)=(WeaponPawnClass=class'TigerCannonPawn_Striped',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'TigerMountedMGPawn_Striped',WeaponBone=MG_Placement)
}
