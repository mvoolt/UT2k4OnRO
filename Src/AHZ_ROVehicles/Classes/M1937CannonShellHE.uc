//==============================================================================
// M1937CannonShellHE
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// M-1937 45mm AT Gun Cannon class
//==============================================================================
class M1937CannonShellHE extends CannonShellHE45MM;

//==============================================================================
// defaultproperties
//==============================================================================
defaultproperties
{
	BallisticCoefficient= 0.6//0.987 - 2.14kg, (0.461 * 2.14), using UO-240A ( HE Fragmentation ) - updated with data from Alan Wilson
	Speed=20217 // 335 M/S, (60.35 * 335), using UO-240A ( HE Fragmentation ) - updated with data from Alan Wilson
	MaxSpeed=20217
	SpeedFudgeScale=0.75
	bDebugBallistics=false
	bOpticalAiming=true
	bMechanicalAiming=true

    //adjusts the range bar
    OpticalRanges(0)=(Range=0,RangeValue=0.48)
    OpticalRanges(1)=(Range=500,RangeValue=0.512)
    OpticalRanges(2)=(Range=1000,RangeValue=0.5426)
    OpticalRanges(3)=(Range=1500,RangeValue=0.5885)
    OpticalRanges(4)=(Range=2000,RangeValue=0.6441)
    OpticalRanges(5)=(Range=2500,RangeValue=0.7053)

    //adjusts the strike of the round
    MechanicalRanges(0)=(Range=0,RangeValue=90)
    MechanicalRanges(1)=(Range=500,RangeValue=145)
    MechanicalRanges(2)=(Range=1000,RangeValue=320)
    MechanicalRanges(3)=(Range=1500,RangeValue=520)
    MechanicalRanges(4)=(Range=2000,RangeValue=760)
	//Range below is an estimate because it hit the ceiling on the test map
    MechanicalRanges(5)=(Range=2500,RangeValue=1000)
}
