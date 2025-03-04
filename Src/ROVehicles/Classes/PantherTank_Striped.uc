//=============================================================================
// PantherTank_Striped
//=============================================================================
// Panther Tank (Striped)
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2007 Tripwire Interactive LLC
// - Dayle Flowers
//=============================================================================

class PantherTank_Striped extends PantherTank;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.pantherg_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.pantherg_int_s');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.pantherg_stripe_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.PantherG_treads');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.pantherg_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.pantherg_int_s');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.pantherg_stripe_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.PantherG_treads');

	super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
	Skins(0)=Texture'axis_vehicles_tex2.ext_vehicles.pantherg_stripe_ext'
	//Skins(1)=Texture'axis_vehicles_tex.Treads.PantherG_treadsnow'
	//Skins(2)=Texture'axis_vehicles_tex.Treads.PantherG_treadsnow'

	PassengerWeapons(0)=(WeaponPawnClass=class'PantherCannonPawn_Striped',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'PantherMountedMGPawn_Striped',WeaponBone=MG_Placement)
}
