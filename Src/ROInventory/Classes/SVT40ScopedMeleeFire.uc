//=============================================================================
// SVT40MeleeFire
//=============================================================================
// Melee firing for the SVT40
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class SVT40ScopedMeleeFire extends ROMeleeFire;

defaultproperties
{
// RO Variables
  	DamageType = class'SVT40BashDamType'

	BashBackAnim = bash_pullback
	BashHoldAnim = bash_hold
	BashAnim = bash_attack
	BashFinishAnim = bash_return

  	TraceRange = 75 			// Sets the attack range of the bash attack

// UT Variables
    BotRefireRate=0.25
    AimError=800
}
