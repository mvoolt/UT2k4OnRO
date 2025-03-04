//=============================================================================
// VoicePack.
//=============================================================================
class VoicePack extends Info
	abstract;


var() localized string VoicePackName;
var() localized string VoicePackDescription;	// Do I need this? Hint text maybe?

/*
ClientInitialize() sets up playing the appropriate voice segment, and returns a string
 representation of the message
*/
function ClientInitialize(PlayerReplicationInfo Sender, PlayerReplicationInfo Recipient, name messagetype, byte messageIndex);
static function PlayerSpeech(name Type, int Index, string Callsign, Actor PackOwner);

// if _RO_
static function xPlayerSpeech(name Type, int Index, PlayerReplicationInfo SquadLeader, Actor PackOwner);
// end if _RO_

static function byte GetMessageIndex(name PhraseName)
{
	return 0;
}

static function int PickRandomTauntFor(controller C, bool bNoMature, bool bNoHumanOnly)
{
	return 0;
}

defaultproperties
{
	bStatic=false
	LifeSpan=+10.0
    RemoteRole=ROLE_None
}
