//=============================================================================
// SVT40MeleeFire
//=============================================================================
// Melee firing for the SVT40
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class SVT40MeleeFire extends ROMeleeFire;

function PlayFireEnd()
{
	if( Weapon.bBayonetMounted )
	{
		// No tween time for the post stab anim, as it causes a visual glitch on this weapon - Hacky, but works for now
        Weapon.PlayAnim(BayoFinishAnim, FireEndAnimRate, 0.0/*TweenTime*/);
	}
	else
	{
	    if( Weapon.AmmoAmount(0) < 1 && Weapon.HasAnim(BashFinishEmptyAnim))
	    {
			Weapon.PlayAnim(BashFinishEmptyAnim, FireEndAnimRate, TweenTime);
		}
		else
		{
			Weapon.PlayAnim(BashFinishAnim, FireEndAnimRate, TweenTime);
		}
    }
}

defaultproperties
{
// RO Variables
  	DamageType = class'SVT40BashDamType'
  	BayonetDamageType = class'SVT40BayonetDamType'

	BashBackAnim = bash_pullback
	BashHoldAnim = bash_hold
	BashAnim = bash_attack
	BashFinishAnim = bash_return
	BayoBackAnim = stab_pullback
	BayoHoldAnim = stab_hold
	BayoStabAnim = stab_attack
	BayoFinishAnim = stab_return

  	TraceRange = 75 			// Sets the attack range of the bash attack
  	BayonetTraceRange = 115   // Sets the attack range of the bayonet attack

// UT Variables
    BotRefireRate=0.25
    AimError=800
}
