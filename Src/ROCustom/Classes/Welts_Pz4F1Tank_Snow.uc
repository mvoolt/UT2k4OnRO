class Welts_Pz4F1Tank_Snow extends PanzerIVF1Tank;

#exec OBJ LOAD FILE=..\textures\GUP_vehicles_tex.utx

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_Panzer4F1_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4F2_int');
    L.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_Panzer4F2_treadsnow');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_Panzer4F1_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Panzer4F2_int');
    Level.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_Panzer4F2_treadsnow');

	Super(ROTreadCraft).UpdatePrecacheMaterials();
}


defaultproperties
{
     PassengerWeapons(0)=(WeaponPawnClass=Class'ROCustom.Welts_Pz4F1CannonPawn_Snow',WeaponBone=Turret_Placement)
     Skins(0)=Texture'GUP_vehicles_tex.WELT_Panzer4F1_ext'
     Skins(1)=Texture'GUP_vehicles_tex.WELT_Panzer4F2_treadsnow'
     Skins(2)=Texture'GUP_vehicles_tex.WELT_Panzer4F2_treadsnow'
}
