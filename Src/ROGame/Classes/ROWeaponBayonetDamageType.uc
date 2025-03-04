//================================================================
// ROWeaponBayonetDamageType
//
// started by Antarian 12/26/03
//
// Master class for all Red Orchestra knife-based damage.  This will
//	include bayonet damage and eventually knife damage.
//	Only includes damage classes with the 'Bayonet' -prefix or the
//	'Knife' -prefix
//================================================================

class ROWeaponBayonetDamageType extends ROWeaponBayonetDamType
	abstract;

defaultproperties
{
	bLocationalHit=true

	HUDIcon=Texture'InterfaceArt_tex.deathicons.knife'
	KDamageImpulse=1000
	KDeathUpKick=10
    KDeathVel=100.000000
    bCauseViewJarring = true;
}
