//=============================================================================
// RDG1GrenadeWeapon
//=============================================================================
// Weapon class for the Russian RDG1 smoke grenade
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class RDG1GrenadeWeapon extends StielGranateWeapon;

defaultproperties
{
	//** Info **//
    ItemName="RDG-1 Grenade"

	//** Display **//
    Mesh=mesh'Allies_RGD1_1st.RGD1_Mesh'
	HighDetailOverlay=none//Material'Weapons1st_tex.Grenades.stiel_s' // Replaceme
	bUseHighDetailOverlayIndex=false//true
	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=RDG1GrenadeFire
    FireModeClass(1)=RDG1GrenadeTossFire
    FuzeLength=5.0

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=PutAway
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out
	// Firing
	PreFireHoldAnim=pre_fire_idle

	//** Inventory/Ammo **//
    PickupClass=class'RDG1GrenadePickup'
    AttachmentClass=class'RDG1GrenadeAttachment'
}
