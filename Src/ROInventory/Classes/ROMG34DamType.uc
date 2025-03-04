//=============================================================================
// ROMG34DamType
//=============================================================================

class ROMG34DamType extends ROWeaponProjectileDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was killed by %k's MG-34."
	MaleSuicide="%o turned the gun on himself."
	FemaleSuicide="%o turned the gun on herself."

	WeaponClass=class'MG34Weapon'

	GibModifier=0.0
    KDeathVel=115.000000
    KDamageImpulse=2250
	KDeathUpKick=5

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'

	HUDIcon=Texture'InterfaceArt_tex.deathicons.b792mm'
}
