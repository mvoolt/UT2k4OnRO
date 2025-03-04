//=============================================================================
// ClientSideTriggeredSound
//=============================================================================
// An actor to play triggered sounds on network clients or offline
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class ClientSideTriggeredSound extends Actor
	placeable;

var()	sound SoundToPlayWhenTriggered;

simulated function Trigger(Actor Other, Pawn EventInstigator)
{
	if( Level.NetMode == NM_DedicatedServer )
		return;

	PlaySound(SoundToPlayWhenTriggered, SLOT_None, SoundVolume, False, SoundRadius,SoundPitch,true);
}



defaultproperties
{
    Texture=S_Ambient

	RemoteRole=ROLE_SimulatedProxy
	bHidden=False
    bStatic=False
	bNoDelete=true

	SoundRadius=1000
	SoundPitch=1.0
	SoundVolume=2.0
}

