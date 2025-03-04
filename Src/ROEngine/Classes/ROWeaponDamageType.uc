//=============================================================================
// ROWeaponDamageType
//=============================================================================
// Adds HUD icons.
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class ROWeaponDamageType extends WeaponDamageType
	abstract;

//=============================================================================
// Variables
//=============================================================================

var	Material	HUDIcon;
var float TankDamageModifier;   // Tank damage
var float APCDamageModifier;    // HT type vehicle damage
var float VehicleDamageModifier;// Standard vehicle damage
var float TreadDamageModifier;   // Tank damage
var bool bCauseViewJarring; // Causes the player to be 'struck' and shake


//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	HUDIcon=Texture'InterfaceArt_tex.deathicons.Generic'
	bKUseOwnDeathVel=True

	TankDamageModifier=0.0
	APCDamageModifier=0.0
	VehicleDamageModifier=0.10
	TreadDamageModifier=0.0
	bExtraMomentumZ=false
	bCauseViewJarring = false;
}
