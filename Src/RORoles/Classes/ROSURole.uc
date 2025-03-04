//=============================================================================
// ROSURole.
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROSURole extends RORoleInfo
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	Side=SIDE_Allies
	VoiceType="ROGame.RORussian1Voice"
	AltVoiceType="ROGame.RORussian1Voice"
	SleeveTexture=Texture'Weapons1st_tex.russian_sleeves'
	DetachedArmClass=class'SeveredArmSovTunic'
	DetachedLegClass=class'SeveredLegSovTunic'
}
