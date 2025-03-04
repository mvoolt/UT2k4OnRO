//=============================================================================
// TT33MeleeFire
//=============================================================================
// Melee firing for the TT33
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class TT33MeleeFire extends ROMeleeFire;

defaultproperties
{
// RO Variables
  	DamageType = class'TT33BashDamType'

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
