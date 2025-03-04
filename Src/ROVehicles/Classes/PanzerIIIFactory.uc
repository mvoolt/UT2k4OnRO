//===================================================================
// PanzerIIIFactory
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// Panzer 3 tank factory class
//===================================================================
class PanzerIIIFactory extends ROVehicleFactory;


defaultproperties
{
	Mesh=Mesh'axis_panzer3_anm.panzer3_body_ext'
	VehicleClass=class'ROVehicles.PanzerIIITank'

	RespawnTime=1.0
}
