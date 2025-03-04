class Moz_Stug3Destroyer_Camo extends Stug3Destroyer;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'BDJ_vehicles_tex.Vehicle_ext.Stug3_ext_camo');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treads');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Stug3_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.stug3_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'BDJ_vehicles_tex.Vehicle_ext.Stug3_ext_camo');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Stug3_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.stug3_int_s');

	Super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
     PassengerWeapons(0)=(WeaponPawnClass=Class'ROCustom.Moz_Stug3CannonPawn_Camo')
     DestroyedVehicleMesh=StaticMesh'axis_vehicles_stc.Stug3.Stug3_Camo_Destroyed'
     Skins(0)=Texture'BDJ_vehicles_tex.Vehicle_ext.Stug3_ext_camo'
}
