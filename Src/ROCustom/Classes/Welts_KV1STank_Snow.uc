class Welts_KV1STank_Snow extends kv1Tank;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_KV1_ext');
    L.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_kv1_treads');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.kv1_int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.kv1_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_KV1_ext');
    Level.AddPrecacheMaterial(Material'GUP_vehicles_tex.WELT_kv1_treads');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.kv1_int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.kv1_int_s');

	Super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
     PassengerWeapons(0)=(WeaponPawnClass=Class'ROCustom.Welts_KV1SCannonPawn_Snow',WeaponBone=Turret_Placement)
     Skins(0)=Texture'GUP_vehicles_tex.WELT_KV1_ext'
     Skins(1)=Texture'GUP_vehicles_tex.WELT_kv1_treads'
     Skins(2)=Texture'GUP_vehicles_tex.WELT_kv1_treads'
}
