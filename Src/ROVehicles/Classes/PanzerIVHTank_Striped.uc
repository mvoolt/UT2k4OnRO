//=============================================================================
// PanzerIVHTank_Striped
//=============================================================================
// Panzer IVH Tank (Striped)
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2007 Tripwire Interactive LLC
// - Dayle Flowers
//=============================================================================

class PanzerIVHTank_Striped extends PanzerIVHTank;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.panzer4_stripe_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4F2_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.panzer4F2_treads');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.panzer4_stripe_armor_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4f2_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.panzer4_stripe_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4F2_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.panzer4F2_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.panzer4_stripe_armor_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4f2_int_s');

	super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
	Skins(0)=Texture'axis_vehicles_tex2.ext_vehicles.panzer4_stripe_ext'
	//Skins(1)=Texture'axis_vehicles_tex.Treads.Panzer4F2_treads'
	//Skins(2)=Texture'axis_vehicles_tex.Treads.Panzer4F2_treads'
	Skins(3)=Texture'axis_vehicles_tex2.ext_vehicles.panzer4_stripe_armor_ext'

	PassengerWeapons(0)=(WeaponPawnClass=class'PanzerIVHCannonPawn_Striped',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'PanzerIVHMountedMGPawn_Striped',WeaponBone=MG_Placement)
}

