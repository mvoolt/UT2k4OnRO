//=====================================================
// RO3rdShellEject
// started by Antarian 1/7/04
//
// Copyright (C) 2004 Jeffrey Nakai
//
// This is the base shell ejection class for the third person shells.
//=====================================================

class RO3rdShellEject extends ROShellEject
	abstract
	placeable;

simulated function PostBeginPlay()
{
	super(Projectile).PostBeginPlay();

	LifeSpan = +10.00;

	speed = default.speed + rand(70);

	Velocity = speed * vector(Rotation);			// set the Velocity
	Velocity.X += rand(40);			// give a random speed increase to the x factor
	Velocity.Y += rand(20);			// give a random speed increase to the y factor
    Velocity.Z += rand(20);			// give a random speed increase to the z factor

	RandSpin(150000);

	Acceleration = 0.5 * PhysicsVolume.Gravity;
}

defaultproperties
{
	bOwnerNoSee = true
}
