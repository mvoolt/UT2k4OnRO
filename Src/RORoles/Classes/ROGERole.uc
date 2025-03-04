//=============================================================================
// ROGERole.
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROGERole extends RORoleInfo
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	Side=SIDE_Axis
	VoiceType="ROGame.ROGerman1Voice"
	AltVoiceType="ROGame.ROGerman1Voice"
	SleeveTexture=Texture'Weapons1st_tex.german_sleeves'
	DetachedArmClass=class'SeveredArmGerTunic'
	DetachedLegClass=class'SeveredLegGerTunic'
}
