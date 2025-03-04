class ROTankShellImpactDamage extends ROWeaponDamageType
	abstract;

defaultproperties
{
	DeathString="%o was killed by %k's tank shell."
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
	bLocationalHit=true
	KDamageImpulse=5000
    KDeathVel=350.000000
	KDeathUpKick=50
	bArmorStops=false

	TankDamageModifier=1.0
	APCDamageModifier=1.0
	VehicleDamageModifier=1.0
	TreadDamageModifier=1.0

	HumanObliterationThreshhold=150

	DeathOverlayMaterial=Material'Effects_Tex.PlayerDeathOverlay'
	DeathOverlayTime=999
}

