//=============================================================================
// ROHeadgear
//=============================================================================
// Headgear dummy attachment
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROHeadgear extends RODummyAttachment
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	AttachmentBone=head

	// Make headgear have the same lighting properties as the pawn
	// even after they are detached
	MaxLights=8
    ScaleGlow=1.0
	AmbientGlow=5
	bDramaticLighting = true
}
