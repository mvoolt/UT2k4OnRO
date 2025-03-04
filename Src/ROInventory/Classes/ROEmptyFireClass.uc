//=====================================================
// ROEmptyFireClass
// started by Antarian 4/17/04
//
// Copyright (C) 2004 Jeffrey Nakai
//
// Empty fire class for weapons that don't use a secondary fire
//=====================================================

class ROEmptyFireClass extends ROWeaponFire;


event ModeDoFire()
{
}

defaultproperties
{
    //ROSmokeEmitterClass = None   // to prevent trying to add smoke emmiters
}


