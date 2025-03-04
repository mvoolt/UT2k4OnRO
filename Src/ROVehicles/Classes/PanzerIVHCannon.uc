//===================================================================
// PanzerIVHCannon
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Panzer 4 tank cannon class
//===================================================================
class PanzerIVHCannon extends PanzerIVF2Cannon;

DefaultProperties
{
    Mesh=Mesh'axis_panzer4H_anm.panzer4H_turret_ext'
    skins(0)=Texture'axis_vehicles_tex.ext_vehicles.Panzer4F2_ext'
    skins(1)=Texture'axis_vehicles_tex2.ext_vehicles.Panzer4H_Armor'
    skins(2)=Texture'axis_vehicles_tex.int_vehicles.Panzer4F2_int'
   	HighDetailOverlayIndex=2

    ProjectileClass=class'ROVehicles.PanzerIVHCannonShell'
    PrimaryProjectileClass=class'ROVehicles.PanzerIVHCannonShell'
    SecondaryProjectileClass=class'ROVehicles.PanzerIVHCannonShellHE'
}
