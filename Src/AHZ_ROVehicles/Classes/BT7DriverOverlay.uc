//===================================================================
// BT7DriverOverlay
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// BT7 Driver Overlay class
//===================================================================
class BT7DriverOverlay extends VehicleHudOverlay;

defaultproperties
{
//  	mesh = mesh'ahz_vehicle_overlays_anm.bt7_driver_overlay'
//  	HighDetailOverlay=Material'allies_ahz_vehicles_tex.int_vehicles.bt7_int'
// Using the IS2 driver overlay right now. The above overlay needs to be replace with something
// that has a higher poly model, and higher res texture. That is the reason for the driver
// overlay, so that when you zoom it it doesn't look low res and low poly
  	mesh = mesh'vehicle_overlays_anm.IS2_driver_overlay'
	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.IS2_int_s'
}



