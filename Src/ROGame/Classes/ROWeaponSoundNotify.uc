//===================================================================
// ROWeaponSoundNotify
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Custom weapon sound notify class. Had to add this because the
// stock UT ones don't play correctly when your standing on BSP
//===================================================================

class ROWeaponSoundNotify extends CustomSoundNotify;

event Notify( Actor Owner )
{
      if ( ROWeapon(Owner) != none && ROWeapon(Owner).Instigator !=none && ROWeapon(Owner).Instigator.IsFirstPerson())
      {
            ROWeapon(Owner).PlayWeaponSound(Sound,Volume,Radius);
      }
      else if (VehicleHUDOverlay(Owner) != none)
      {
      	  Owner.PlaySound(Sound,,Volume,false,Radius);
	  }
}


