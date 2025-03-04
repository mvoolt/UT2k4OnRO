class CannonShellHE50MM extends HECannonShell;

defaultproperties
{
    ShellImpactDamage=class'ROTankShellImpactDamage'
    MyDamageType=class'HECannonShellDamageSmall'
    ImpactDamage=150
    //Physics=PHYS_Falling
    Damage=200.0
    DamageRadius=500.0
	HEPenetrationNumber=6
}
