//=============================================================================
// ROSchuMine
//=============================================================================
// German Schu-Mine 42
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class ROSchuMine extends ROMine
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
	CollisionRadius=8.0
	CollisionHeight=8.0
}