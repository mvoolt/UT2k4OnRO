//===================================================================
// F1GrenadeAmmo
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Ammo class for the F1Grenade
//===================================================================

class F1GrenadeAmmo extends ROAmmunition;

defaultproperties
{
    ItemName="F1 Grenade"
    IconMaterial=Material'InterfaceArt_tex.HUD.F1nade_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=none//class'G43AmmoPickup'
    MaxAmmo=2
    InitialAmount=2
}
