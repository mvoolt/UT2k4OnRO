//=============================================================================
// ROSMine
//=============================================================================
// German S-Mine 35/44
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class ROSMine extends ROMine
	notplaceable;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// Touch - The mine has a 4.5 second delay
//-----------------------------------------------------------------------------

singular function Touch(Actor Other)
{
	if (Pawn(Other) != None)
		SetTimer(4.5, false);
}

//-----------------------------------------------------------------------------
// Timer - Mine explodes
//-----------------------------------------------------------------------------

function Timer()
{
	HurtRadius(Damage, DamageRadius, MyDamageType, Momentum, Location + vect(0,0,64));
	SetCollision(false, false, false);
	SpawnExplosionEffects();
}

//-----------------------------------------------------------------------------
// SpawnExplosionEffects - Creates any effects for the explosion
//-----------------------------------------------------------------------------

function SpawnExplosionEffects()
{
	local RORocketExplosion RE;
	local int i;

	if (ExplosionSound != None)
		PlaySound(ExplosionSound,, 2.5 * TransientSoundVolume);

	RE = Spawn(class'RORocketExplosion',,, Location + vect(0,0,64));
	RE.RemoteRole = ROLE_SimulatedProxy;

	//Spawn(ExplosionDecal,Other,,HitLocation, rotator(-HitNormal));

	//if (ExplosionSound != None)
	//	PlaySound(ExplosionSound);

	//if (ExplodeEffect != None)
	//	Spawn(ExplodeEffect,,, Location + vect(0,0,64));

	for (i = 0; i < 25; i++)
		Spawn(class'ROSMineShrapnel',,, Location + vect(0,0,64), RotRand());
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	Damage=300
	DamageRadius=512
	MyDamageType=class'ROSMineDamType'
	Momentum=5000
	bAcceptsProjectors=false
	bUseCylinderCollision=true
	DrawType=DT_None
	bHidden=true
	CollisionRadius=4.0
	CollisionHeight=8.0
}
