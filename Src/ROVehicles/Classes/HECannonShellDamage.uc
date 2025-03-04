class HECannonShellDamage extends ROTankShellExplosionDamage;
	//abstract;

defaultproperties
{
	DeathString="%o was killed by %k's tank shell shrapnel."
	MaleSuicide="%o fired his shell prematurely."
	FemaleSuicide="%o fired her shell prematurely."

	HUDIcon=Texture'InterfaceArt_tex.deathicons.Strike'

	GibModifier=4.0

//	WeaponClass=class'ROVehicleWeapon'
	bDetonatesGoop=true
	VehicleMomentumScaling=1.3
	bThrowRagdoll=true
	GibPerterbation=0.15
	bFlaming=true
	bDelayedDamage=true
	//VehicleClass=class'ROTreadCraft'
	bLocationalHit=false
	KDamageImpulse=5000
    KDeathVel=300.000000
	KDeathUpKick=60
	bExtraMomentumZ=true
	KDeadLinZVelScale=0.0020
	KDeadAngVelScale=0.0030

	TankDamageModifier=0.05
	APCDamageModifier=0.25
	VehicleDamageModifier=0.5
	TreadDamageModifier=0.25

	HumanObliterationThreshhold=265

	DeathOverlayMaterial=Material'Effects_Tex.PlayerDeathOverlay'
	DeathOverlayTime=999
}
