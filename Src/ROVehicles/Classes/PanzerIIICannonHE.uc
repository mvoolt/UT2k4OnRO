//===================================================================
// PanzerIIICannonHE
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// Panzer III tank cannon class with HE loadout
//===================================================================
class PanzerIIICannonHE extends PanzerIIICannon;

defaultproperties
{
    ProjectileClass=class'ROVehicles.PanzerIIICannonShell'
    PrimaryProjectileClass=class'ROVehicles.PanzerIIICannonShell'
    SecondaryProjectileClass=class'ROVehicles.PanzerIIICannonShellHE'

	ProjectileDescriptions(0)="AP"
	ProjectileDescriptions(1)="HE"
}
