//=============================================================================
// MP41Fire
//=============================================================================
// Bullet firing class for the MP41 SMG
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MP41Fire extends MP40Fire;

defaultproperties
{
    //** Projectile firing **//
    ProjectileClass = class'MP41Bullet'
	Spread = 410

    //** Shell Ejection **//
	ShellIronSightOffset=(X=15,Y=0,Z=0)

    //** Recoil **//
  	maxVerticalRecoilAngle=700
  	maxHorizontalRecoilAngle=400

    //** View shake **//
    ShakeOffsetMag=(X=3.0,Y=1.0,Z=3.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=1.0
    ShakeRotMag=(X=50.0,Y=50.0,Z=150.0)
    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=0.5

    //** Recoil modifiers **//
    PctStandIronRecoil = .90   // this is the percentage of recoil felt compared to firing from the hip
    PctCrouchRecoil = 0.75      	// this is the percentage of recoil felt compared to standing
    PctCrouchIronRecoil = 0.60  	// this is the percentage of recoil felt compared to standard crouch
    PctProneRecoil = 0.6        // this is the percantage of recoil felt compared to standing
    PctProneIronRecoil = 0.50    // this is the percentage of recoil felt compared to standard prone
    RecoilRate=0.075
}
