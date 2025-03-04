//=============================================================================
//DP28Ammo
//=============================================================================
// Ammo class for DP28 machine guns
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class DP28Ammo extends ROAmmunition;

defaultproperties
{
    ItemName="DP28 Magazine"
    IconMaterial=Material'InterfaceArt_tex.HUD.dp27_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'DP28AmmoPickup'
    MaxAmmo=48
    InitialAmount=47
}
