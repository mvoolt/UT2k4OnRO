//=============================================================================
// MN762x54RAmmo
//=============================================================================
// Ammo class for Mosin Nagant rifles using 7.62x54R ammo
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MN762x54RAmmo extends ROAmmunition;

defaultproperties
{
    ItemName="MN 7.62x54R clip"
    IconMaterial=Material'InterfaceArt_tex.HUD.nagant_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'MN762x54RAmmoPickup'
    MaxAmmo=5
    InitialAmount=5
}
