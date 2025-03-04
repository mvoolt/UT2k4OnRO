//-----------------------------------------------------------
//
//-----------------------------------------------------------
class Moz_T3476Tank_Camo extends T3476Tank;

#exec OBJ LOAD FILE=..\textures\BDJ_vehicles_tex.utx

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'BDJ_vehicles_tex.Vehicle_ext.T3476_ext_camo');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T3485_treads');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3476_int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.t3476_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'BDJ_vehicles_tex.Vehicle_ext.T3476_ext_camo');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T3485_treads');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3476_int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.t3476_int_s');

	Super(ROTreadCraft).UpdatePrecacheMaterials();
}


defaultproperties
{
     PassengerWeapons(0)=(WeaponPawnClass=Class'ROCustom.Moz_T3476CannonPawn_Camo')
     PassengerWeapons(1)=(WeaponPawnClass=Class'ROCustom.Moz_T3485MountedTankMGPawn_camo')
     DestroyedVehicleMesh=StaticMesh'BDJ_vehicles_stc.DesVeh.T34r_destroyed'
     VehicleTeam=0
     VehiclePositionString="in a PzKpfw T-34"
     VehicleNameString="PzKpfw T-34"
     Skins(0)=Texture'BDJ_vehicles_tex.Vehicle_ext.T3476_ext_camo'
     Skins(1)=Texture'allies_vehicles_tex.Treads.T3485_treads'
     Skins(2)=Texture'allies_vehicles_tex.Treads.T3485_treads'
}
