//=============================================================================
// PPS43Ammo
//=============================================================================
// Ammo class for the PPS43
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PPS43Ammo extends ROAmmunition;

defaultproperties
{
    ItemName="PPS43 Magazine"
    IconMaterial=Material'InterfaceArt_tex.HUD.pps43_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'PPS43AmmoPickup'
    MaxAmmo=36
    InitialAmount=35
}
