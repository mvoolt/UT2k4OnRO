class SU76CannonShell extends ROTankCannonShell;

defaultproperties
{
	BallisticCoefficient=2.0
	Speed=41038 //680 M/S
	MaxSpeed=41038
	SpeedFudgeScale=0.5
	bDebugBallistics=false
	bMechanicalAiming=True

    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=350

	PenetrationTable(0)=14
	PenetrationTable(1)=13
	PenetrationTable(2)=13
	PenetrationTable(3)=13
	PenetrationTable(4)=13
	PenetrationTable(5)=12
	PenetrationTable(6)=12
	PenetrationTable(7)=11
	PenetrationTable(8)=11
	PenetrationTable(9)=10
	PenetrationTable(10)=10

	MechanicalRanges(0)=(Range=0,RangeValue=0)
	MechanicalRanges(1)=(Range=100,RangeValue=10)
	MechanicalRanges(2)=(Range=200,RangeValue=25)
	MechanicalRanges(3)=(Range=300,RangeValue=37)
	MechanicalRanges(4)=(Range=400,RangeValue=48)
	MechanicalRanges(5)=(Range=500,RangeValue=60)
	MechanicalRanges(6)=(Range=600,RangeValue=75)
	MechanicalRanges(7)=(Range=700,RangeValue=88)
	MechanicalRanges(8)=(Range=800,RangeValue=103)
	MechanicalRanges(9)=(Range=900,RangeValue=118)
	MechanicalRanges(10)=(Range=1000,RangeValue=130)
	MechanicalRanges(11)=(Range=1200,RangeValue=162)
	MechanicalRanges(12)=(Range=1400,RangeValue=200)
	MechanicalRanges(13)=(Range=1600,RangeValue=234)
	MechanicalRanges(14)=(Range=1800,RangeValue=276)
	MechanicalRanges(15)=(Range=2000,RangeValue=312)
	MechanicalRanges(16)=(Range=2200,RangeValue=355)
	MechanicalRanges(17)=(Range=2400,RangeValue=400)
	MechanicalRanges(18)=(Range=2600,RangeValue=449)
	MechanicalRanges(19)=(Range=2800,RangeValue=504)
	MechanicalRanges(20)=(Range=3000,RangeValue=559)
	MechanicalRanges(21)=(Range=3200,RangeValue=620)
	MechanicalRanges(22)=(Range=3400,RangeValue=685)
	MechanicalRanges(23)=(Range=3600,RangeValue=753)
	MechanicalRanges(24)=(Range=3800,RangeValue=827)
	MechanicalRanges(25)=(Range=4000,RangeValue=902)
}
