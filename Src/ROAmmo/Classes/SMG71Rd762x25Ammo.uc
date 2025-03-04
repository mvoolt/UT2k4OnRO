//=============================================================================
// SMG71Rd762x25Ammo
//=============================================================================
// Ammo class for PPSH style smgs
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class SMG71Rd762x25Ammo extends ROAmmunition;

defaultproperties
{
    ItemName="71rd 7.62mm Magazine"
    IconMaterial=Material'InterfaceArt_tex.HUD.ppsh_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'SMG71Rd762x25AmmoPickup'
    MaxAmmo=72
    InitialAmount=71
}
