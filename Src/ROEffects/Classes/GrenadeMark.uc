//=============================================================================
// GrenadeMark
//=============================================================================
// A blast texture for grenades
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 John "Ramm-Jaeger" Gibson
//=============================================================================


class GrenadeMark extends BlastMark;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DrawScale=0.5
	bGameRelevant=true
	PushBack=24
	LifeSpan=30
	FOV=1
	MaxTraceDistance=60
	bProjectBSP=true
	bProjectTerrain=true
	bProjectStaticMesh=true
	bProjectActor=false
}
