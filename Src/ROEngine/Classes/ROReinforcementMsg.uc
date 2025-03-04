//=============================================================================
// ROReinforcementMsg
//=============================================================================
// Message when reinforcements run low
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROReinforcementMsg extends LocalMessage;

//=============================================================================
// Variables
//=============================================================================

var(Messages) localized string LowReinforcements;
var(Messages) localized string NoReinforcements;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// GetString
//-----------------------------------------------------------------------------

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	switch (Switch)
	{
		case 0:
			return default.LowReinforcements;
		case 1:
			return default.NoReinforcements;
	}
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	LowReinforcements="Running Low on Reinforcements!"
	NoReinforcements="Reinforcements Are Depleted!"
	bBeep=false
	bFadeMessage=false
	bIsUnique=false
	DrawColor=(R=255,G=255,B=255,A=255)
	FontSize=1
	LifeTime=5
	PosX=0.5
	PosY=0.75  // used to be 0.5, moved to get it out of the middle
}
