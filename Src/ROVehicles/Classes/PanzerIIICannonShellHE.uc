class PanzerIIICannonShellHE extends CannonShellHE50MM;

// TODO: Plug in the real ballistics for this
defaultproperties
{
	BallisticCoefficient=0.95
	Speed=50392 //835 M/S
	MaxSpeed=50392
	SpeedFudgeScale=0.5
	bDebugBallistics=false
	bMechanicalAiming=True
	StaticMesh=StaticMesh'WeaponPickupSM.Ammo.76mm_Shell'

	MechanicalRanges(0)=(Range=0,RangeValue=0)
	MechanicalRanges(1)=(Range=100,RangeValue=8)
	MechanicalRanges(2)=(Range=200,RangeValue=14)
	MechanicalRanges(3)=(Range=300,RangeValue=25)
	MechanicalRanges(4)=(Range=400,RangeValue=32)
	MechanicalRanges(5)=(Range=500,RangeValue=45)
	MechanicalRanges(6)=(Range=600,RangeValue=52)
	MechanicalRanges(7)=(Range=700,RangeValue=65)
	MechanicalRanges(8)=(Range=800,RangeValue=77)
	MechanicalRanges(9)=(Range=900,RangeValue=90)
	MechanicalRanges(10)=(Range=1000,RangeValue=100)
	MechanicalRanges(11)=(Range=1200,RangeValue=131)
	MechanicalRanges(12)=(Range=1400,RangeValue=166)
	MechanicalRanges(13)=(Range=1600,RangeValue=203)
	MechanicalRanges(14)=(Range=1800,RangeValue=251)
	MechanicalRanges(15)=(Range=2000,RangeValue=296)
	//Ranges below are not currently used due to visible scope range limitations
/*	MechanicalRanges(16)=(Range=2200,RangeValue=359)
	MechanicalRanges(17)=(Range=2400,RangeValue=424)
	MechanicalRanges(18)=(Range=2600,RangeValue=503)
	MechanicalRanges(19)=(Range=2800,RangeValue=581)
	MechanicalRanges(20)=(Range=3000,RangeValue=672)
	MechanicalRanges(21)=(Range=3200,RangeValue=772)
	MechanicalRanges(22)=(Range=3400,RangeValue=871)
	MechanicalRanges(23)=(Range=3600,RangeValue=987)
	//Ranges below are estimates because they hit the ceiling on the test map
	MechanicalRanges(24)=(Range=3800,RangeValue=1094)
	MechanicalRanges(25)=(Range=4000,RangeValue=1202)
*/
}
