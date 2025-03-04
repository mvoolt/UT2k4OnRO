//=============================================================================
// RODummyAttachment
//=============================================================================
// Player attachments that serve no function other than visual
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class RODummyAttachment extends Actor
	abstract;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// PostBeginPlay
//-----------------------------------------------------------------------------

simulated function PostBeginPlay()
{
	local Pawn P;

	P = Pawn(Owner);

	if (P == None)
		Destroy();

	P.AttachToBone(self, AttachmentBone);
}

//-----------------------------------------------------------------------------
// StaticPrecache
//-----------------------------------------------------------------------------

static function StaticPrecache(LevelInfo L)
{
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	bOnlyDrawIfAttached=true
	RemoteRole=ROLE_None
	DrawType=DT_Mesh
	bAcceptsProjectors=true
	bUseLightingFromBase=true
}