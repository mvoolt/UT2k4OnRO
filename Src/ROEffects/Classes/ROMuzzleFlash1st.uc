//=============================================================================
// ROMuzzleFlash1st
//=============================================================================
// 1st person muzzle flash
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John Gibson
//=============================================================================

class ROMuzzleFlash1st extends Emitter;

simulated function Trigger(Actor Other, Pawn EventInstigator)
{
	Emitters[0].SpawnParticle(1);
}

defaultproperties
{
	DrawScale=1.00000
	Style=STY_Additive

    bNoDelete=false
    RemoteRole=ROLE_None
    bDirectional=True
    bOnlyOwnerSee=false//true
    bHardAttach=true

}
