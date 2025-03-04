//=============================================================================
// MG42Attachment
//=============================================================================
// MG42 Weapon attachment
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MG42Attachment extends ROMGWeaponAttachment;

defaultproperties
{
    menuImage=Texture'InterfaceArt_tex.Menu_weapons.mg42'
    MenuDescription="Maschinengewehr 42: designed to replace the MG34. Renowned as the best MG of all time. Uses a 100-round belt, firing at 1,200 rpm. Overheats - use barrel change."

/* RO TRACER AND SHELL VARIABLES */
  	mMuzFlashClass=class'ROEffects.MuzzleFlash3rdMG'
  	ROShellCaseClass=class'ROAmmo.RO3rdShellEject762x54mm'

    Mesh=mesh'Weapons3rd_anm.mg42'
    bHeavy=false
    bRapidFire=true
    bAltRapidFire=false
    bAltFireFlash=false

    bDynamicLight=false
    LightType=LT_Steady
    LightEffect=LE_NonIncidence
    LightPeriod=3
    LightBrightness=150
    LightHue=30
    LightSaturation=150
    LightRadius=4.0

	PA_MovementAnims(0)=stand_jogF_mg34
	PA_MovementAnims(1)=stand_jogB_mg34
	PA_MovementAnims(2)=stand_jogL_mg34
	PA_MovementAnims(3)=stand_jogR_mg34
	PA_MovementAnims(4)=stand_jogFL_mg34
	PA_MovementAnims(5)=stand_jogFR_mg34
	PA_MovementAnims(6)=stand_jogBL_mg34
	PA_MovementAnims(7)=stand_jogBR_mg34

	PA_ProneAnims(0)=prone_crawlF_kar
	PA_ProneAnims(1)=prone_crawlB_kar
	PA_ProneAnims(2)=prone_crawlL_kar
	PA_ProneAnims(3)=prone_crawlR_kar
	PA_ProneAnims(4)=prone_crawlFL_kar
	PA_ProneAnims(5)=prone_crawlFR_kar
	PA_ProneAnims(6)=prone_crawlBL_kar
	PA_ProneAnims(7)=prone_crawlBR_kar
	PA_ProneIronAnims(0)=prone_slowcrawlF_mg42
	PA_ProneIronAnims(1)=prone_slowcrawlB_mg42
	PA_ProneIronAnims(2)=prone_slowcrawlL_mg42
	PA_ProneIronAnims(3)=prone_slowcrawlR_mg42
	PA_ProneIronAnims(4)=prone_slowcrawlL_mg42
	PA_ProneIronAnims(5)=prone_slowcrawlR_mg42
	PA_ProneIronAnims(6)=prone_slowcrawlB_mg42
	PA_ProneIronAnims(7)=prone_slowcrawlB_mg42

	PA_ProneTurnRightAnim=prone_turnR_mg42
	PA_ProneTurnLeftAnim=prone_turnL_mg42
	PA_StandToProneAnim=StandtoProne_mg42
	PA_ProneToStandAnim=PronetoStand_mg42
	PA_CrouchToProneAnim=CrouchtoProne_mg42
	PA_ProneToCrouchAnim=PronetoCrouch_mg42
	PA_ProneIdleRestAnim=prone_idle_mg42
	PA_DiveToProneStartAnim=prone_divef_kar
	PA_DiveToProneEndAnim=prone_diveend_kar

	PA_SprintAnims(0)=stand_sprintF_mg42
	PA_SprintAnims(1)=stand_sprintB_mg42
	PA_SprintAnims(2)=stand_sprintL_mg42
	PA_SprintAnims(3)=stand_sprintR_mg42
	PA_SprintAnims(4)=stand_sprintFL_mg42
	PA_SprintAnims(5)=stand_sprintFR_mg42
	PA_SprintAnims(6)=stand_sprintBL_mg42
	PA_SprintAnims(7)=stand_sprintBR_mg42
	PA_SprintCrouchAnims(0)=crouch_sprintF_mg42
	PA_SprintCrouchAnims(1)=crouch_sprintB_mg42
	PA_SprintCrouchAnims(2)=crouch_sprintL_mg42
	PA_SprintCrouchAnims(3)=crouch_sprintR_mg42
	PA_SprintCrouchAnims(4)=crouch_sprintFL_mg42
	PA_SprintCrouchAnims(5)=crouch_sprintFR_mg42
	PA_SprintCrouchAnims(6)=crouch_sprintBL_mg42
	PA_SprintCrouchAnims(7)=crouch_sprintBR_mg42
	PA_CrouchAnims(0)=crouch_walkF_mg42
	PA_CrouchAnims(1)=crouch_walkB_mg42
	PA_CrouchAnims(2)=crouch_walkL_mg42
	PA_CrouchAnims(3)=crouch_walkR_mg42
	PA_CrouchAnims(4)=crouch_walkFL_mg42
	PA_CrouchAnims(5)=crouch_walkFR_mg42
	PA_CrouchAnims(6)=crouch_walkBL_mg42
	PA_CrouchAnims(7)=crouch_walkBR_mg42
	PA_CrouchTurnRightAnim=crouch_turnR_mg42
	PA_CrouchTurnLeftAnim=crouch_turnL_mg42
	PA_CrouchIdleRestAnim=crouch_idle_mg42

	PA_WalkAnims(0)=stand_walkFhip_mg42
	PA_WalkAnims(1)=stand_walkBhip_mg42
	PA_WalkAnims(2)=stand_walkLhip_mg42
	PA_WalkAnims(3)=stand_walkRhip_mg42
	PA_WalkAnims(4)=stand_walkFLhip_mg42
	PA_WalkAnims(5)=stand_walkFRhip_mg42
	PA_WalkAnims(6)=stand_walkBLhip_mg42
	PA_WalkAnims(7)=stand_walkBRhip_mg42
	PA_WalkIronAnims(0)=stand_walkFiron_mg42
	PA_WalkIronAnims(1)=stand_walkBiron_mg42
	PA_WalkIronAnims(2)=stand_walkLiron_mg42
	PA_WalkIronAnims(3)=stand_walkRiron_mg42
	PA_WalkIronAnims(4)=stand_walkFLiron_mg42
	PA_WalkIronAnims(5)=stand_walkFRiron_mg42
	PA_WalkIronAnims(6)=stand_walkBLiron_mg42
	PA_WalkIronAnims(7)=stand_walkBRiron_mg42

	PA_IdleCrouchAnim=crouch_idle_mg42
	PA_IdleRestAnim=stand_idlehip_mg42
	PA_IdleWeaponAnim=stand_idlehip_mg42
	PA_IdleIronRestAnim=stand_idleiron_mg42
	PA_IdleIronWeaponAnim=stand_idleiron_mg42
	PA_IdleCrouchIronWeaponAnim=crouch_idleiron_mg42
	PA_IdleProneAnim=prone_idle_mg42

	PA_TurnLeftAnim=stand_turnL_mg42
	PA_TurnRightAnim=stand_turnR_mg42
	PA_TurnIronLeftAnim=stand_turnLiron_mg42
	PA_TurnIronRightAnim=stand_turnRiron_mg42
	PA_CrouchTurnIronLeftAnim=crouch_turnRiron_mg42
	PA_CrouchTurnIronRightAnim=crouch_turnRiron_mg42

	PA_Fire=stand_shoothip_mg42
	PA_CrouchFire=crouch_shootiron_mg42
	PA_ProneFire=prone_shoot_mg42
	PA_IronFire=stand_shootiron_mg42
	PA_FireLastShot=stand_shoothip_mg42
	PA_CrouchFireLastShot=crouch_shoot_mg42
	PA_ProneFireLastShot=prone_shoot_mg42
	PA_IronFireLastShot=stand_shootiron_mg42

// Moving fire anims
	PA_MoveStandFire(0)=stand_shootFhip_mg42
	PA_MoveStandFire(1)=stand_shootFhip_mg42
	PA_MoveStandFire(2)=stand_shootLRhip_mg42
	PA_MoveStandFire(3)=stand_shootLRhip_mg42
	PA_MoveStandFire(4)=stand_shootFLhip_mg42
	PA_MoveStandFire(5)=stand_shootFRhip_mg42
	PA_MoveStandFire(6)=stand_shootFRhip_mg42
	PA_MoveStandFire(7)=stand_shootFLhip_mg42

	PA_MoveCrouchFire(0)=crouch_shootF_mg42
	PA_MoveCrouchFire(1)=crouch_shootF_mg42
	PA_MoveCrouchFire(2)=crouch_shootLR_mg42
	PA_MoveCrouchFire(3)=crouch_shootLR_mg42
	PA_MoveCrouchFire(4)=crouch_shootF_mg42
	PA_MoveCrouchFire(5)=crouch_shootF_mg42
	PA_MoveCrouchFire(6)=crouch_shootF_mg42
	PA_MoveCrouchFire(7)=crouch_shootF_mg42

	PA_MoveStandIronFire(0)=stand_shootiron_mg42
	PA_MoveStandIronFire(1)=stand_shootiron_mg42
	PA_MoveStandIronFire(2)=stand_shootLRiron_mg42
	PA_MoveStandIronFire(3)=stand_shootLRiron_mg42
	PA_MoveStandIronFire(4)=stand_shootFLiron_mg42
	PA_MoveStandIronFire(5)=stand_shootFRiron_mg42
	PA_MoveStandIronFire(6)=stand_shootFRiron_mg42
	PA_MoveStandIronFire(7)=stand_shootFLiron_mg42

	PA_MoveWalkFire(0)=stand_shootFwalk_mg42
	PA_MoveWalkFire(1)=stand_shootFwalk_mg42
	PA_MoveWalkFire(2)=stand_shootLRwalk_mg42
	PA_MoveWalkFire(3)=stand_shootLRwalk_mg42
	PA_MoveWalkFire(4)=stand_shootFLwalk_mg42
	PA_MoveWalkFire(5)=stand_shootFRwalk_mg42
	PA_MoveWalkFire(6)=stand_shootFRwalk_mg42
	PA_MoveWalkFire(7)=stand_shootFLwalk_mg42

	PA_ReloadAnim=stand_reload_mg42
	PA_ProneReloadAnim=prone_reload_mg42
	PA_ReloadEmptyAnim=stand_reload_mg42
	PA_ProneReloadEmptyAnim=prone_reload_mg42

	PA_HitFAnim=hitF_mg42
	PA_HitBAnim=hitB_mg42
	PA_HitLAnim=hitL_mg42
	PA_HitRAnim=hitR_mg42
	PA_HitLLegAnim=hitL_leg_mg42
	PA_HitRLegAnim=hitR_leg_mg42

	PA_AltFire=single_iron_mg42
	PA_CrouchAltFire=crouch_single_mg42
	PA_ProneAltFire=prone_single_mg42

	//-------------temp anims-------------------
	PA_StandWeaponDeployAnim=stand_idleiron_mg42
	PA_ProneWeaponDeployAnim=prone_idle_mg42

	PA_StandWeaponUnDeployAnim=stand_idlehip_mg42
	PA_ProneWeaponUnDeployAnim=prone_idle_mg42

	PA_IdleDeployedAnim=stand_idleiron_mg42
	PA_IdleDeployedCrouchAnim=crouch_idleiron_mg42
	PA_IdleDeployedProneAnim=prone_idle_mg42

	PA_DeployedFire=stand_shootiron_mg42
	PA_CrouchDeployedFire=crouch_shootiron_mg42
	PA_ProneDeployedFire=prone_shoot_mg42
	//------------------------------------------

	PA_AirStillAnim=jump_mid_kar
	PA_AirAnims(0)=jumpF_mid_kar
	PA_AirAnims(1)=jumpB_mid_kar
	PA_AirAnims(2)=jumpL_mid_kar
	PA_AirAnims(3)=jumpR_mid_kar
	PA_TakeoffStillAnim=jump_takeoff_kar
	PA_TakeoffAnims(0)=jumpF_takeoff_kar
	PA_TakeoffAnims(1)=jumpB_takeoff_kar
	PA_TakeoffAnims(2)=jumpL_takeoff_kar
	PA_TakeoffAnims(3)=jumpR_takeoff_kar
	PA_LandAnims(0)=jumpF_land_kar
	PA_LandAnims(1)=jumpB_land_kar
	PA_LandAnims(2)=jumpL_land_kar
	PA_LandAnims(3)=jumpR_land_kar
	PA_DodgeAnims(0)=jumpF_mid_kar
	PA_DodgeAnims(1)=jumpB_mid_kar
	PA_DodgeAnims(2)=jumpL_mid_kar
	PA_DodgeAnims(3)=jumpR_mid_kar

	PA_LimpAnims(0)=stand_limpFhip_mg42
	PA_LimpAnims(1)=stand_limpBhip_mg42
	PA_LimpAnims(2)=stand_limpLrest_mg34//stand_limpLhip_mg42
	PA_LimpAnims(3)=stand_limpRrest_mg34//stand_limpRhip_mg42
	PA_LimpAnims(4)=stand_limpFLhip_mg42
	PA_LimpAnims(5)=stand_limpFRhip_mg42
	PA_LimpAnims(6)=stand_limpBLhip_mg42
	PA_LimpAnims(7)=stand_limpBRhip_mg42

	PA_LimpIronAnims(0)=stand_limpFiron_mg42
	PA_LimpIronAnims(1)=stand_limpBiron_mg42
	PA_LimpIronAnims(2)=stand_limpLiron_mg42
	PA_LimpIronAnims(3)=stand_limpRiron_mg42
	PA_LimpIronAnims(4)=stand_limpFLiron_mg42
	PA_LimpIronAnims(5)=stand_limpFRiron_mg42
	PA_LimpIronAnims(6)=stand_limpBLiron_mg42
	PA_LimpIronAnims(7)=stand_limpBRiron_mg42

	WA_Idle=idle_mg42
	WA_IdleEmpty=idle_mg42
	WA_Fire=shoot_mg42
	WA_Reload=reload_mg42
	WA_ReloadEmpty=reload_mg42
	WA_ProneReload=prone_reload_mg42
	WA_ProneReloadEmpty=prone_reload_mg42

	// High Cyclic Helper Vars
	ClientProjectileClass = class'ROInventory.MG34bullet_C'
  	ClientTracerClass = class'ROInventory.MG34ClientTracer'
  	bUsesTracers=true
	TracerFrequency=4
}
