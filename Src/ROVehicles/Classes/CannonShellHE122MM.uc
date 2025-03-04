class CannonShellHE122MM extends HECannonShell;

defaultproperties
{
    ShellImpactDamage=class'ROTankShellImpactDamage'
    MyDamageType=class'HECannonShellDamageLarge'
    ImpactDamage=400
    //Physics=PHYS_Falling
    Damage=550.0
    DamageRadius=1200.0
	HEPenetrationNumber=12
}
