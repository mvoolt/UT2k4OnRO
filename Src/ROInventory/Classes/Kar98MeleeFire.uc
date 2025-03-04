//=============================================================================
// Kar98MeleeFire
//=============================================================================
// Melee firing for the Kar98
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class Kar98MeleeFire extends ROMeleeFire;

defaultproperties
{
// RO Variables
  	DamageType = class'Kar98BashDamType'
  	BayonetDamageType = class'Kar98BayonetDamType'

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
