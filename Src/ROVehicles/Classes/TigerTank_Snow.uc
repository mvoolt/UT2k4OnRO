class TigerTank_Snow extends TigerTank;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Titger1snow_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Tiger1_treadsnow');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Titger1snow_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Tiger1_treadsnow');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int_s');

	super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
	Skins(0)=Texture'axis_vehicles_tex.ext_vehicles.Titger1snow_ext'
	Skins(1)=Texture'axis_vehicles_tex.Treads.Tiger1_treadsnow'
	Skins(2)=Texture'axis_vehicles_tex.Treads.Tiger1_treadsnow'
	DestroyedVehicleMesh=StaticMesh'axis_vehicles_stc.Tiger1_Snow_Destroyed'

	PassengerWeapons(0)=(WeaponPawnClass=class'TigerCannonPawn_Snow',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'TigerMountedMGPawn_Snow',WeaponBone=MG_Placement)
}
