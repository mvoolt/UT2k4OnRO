//==============================================================================
// M1937CannonShell
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// M-1937 45mm AT Gun Cannon Shell class
//==============================================================================
class M1937CannonShell extends ROTankCannonShell;

//==============================================================================
// defaultproperties
//==============================================================================
defaultproperties
{
	BallisticCoefficient=0.7 // 1.13 - 2.45kg, (0.461 * 2.45), using BR-240 SP ( Armor Piercing Ballistic Cap )   //bill - updated with data from Alan Wilson                                                  //bill
	Speed=45806 // 759 M/S, (60.35 * 759), using BR-240 SP ( Armor Piercing Ballistic Cap )
	MaxSpeed=45806
	SpeedFudgeScale=0.5
	bDebugBallistics=false
	bOpticalAiming=true
	bMechanicalAiming=true

    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=190

    //bill - updated with data from Alan Wilson and adjusted to match the RO vehicle cannons
	PenetrationTable(0)=11
	PenetrationTable(1)=11
    PenetrationTable(2)=10
	PenetrationTable(3)=10
	PenetrationTable(4)=10
	PenetrationTable(5)=9
	PenetrationTable(6)=8
	PenetrationTable(7)=8
	PenetrationTable(8)=7
	PenetrationTable(9)=6
	PenetrationTable(10)=6

    //adjusts the range bar
    OpticalRanges(0)=(Range=0,RangeValue=0.48)
    OpticalRanges(1)=(Range=500,RangeValue=0.512)
    OpticalRanges(2)=(Range=1000,RangeValue=0.5426)
    OpticalRanges(3)=(Range=1500,RangeValue=0.5885)
    OpticalRanges(4)=(Range=2000,RangeValue=0.6441)
    OpticalRanges(5)=(Range=2500,RangeValue=0.7053)

    //adjusts the strike of the round
    MechanicalRanges(0)=(Range=0,RangeValue=30)
    MechanicalRanges(1)=(Range=500,RangeValue=-85)
    MechanicalRanges(2)=(Range=1000,RangeValue=-135)
    MechanicalRanges(3)=(Range=1500,RangeValue=-215)
    MechanicalRanges(4)=(Range=2000,RangeValue=-285)
    MechanicalRanges(5)=(Range=2500,RangeValue=-300)
}
