//=============================================================================
// PanzerIVGTank
//=============================================================================
// Panzer IVG Tank
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2007 Tripwire Interactive LLC
// - Dayle Flowers
//=============================================================================

class PanzerIVGTank extends PanzerIVF2Tank;

#exec OBJ LOAD FILE=..\Animations\axis_panzer4H_anm.ukx
#exec OBJ LOAD FILE=..\textures\axis_vehicles_tex2.utx

static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.Panzer4H_Armor');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.Panzer4H_Armor');

	Super.UpdatePrecacheMaterials();
}

defaultproperties
{
	Health=650
	HealthMax=650

	// Display
	Mesh=Mesh'axis_panzer4F2_anm.panzer4F2_body_ext'
	Skins(0)=Texture'axis_vehicles_tex.ext_vehicles.Panzer4F2_ext'
	Skins(1)=Texture'axis_vehicles_tex.Treads.panzer4F2_treads'
	Skins(2)=Texture'axis_vehicles_tex.Treads.panzer4F2_treads'
	Skins(3)=Texture'axis_vehicles_tex.int_vehicles.Panzer4F2_int'

	bUseHighDetailOverlayIndex=True
	HighDetailOverlayIndex=4

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.panzer4F2_body'
	VehicleHudTurret=TexRotator'InterfaceArt2_tex.Tank_Hud.panzer4H_turret_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt2_tex.Tank_Hud.panzer4H_turret_look'

	// Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=class'PanzerIVGCannonPawn',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'PanzerIVGMountedMGPawn',WeaponBone=MG_Placement)

	// Position Info
	DriverAttachmentBone=driver_attachment
	DriverPositions(0)=(PositionMesh=Mesh'axis_panzer4F2_anm.panzer4F2_body_int',DriverTransitionAnim=none,TransitionUpAnim=Overlay_Out,ViewPitchUpLimit=1,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,bDrawOverlays=true)
	DriverPositions(1)=(PositionMesh=Mesh'axis_panzer4F2_anm.panzer4F2_body_int',DriverTransitionAnim=VPanzer4_driver_close,TransitionUpAnim=driver_hatch_open,TransitionDownAnim=Overlay_in,ViewPitchUpLimit=5000,ViewPitchDownLimit=61000,ViewPositiveYawLimit=5000,ViewNegativeYawLimit=-10000,bExposed=false)
	DriverPositions(2)=(PositionMesh=Mesh'axis_panzer4F2_anm.panzer4F2_body_int',DriverTransitionAnim=VPanzer4_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=65536,ViewPositiveYawLimit=19000,ViewNegativeYawLimit=-20000,bExposed=true,ViewFOV=85)

	VehiclePositionString="in a Panzer IV G"
	VehicleNameString="Panzer IV G"

	// Destruction
	DestroyedVehicleMesh=StaticMesh'axis_vehicles_stc.Panzer4G_destroyed'

	// Armor
    FrontArmorFactor=6
	SideArmorFactor=3
	RearArmorFactor=2
}

