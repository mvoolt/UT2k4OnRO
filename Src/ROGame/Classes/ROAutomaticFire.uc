//=============================================================================
// ROAutomaticFire
//=============================================================================
// Automatic fire class
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John "Ramm-Jaeger" Gibson
//=============================================================================

class ROAutomaticFire extends ROProjectileFire
	abstract;

// Overriden to make the player stop firing when they switch to from ironsights
simulated function bool AllowFire()
{
	if( Weapon.IsInState('IronSightZoomIn') || Weapon.IsInState('IronSightZoomOut')
		|| Weapon.IsInState('TweenDown') || Instigator.bIsSprinting )
	{
		return false;
	}
	else
	{
		return super.AllowFire();
	}
}

defaultproperties
{
	//** Functionality **//
	bWaitForRelease = false // Set to true for non automatic weapons
	bPawnRapidFireAnim=true

    PreLaunchTraceDistance=1312.0 // 25 meters
}
