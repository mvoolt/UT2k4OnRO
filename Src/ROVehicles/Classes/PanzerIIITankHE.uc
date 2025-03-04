//===================================================================
// PanzerIIITankHE
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// Panzer 3 light tank class with HE loadout
//===================================================================
class PanzerIIITankHE extends PanzerIIITank;

defaultproperties
{
	// Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=class'PanzerIIICannonPawnHE',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'PanzerIIIMountedMGPawn',WeaponBone=MG_Placement)

}
