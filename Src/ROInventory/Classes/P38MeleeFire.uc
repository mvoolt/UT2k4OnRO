//=============================================================================
// P38MeleeFire
//=============================================================================
// Melee firing for the P38
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class P38MeleeFire extends ROMeleeFire;

defaultproperties
{
// RO Variables
  	DamageType = class'P38BashDamType'

	BashBackAnim = bash_pullback
	BashBackEmptyAnim = bash_pullback_empty
	BashHoldAnim = bash_hold
	BashHoldEmptyAnim = bash_hold_empty
	BashAnim = bash_attack
	BashEmptyAnim = bash_attack_empty
	BashFinishAnim = bash_return
	BashFinishEmptyAnim = bash_return_empty

  	TraceRange = 75 			// Sets the attack range of the bash attack

    GroundBashSound=sound'Inf_Weapons_Foley.melee.pistol_hit_ground'
    PlayerBashSound=sound'Inf_Weapons_Foley.melee.pistol_hit'
// UT Variables
    BotRefireRate=0.25
    AimError=800
}
