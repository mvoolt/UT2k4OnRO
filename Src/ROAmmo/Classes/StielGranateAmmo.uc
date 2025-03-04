//===================================================================
// StielGranateAmmo
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Ammo class for the F1Grenade
//===================================================================

class StielGranateAmmo extends ROAmmunition;

defaultproperties
{
    ItemName="StielHandGrenate"
    IconMaterial=Material'InterfaceArt_tex.HUD.sticknade_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=none//class'G43AmmoPickup'
    MaxAmmo=2
    InitialAmount=2
}
