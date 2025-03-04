//==============================================================================
// ATGunCannon
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// AT-Gun Cannon class
//==============================================================================
class ATGunCannon extends ROTankCannon;

//==============================================================================
// Variables
//==============================================================================
var     sound       ReloadSoundReady;    //The reload sound
var     sound       FireSoundCmdr;       //The command to fire sound

var     float       CrewSoundVolume;     //Sound volume for crew commands

//==============================================================================
// Functions
//==============================================================================

// TakeDamage - overloaded to allow nade, bayonet, and bash attacks to the driver.
function TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex)
{
	//log("ATGunCannon-Damage Type = "$DamageType, 'Teuf');

    // Fix for suicide death messages
    if (DamageType == class'Suicided')
    {
	    DamageType = class'ROSuicided';
	    ROVehicleWeaponPawn(Owner).TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
	}
	else if (DamageType == class'ROSuicided')
	{
		ROVehicleWeaponPawn(Owner).TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
	}

    //Added ability for gunner to take nade, bash, and bayonet damage
    if( HitDriver(Hitlocation, Momentum) || ClassIsChildOf(DamageType,class'ROGrenadeDamType') || ClassIsChildOf(DamageType,class'ROWeaponBashDamageType') || ClassIsChildOf(DamageType,class'ROWeaponBayonetDamageType') )
	{
 		 //log("ATGunCannon-Take Damage, CP1", 'Teuf');
         ROVehicleWeaponPawn(Owner).TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
	}
    //log("ATGunCannon-Take Damage, CP2", 'Teuf');
}

// There aren't any angles that are below the driver angle for the AT Gun cannon
simulated function bool BelowDriverAngle(vector loc, vector ray)
{
	return false;
}


// Limit the left and right movement of the gun
simulated function int LimitYaw(int yaw)
{
    local int NewYaw;
	local ROVehicleWeaponPawn PwningPawn;

    PwningPawn = ROVehicleWeaponPawn(Owner);

    if ( !bLimitYaw )
    {
        return yaw;
    }

    NewYaw = yaw;

    if( PwningPawn != none )
    {
	   	if( yaw > PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewPositiveYawLimit)
	   	{
	   		NewYaw = PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewPositiveYawLimit;
	   	}
	   	else if( yaw < PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewNegativeYawLimit )
	   	{
	   		NewYaw = PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewNegativeYawLimit;
	  	}
  	}
  	else
  	{
	   	if( yaw > MaxPositiveYaw )
	   	{
	   		NewYaw = MaxPositiveYaw;
	   	}
	   	else if( yaw < MaxNegativeYaw )
	   	{
	   		NewYaw = MaxNegativeYaw;
	  	}
    }


  	return NewYaw;
}

//Overrode to allow a faster reload time and play 'reloaded' gun command.
simulated function Timer()
{
   if ( VehicleWeaponPawn(Owner) == none || VehicleWeaponPawn(Owner).Controller == none )
   {
      //log(" Returning because there is no controller");
      SetTimer(0.05,true);
   }
   else if ( CannonReloadState == CR_Empty )
   {
         if (Role == ROLE_Authority)
	     {
              PlayOwnedSound(ReloadSoundOne, SLOT_Misc, FireSoundVolume/255.0,, 150,, false);
         }
         else
         {
              PlaySound(ReloadSoundOne, SLOT_Misc, FireSoundVolume/255.0,, 150,, false);
         }

         CannonReloadState = CR_ReloadedPart3;
         SetTimer(GetSoundDuration(ReloadSoundOne),false);
   }
   else if ( CannonReloadState == CR_ReloadedPart3 )
   {
         if (Role == ROLE_Authority)
	     {
              PlayOwnedSound(ReloadSoundFour, SLOT_Misc, FireSoundVolume/255.0,, 150,, false);
         }
         else
         {
              PlaySound(ReloadSoundFour, SLOT_Misc, FireSoundVolume/255.0,, 150,, false);
         }
         CannonReloadState = CR_ReloadedPart4;
         SetTimer(GetSoundDuration(ReloadSoundFour),false);
   }
   else if ( CannonReloadState == CR_ReloadedPart4 )
   {
		if(Role == ROLE_Authority)
		{
			bClientCanFireCannon = true;
		    PlayOwnedSound(ReloadSoundReady, SLOT_Misc, CrewSoundVolume/255.0,, 150, , false);
        }
		else
		{
		    PlaySound(ReloadSoundReady, SLOT_Misc, CrewSoundVolume/255.0,, 150, , false);
        }

        SetTimer(GetSoundDuration(ReloadSoundReady),false);

        CannonReloadState = CR_ReadyToFire;
		SetTimer(0.0,false);
   }
}

// Overridden so we can get the crew 'fire' command.
function Projectile SpawnProjectile(class<Projectile> ProjClass, bool bAltFire)
{
	local Projectile P;

    // Play firing noise
    //Note to self: When you hold down the fire button you can get an "auto-fire".  The sounds do not replicate to the gunner when on a server.
    //    This is because there is no 'replication' for the sound.  It is the same thing for a tank cannon.  The t-60 replicates because they have it in there.
    //    I put the replicate in and it does work, but there is a server load cost.  Since an AT-Gun is not setup for auto-fire and it didn't work for the tanks I took it out.
	if ( !bAltFire && !bAmbientFireSound )
	{
		if(Role == ROLE_Authority)
		{
            PlayOwnedSound(FireSoundCmdr, SLOT_None, FireSoundVolume/255.0,, 150, , false);
        }
		else
		{
		    PlaySound(FireSoundCmdr, SLOT_None, FireSoundVolume/255.0,, 150, , false);
        }
        SetTimer(GetSoundDuration(FireSoundCmdr),false);
    }

    super.SpawnProjectile(ProjectileClass, False);

	return P;
}

//==============================================================================
// defaultproperties
//==============================================================================
defaultproperties
{
    TankShootClosedAnim=shoot_open
}


