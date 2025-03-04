//=============================================================================
// PPSH41MeleeFire
//=============================================================================
// Melee firing for the PPSH41
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PPSh41MeleeFire extends ROMeleeFire;

defaultproperties
{
// RO Variables
  	DamageType = class'PPSh41BashDamType'

	BashBackAnim = bash_pullback
	BashHoldAnim = bash_hold
	BashAnim = bash_attack
	BashFinishAnim = bash_return

  	TraceRange = 75 			// Sets the attack range of the bash attack

// UT Variables
    BotRefireRate=0.25
    AimError=800
}
