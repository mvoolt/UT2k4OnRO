//=============================================================================
// ROShrapnelChunk
//=============================================================================
// Piece of shrapnel. *OBSOLETE* - It's better to just do shrapnel damage directly rather than through a projectile
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class ROShrapnelChunk extends Projectile;

//=============================================================================
// Variables
//=============================================================================

// Constants
const ScaleFactor = 16.0;
const MinPenetrateVelocity = 300;

var	float	DamageAtten;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// PostBeginPlay - Give it a random speed
//-----------------------------------------------------------------------------

function PostBeginPlay()
{
	local rotator dir;

	dir.Yaw = 65355 * FRand();
	dir.Roll = 0;
	dir.Pitch = 16384 * FRand(); //2048 + 14336 * FRand();

	Speed = 1000 + Rand(500);
	Velocity = Speed * vector(dir);
}

//-----------------------------------------------------------------------------
// ProcessTouch
//-----------------------------------------------------------------------------

function ProcessTouch(Actor Other, Vector HitLocation)
{
	//local float	V;

	//if (Other == Instigator)
	//	return;

	//V = VSize(Velocity) / ScaleFactor;

	//if (V > MinPenetrateVelocity)
		Other.TakeDamage(Damage + 2 * FRand() * Damage /*- DamageAtten * FMax(0, (default.LifeSpan - LifeSpan - 1)))*/, Instigator, HitLocation, MomentumTransfer * (Velocity / Speed), MyDamageType);

	Destroy();
}

//-----------------------------------------------------------------------------
// HitWall
//-----------------------------------------------------------------------------

function HitWall(vector HitNormal, actor Wall)
{
	if ( Mover(Wall) != None )
		Wall.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);

    //Spawn(class'ROShortDustPuff', Wall,,Location, rotator(-HitNormal));
	Destroy();
}

//-----------------------------------------------------------------------------
// Landed
//-----------------------------------------------------------------------------

function Landed(vector HitNormal)
{
	HitWall(HitNormal, None);
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	Physics=PHYS_Falling
	RemoteRole=ROLE_None
	Style=STY_Alpha
	ScaleGlow=1.0
	DrawType=DT_None
	//StaticMesh=StaticMesh'WeaponStaticMesh.FlakChunk'
	MyDamageType=class'ROGrenShrapnelDamType'
	Speed=3500.000000
	MaxSpeed=5000.000000
	Damage=35
	DamageAtten=15.0
	MomentumTransfer=200
	LifeSpan=5.0
	AmbientGlow=254
	DrawScale=14.0
	CollisionRadius=24.0
	CollisionHeight=24.0
}
