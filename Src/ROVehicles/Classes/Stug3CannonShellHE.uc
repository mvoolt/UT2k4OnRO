class Stug3CannonShellHE extends CannonShellHE75MM;

defaultproperties
{
	BallisticCoefficient=1.9
	Speed=32859 //540 M/S
	MaxSpeed=32859
	SpeedFudgeScale=0.6
	bDebugBallistics=false
	bMechanicalAiming=True

	MechanicalRanges(0)=(Range=0,RangeValue=0)
	MechanicalRanges(1)=(Range=100,RangeValue=17)
	MechanicalRanges(2)=(Range=200,RangeValue=36)
	MechanicalRanges(3)=(Range=300,RangeValue=57)
	MechanicalRanges(4)=(Range=400,RangeValue=77)
	MechanicalRanges(5)=(Range=500,RangeValue=98)
	MechanicalRanges(6)=(Range=600,RangeValue=115)
	MechanicalRanges(7)=(Range=700,RangeValue=137)
	MechanicalRanges(8)=(Range=800,RangeValue=160)
	MechanicalRanges(9)=(Range=900,RangeValue=183)
	MechanicalRanges(10)=(Range=1000,RangeValue=208)
	MechanicalRanges(11)=(Range=1200,RangeValue=262)
	MechanicalRanges(12)=(Range=1400,RangeValue=320)
	MechanicalRanges(13)=(Range=1600,RangeValue=379)
	MechanicalRanges(14)=(Range=1800,RangeValue=440)
	MechanicalRanges(15)=(Range=2000,RangeValue=504)
	MechanicalRanges(16)=(Range=2200,RangeValue=573)
	MechanicalRanges(17)=(Range=2400,RangeValue=652)
	MechanicalRanges(18)=(Range=2600,RangeValue=730)
	MechanicalRanges(19)=(Range=2800,RangeValue=809)
	MechanicalRanges(20)=(Range=3000,RangeValue=900)
	MechanicalRanges(21)=(Range=3200,RangeValue=984)
	MechanicalRanges(22)=(Range=3400,RangeValue=1087)
	MechanicalRanges(23)=(Range=3600,RangeValue=1208)
	//Ranges below are estimates because they hit the ceiling on the test map
	MechanicalRanges(24)=(Range=3800,RangeValue=1340)
	MechanicalRanges(25)=(Range=4000,RangeValue=1485)
}
