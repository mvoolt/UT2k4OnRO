//=============================================================================
// Sdkfz251Transport_Striped
//=============================================================================
// Sdkfz251 Half Track Transport Vehicle (Striped)
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2007 Tripwire Interactive LLC
// - Dayle Flowers
//=============================================================================

class Sdkfz251Transport_Striped extends Sdkfz251Transport;

static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

 	L.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.halftrack_stripe_ext');
 	L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Halftrack_treads');
 	L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.halftrack_int');
 	L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.halftrack_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex2.ext_vehicles.halftrack_stripe_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Halftrack_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.halftrack_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.halftrack_int_s');

	Super.UpdatePrecacheMaterials();
}


defaultproperties
{
	Skins(0)=Texture'axis_vehicles_tex2.ext_vehicles.halftrack_stripe_ext'
	//Skins(1)=Texture'axis_vehicles_tex.Treads.Halftrack_treads'
	//Skins(2)=Texture'axis_vehicles_tex.Treads.Halftrack_treads'
	//Skins(3)=Texture'axis_vehicles_tex.int_vehicles.halftrack_int'

    // Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251GunPawn_Striped',WeaponBone=mg_base)
	//PassengerWeapons(1)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerOne',WeaponBone=passenger_L_1)
	//PassengerWeapons(2)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerTwo',WeaponBone=passenger_L_2)
	//PassengerWeapons(3)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerThree',WeaponBone=passenger_L_3)
	//PassengerWeapons(4)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerFour',WeaponBone=passenger_R_1)
	//PassengerWeapons(5)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerFive',WeaponBone=passenger_R_2)
	//PassengerWeapons(6)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerSix',WeaponBone=passenger_R_3)
}
