class ROSmallBloodDrops extends ProjectedDecal;

var texture Splats[3];

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
    ProjTexture = splats[Rand(3)];
    Super.PostBeginPlay();
}

defaultproperties
{
	LifeSpan=20//5
	// MergeTODO: Replace this with our own textures
	splats(0)=Texture'Effects_Tex.Drip_001'
	splats(1)=Texture'Effects_Tex.Drip_002'
	splats(2)=Texture'Effects_Tex.Drip_003'
	ProjTexture=Texture'Effects_Tex.Drip_001'
	RemoteRole=ROLE_None
    FOV=6
    bClipStaticMesh=True
    CullDistance=+7000.0
    DrawScale=0.15
}
