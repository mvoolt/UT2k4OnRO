//=============================================================================
// ROBloodSplatter
//=============================================================================
// Blood splatter from someone getting shot
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// John "Ramm-Jaeger" Gibson
// Based off of the old XGame.BloodSplatter
//=============================================================================
class ROBloodSplatter extends ProjectedDecal;

var texture Splats[6];

event PreBeginPlay()
{
	if ( Level.DetailMode > 1 )
	{
		CullDistance = CullDistance*3;
	}
	else if ( Level.DetailMode < 2 && Level.DetailMode > 0 )
	{
		CullDistance = CullDistance*1.5;
	}

	Super.PreBeginPlay();
}


simulated function PostBeginPlay()
{
    ProjTexture = splats[Rand(6)];
    Super.PostBeginPlay();
}

defaultproperties
{
	LifeSpan=20
	splats(0)=Texture'Effects_Tex.Splatter_001'
	splats(1)=Texture'Effects_Tex.Splatter_002'
	splats(2)=Texture'Effects_Tex.Splatter_003'
	splats(3)=Texture'Effects_Tex.Splatter_004'
	splats(4)=Texture'Effects_Tex.Splatter_005'
	splats(5)=Texture'Effects_Tex.Splatter_006'
	ProjTexture=Texture'Effects_Tex.Splatter_001'
	RemoteRole=ROLE_None
    FOV=6
    bClipStaticMesh=True
    CullDistance=0//+7000.0
    DrawScale=0.25
}
