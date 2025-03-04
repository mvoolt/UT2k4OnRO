//================================================================
// ROWeaponBashDamageType
//
// started by Antarian 12/26/03
//
// Master class for all Red Orchestra bash damage.  DOES NOT INCLUDE
// 	BAYONET OR KNIFE DAMAGE.  Only includes damage classes with the
//	'CC'-prefix in it
//================================================================

class ROWeaponBashDamageType extends ROWeaponBashDamType
	abstract;

defaultproperties
{
	bLocationalHit=true

	HUDIcon=Texture'InterfaceArt_tex.deathicons.buttsmack'
	KDamageImpulse=2000
	KDeathUpKick=25
    KDeathVel=100.000000
    bCauseViewJarring = true;
}
