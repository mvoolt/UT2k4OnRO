//=============================================================================
// STG44Attachment
//=============================================================================
// STG44 Weapon attachment
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class STG44Attachment extends ROWeaponAttachment;

defaultproperties
{
    menuImage=Texture'InterfaceArt_tex.Menu_weapons.stg44'
    MenuDescription="Sturmgewehr 44/MP43: the world's first assault rifle. Prized and reliable, firing accurately in single-shot to 500 metres, or at 500 rpm in automatic mode."

/* RO TRACER AND SHELL VARIABLES */
  	mMuzFlashClass=class'ROEffects.MuzzleFlash3rdSTG'
  	ROShellCaseClass=class'ROAmmo.RO3rdShellEject762x54mm'

    Mesh=mesh'Weapons3rd_anm.stg44'
    bHeavy=false
    bRapidFire=true
    bAltRapidFire=false

    bDynamicLight=false
    LightType=LT_Steady
    LightEffect=LE_NonIncidence
    LightPeriod=3
    LightBrightness=150
    LightHue=30
    LightSaturation=150
    LightRadius=4.0

// MergeTODO: Replace these with the right anims

	PA_MovementAnims(0)=stand_jogF_stg44
	PA_MovementAnims(1)=stand_jogB_stg44
	PA_MovementAnims(2)=stand_jogL_stg44
	PA_MovementAnims(3)=stand_jogR_stg44
	PA_MovementAnims(4)=stand_jogFL_stg44
	PA_MovementAnims(5)=stand_jogFR_stg44
	PA_MovementAnims(6)=stand_jogBL_stg44
	PA_MovementAnims(7)=stand_jogBR_stg44

	PA_ProneAnims(0)=prone_crawlF_kar
	PA_ProneAnims(1)=prone_crawlB_kar
	PA_ProneAnims(2)=prone_crawlL_kar
	PA_ProneAnims(3)=prone_crawlR_kar
	PA_ProneAnims(4)=prone_crawlFL_kar
	PA_ProneAnims(5)=prone_crawlFR_kar
	PA_ProneAnims(6)=prone_crawlBL_kar
	PA_ProneAnims(7)=prone_crawlBR_kar
	PA_ProneIronAnims(0)=prone_slowcrawlF_stg44
	PA_ProneIronAnims(1)=prone_slowcrawlB_stg44
	PA_ProneIronAnims(2)=prone_slowcrawlL_stg44
	PA_ProneIronAnims(3)=prone_slowcrawlR_stg44
	PA_ProneIronAnims(4)=prone_slowcrawlL_stg44
	PA_ProneIronAnims(5)=prone_slowcrawlR_stg44
	PA_ProneIronAnims(6)=prone_slowcrawlB_stg44
	PA_ProneIronAnims(7)=prone_slowcrawlB_stg44

	PA_ProneTurnRightAnim=prone_turnR_stg44
	PA_ProneTurnLeftAnim=prone_turnL_stg44
	PA_StandToProneAnim=StandtoProne_stg44
	PA_ProneToStandAnim=PronetoStand_stg44
	PA_CrouchToProneAnim=CrouchtoProne_stg44
	PA_ProneToCrouchAnim=PronetoCrouch_stg44
	PA_ProneIdleRestAnim=prone_idle_stg44
	PA_DiveToProneStartAnim=prone_divef_kar
	PA_DiveToProneEndAnim=prone_diveend_kar

	PA_SprintAnims(0)=stand_sprintF_stg44
	PA_SprintAnims(1)=stand_sprintB_stg44
	PA_SprintAnims(2)=stand_sprintL_stg44
	PA_SprintAnims(3)=stand_sprintR_stg44
	PA_SprintAnims(4)=stand_sprintFL_stg44
	PA_SprintAnims(5)=stand_sprintFR_stg44
	PA_SprintAnims(6)=stand_sprintBL_stg44
	PA_SprintAnims(7)=stand_sprintBR_stg44
	PA_SprintCrouchAnims(0)=crouch_sprintF_stg44
	PA_SprintCrouchAnims(1)=crouch_sprintB_stg44
	PA_SprintCrouchAnims(2)=crouch_sprintL_stg44
	PA_SprintCrouchAnims(3)=crouch_sprintR_stg44
	PA_SprintCrouchAnims(4)=crouch_sprintFL_stg44
	PA_SprintCrouchAnims(5)=crouch_sprintFR_stg44
	PA_SprintCrouchAnims(6)=crouch_sprintBL_stg44
	PA_SprintCrouchAnims(7)=crouch_sprintBR_stg44

	PA_CrouchAnims(0)=crouch_walkF_stg44
	PA_CrouchAnims(1)=crouch_walkB_stg44
	PA_CrouchAnims(2)=crouch_walkL_stg44
	PA_CrouchAnims(3)=crouch_walkR_stg44
	PA_CrouchAnims(4)=crouch_walkFL_stg44
	PA_CrouchAnims(5)=crouch_walkFR_stg44
	PA_CrouchAnims(6)=crouch_walkBL_stg44
	PA_CrouchAnims(7)=crouch_walkBR_stg44
	PA_CrouchTurnRightAnim=crouch_turnR_stg44
	PA_CrouchTurnLeftAnim=crouch_turnL_stg44
	PA_CrouchIdleRestAnim=crouch_idle_stg44

	PA_WalkAnims(0)=stand_walkFhip_stg44
	PA_WalkAnims(1)=stand_walkBhip_stg44
	PA_WalkAnims(2)=stand_walkLhip_stg44
	PA_WalkAnims(3)=stand_walkRhip_stg44
	PA_WalkAnims(4)=stand_walkFLhip_stg44
	PA_WalkAnims(5)=stand_walkFRhip_stg44
	PA_WalkAnims(6)=stand_walkBLhip_stg44
	PA_WalkAnims(7)=stand_walkBRhip_stg44
	PA_WalkIronAnims(0)=stand_walkFiron_stg44
	PA_WalkIronAnims(1)=stand_walkBiron_stg44
	PA_WalkIronAnims(2)=stand_walkLiron_stg44
	PA_WalkIronAnims(3)=stand_walkRiron_stg44
	PA_WalkIronAnims(4)=stand_walkFLiron_stg44
	PA_WalkIronAnims(5)=stand_walkFRiron_stg44
	PA_WalkIronAnims(6)=stand_walkBLiron_stg44
	PA_WalkIronAnims(7)=stand_walkBRiron_stg44

	PA_IdleCrouchAnim=crouch_idle_stg44
	PA_IdleRestAnim=stand_idlehip_stg44
	PA_IdleWeaponAnim=stand_idlehip_stg44
	PA_IdleIronRestAnim=stand_idleiron_stg44
	PA_IdleIronWeaponAnim=stand_idleiron_stg44
	PA_IdleCrouchIronWeaponAnim=crouch_idleiron_stg44
	PA_IdleProneAnim=prone_idle_stg44

	PA_TurnLeftAnim=stand_turnLhip_stg44
	PA_TurnRightAnim=stand_turnRhip_stg44
	PA_TurnIronLeftAnim=stand_turnLiron_stg44
	PA_TurnIronRightAnim=stand_turnRiron_stg44
	PA_CrouchTurnIronLeftAnim=crouch_turnRiron_stg44
	PA_CrouchTurnIronRightAnim=crouch_turnRiron_stg44

	PA_Fire=stand_shoothip_stg44
	PA_CrouchFire=crouch_shoot_stg44
	PA_ProneFire=prone_shoot_stg44
	PA_IronFire=stand_shootiron_stg44
	PA_FireLastShot=stand_shoothip_stg44
	PA_CrouchFireLastShot=crouch_shoot_stg44
	PA_ProneFireLastShot=prone_shoot_stg44
	PA_IronFireLastShot=stand_shootiron_stg44

// Moving fire anims
	PA_MoveStandFire(0)=stand_shootFhip_stg44
	PA_MoveStandFire(1)=stand_shootFhip_stg44
	PA_MoveStandFire(2)=stand_shootLRhip_stg44
	PA_MoveStandFire(3)=stand_shootLRhip_stg44
	PA_MoveStandFire(4)=stand_shootFLhip_stg44
	PA_MoveStandFire(5)=stand_shootFRhip_stg44
	PA_MoveStandFire(6)=stand_shootFRhip_stg44
	PA_MoveStandFire(7)=stand_shootFLhip_stg44

	PA_MoveCrouchFire(0)=crouch_shootF_stg44
	PA_MoveCrouchFire(1)=crouch_shootF_stg44
	PA_MoveCrouchFire(2)=crouch_shootLR_stg44
	PA_MoveCrouchFire(3)=crouch_shootLR_stg44
	PA_MoveCrouchFire(4)=crouch_shootF_stg44
	PA_MoveCrouchFire(5)=crouch_shootF_stg44
	PA_MoveCrouchFire(6)=crouch_shootF_stg44
	PA_MoveCrouchFire(7)=crouch_shootF_stg44

	PA_MoveStandIronFire(0)=stand_shootiron_stg44
	PA_MoveStandIronFire(1)=stand_shootiron_stg44
	PA_MoveStandIronFire(2)=stand_shootLRiron_stg44
	PA_MoveStandIronFire(3)=stand_shootLRiron_stg44
	PA_MoveStandIronFire(4)=stand_shootFLiron_stg44
	PA_MoveStandIronFire(5)=stand_shootFRiron_stg44
	PA_MoveStandIronFire(6)=stand_shootFRiron_stg44
	PA_MoveStandIronFire(7)=stand_shootFLiron_stg44

	PA_MoveWalkFire(0)=stand_shootFwalk_stg44
	PA_MoveWalkFire(1)=stand_shootFwalk_stg44
	PA_MoveWalkFire(2)=stand_shootLRwalk_stg44
	PA_MoveWalkFire(3)=stand_shootLRwalk_stg44
	PA_MoveWalkFire(4)=stand_shootFLwalk_stg44
	PA_MoveWalkFire(5)=stand_shootFRwalk_stg44
	PA_MoveWalkFire(6)=stand_shootFRwalk_stg44
	PA_MoveWalkFire(7)=stand_shootFLwalk_stg44

	PA_ReloadAnim=stand_reloadhalf_stg44
	PA_ProneReloadAnim=prone_reloadhalf_stg44
	PA_ReloadEmptyAnim=stand_reloadempty_stg44
	PA_ProneReloadEmptyAnim=prone_reloadempty_stg44

	PA_HitFAnim=hitF_stg44
	PA_HitBAnim=hitB_stg44
	PA_HitLAnim=hitL_stg44
	PA_HitRAnim=hitR_stg44
	PA_HitLLegAnim=hitL_leg_stg44
	PA_HitRLegAnim=hitR_leg_stg44

	PA_AltFire=stand_idlestrike_kar
	PA_CrouchAltFire=stand_idlestrike_kar
	PA_ProneAltFire=prone_idlestrike_bayo

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

	PA_LimpAnims(0)=stand_limpFhip_stg44
	PA_LimpAnims(1)=stand_limpBhip_stg44
	PA_LimpAnims(2)=stand_limpLhip_stg44
	PA_LimpAnims(3)=stand_limpRhip_stg44
	PA_LimpAnims(4)=stand_limpFLhip_stg44
	PA_LimpAnims(5)=stand_limpFRhip_stg44
	PA_LimpAnims(6)=stand_limpBLhip_stg44
	PA_LimpAnims(7)=stand_limpBRhip_stg44

	PA_LimpIronAnims(0)=stand_limpFiron_stg44
	PA_LimpIronAnims(1)=stand_limpBiron_stg44
	PA_LimpIronAnims(2)=stand_limpLiron_stg44
	PA_LimpIronAnims(3)=stand_limpRiron_stg44
	PA_LimpIronAnims(4)=stand_limpFLiron_stg44
	PA_LimpIronAnims(5)=stand_limpFRiron_stg44
	PA_LimpIronAnims(6)=stand_limpBLiron_stg44
	PA_LimpIronAnims(7)=stand_limpBRiron_stg44

	WA_Idle=idle_stg44
	WA_IdleEmpty=idle_stg44
	WA_Fire=shoot_stg44
	WA_Reload=reloadhalf_stg44
	WA_ReloadEmpty=reloadempty_stg44
	WA_ProneReload=prone_reloadhalf_stg44
	WA_ProneReloadEmpty=prone_reloadempty_stg44
}
