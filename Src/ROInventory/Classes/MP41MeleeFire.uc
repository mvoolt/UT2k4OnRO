//=============================================================================
// MP41MeleeFire
//=============================================================================
// Melee firing for the MP41
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MP41MeleeFire extends MP40MeleeFire;

defaultproperties
{
// RO Variables
  	DamageType = class'MP41BashDamType'

	GroundBashSound=sound'Inf_Weapons_Foley.melee.butt_hit_ground'
	PlayerBashSound=sound'Inf_Weapons_Foley.melee.butt_hit'

  	TraceRange = 85 			// Sets the attack range of the bash attack
}
