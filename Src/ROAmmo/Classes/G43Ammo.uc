//=============================================================================
// G43Ammo
//=============================================================================
// Ammo class for the G43
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class G43Ammo extends ROAmmunition;

defaultproperties
{
    ItemName="G43 Magazine"
    IconMaterial=Material'InterfaceArt_tex.HUD.G43_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'G43AmmoPickup'
    MaxAmmo=11
    InitialAmount=10
}
