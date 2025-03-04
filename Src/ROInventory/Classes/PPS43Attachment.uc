//=============================================================================
// PPS43Attachment
//=============================================================================
// PPS43 Weapon attachment
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PPS43Attachment extends ROHighROFWeaponAttachment;

defaultproperties
{
    menuImage=Texture'InterfaceArt_tex.Menu_weapons.pps43'
    MenuDescription="PPS43 (and PPS42): very basic sub-machine gun produced in Leningrad during the siege. Used a 35-round box mag, firing at 700 rpm. Found in small numbers."

/* RO TRACER AND SHELL VARIABLES */
  	mMuzFlashClass=class'ROEffects.MuzzleFlash3rdPPSH'
  	ROShellCaseClass=class'ROAmmo.RO3rdShellEject762x25mm'

    Mesh=mesh'Weapons3rd_anm.pps43'
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

	PA_MovementAnims(0)=stand_jogF_pps43
	PA_MovementAnims(1)=stand_jogB_pps43
	PA_MovementAnims(2)=stand_jogL_pps43
	PA_MovementAnims(3)=stand_jogR_pps43
	PA_MovementAnims(4)=stand_jogFL_pps43
	PA_MovementAnims(5)=stand_jogFR_pps43
	PA_MovementAnims(6)=stand_jogBL_pps43
	PA_MovementAnims(7)=stand_jogBR_pps43

	PA_ProneAnims(0)=prone_crawlF_kar
	PA_ProneAnims(1)=prone_crawlB_kar
	PA_ProneAnims(2)=prone_crawlL_kar
	PA_ProneAnims(3)=prone_crawlR_kar
	PA_ProneAnims(4)=prone_crawlFL_kar
	PA_ProneAnims(5)=prone_crawlFR_kar
	PA_ProneAnims(6)=prone_crawlBL_kar
	PA_ProneAnims(7)=prone_crawlBR_kar
	PA_ProneIronAnims(0)=prone_slowcrawlF_pps43
	PA_ProneIronAnims(1)=prone_slowcrawlB_pps43
	PA_ProneIronAnims(2)=prone_slowcrawlL_pps43
	PA_ProneIronAnims(3)=prone_slowcrawlR_pps43
	PA_ProneIronAnims(4)=prone_slowcrawlL_pps43
	PA_ProneIronAnims(5)=prone_slowcrawlR_pps43
	PA_ProneIronAnims(6)=prone_slowcrawlB_pps43
	PA_ProneIronAnims(7)=prone_slowcrawlB_pps43

	PA_ProneTurnRightAnim=prone_turnR_pps43
	PA_ProneTurnLeftAnim=prone_turnL_pps43
	PA_StandToProneAnim=StandtoProne_pps43
	PA_ProneToStandAnim=PronetoStand_pps43
	PA_CrouchToProneAnim=CrouchtoProne_pps43
	PA_ProneToCrouchAnim=PronetoCrouch_pps43
	PA_ProneIdleRestAnim=prone_idle_pps43
	PA_DiveToProneStartAnim=prone_divef_kar
	PA_DiveToProneEndAnim=prone_diveend_kar

	PA_SprintAnims(0)=stand_sprintF_pps43
	PA_SprintAnims(1)=stand_sprintB_pps43
	PA_SprintAnims(2)=stand_sprintL_pps43
	PA_SprintAnims(3)=stand_sprintR_pps43
	PA_SprintAnims(4)=stand_sprintFL_pps43
	PA_SprintAnims(5)=stand_sprintFR_pps43
	PA_SprintAnims(6)=stand_sprintBL_pps43
	PA_SprintAnims(7)=stand_sprintBR_pps43
	PA_SprintCrouchAnims(0)=crouch_sprintF_pps43
	PA_SprintCrouchAnims(1)=crouch_sprintB_pps43
	PA_SprintCrouchAnims(2)=crouch_sprintL_pps43
	PA_SprintCrouchAnims(3)=crouch_sprintR_pps43
	PA_SprintCrouchAnims(4)=crouch_sprintFL_pps43
	PA_SprintCrouchAnims(5)=crouch_sprintFR_pps43
	PA_SprintCrouchAnims(6)=crouch_sprintBL_pps43
	PA_SprintCrouchAnims(7)=crouch_sprintBR_pps43

	PA_CrouchAnims(0)=crouch_walkF_pps43
	PA_CrouchAnims(1)=crouch_walkB_pps43
	PA_CrouchAnims(2)=crouch_walkL_pps43
	PA_CrouchAnims(3)=crouch_walkR_pps43
	PA_CrouchAnims(4)=crouch_walkFL_pps43
	PA_CrouchAnims(5)=crouch_walkFR_pps43
	PA_CrouchAnims(6)=crouch_walkBL_pps43
	PA_CrouchAnims(7)=crouch_walkBR_pps43
	PA_CrouchTurnRightAnim=crouch_turnR_pps43
	PA_CrouchTurnLeftAnim=crouch_turnL_pps43
	PA_CrouchIdleRestAnim=crouch_idle_pps43

	PA_WalkAnims(0)=stand_walkFhip_pps43
	PA_WalkAnims(1)=stand_walkBhip_pps43
	PA_WalkAnims(2)=stand_walkLhip_pps43
	PA_WalkAnims(3)=stand_walkRhip_pps43
	PA_WalkAnims(4)=stand_walkFLhip_pps43
	PA_WalkAnims(5)=stand_walkFRhip_pps43
	PA_WalkAnims(6)=stand_walkBLhip_pps43
	PA_WalkAnims(7)=stand_walkBRhip_pps43
	PA_WalkIronAnims(0)=stand_walkFiron_pps43
	PA_WalkIronAnims(1)=stand_walkBiron_pps43
	PA_WalkIronAnims(2)=stand_walkLiron_pps43
	PA_WalkIronAnims(3)=stand_walkRiron_pps43
	PA_WalkIronAnims(4)=stand_walkFLiron_pps43
	PA_WalkIronAnims(5)=stand_walkFRiron_pps43
	PA_WalkIronAnims(6)=stand_walkBLiron_pps43
	PA_WalkIronAnims(7)=stand_walkBRiron_pps43

	PA_IdleCrouchAnim=crouch_idle_pps43
	PA_IdleRestAnim=stand_idlehip_pps43
	PA_IdleWeaponAnim=stand_idlehip_pps43
	PA_IdleIronRestAnim=stand_idleiron_pps43
	PA_IdleIronWeaponAnim=stand_idleiron_pps43
	PA_IdleCrouchIronWeaponAnim=crouch_idleiron_pps43
	PA_IdleProneAnim=prone_idle_pps43

	PA_TurnLeftAnim=stand_turnLhip_pps43
	PA_TurnRightAnim=stand_turnRhip_pps43
	PA_TurnIronLeftAnim=stand_turnLiron_pps43
	PA_TurnIronRightAnim=stand_turnRiron_pps43
	PA_CrouchTurnIronLeftAnim=crouch_turnRiron_pps43
	PA_CrouchTurnIronRightAnim=crouch_turnRiron_pps43

	PA_Fire=stand_shoothip_pps43
	PA_CrouchFire=crouch_shoot_pps43
	PA_CrouchIronFire=crouch_shootiron_pps43
	PA_ProneFire=prone_shoot_pps43
	PA_IronFire=stand_shootiron_pps43
	PA_FireLastShot=stand_shoothip_pps43
	PA_CrouchFireLastShot=crouch_shoot_pps43
	PA_ProneFireLastShot=prone_shoot_pps43
	PA_IronFireLastShot=stand_shootiron_pps43

// Moving fire anims
	PA_MoveStandFire(0)=stand_shootFhip_pps43
	PA_MoveStandFire(1)=stand_shootFhip_pps43
	PA_MoveStandFire(2)=stand_shootLRhip_pps43
	PA_MoveStandFire(3)=stand_shootLRhip_pps43
	PA_MoveStandFire(4)=stand_shootFLhip_pps43
	PA_MoveStandFire(5)=stand_shootFRhip_pps43
	PA_MoveStandFire(6)=stand_shootFRhip_pps43
	PA_MoveStandFire(7)=stand_shootFLhip_pps43

	PA_MoveCrouchFire(0)=crouch_shootF_pps43
	PA_MoveCrouchFire(1)=crouch_shootF_pps43
	PA_MoveCrouchFire(2)=crouch_shootLR_pps43
	PA_MoveCrouchFire(3)=crouch_shootLR_pps43
	PA_MoveCrouchFire(4)=crouch_shootF_pps43
	PA_MoveCrouchFire(5)=crouch_shootF_pps43
	PA_MoveCrouchFire(6)=crouch_shootF_pps43
	PA_MoveCrouchFire(7)=crouch_shootF_pps43

	PA_MoveStandIronFire(0)=stand_shootiron_pps43
	PA_MoveStandIronFire(1)=stand_shootiron_pps43
	PA_MoveStandIronFire(2)=stand_shootLRiron_pps43
	PA_MoveStandIronFire(3)=stand_shootLRiron_pps43
	PA_MoveStandIronFire(4)=stand_shootFLiron_pps43
	PA_MoveStandIronFire(5)=stand_shootFRiron_pps43
	PA_MoveStandIronFire(6)=stand_shootFRiron_pps43
	PA_MoveStandIronFire(7)=stand_shootFLiron_pps43

	PA_MoveWalkFire(0)=stand_shootFwalk_pps43
	PA_MoveWalkFire(1)=stand_shootFwalk_pps43
	PA_MoveWalkFire(2)=stand_shootLRwalk_pps43
	PA_MoveWalkFire(3)=stand_shootLRwalk_pps43
	PA_MoveWalkFire(4)=stand_shootFLwalk_pps43
	PA_MoveWalkFire(5)=stand_shootFRwalk_pps43
	PA_MoveWalkFire(6)=stand_shootFRwalk_pps43
	PA_MoveWalkFire(7)=stand_shootFLwalk_pps43

	PA_ReloadAnim=stand_reloadhalf_pps43
	PA_ProneReloadAnim=prone_reloadhalf_pps43
	PA_ReloadEmptyAnim=stand_reloadempty_pps43
	PA_ProneReloadEmptyAnim=prone_reloadempty_pps43

	PA_HitFAnim=hitF_pps43
	PA_HitBAnim=hitB_pps43
	PA_HitLAnim=hitL_pps43
	PA_HitRAnim=hitR_pps43
	PA_HitLLegAnim=hitL_leg_pps43
	PA_HitRLegAnim=hitR_leg_pps43

	PA_AltFire=stand_idlestrike_kar
	PA_CrouchAltFire=stand_idlestrike_kar
	PA_ProneAltFire=prone_idlestrike_bayo

	PA_AirStillAnim=jump_mid_pps43
	PA_AirAnims(0)=jumpF_mid_pps43
	PA_AirAnims(1)=jumpB_mid_pps43
	PA_AirAnims(2)=jumpL_mid_pps43
	PA_AirAnims(3)=jumpR_mid_pps43
	PA_TakeoffStillAnim=jump_takeoff_pps43
	PA_TakeoffAnims(0)=jumpF_takeoff_pps43
	PA_TakeoffAnims(1)=jumpB_takeoff_pps43
	PA_TakeoffAnims(2)=jumpL_takeoff_pps43
	PA_TakeoffAnims(3)=jumpR_takeoff_pps43
	PA_LandAnims(0)=jumpF_land_pps43
	PA_LandAnims(1)=jumpB_land_pps43
	PA_LandAnims(2)=jumpL_land_pps43
	PA_LandAnims(3)=jumpR_land_pps43
	PA_DodgeAnims(0)=jumpF_mid_pps43
	PA_DodgeAnims(1)=jumpB_mid_pps43
	PA_DodgeAnims(2)=jumpL_mid_pps43
	PA_DodgeAnims(3)=jumpR_mid_pps43

	PA_LimpAnims(0)=stand_limpFhip_pps43
	PA_LimpAnims(1)=stand_limpBhip_pps43
	PA_LimpAnims(2)=stand_limpLhip_pps43
	PA_LimpAnims(3)=stand_limpRhip_pps43
	PA_LimpAnims(4)=stand_limpFLhip_pps43
	PA_LimpAnims(5)=stand_limpFRhip_pps43
	PA_LimpAnims(6)=stand_limpBLhip_pps43
	PA_LimpAnims(7)=stand_limpBRhip_pps43

	PA_LimpIronAnims(0)=stand_limpFiron_pps43
	PA_LimpIronAnims(1)=stand_limpBiron_pps43
	PA_LimpIronAnims(2)=stand_limpLiron_pps43
	PA_LimpIronAnims(3)=stand_limpRiron_pps43
	PA_LimpIronAnims(4)=stand_limpFLiron_pps43
	PA_LimpIronAnims(5)=stand_limpFRiron_pps43
	PA_LimpIronAnims(6)=stand_limpBLiron_pps43
	PA_LimpIronAnims(7)=stand_limpBRiron_pps43

	WA_Idle=idle_pps43
	WA_IdleEmpty=idle_pps43
	WA_Fire=shoot_pps43
	WA_Reload=reloadhalf_pps43
	WA_ReloadEmpty=reloadempty_pps43
	WA_ProneReload=prone_reloadhalf_pps43
	WA_ProneReloadEmpty=prone_reloadempty_pps43


	// High Cyclic Helper Vars
	ClientProjectileClass = class'ROInventory.PPS43Bullet_C'
  	bUsesTracers=false
}
