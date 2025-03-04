//=============================================================================
// ArtilleryMarkDirt
//=============================================================================
// A blast texture for artillery that exploded on dirt
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 John "Ramm-Jaeger" Gibson
//=============================================================================


class ArtilleryMarkDirt extends BlastMark;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	ProjTexture=Texture'Effects_Tex.explosions.artillerymark_dirt'
	DrawScale=1.5
	bGameRelevant=true
	PushBack=24
	LifeSpan=15
	FOV=1
	MaxTraceDistance=60
	bProjectBSP=true
	bProjectTerrain=true
	bProjectStaticMesh=true
	bProjectActor=false
}
