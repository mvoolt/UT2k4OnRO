//===================================================================
// SeveredAppendageAttachment
// Copyright (C) 2005 Tripwire Interactive LLC
// John "Ramm-Jaeger"  Gibson
//
// Base class for body parts that get attached to a pawn after
// an appendage has been blown off
//===================================================================

class SeveredAppendageAttachment extends Actor
    abstract;

#exec OBJ LOAD FILE=..\Animations\gear_anm.ukx

static function PrecacheContent(LevelInfo Level)
{
	if ( !class'GameInfo'.static.UseLowGore() )
	{
		Level.AddPrecacheMaterial(Default.Skins[0]);
	}
}

defaultproperties
{
	DrawType = DT_Mesh

    bCollideWorld=false
    bCollideActors=false

    RemoteRole=ROLE_None

    Physics=PHYS_None
    Skins(0)=Texture'Effects_Tex.Gore_Effects'
}



