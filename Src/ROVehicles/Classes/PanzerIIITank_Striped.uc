//=============================================================================
// PanzerIIITank_Striped
//=============================================================================
// Panzer III Tank (Striped)
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2007 Tripwire Interactive LLC
// - Dayle Flowers
//=============================================================================

class PanzerIIITank_Striped extends PanzerIIITank;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.PZ3_stripe_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Panzer3_treads');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.PZ3_stripe_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Panzer3_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int_s');

    super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
    Skins(0)=Texture'axis_vehicles_tex2.ext_vehicles.PZ3_stripe_ext'

    PassengerWeapons(0)=(WeaponPawnClass=class'PanzerIIICannonPawn_Striped',WeaponBone=Turret_Placement)
    PassengerWeapons(1)=(WeaponPawnClass=class'PanzerIIIMountedMGPawn_Striped',WeaponBone=MG_Placement)
}
