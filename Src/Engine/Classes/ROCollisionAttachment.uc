//=============================================================================
// ROCollisionAttachment
//=============================================================================
// An additional collision cylinder to assist in detecting special traces
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 John Gibson
//=============================================================================

class ROCollisionAttachment extends Actor
	native;

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
	bUseCylinderCollision=true
	CollisionHeight=15.0
	CollisionRadius=28.0
}
