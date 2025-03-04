//===================================================================
// PanzerIVF1Cannon
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Panzer 4 tank cannon class
//===================================================================
class PanzerIVF1Cannon extends PanzerIVF2Cannon;

DefaultProperties
{
    Mesh=Mesh'axis_panzer4F1_anm.panzer4F1_turret_ext'
    skins(0)=Texture'axis_vehicles_tex.ext_vehicles.Panzer4F1_ext'
    skins(1)=Texture'axis_vehicles_tex.int_vehicles.Panzer4F2_int'
    BeginningIdleAnim=com_idle_close
	CannonFireSound(0)=sound'Vehicle_Weapons.PanzerIV_F2.75mm_S_fire01'
	CannonFireSound(1)=sound'Vehicle_Weapons.PanzerIV_F2.75mm_S_fire02'
	CannonFireSound(2)=sound'Vehicle_Weapons.PanzerIV_F2.75mm_S_fire03'
    ProjectileClass=class'ROVehicles.PanzerIVF1CannonShell'
    PrimaryProjectileClass=class'ROVehicles.PanzerIVF1CannonShell'
    SecondaryProjectileClass=class'ROVehicles.PanzerIVF1CannonShellHE'
    WeaponFireOffset=110

    FireInterval=9

    // RO Vehicle sound vars
    ReloadSoundOne=Sound'Vehicle_reloads.Reloads.Pz_IV_F1_Reload_01'
    ReloadSoundTwo=Sound'Vehicle_reloads.Reloads.Pz_IV_F1_Reload_02'
    ReloadSoundThree=Sound'Vehicle_reloads.Reloads.Pz_IV_F1_Reload_03'
    ReloadSoundFour=Sound'Vehicle_reloads.Reloads.Pz_IV_F1_Reload_04'
    RotateSound=Sound'Vehicle_Weapons.Turret.electric_turret_traverse'
    SoundVolume=200

	// Ammo
	InitialPrimaryAmmo=40
	InitialSecondaryAmmo=40
	InitialAltAmmo=150
	ReloadSound=sound'Vehicle_reloads.MG34_ReloadHidden'
	NumAltMags=4
}
