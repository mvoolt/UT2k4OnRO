class PanzerIVF2Tank_Snow extends PanzerIVF2Tank;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Panzer4F2Snow_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4F2_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Panzer4F2_treadsnow');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4f2_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4f2_int_s');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Panzer4F2Snow_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4F2_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Panzer4F2_treadsnow');

	super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
	Skins(0)=Texture'axis_vehicles_tex.ext_vehicles.Panzer4F2Snow_ext'
	Skins(1)=Texture'axis_vehicles_tex.Treads.Panzer4F2_treadsnow'
	Skins(2)=Texture'axis_vehicles_tex.Treads.Panzer4F2_treadsnow'
	DestroyedVehicleMesh=StaticMesh'axis_vehicles_stc.Panzer4F2_Snow_Destroyed'

	PassengerWeapons(0)=(WeaponPawnClass=class'PanzerIVF2CannonPawn_Snow',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'PanzerIVF2MountedMGPawn_Snow',WeaponBone=MG_Placement)
}

