//------------------------------------------------------------------------------
// 	ROsdkfz251Factory
//
//	sdkfz 251 Half-Track Vehicle factory
//
//	Created By: Antarian 7/24/2004
//	Last Modified By:
//------------------------------------------------------------------------------
class ROsdkfz251Factory extends ROVehicleFactory;

defaultproperties
{
	Mesh=SkeletalMesh'axis_halftrack_anm.Halftrack_body_ext'
	VehicleClass=class'ROVehicles.Sdkfz251Transport'

	RespawnTime=1.0
}
