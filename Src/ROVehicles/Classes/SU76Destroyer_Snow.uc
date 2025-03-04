class SU76Destroyer_Snow extends SU76Destroyer;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.SU76Snow_ext');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.SU76_Treadsnow');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.SU76Snow_Int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.SU76_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.SU76Snow_ext');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.SU76_Treadsnow');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.SU76Snow_Int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.SU76_int_s');

	super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
	Skins(0)=Texture'allies_vehicles_tex.ext_vehicles.SU76Snow_ext'
 	Skins(1)=Texture'allies_vehicles_tex.Treads.SU76_Treadsnow'
	Skins(2)=Texture'allies_vehicles_tex.Treads.SU76_Treadsnow'
	Skins(3)=Texture'allies_vehicles_tex.int_vehicles.SU76Snow_Int'
	DestroyedVehicleMesh=StaticMesh'allies_vehicles_stc.SU76_Snow_Destroyed'

	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.SU76Snow_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

	PassengerWeapons(0)=(WeaponPawnClass=class'SU76CannonPawn_Snow',WeaponBone=Turret_Placement)
}
