//=============================================================================
// MP32Rd9x19Ammo
//=============================================================================
// Ammo class for MP40 style machine pistols
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MP32Rd9x19Ammo extends ROAmmunition;

defaultproperties
{
    ItemName="32rd 9mm Magazine"
    IconMaterial=Material'InterfaceArt_tex.HUD.mg40_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'MP32Rd9x19AmmoPickup'
    MaxAmmo=33
    InitialAmount=32
}
