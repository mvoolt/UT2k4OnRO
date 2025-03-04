class BA64ArmoredCar_Snow extends BA64ArmoredCar;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.BA64_int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.BA64_int_s');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.BA64Snow_ext');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.BA64_int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.BA64_int_s');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.BA64Snow_ext');

	super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
	Skins(0)=Texture'allies_vehicles_tex.ext_vehicles.BA64Snow_ext'

	PassengerWeapons(0)=(WeaponPawnClass=Class'ROVehicles.BA64GunPawn_Snow',WeaponBone=turret_placement)
}
