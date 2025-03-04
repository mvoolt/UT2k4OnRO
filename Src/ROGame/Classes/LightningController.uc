//=============================================================================
// LightningController
//=============================================================================
// An actor to randomly trigger lighting and thunder on clients
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class LightningController extends Actor
	placeable;

var(LightningController) float MaxLightningInterval;
var(LightningController) float MinLightningInterval;
var(LightningController) name  LightningEvent;
var(LightningController) name  ThunderEvent;
var(LightningController) float LightningLength;
var bool bPlayingLightning;
var bool bPlayedThunder;
var float LastLightningTime;

auto state MakingLightning
{
	simulated function Timer()
	{
    	// Cause the lightning and thunder
    	if(bPlayingLightning)
    	{
			if( !bPlayedThunder )
			{
				TriggerEvent(ThunderEvent, self, None);
				bPlayedThunder = true;
				SetTimer(FMax(0.1,LightningLength - (Level.TimeSeconds - LastLightningTime)),false);
			}
			else
			{
				bPlayingLightning=false;
				TriggerEvent(LightningEvent, self, None);
				SetTimer(RandRange(MinLightningInterval,MaxLightningInterval),false);
			}
    	}
    	else
    	{
			bPlayingLightning=true;
			bPlayedThunder = false;
			TriggerEvent(LightningEvent, self, None);
			LastLightningTime = Level.TimeSeconds;
	    	SetTimer(RandRange(0,LightningLength),false);
		}
	}

	simulated function BeginState()
	{
        if( Level.NetMode == NM_DedicatedServer )
			return;

		SetTimer(RandRange(MinLightningInterval,MaxLightningInterval),false);
	}
}

defaultproperties
{
	RemoteRole=ROLE_SimulatedProxy
	bHidden=False
    bStatic=False
	bNoDelete=true

	NetUpdateFrequency=1
}
