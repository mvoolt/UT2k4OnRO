//=============================================================================
// PTRDAttachment
//=============================================================================
// PTRD Weapon attachment
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PTRDAttachment extends ROWeaponAttachment;

defaultproperties
{
    menuImage=Texture'InterfaceArt_tex.Menu_weapons.PTRD'
    MenuDescription="PTRD: anti-tank rifle, firing a 14.5mm tungsten-cored round. Can penetrate the thinner armour on old tanks or sides/rear of newer models. Also lethal to people!"
    Mesh=mesh'Weapons3rd_anm.ptrd'
    mMuzFlashClass=class'ROEffects.MuzzleFlash3rdPTRD'
    ROShellCaseClass=class'ROAmmo.RO3rdShellEject14mm'
    bHeavy=false
    bRapidFire=false
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

	PA_MovementAnims(0)=stand_jogF_ptrd
	PA_MovementAnims(1)=stand_jogB_ptrd
	PA_MovementAnims(2)=stand_jogL_ptrd
	PA_MovementAnims(3)=stand_jogR_ptrd
	PA_MovementAnims(4)=stand_jogFL_ptrd
	PA_MovementAnims(5)=stand_jogFR_ptrd
	PA_MovementAnims(6)=stand_jogBL_ptrd
	PA_MovementAnims(7)=stand_jogBR_ptrd

	PA_ProneAnims(0)=prone_crawlF_kar
	PA_ProneAnims(1)=prone_crawlB_kar
	PA_ProneAnims(2)=prone_crawlL_kar
	PA_ProneAnims(3)=prone_crawlR_kar
	PA_ProneAnims(4)=prone_crawlFL_kar
	PA_ProneAnims(5)=prone_crawlFR_kar
	PA_ProneAnims(6)=prone_crawlBL_kar
	PA_ProneAnims(7)=prone_crawlBR_kar
	PA_ProneIronAnims(0)=prone_slowcrawlF_ptrd
	PA_ProneIronAnims(1)=prone_slowcrawlB_ptrd
	PA_ProneIronAnims(2)=prone_slowcrawlL_ptrd
	PA_ProneIronAnims(3)=prone_slowcrawlR_ptrd
	PA_ProneIronAnims(4)=prone_slowcrawlL_ptrd
	PA_ProneIronAnims(5)=prone_slowcrawlR_ptrd
	PA_ProneIronAnims(6)=prone_slowcrawlB_ptrd
	PA_ProneIronAnims(7)=prone_slowcrawlB_ptrd

	PA_ProneTurnRightAnim=prone_turnR_ptrd
	PA_ProneTurnLeftAnim=prone_turnL_ptrd
	PA_StandToProneAnim=StandtoProne_ptrd
	PA_ProneToStandAnim=PronetoStand_ptrd
	PA_CrouchToProneAnim=CrouchtoProne_ptrd
	PA_ProneToCrouchAnim=PronetoCrouch_ptrd
	PA_ProneIdleRestAnim=prone_idle_ptrd
	PA_DiveToProneStartAnim=prone_divef_kar
	PA_DiveToProneEndAnim=prone_diveend_kar

	PA_SprintAnims(0)=stand_sprintF_ptrd
	PA_SprintAnims(1)=stand_sprintB_ptrd
	PA_SprintAnims(2)=stand_sprintL_ptrd
	PA_SprintAnims(3)=stand_sprintR_ptrd
	PA_SprintAnims(4)=stand_sprintFL_ptrd
	PA_SprintAnims(5)=stand_sprintFR_ptrd
	PA_SprintAnims(6)=stand_sprintBL_ptrd
	PA_SprintAnims(7)=stand_sprintBR_ptrd
	PA_SprintCrouchAnims(0)=crouch_sprintF_ptrd
	PA_SprintCrouchAnims(1)=crouch_sprintB_ptrd
	PA_SprintCrouchAnims(2)=crouch_sprintL_ptrd
	PA_SprintCrouchAnims(3)=crouch_sprintR_ptrd
	PA_SprintCrouchAnims(4)=crouch_sprintFL_ptrd
	PA_SprintCrouchAnims(5)=crouch_sprintFR_ptrd
	PA_SprintCrouchAnims(6)=crouch_sprintBL_ptrd
	PA_SprintCrouchAnims(7)=crouch_sprintBR_ptrd
	PA_CrouchAnims(0)=crouch_walkF_ptrd
	PA_CrouchAnims(1)=crouch_walkB_ptrd
	PA_CrouchAnims(2)=crouch_walkL_ptrd
	PA_CrouchAnims(3)=crouch_walkR_ptrd
	PA_CrouchAnims(4)=crouch_walkFL_ptrd
	PA_CrouchAnims(5)=crouch_walkFR_ptrd
	PA_CrouchAnims(6)=crouch_walkBL_ptrd
	PA_CrouchAnims(7)=crouch_walkBR_ptrd
	PA_CrouchTurnRightAnim=crouch_turnR_ptrd
	PA_CrouchTurnLeftAnim=crouch_turnL_ptrd
	PA_CrouchIdleRestAnim=crouch_idle_ptrd

	PA_WalkAnims(0)=stand_walkFhip_ptrd
	PA_WalkAnims(1)=stand_walkBhip_ptrd
	PA_WalkAnims(2)=stand_walkLhip_ptrd
	PA_WalkAnims(3)=stand_walkRhip_ptrd
	PA_WalkAnims(4)=stand_walkFLhip_ptrd
	PA_WalkAnims(5)=stand_walkFRhip_ptrd
	PA_WalkAnims(6)=stand_walkBLhip_ptrd
	PA_WalkAnims(7)=stand_walkBRhip_ptrd
	PA_WalkIronAnims(0)=stand_walkFiron_ptrd
	PA_WalkIronAnims(1)=stand_walkBiron_ptrd
	PA_WalkIronAnims(2)=stand_walkLiron_ptrd
	PA_WalkIronAnims(3)=stand_walkRiron_ptrd
	PA_WalkIronAnims(4)=stand_walkFLiron_ptrd
	PA_WalkIronAnims(5)=stand_walkFRiron_ptrd
	PA_WalkIronAnims(6)=stand_walkBLiron_ptrd
	PA_WalkIronAnims(7)=stand_walkBRiron_ptrd

	PA_IdleCrouchAnim=crouch_idle_ptrd
	PA_IdleRestAnim=stand_idlehip_ptrd
	PA_IdleWeaponAnim=stand_idlehip_ptrd
	PA_IdleIronRestAnim=stand_idleiron_ptrd
	PA_IdleIronWeaponAnim=stand_idleiron_ptrd
	PA_IdleCrouchIronWeaponAnim=crouch_idleiron_ptrd
	PA_IdleProneAnim=prone_idle_ptrd
	PA_IdleDeployedCrouchAnim=crouch_idleiron_ptrd

	PA_TurnLeftAnim=stand_turnLhip_ptrd
	PA_TurnRightAnim=stand_turnRhip_ptrd
	PA_TurnIronLeftAnim=stand_turnLiron_ptrd
	PA_TurnIronRightAnim=stand_turnRiron_ptrd
	PA_CrouchTurnIronLeftAnim=crouch_turnRiron_ptrd
	PA_CrouchTurnIronRightAnim=crouch_turnRiron_ptrd

	PA_Fire=stand_shoothip_ptrd
	PA_CrouchFire=crouch_shootiron_ptrd
	PA_ProneFire=prone_shoot_ptrd
	PA_IronFire=stand_shootiron_ptrd
	PA_FireLastShot=stand_shoothip_ptrd
	PA_CrouchFireLastShot=crouch_shoot_ptrd
	PA_ProneFireLastShot=prone_shoot_ptrd
	PA_IronFireLastShot=stand_shootiron_ptrd

// Moving fire anims
	PA_MoveStandFire(0)=stand_shootFhip_ptrd
	PA_MoveStandFire(1)=stand_shootFhip_ptrd
	PA_MoveStandFire(2)=stand_shootLRhip_ptrd
	PA_MoveStandFire(3)=stand_shootLRhip_ptrd
	PA_MoveStandFire(4)=stand_shootFLhip_ptrd
	PA_MoveStandFire(5)=stand_shootFRhip_ptrd
	PA_MoveStandFire(6)=stand_shootFRhip_ptrd
	PA_MoveStandFire(7)=stand_shootFLhip_ptrd

	PA_MoveCrouchFire(0)=crouch_shootF_ptrd
	PA_MoveCrouchFire(1)=crouch_shootF_ptrd
	PA_MoveCrouchFire(2)=crouch_shootLR_ptrd
	PA_MoveCrouchFire(3)=crouch_shootLR_ptrd
	PA_MoveCrouchFire(4)=crouch_shootF_ptrd
	PA_MoveCrouchFire(5)=crouch_shootF_ptrd
	PA_MoveCrouchFire(6)=crouch_shootF_ptrd
	PA_MoveCrouchFire(7)=crouch_shootF_ptrd

	PA_MoveStandIronFire(0)=stand_shootiron_ptrd
	PA_MoveStandIronFire(1)=stand_shootiron_ptrd
	PA_MoveStandIronFire(2)=stand_shootLRiron_ptrd
	PA_MoveStandIronFire(3)=stand_shootLRiron_ptrd
	PA_MoveStandIronFire(4)=stand_shootFLiron_ptrd
	PA_MoveStandIronFire(5)=stand_shootFRiron_ptrd
	PA_MoveStandIronFire(6)=stand_shootFRiron_ptrd
	PA_MoveStandIronFire(7)=stand_shootFLiron_ptrd

	PA_MoveWalkFire(0)=stand_shootFwalk_ptrd
	PA_MoveWalkFire(1)=stand_shootFwalk_ptrd
	PA_MoveWalkFire(2)=stand_shootLRwalk_ptrd
	PA_MoveWalkFire(3)=stand_shootLRwalk_ptrd
	PA_MoveWalkFire(4)=stand_shootFLwalk_ptrd
	PA_MoveWalkFire(5)=stand_shootFRwalk_ptrd
	PA_MoveWalkFire(6)=stand_shootFRwalk_ptrd
	PA_MoveWalkFire(7)=stand_shootFLwalk_ptrd

	PA_ReloadAnim=stand_reload_ptrd
	PA_ProneReloadAnim=prone_reload_ptrd
	PA_ReloadEmptyAnim=stand_reload_ptrd
	PA_ProneReloadEmptyAnim=prone_reload_ptrd

	PA_HitFAnim=hitF_ptrd
	PA_HitBAnim=hitB_ptrd
	PA_HitLAnim=hitL_ptrd
	PA_HitRAnim=hitR_ptrd
	PA_HitLLegAnim=hitL_leg_ptrd
	PA_HitRLegAnim=hitR_leg_ptrd

	PA_AltFire=single_iron_ptrd
	PA_CrouchAltFire=crouch_single_ptrd
	PA_ProneAltFire=prone_single_ptrd

	//-------------temp anims-------------------
	PA_StandWeaponDeployAnim=stand_idleiron_ptrd
	PA_ProneWeaponDeployAnim=prone_idle_ptrd

	PA_StandWeaponUnDeployAnim=stand_idlehip_ptrd
	PA_ProneWeaponUnDeployAnim=prone_idle_ptrd

	PA_IdleDeployedAnim=stand_idleiron_ptrd
	PA_IdleDeployedProneAnim=prone_idle_ptrd

	PA_DeployedFire=stand_shootiron_ptrd
	PA_CrouchDeployedFire=crouch_shootiron_ptrd
	PA_ProneDeployedFire=prone_shoot_ptrd
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

	PA_LimpAnims(0)=stand_limpFhip_ptrd
	PA_LimpAnims(1)=stand_limpBhip_ptrd
	PA_LimpAnims(2)=stand_limpLhip_ptrd
	PA_LimpAnims(3)=stand_limpRhip_ptrd
	PA_LimpAnims(4)=stand_limpFLhip_ptrd
	PA_LimpAnims(5)=stand_limpFRhip_ptrd
	PA_LimpAnims(6)=stand_limpBLhip_ptrd
	PA_LimpAnims(7)=stand_limpBRhip_ptrd

	PA_LimpIronAnims(0)=stand_limpFiron_ptrd
	PA_LimpIronAnims(1)=stand_limpBiron_ptrd
	PA_LimpIronAnims(2)=stand_limpLiron_ptrd
	PA_LimpIronAnims(3)=stand_limpRiron_ptrd
	PA_LimpIronAnims(4)=stand_limpFLiron_ptrd
	PA_LimpIronAnims(5)=stand_limpFRiron_ptrd
	PA_LimpIronAnims(6)=stand_limpBLiron_ptrd
	PA_LimpIronAnims(7)=stand_limpBRiron_ptrd

	WA_Idle=idle_ptrd
	WA_IdleEmpty=idle_open
	WA_Fire=shoot_ptrd
	WA_Reload=reload_ptrd
	WA_ReloadEmpty=reload_ptrd
	WA_ProneReload=prone_reload_ptrd
	WA_ProneReloadEmpty=prone_reload_ptrd
}
