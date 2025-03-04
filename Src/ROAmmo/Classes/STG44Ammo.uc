//=============================================================================
// STG44Ammo
//=============================================================================
// Ammo class for the STG44
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class STG44Ammo extends ROAmmunition;

defaultproperties
{
    ItemName="STG44 Magazine"
    IconMaterial=Material'InterfaceArt_tex.HUD.stg44_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'STG44AmmoPickup'
    MaxAmmo=31
    InitialAmount=31
}
