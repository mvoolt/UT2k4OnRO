class Stug3Destroyer_Snow extends Stug3Destroyer;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Stug3Snow_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treadsnow');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Stug3_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.stug3_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Stug3Snow_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treadsnow');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Stug3_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.stug3_int_s');

	super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
	Skins(0)=Texture'axis_vehicles_tex.ext_vehicles.Stug3Snow_ext'
	Skins(1)=Texture'axis_vehicles_tex.Treads.Stug3_treadsnow'
	Skins(2)=Texture'axis_vehicles_tex.Treads.Stug3_treadsnow'
	DestroyedVehicleMesh=StaticMesh'axis_vehicles_stc.Stug3_Snow_Destroyed'

	PassengerWeapons(0)=(WeaponPawnClass=class'Stug3CannonPawn_Snow',WeaponBone=Turret_Placement)
}
