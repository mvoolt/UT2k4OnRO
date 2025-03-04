//=============================================================================
// Kar792x57Ammo
//=============================================================================
// Ammo class for Kar 98 rifles using 7.92x57mm ammo
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class Kar792x57Ammo extends ROAmmunition;

defaultproperties
{
    ItemName="7.92x57mm clip"
    IconMaterial=Material'InterfaceArt_tex.HUD.kar98_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'Kar792x57AmmoPickup'
    MaxAmmo=5
    InitialAmount=5
}
