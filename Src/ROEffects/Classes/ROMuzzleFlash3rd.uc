//=============================================================================
// ROMuzzleFlash3rd
//=============================================================================
// 3rd person muzzle flash
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John Gibson
//=============================================================================

class ROMuzzleFlash3rd extends Emitter;

simulated function Trigger(Actor Other, Pawn EventInstigator)
{
	Emitters[0].SpawnParticle(1);
}

defaultproperties
{
    bUnlit=False
    bNoDelete=False
    bHardAttach=True
	RemoteRole=ROLE_None
	Physics=PHYS_None
	bBlockActors=False
	CullDistance=20000.0
	Style=STY_Additive
}
