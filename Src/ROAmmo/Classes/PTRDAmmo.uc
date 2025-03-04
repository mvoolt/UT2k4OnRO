//=============================================================================
// PTRDAmmo
//=============================================================================
// Ammo class for PTRD AT rifles using 14.5mm ammo
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PTRDAmmo extends ROAmmunition;

defaultproperties
{
    ItemName="14.5mm AP Rounds"
    IconMaterial=Material'InterfaceArt_tex.HUD.PTRD_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=class'PTRDAmmoPickup'
    MaxAmmo=1
    InitialAmount=1
}
