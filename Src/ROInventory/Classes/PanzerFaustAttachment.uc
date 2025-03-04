//=============================================================================
// PanzerFaustAttachment
//=============================================================================
// PanzerFaust Weapon attachment
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PanzerFaustAttachment extends ROWeaponAttachment;

var   mesh   EmptyMesh;  // The mesh to swap to after the round is fired

// Overridden because the 3rd person effects are handled differently for the panzerfaust
simulated function PostBeginPlay()
{
	if (Role == ROLE_Authority)
	{
		bOldBayonetAttached = bBayonetAttached;
		bOldBarrelSteamActive = bBarrelSteamActive;
		bUpdated = true;
	}
}

// Overridden because the 3rd person effects are handled differently for the panzerfaust
simulated event ThirdPersonEffects()
{

	// Only switch to the empty mesh if its not a melee attack
	if(FiringMode == 0)
		LinkMesh( EmptyMesh );

	if (Level.NetMode == NM_DedicatedServer || ROPawn(Instigator) == None )
		return;

	if (FlashCount > 0 && ((FiringMode == 0) || bAltFireFlash) )
	{
		if( (Level.TimeSeconds - LastRenderTime > 0.2) && (PlayerController(Instigator.Controller) == None))
			return;

		WeaponLight();

		mMuzFlash3rd = Spawn(mMuzFlashClass);
		AttachToBone(mMuzFlash3rd, MuzzleBoneName);
	}

    if (FlashCount == 0)
    {
        ROPawn(Instigator).StopFiring();
    }
    else if (FiringMode == 0)
    {
        ROPawn(Instigator).StartFiring(false, bRapidFire);
    }
    else
    {
        ROPawn(Instigator).StartFiring(true, bAltRapidFire);
    }

}

