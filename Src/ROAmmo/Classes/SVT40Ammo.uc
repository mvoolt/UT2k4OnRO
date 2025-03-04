//=============================================================================
// SVT40Ammo
//=============================================================================
// Ammo class for the SVT40
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class SVT40Ammo extends ROAmmunition;

defaultproperties
{
    ItemName="SVT40 Magazine"
    IconMaterial=Material'InterfaceArt_tex.HUD.svt40_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'SVT40AmmoPickup'
    MaxAmmo=11
    InitialAmount=10
}
