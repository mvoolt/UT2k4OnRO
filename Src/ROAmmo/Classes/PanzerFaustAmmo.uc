//===================================================================
// ROPanzerFaustAmmo
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// The panzerfaust rocket ammunition
//===================================================================

class PanzerFaustAmmo extends ROAmmunition;

defaultproperties
{
    ItemName="Panzerfaust"
    IconMaterial=Material'InterfaceArt_tex.HUD.panzerfaust_ammo'
    IconCoords=(X1=445,Y1=75,X2=544,Y2=149)

    PickupClass=none//class'G43AmmoPickup'
    MaxAmmo=3
    InitialAmount=3
}