defaultproperties
{
    Mesh=Mesh'Weapons3rd_anm.Panzerfaust'
    EmptyMesh=Mesh'Weapons3rd_anm.Panzerfaust_empty'
    mMuzFlashClass=class'ROEffects.RO3rdPersonPanzerfaustFX'

    MuzzleBoneName=tip

    menuImage=Texture'InterfaceArt_tex.Menu_weapons.PanzerFaust'
    MenuDescription="Panzerfaust: single-use recoilless anti-tank weapon. Cheap and made in large numbers to combat Allied armour. Aim using the various sighting holes by distance."

    //ROShellCaseClass=class'RO3rdShellEject762x54mm'
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

	PA_MovementAnims(0)=stand_jogF_faust
	PA_MovementAnims(1)=stand_jogB_faust
	PA_MovementAnims(2)=stand_jogL_faust
	PA_MovementAnims(3)=stand_jogR_faust
	PA_MovementAnims(4)=stand_jogFL_faust
	PA_MovementAnims(5)=stand_jogFR_faust
	PA_MovementAnims(6)=stand_jogBL_faust
	PA_MovementAnims(7)=stand_jogBR_faust

	PA_ProneAnims(0)=prone_crawlF_faust
	PA_ProneAnims(1)=prone_crawlB_faust
	PA_ProneAnims(2)=prone_crawlL_faust
	PA_ProneAnims(3)=prone_crawlR_faust
	PA_ProneAnims(4)=prone_crawlFL_faust
	PA_ProneAnims(5)=prone_crawlFR_faust
	PA_ProneAnims(6)=prone_crawlBL_faust
	PA_ProneAnims(7)=prone_crawlBR_faust
	PA_ProneIronAnims(0)=prone_slowcrawlF_faust
	PA_ProneIronAnims(1)=prone_slowcrawlB_faust
	PA_ProneIronAnims(2)=prone_slowcrawlL_faust
	PA_ProneIronAnims(3)=prone_slowcrawlR_faust
	PA_ProneIronAnims(4)=prone_slowcrawlL_faust
	PA_ProneIronAnims(5)=prone_slowcrawlR_faust
	PA_ProneIronAnims(6)=prone_slowcrawlB_faust
	PA_ProneIronAnims(7)=prone_slowcrawlB_faust

	PA_ProneTurnRightAnim=prone_turnR_faust
	PA_ProneTurnLeftAnim=prone_turnL_faust
	PA_StandToProneAnim=StandtoProne_faust
	PA_ProneToStandAnim=PronetoStand_faust
	PA_CrouchToProneAnim=CrouchtoProne_faust
	PA_ProneToCrouchAnim=PronetoCrouch_faust
	PA_ProneIdleRestAnim=prone_idle_faust
	PA_DiveToProneStartAnim=prone_divef_faust
	PA_DiveToProneEndAnim=prone_diveend_faust

	PA_SprintAnims(0)=stand_sprintF_faust
	PA_SprintAnims(1)=stand_sprintB_faust
	PA_SprintAnims(2)=stand_sprintL_faust
	PA_SprintAnims(3)=stand_sprintR_faust
	PA_SprintAnims(4)=stand_sprintFL_faust
	PA_SprintAnims(5)=stand_sprintFR_faust
	PA_SprintAnims(6)=stand_sprintBL_faust
	PA_SprintAnims(7)=stand_sprintBR_faust
	PA_SprintCrouchAnims(0)=crouch_sprintF_faust
	PA_SprintCrouchAnims(1)=crouch_sprintB_faust
	PA_SprintCrouchAnims(2)=crouch_sprintL_faust
	PA_SprintCrouchAnims(3)=crouch_sprintR_faust
	PA_SprintCrouchAnims(4)=crouch_sprintFL_faust
	PA_SprintCrouchAnims(5)=crouch_sprintFR_faust
	PA_SprintCrouchAnims(6)=crouch_sprintBL_faust
	PA_SprintCrouchAnims(7)=crouch_sprintBR_faust

	PA_CrouchAnims(0)=crouch_walkF_faust
	PA_CrouchAnims(1)=crouch_walkB_faust
	PA_CrouchAnims(2)=crouch_walkL_faust
	PA_CrouchAnims(3)=crouch_walkR_faust
	PA_CrouchAnims(4)=crouch_walkFL_faust
	PA_CrouchAnims(5)=crouch_walkFR_faust
	PA_CrouchAnims(6)=crouch_walkBL_faust
	PA_CrouchAnims(7)=crouch_walkBR_faust
	PA_CrouchTurnRightAnim=crouch_turnR_faust
	PA_CrouchTurnLeftAnim=crouch_turnL_faust
	PA_CrouchIdleRestAnim=crouch_idle_faust

	PA_WalkAnims(0)=stand_walkFhip_faust
	PA_WalkAnims(1)=stand_walkBhip_faust
	PA_WalkAnims(2)=stand_walkLhip_faust
	PA_WalkAnims(3)=stand_walkRhip_faust
	PA_WalkAnims(4)=stand_walkFLhip_faust
	PA_WalkAnims(5)=stand_walkFRhip_faust
	PA_WalkAnims(6)=stand_walkBLhip_faust
	PA_WalkAnims(7)=stand_walkBRhip_faust
	PA_WalkIronAnims(0)=stand_walkFiron_faust
	PA_WalkIronAnims(1)=stand_walkBiron_faust
	PA_WalkIronAnims(2)=stand_walkLiron_faust
	PA_WalkIronAnims(3)=stand_walkRiron_faust
	PA_WalkIronAnims(4)=stand_walkFLiron_faust
	PA_WalkIronAnims(5)=stand_walkFRiron_faust
	PA_WalkIronAnims(6)=stand_walkBLiron_faust
	PA_WalkIronAnims(7)=stand_walkBRiron_faust

	PA_IdleCrouchAnim=crouch_idle_faust
	PA_IdleRestAnim=stand_idlehip_faust
	PA_IdleWeaponAnim=stand_idlehip_faust
	PA_IdleIronRestAnim=stand_idleiron_faust
	PA_IdleIronWeaponAnim=stand_idleiron_faust
	PA_IdleCrouchIronWeaponAnim=crouch_idleiron_faust
	PA_IdleProneAnim=prone_idle_faust

	PA_TurnLeftAnim=stand_turnLhip_faust
	PA_TurnRightAnim=stand_turnRhip_faust
	PA_TurnIronLeftAnim=stand_turnLiron_faust
	PA_TurnIronRightAnim=stand_turnRiron_faust
	PA_CrouchTurnIronLeftAnim=crouch_turnRiron_faust
	PA_CrouchTurnIronRightAnim=crouch_turnRiron_faust

	PA_Fire=stand_shootiron_faust
	PA_CrouchFire=crouch_shoot_faust
	PA_ProneFire=prone_shoot_faust
	PA_IronFire=stand_shootiron_faust
	PA_FireLastShot=stand_shoothip_faust
	PA_CrouchFireLastShot=crouch_shoot_faust
	PA_ProneFireLastShot=prone_shoot_faust
	PA_IronFireLastShot=stand_shootiron_faust

// Moving fire anims
	PA_MoveStandFire(0)=stand_shootiron_faust
	PA_MoveStandFire(1)=stand_shootiron_faust
	PA_MoveStandFire(2)=stand_shootLRiron_faust
	PA_MoveStandFire(3)=stand_shootLRiron_faust
	PA_MoveStandFire(4)=stand_shootFLiron_faust
	PA_MoveStandFire(5)=stand_shootFRiron_faust
	PA_MoveStandFire(6)=stand_shootFRiron_faust
	PA_MoveStandFire(7)=stand_shootFLiron_faust

	PA_MoveCrouchFire(0)=crouch_shootF_faust
	PA_MoveCrouchFire(1)=crouch_shootF_faust
	PA_MoveCrouchFire(2)=crouch_shootLR_faust
	PA_MoveCrouchFire(3)=crouch_shootLR_faust
	PA_MoveCrouchFire(4)=crouch_shootF_faust
	PA_MoveCrouchFire(5)=crouch_shootF_faust
	PA_MoveCrouchFire(6)=crouch_shootF_faust
	PA_MoveCrouchFire(7)=crouch_shootF_faust

	PA_MoveStandIronFire(0)=stand_shootiron_faust
	PA_MoveStandIronFire(1)=stand_shootiron_faust
	PA_MoveStandIronFire(2)=stand_shootLRiron_faust
	PA_MoveStandIronFire(3)=stand_shootLRiron_faust
	PA_MoveStandIronFire(4)=stand_shootFLiron_faust
	PA_MoveStandIronFire(5)=stand_shootFRiron_faust
	PA_MoveStandIronFire(6)=stand_shootFRiron_faust
	PA_MoveStandIronFire(7)=stand_shootFLiron_faust

	PA_MoveWalkFire(0)=stand_shootFwalk_faust
	PA_MoveWalkFire(1)=stand_shootFwalk_faust
	PA_MoveWalkFire(2)=stand_shootLRwalk_faust
	PA_MoveWalkFire(3)=stand_shootLRwalk_faust
	PA_MoveWalkFire(4)=stand_shootFLwalk_faust
	PA_MoveWalkFire(5)=stand_shootFRwalk_faust
	PA_MoveWalkFire(6)=stand_shootFRwalk_faust
	PA_MoveWalkFire(7)=stand_shootFLwalk_faust

	PA_ReloadAnim=stand_reload_faust
	PA_ProneReloadAnim=prone_reload_faust
	PA_ReloadEmptyAnim=reload_k98
	PA_ProneReloadEmptyAnim=prone_reload_faust

	PA_HitFAnim=hitF_rifle
	PA_HitBAnim=hitB_rifle
	PA_HitLAnim=hitL_rifle
	PA_HitRAnim=hitR_rifle
	PA_HitLLegAnim=hitL_leg_rifle
	PA_HitRLegAnim=hitR_leg_rifle

	PA_AltFire=stand_idlestrike_kar
	PA_CrouchAltFire=stand_idlestrike_kar
	PA_ProneAltFire=prone_idlestrike_bayo

	PA_BayonetAltFire=baystrike_faust
	PA_CrouchBayonetAltFire=baystrike_faust
	PA_ProneBayonetAltFire=baystrike_faust

	PA_BayonetAttachAnim=bayattach_faust
	PA_ProneBayonetAttachAnim=prone_Bayattach_faust

	PA_BayonetDetachAnim=bayremove_faust
	PA_ProneBayonetDetachAnim=prone_Bayremove_faust

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

	PA_LimpAnims(0)=stand_limpFhip_faust
	PA_LimpAnims(1)=stand_limpBhip_faust
	PA_LimpAnims(2)=stand_limpLhip_faust
	PA_LimpAnims(3)=stand_limpRhip_faust
	PA_LimpAnims(4)=stand_limpFLhip_faust
	PA_LimpAnims(5)=stand_limpFRhip_faust
	PA_LimpAnims(6)=stand_limpBLhip_faust
	PA_LimpAnims(7)=stand_limpBRhip_faust

	PA_LimpIronAnims(0)=stand_limpFiron_faust
	PA_LimpIronAnims(1)=stand_limpBiron_faust
	PA_LimpIronAnims(2)=stand_limpLiron_faust
	PA_LimpIronAnims(3)=stand_limpRiron_faust
	PA_LimpIronAnims(4)=stand_limpFLiron_faust
	PA_LimpIronAnims(5)=stand_limpFRiron_faust
	PA_LimpIronAnims(6)=stand_limpBLiron_faust
	PA_LimpIronAnims(7)=stand_limpBRiron_faust

	WA_Idle=idle_Faust
	WA_Fire=idle_Faust

	//stand_shoothip_faust
}
