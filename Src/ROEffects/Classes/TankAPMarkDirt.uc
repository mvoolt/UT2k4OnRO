//=============================================================================
// TankAPMarkDirt
//=============================================================================
// A blast texture for ap tank shell that exploded on dirt
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 John "Ramm-Jaeger" Gibson
//=============================================================================


class TankAPMarkDirt extends BlastMark;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	ProjTexture=Texture'Effects_Tex.explosions.aptankmark_dirt'
	DrawScale=1.0
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
