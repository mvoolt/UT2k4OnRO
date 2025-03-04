//=============================================================================
// MP41Weapon
//=============================================================================
// Weapon class for the German MP41 sub machinegun
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class MP41Weapon extends MP40Weapon;

defaultproperties
{
	//** Info **//
    ItemName="MP41 SMG"

	//** Display **//
    Mesh=mesh'Axis_Mp40_1st.mp41_mesh'
	HighDetailOverlay=Material'Weapons1st_tex.MP41_s'

    //** Weapon Firing **//
    FireModeClass(0)=MP41Fire
    FireModeClass(1)=MP41MeleeFire

	//** Inventory/Ammo **//
    PickupClass=class'MP41Pickup'
    AttachmentClass=class'MP41Attachment'

	//** Weapon Functionality **//
	FreeAimRotationSpeed=7.5 // slightly slower than a standard MP40
}
