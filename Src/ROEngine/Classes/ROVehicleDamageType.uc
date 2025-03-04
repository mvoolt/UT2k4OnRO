class ROVehicleDamageType extends WeaponDamageType//DamageType
	abstract;

//=============================================================================
// Variables
//=============================================================================

var	Material	HUDIcon;
var float TankDamageModifier;   // Tank damage
var float APCDamageModifier;    // HT type vehicle damage
var float VehicleDamageModifier;// Standard vehicle damage
var float TreadDamageModifier;   // Tank damage


//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	HUDIcon=Texture'InterfaceArt_tex.deathicons.Generic'
	bKUseOwnDeathVel=True

	TankDamageModifier=0.0
	APCDamageModifier=0.025
	VehicleDamageModifier=0.05
	TreadDamageModifier=0.0
}
