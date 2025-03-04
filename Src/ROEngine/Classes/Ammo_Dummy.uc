//=============================================================================
// Ammo_Dummy
//=============================================================================
// Created by Laurent Delayen
// © 2003, Epic Games, Inc.  All Rights Reserved
//=============================================================================

class Ammo_Dummy extends Ammunition;

// if _RO_
// else
//#EXEC OBJ LOAD FILE=InterfaceContent.utx
// end if _RO_

defaultproperties
{
	RemoteRole=Role_None
    ItemName="Dummy"

    PickupClass=None
    MaxAmmo=1
    InitialAmount=1
    bStasis=true
}
