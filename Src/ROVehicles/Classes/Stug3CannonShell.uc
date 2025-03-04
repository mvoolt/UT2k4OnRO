class Stug3CannonShell extends ROTankCannonShell;

defaultproperties
{
	BallisticCoefficient=1.65
	Speed=47676 //790 M/S
	MaxSpeed=47676
	SpeedFudgeScale=0.5
	bDebugBallistics=false
	bMechanicalAiming=True

    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=400

	// PanzerIV F2
	PenetrationTable(0)=18
	PenetrationTable(1)=17
	PenetrationTable(2)=17
	PenetrationTable(3)=17
	PenetrationTable(4)=17
	PenetrationTable(5)=16
	PenetrationTable(6)=16
	PenetrationTable(7)=15
	PenetrationTable(8)=15
	PenetrationTable(9)=14
	PenetrationTable(10)=14

	MechanicalRanges(0)=(Range=0,RangeValue=0)
	MechanicalRanges(1)=(Range=100,RangeValue=8)
	MechanicalRanges(2)=(Range=200,RangeValue=16)
	MechanicalRanges(3)=(Range=300,RangeValue=28)
	MechanicalRanges(4)=(Range=400,RangeValue=36)
	MechanicalRanges(5)=(Range=500,RangeValue=45)
	MechanicalRanges(6)=(Range=600,RangeValue=56)
	MechanicalRanges(7)=(Range=700,RangeValue=67)
	MechanicalRanges(8)=(Range=800,RangeValue=76)
	MechanicalRanges(9)=(Range=900,RangeValue=87)
	MechanicalRanges(10)=(Range=1000,RangeValue=99)
	MechanicalRanges(11)=(Range=1200,RangeValue=131)
	MechanicalRanges(12)=(Range=1400,RangeValue=158)
	MechanicalRanges(13)=(Range=1600,RangeValue=183)
	MechanicalRanges(14)=(Range=1800,RangeValue=215)
	MechanicalRanges(15)=(Range=2000,RangeValue=248)
	MechanicalRanges(16)=(Range=2200,RangeValue=283)
	MechanicalRanges(17)=(Range=2400,RangeValue=322)
	MechanicalRanges(18)=(Range=2600,RangeValue=364)
	MechanicalRanges(19)=(Range=2800,RangeValue=411)
	MechanicalRanges(20)=(Range=3000,RangeValue=460)
	MechanicalRanges(21)=(Range=3200,RangeValue=514)
	MechanicalRanges(22)=(Range=3400,RangeValue=571)
	MechanicalRanges(23)=(Range=3600,RangeValue=633)
	MechanicalRanges(24)=(Range=3800,RangeValue=697)
	MechanicalRanges(25)=(Range=4000,RangeValue=770)
}
