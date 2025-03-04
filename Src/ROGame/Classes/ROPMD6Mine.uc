//=============================================================================
// ROPMD6Mine
//=============================================================================
// Russian PMD-6 AP mine
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class ROPMD6Mine extends ROMine
	notplaceable;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	Damage=175
	DamageRadius=64
	MyDamageType=class'ROMineDamType'
	Momentum=3000
	bAcceptsProjectors=false
	bUseCylinderCollision=true
	DrawType=DT_None
	bHidden=true
	CollisionRadius=6.0
	CollisionHeight=8.0
}