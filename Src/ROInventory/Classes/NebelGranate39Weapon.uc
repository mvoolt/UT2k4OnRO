//=============================================================================
// NebelGranate39Weapon
//=============================================================================
// Weapon class for the German NebelHandGranate 39 smoke grenade
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class NebelGranate39Weapon extends StielGranateWeapon;

defaultproperties
{
	//** Info **//
    ItemName="Nb.39 Grenade"

	//** Display **//
    Mesh=mesh'Axis_Granate_1st.German-Grenade-Mesh'
	HighDetailOverlay=none//Material'Weapons1st_tex.Grenades.stiel_s' // Replaceme
	bUseHighDetailOverlayIndex=false//true
	HighDetailOverlayIndex=2
    Skins[2]=Texture'Weapons1st_tex.Grenades.StielGranate_smokenade'

    //** Weapon Firing **//
    FireModeClass(0)=NebelGranate39Fire
    FireModeClass(1)=NebelGranate39TossFire
    FuzeLength=5.0

	//** Inventory/Ammo **//
    PickupClass=class'NebelGranate39Pickup'
    AttachmentClass=class'NebelGranate39Attachment'
}
