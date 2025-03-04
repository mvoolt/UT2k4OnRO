//=============================================================================
// UniCarrierFactory
//=============================================================================
// Universal Carrier Vehicle factory
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class UniCarrierFactory extends ROVehicleFactory;

defaultproperties
{
	Mesh=SkeletalMesh'allies_carrier_anm.carrier_body_ext'
	VehicleClass=class'ROVehicles.UniCarrierTransport'

	RespawnTime=1.0
}
