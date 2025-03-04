class RORocketImpactDamage extends ROWeaponProjectileDamageType
	abstract;

defaultproperties
{
	DeathString="%o was killed by %k's Rocket."
	MaleSuicide="%o was careless with his Rocket."
	FemaleSuicide="%o was careless with her Rocket."

//	WeaponClass=class'RORocketWeapon'

	GibModifier=10.0

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'

	bDetonatesGoop=true
	bDelayedDamage=true
	bLocationalHit=true
	bKUseOwnDeathVel=true
	KDamageImpulse=4000
	KDeathVel=225
	KDeathUpKick=100

	HUDIcon=Texture'InterfaceArt_tex.deathicons.Generic'

	TankDamageModifier=1.0
	APCDamageModifier=1.0
	VehicleDamageModifier=1.0
	TreadDamageModifier=1.0
}

