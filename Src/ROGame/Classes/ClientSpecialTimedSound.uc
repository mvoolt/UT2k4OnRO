//=============================================================================
// ClientSpecialTimedSound
//=============================================================================
// An actor to play a specific sound at a specific time on network clients or offline
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class ClientSpecialTimedSound extends ClientSideTriggeredSound
	placeable;

var(ClientSpecialTimedSound) int SecondsTimeToTrigger;
var(ClientSpecialTimedSound) name SpecialTimedEvent;

simulated event PostNetBeginPlay()
{
    if( Level.NetMode != NM_DedicatedServer )
        SetTimer(1.0, true);
}

simulated event Timer()
{
    local GameReplicationInfo GRI;
    local PlayerController PC;
    local float CurrentTime;

    PC = Level.GetLocalPlayerController();

    if( PC != none )
    {
        GRI = Level.GetLocalPlayerController().GameReplicationInfo;

        if( GRI != none && GRI.bMatchHasBegun)
        {
            CurrentTime = FMax(0.0, GRI.RoundStartTime + GRI.RoundDuration - GRI.ElapsedTime);

            // Give about a 5 second buffer here, otherwise it can get off when things are out of sync during a reset
            if( CurrentTime < SecondsTimeToTrigger && ((SecondsTimeToTrigger - CurrentTime) < 5))
            {
                Trigger(self, none);
                TriggerEvent(SpecialTimedEvent, self, None);
                SetTimer(0.0, false);
            }
        }
    }
}

simulated function Reset()
{
    super.Reset();

    // Restart the timer when the round restarts
    if( Level.NetMode != NM_DedicatedServer )
        SetTimer(1.0, true);
}

defaultproperties
{
	RemoteRole=ROLE_SimulatedProxy
	bHidden=true
    bStatic=False
	bNoDelete=true
	bReplicateMovement=false
	NetUpdateFrequency=1.0
	bSkipActorPropertyReplication=true
}

