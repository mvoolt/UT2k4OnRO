class Moz_PanzerIIITank_Camo extends PanzerIIITank;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'BDJ_vehicles_tex.Vehicle_ext.panzer3_ext_camo');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Panzer3_treads');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'BDJ_vehicles_tex.Vehicle_ext.panzer3_ext_camo');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Panzer3_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int_s');

	Super(ROTreadCraft).UpdatePrecacheMaterials();
}


defaultproperties
{
     PassengerWeapons(0)=(WeaponPawnClass=Class'ROCustom.Moz_PanzerIIICannonPawn_Camo')
     Skins(0)=Texture'BDJ_vehicles_tex.Vehicle_ext.panzer3_ext_camo'
}
