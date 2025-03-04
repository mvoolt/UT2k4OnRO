//=============================================================================
// ROMG34DamType
//=============================================================================

class ROVehMountedMGDamType extends ROWeaponProjectileDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was killed by %k's mounted MG."
	MaleSuicide="%o turned the gun on himself."
	FemaleSuicide="%o turned the gun on herself."

//	WeaponClass=class'ROWeapon'

	GibModifier=0.0
    KDeathVel=115.000000
    KDamageImpulse=1250
	KDeathUpKick=5

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'

	HUDIcon=Texture'InterfaceArt_tex.deathicons.b792mm'

	TankDamageModifier=0.0
	APCDamageModifier=0.1
	VehicleDamageModifier=0.35
}
