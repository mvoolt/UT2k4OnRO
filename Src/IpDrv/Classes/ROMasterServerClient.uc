//=============================================================================
// ROMasterServerClient
//=============================================================================
// Steam Master Server Uplink
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2008 Tripwire Interactive LLC
// Created by Dayle Flowers
//=============================================================================

class ROMasterServerClient extends MasterServerClient
	native;

var bool bInternetQueryRunning;

cpptext
{
	// AActor interface
	void Destroy();
	void PostScriptDestroyed();
	// MasterServerLink interface
	UBOOL Poll( INT WaitTime );
	// ServerQueryClient interface
	void Init();

}

native function StartQuery(EClientToMaster Command);
native function Stop();

