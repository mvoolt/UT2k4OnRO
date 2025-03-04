//=============================================================================
// G41Ammo
//=============================================================================
// Ammo class for the G43
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class G41Ammo extends ROAmmunition;

defaultproperties
{
    ItemName="G41 Magazine"
    IconMaterial=Material'InterfaceArt_tex.HUD.kar98_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'G41AmmoPickup'
    MaxAmmo=10
    InitialAmount=5
}
