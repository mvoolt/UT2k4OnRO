class Welts_Pz3Tank_Snow extends PanzerIIITankHE;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_panzer3_extco');
    L.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_Panzer3_treads');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_panzer3_extco');
    Level.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_Panzer3_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.panzer3_int_s');

	Super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
     PassengerWeapons(0)=(WeaponPawnClass=Class'ROCustom.Welts_Pz3CannonPawn_Snow',WeaponBone=Turret_Placement)
     Skins(0)=Texture'GUP_vehicles_tex.WELT_panzer3_extco'
     Skins(1)=Texture'GUP_vehicles_tex.WELT_Panzer3_treads'
     Skins(2)=Texture'GUP_vehicles_tex.WELT_Panzer3_treads'
}
