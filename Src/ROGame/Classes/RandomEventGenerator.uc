//=============================================================================
// RandomEventGenerator
//=============================================================================
// An actor to randomly trigger events on clients or servers
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class RandomEventGenerator extends Actor
	placeable;

// Net type
var(RandomEventGenerator) enum ENetType
{
	NT_ClientSideOnly,
	NT_ServerSideOnly,
} NetType;


var(RandomEventGenerator) float MaxEventInterval;
var(RandomEventGenerator) float MinEventInterval;
var(RandomEventGenerator) name  EventToTrigger;

auto state TriggeringEvents
{
	simulated function Timer()
	{
    	TriggerEvent(EventToTrigger, self, None);
    	SetTimer(RandRange(MinEventInterval,MaxEventInterval),false);
	}

	simulated function BeginState()
	{

  		if( NetType == NT_ClientSideOnly )
  		{
	        if( Level.NetMode == NM_DedicatedServer )
				return;
		}
		else
		{
		 	if( Role < ROLE_Authority )
		 		return;
		}

		SetTimer(RandRange(MinEventInterval,MaxEventInterval),false);

	}
}

defaultproperties
{
	RemoteRole=ROLE_SimulatedProxy
	bHidden=False
    bStatic=False
	bNoDelete=true
	//bNetNotify = true

	NetUpdateFrequency=10
}
