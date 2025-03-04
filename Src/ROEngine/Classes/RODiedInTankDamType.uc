//-----------------------------------------------------------
//  RODiedInTankDamType
//  Copyright (C) 2007 Tripwire Interactive
//
//  Created July 2007 by Stephen Timothy Cooney
//
//  Used when a player dies in a tank. Acts as a specific
//  marker to the game engine.
//-----------------------------------------------------------
class RODiedInTankDamType extends DamageType;

DefaultProperties
{
	DeathString="%k blew up %o's vehicle!"
	MaleSuicide="%o blew up his own tank."
	FemaleSuicide="%o blew up her own tank."

    GibPerterbation=0.5
    GibModifier=2.0
    bLocationalHit=false
    bNeverSevers=true
    bKUseTearOffMomentum=true
    bExtraMomentumZ=false
    bVehicleHit=true

    HumanObliterationThreshhold=-1000000
    bAlwaysGibs = true;
}
