//=============================================================================
// MN9130MeleeFire
//=============================================================================
// Melee firing for the MN9130
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MN9130MeleeFire extends ROMeleeFire;

defaultproperties
{
// RO Variables
  	DamageType = class'MN9130BashDamType'
  	BayonetDamageType = class'MN9130BayonetDamType'

	BashBackAnim = bash_pullback
	BashHoldAnim = bash_hold
	BashAnim = bash_attack
	BashFinishAnim = bash_return
	BayoBackAnim = stab_pullback
	BayoHoldAnim = stab_hold
	BayoStabAnim = stab_attack
	BayoFinishAnim = stab_return

  	TraceRange = 75 			// Sets the attack range of the bash attack
  	BayonetTraceRange = 125   // Sets the attack range of the bayonet attack

// UT Variables
    BotRefireRate=0.25
    AimError=800
}
