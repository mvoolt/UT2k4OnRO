//=============================================================================
// RocketMarkDirt
//=============================================================================
// A blast texture for rocket that exploded on dirt
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 John "Ramm-Jaeger" Gibson
//=============================================================================


class RocketMarkDirt extends BlastMark;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	ProjTexture=Texture'Effects_Tex.explosions.rocketmark_dirt'
	DrawScale=0.7
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
