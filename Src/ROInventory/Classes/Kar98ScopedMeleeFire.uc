//=============================================================================
// Kar98ScopedMeleeFire
//=============================================================================
// Melee firing for the Kar98 scoped
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class Kar98ScopedMeleeFire extends ROMeleeFire;

defaultproperties
{
// RO Variables
  	DamageType = class'Kar98ScopedBashDamType'

	BashBackAnim = bash_pullback
	BashHoldAnim = bash_hold
	BashAnim = bash_attack
	BashFinishAnim = bash_return

  	TraceRange = 75 			// Sets the attack range of the bash attack

// UT Variables
    BotRefireRate=0.25
    AimError=800
}
