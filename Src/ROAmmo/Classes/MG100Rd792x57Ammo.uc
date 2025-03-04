//=============================================================================
// MG100Rd792x57Ammo
//=============================================================================
// Ammo class for German machine guns using 100 round ammo belts
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MG100Rd792x57Ammo extends ROAmmunition;

defaultproperties
{
    ItemName="MG 100 Round 7.92x57 Belt"
    IconMaterial=Material'InterfaceArt_tex.HUD.mg42_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'MG100Rd792x57AmmoPickup'
    MaxAmmo=101
    InitialAmount=100
}
