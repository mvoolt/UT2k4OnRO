//===================================================================
// BT7Cannon
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// BT7 tank cannon shell class
//===================================================================
class BT7CannonShell extends ROTankCannonShell;

defaultproperties
{
	BallisticCoefficient=0.7 // 1.13 - 2.45kg, (0.461 * 2.45), using BR-240 SP ( Armor Piercing Ballistic Cap )   //bill  - updated with data from Alan Wilson                                                //bill
	Speed=45806 // 759 M/S, (60.35 * 759), using BR-240 SP ( Armor Piercing Ballistic Cap )
	MaxSpeed=45806                                                              //Increased M/S from 50392
	SpeedFudgeScale=0.5
	bDebugBallistics=false
	bOpticalAiming=true
	bMechanicalAiming=true

    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=190

    //bill - updated with data from Alan Wilson and adjusted to match the RO vehicle cannons
	PenetrationTable(0)=11                                                      //Reduce from 14
	PenetrationTable(1)=11                                                      //Reduce from 14
    PenetrationTable(2)=10                                                      //Reduce from 13
	PenetrationTable(3)=10                                                      //Reduce from 13
	PenetrationTable(4)=10                                                      //Reduce from 13
	PenetrationTable(5)=9                                                       //Reduce from 12
	PenetrationTable(6)=8                                                       //Reduce from 11
	PenetrationTable(7)=8                                                       //Reduce from 11
	PenetrationTable(8)=7                                                       //Reduce from 10
	PenetrationTable(9)=6                                                       //Reduce from 9
	PenetrationTable(10)=6

    //adjusts the range bar
    OpticalRanges(0)=(Range=0,RangeValue=0.48)
    OpticalRanges(1)=(Range=250,RangeValue=0.496)
    OpticalRanges(2)=(Range=500,RangeValue=0.512)
    OpticalRanges(3)=(Range=1000,RangeValue=0.5426)
    OpticalRanges(4)=(Range=1500,RangeValue=0.5885)
    OpticalRanges(5)=(Range=2000,RangeValue=0.6441)
    OpticalRanges(6)=(Range=2500,RangeValue=0.7053)

    //adjusts the strike of the round
    MechanicalRanges(0)=(Range=0,RangeValue=-5)
    MechanicalRanges(1)=(Range=250,RangeValue=-40)
    MechanicalRanges(2)=(Range=500,RangeValue=-70)
    MechanicalRanges(3)=(Range=1000,RangeValue=-145)
    MechanicalRanges(4)=(Range=1500,RangeValue=-205)
    MechanicalRanges(5)=(Range=2000,RangeValue=-255)
    MechanicalRanges(6)=(Range=2500,RangeValue=-265)
}
