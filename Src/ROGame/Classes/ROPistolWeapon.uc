//===================================================================
// ROPistolWeapon
// started by Antarian 8/5/03
//
// Copyright (C) 2003 Jeffrey Nakai
//
// Base class for the Red Orchestra Pistol Weapons
//===================================================================

class ROPistolWeapon extends ROProjectileWeapon
	abstract;

// Overridden so we don't play idle empty anims after a reload
simulated state Reloading
{
	simulated function PlayIdle()
	{
		if( bUsingSights )
	    {
			LoopAnim(IronIdleEmptyAnim, IdleAnimRate, 0.2 );
	    }
		else
	    {
			LoopAnim(IdleAnim, IdleAnimRate, 0.2 );
	    }
	}
}

// Overriden to prevent the exploit of freezing your animations after firing
simulated function AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if (ClientState == WS_ReadyToFire)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim) && !FireMode[0].bIsFiring )
        {
            PlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, FastTweenTime);
        }
        else if (anim == ROProjectileFire(FireMode[0]).FireIronAnim && !FireMode[0].bIsFiring)
        {
            PlayIdle();
        }
        else if (anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
        {
            PlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        }
        else if ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))
        {
            PlayIdle();
        }
    }
}

// Overriden to prevent the exploit of freezing your animations after firing
simulated event StopFire(int Mode)
{
	if ( FireMode[Mode].bIsFiring )
	    FireMode[Mode].bInstantStop = true;
    if (Instigator.IsLocallyControlled() && !FireMode[Mode].bFireOnRelease)
    {
     	if( !IsAnimating(0) )
     	{
     		PlayIdle();
     	}
    }

    FireMode[Mode].bIsFiring = false;
    FireMode[Mode].StopFiring();
    if (!FireMode[Mode].bFireOnRelease)
        ZeroFlashCount(Mode);
}

defaultproperties
{
	InventoryGroup=3
	Priority=5
}


