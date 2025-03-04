//==============================================================================
// RODemolitionVolume
//
// Use this volume for any demolition targets within Red Orchestra
//==============================================================================

class RODemolitionVolume extends Volume;

var			bool			bCompleted;
var()      	name			DetonationEvent;		// Mapper specified 'detonation' event
var()		bool			bIsObjective;

function Reset()
{
	bCompleted = false;
}

//-----------------------------------------------------------------------------
// Trigger - Calls TriggerEvent if there's a specified tag that's given
//-----------------------------------------------------------------------------
function Trigger(Actor Other, Pawn EventInstigator)
{
	if (bCompleted || ROTeamGame(Level.Game) == None || !ROTeamGame(Level.Game).IsInState('RoundInPlay'))
		return;

	if( DetonationEvent != '' )
	{
		TriggerEvent(DetonationEvent, Other, EventInstigator);
		bCompleted = true;
	};
}

defaultproperties
{
}
