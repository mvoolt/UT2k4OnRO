//===================================================================
// RDG1GrenadeAmmo
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Ammo class for the RDG1 smoke nade
//===================================================================

class RDG1GrenadeAmmo extends ROAmmunition;

defaultproperties
{
    ItemName="StielHandGrenate"
    IconMaterial=Material'InterfaceArt_tex.HUD.RDG1_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=none
    MaxAmmo=2
    InitialAmount=2
}
