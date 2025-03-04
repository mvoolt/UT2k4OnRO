//=============================================================================
// TT33Ammo
//=============================================================================
// Ammo class for the TT33
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class TT33Ammo extends ROAmmunition;

defaultproperties
{
    ItemName="TT33 Magazine"
    IconMaterial=Material'InterfaceArt_tex.HUD.tt33_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'TT33AmmoPickup'
    MaxAmmo=9
    InitialAmount=8
}
