//=============================================================================
// ROObjSatchel
//=============================================================================
// Objective triggered by satchel explosion
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROObjSatchel extends ROObjective
	placeable;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// Trigger - Allows some other Actor to complete this objective
//-----------------------------------------------------------------------------

function Trigger(Actor Other, Pawn EventInstigator)
{
	local PlayerReplicationInfo SavedPRI;

    if( EventInstigator != none && EventInstigator.PlayerReplicationInfo != none )
    {
        SavedPRI = EventInstigator.PlayerReplicationInfo;
    }
    else if ( ROSatchelChargeProjectile(Other) != none && ROSatchelChargeProjectile(Other).SavedPRI != none)
	{
	     SavedPRI = ROSatchelChargeProjectile(Other).SavedPRI;
    }

    if ( !bActive || ROTeamGame(Level.Game) == None || !ROTeamGame(Level.Game).IsInState('RoundInPlay')
		|| SavedPRI == none || SavedPRI.Team == none )
		return;

	if ( ObjState== OBJ_Neutral)
	{
	   ObjectiveCompleted(SavedPRI, SavedPRI.Team.TeamIndex);
    }
    else
    {
    	if (ObjState == OBJ_Axis)
    		ObjectiveCompleted(SavedPRI, ALLIES_TEAM_INDEX);
    	else if (ObjState == OBJ_Allies)
    		ObjectiveCompleted(SavedPRI, AXIS_TEAM_INDEX);
    }
}

//-----------------------------------------------------------------------------
// HandleCompletion - Overridden
//-----------------------------------------------------------------------------

function HandleCompletion(PlayerReplicationInfo CompletePRI, int Team)
{
	bActive = false;

	if (CompletePRI != None)
	{
        Level.Game.ScoreObjective(CompletePRI, 10);
	}

	BroadcastLocalizedMessage(class'ROObjectiveMsg', Team + 2, None, None, self);
}

//-----------------------------------------------------------------------------
// WithinArea - Function to identify satchels within the area
//-----------------------------------------------------------------------------

function bool WithinArea(Actor Satchel)
{
	if (AttachedVolume != None)
	{
		if (AttachedVolume.Encompasses(Satchel))
			return true;
	}
	else if (VSize(Satchel.Location - Location) < Radius)
	{
		return true;
	}

	return false;
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	Texture=Texture'InterfaceArt_tex.OverheadMap.ROObjectiveSatchel'
}
