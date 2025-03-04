//==============================================================================
// CannonShellHE45MM
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// Cannon Shell HE 45MM class
//==============================================================================
class CannonShellHE45MM extends HECannonShell;

//==============================================================================
// defaultproperties
//==============================================================================
defaultproperties
{
    ShellImpactDamage=class'ROTankShellImpactDamage'
    MyDamageType=class'HECannonShellDamageSmall'
    ImpactDamage=135
    //Physics=PHYS_Falling
    Damage=180.0
    DamageRadius=450.0
	HEPenetrationNumber=5
}
