//=============================================================================
// ROBulletWhipAttachment
//=============================================================================
// An additional collision cylinder for detecting precision hit traces or
// projectiles as well as detecting bullets passing by which allows for the
// creation of bullet whip sound effects.
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 John Gibson
//=============================================================================

class ROBulletWhipAttachment extends ROCollisionAttachment;

// Don't damage anything when this is hit, it is for sounds only
function TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex)
{
	return;
}

// Don't do anything
function SetDelayedDamageInstigatorController(Controller C)
{
	return;
}

defaultproperties
{
	DrawType=DT_None
	// Debug draw
	//DrawType=DT_Sprite
	//Texture=S_Actor
	//DrawScale=+00001.000000
	//DrawScale=+00000.0100000
	//DrawScale3D=(X=1,Y=1,Z=1)

	bCollideActors=True
	bCollideWorld=False
	bBlockKarma=False
	bIgnoreEncroachers=True
	bBlockActors=False
	bProjTarget=True
	bBlockHitPointTraces=True
	bUseCylinderCollision=true
	CollisionHeight=150.0
	CollisionRadius=150.0
}
