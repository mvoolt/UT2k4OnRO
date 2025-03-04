//================================================================
// ROWeaponProjectileDamageType
//
// started by Antarian 1/18/04
//
// Master class for all Red Orchestra projectile damage.  This includes
//	bullets and shrapnel
//================================================================

class ROWeaponProjectileDamageType extends ROWeaponDamageType
	abstract;

defaultproperties
{
	LowDetailEmitter=ROEffects.ROBloodPuffSmall
	LowGoreDamageEmitter=ROEffects.ROBloodPuffNoGore
    KDeathVel=115.000000 // move to each weapon separately
    KDamageImpulse=1250
	KDeathUpKick=5
	// Make this bullet move the ragdoll when its shot
	bRagdollBullet=true
	bLocationalHit=true
}
