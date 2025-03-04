//=============================================================================
// SVT40MeleeFire
//=============================================================================
// Melee firing for the MP40
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MP40MeleeFire extends ROMeleeFire;

defaultproperties
{
// RO Variables
  	DamageType = class'MP40BashDamType'

	BashBackAnim = bash_pullback
	BashHoldAnim = bash_hold
	BashAnim = bash_attack
	BashFinishAnim = bash_return

  	TraceRange = 75 			// Sets the attack range of the bash attack

    GroundBashSound=sound'Inf_Weapons_Foley.melee.pistol_hit_ground'

// UT Variables
    BotRefireRate=0.25
    AimError=800
}
