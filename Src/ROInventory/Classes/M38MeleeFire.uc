//=============================================================================
// M38MeleeFire
//=============================================================================
// Melee firing for the M38
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class M38MeleeFire extends ROMeleeFire;

defaultproperties
{
// RO Variables
  	DamageType = class'M38BashDamType'

	BashBackAnim = bash_pullback
	BashHoldAnim = bash_hold
	BashAnim = bash_attack
	BashFinishAnim = bash_return

  	TraceRange = 75 			// Sets the attack range of the bash attack

// UT Variables
    BotRefireRate=0.25
    AimError=800
}
