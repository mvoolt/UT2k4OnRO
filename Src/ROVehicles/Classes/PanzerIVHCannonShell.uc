class PanzerIVHCannonShell extends ROTankCannonShell;

defaultproperties
{
	BallisticCoefficient=1.8
	Speed=44660 //740 M/S
	MaxSpeed=44660
	SpeedFudgeScale=0.5
	bDebugBallistics=false
	bMechanicalAiming=True

    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=400

	// PanzerIV H
	PenetrationTable(0)=19
	PenetrationTable(1)=18
	PenetrationTable(2)=18
	PenetrationTable(3)=18
	PenetrationTable(4)=18
	PenetrationTable(5)=17
	PenetrationTable(6)=17
	PenetrationTable(7)=16
	PenetrationTable(8)=16
	PenetrationTable(9)=15
	PenetrationTable(10)=15

	MechanicalRanges(0)=(Range=0,RangeValue=0)
	MechanicalRanges(1)=(Range=100,RangeValue=8)
	MechanicalRanges(2)=(Range=200,RangeValue=20)
	MechanicalRanges(3)=(Range=300,RangeValue=31)
	MechanicalRanges(4)=(Range=400,RangeValue=40)
	MechanicalRanges(5)=(Range=500,RangeValue=55)
	MechanicalRanges(6)=(Range=600,RangeValue=64)
	MechanicalRanges(7)=(Range=700,RangeValue=75)
	MechanicalRanges(8)=(Range=800,RangeValue=86)
	MechanicalRanges(9)=(Range=900,RangeValue=99)
	MechanicalRanges(10)=(Range=1000,RangeValue=112)
	MechanicalRanges(11)=(Range=1200,RangeValue=137)
	MechanicalRanges(12)=(Range=1400,RangeValue=170)
	MechanicalRanges(13)=(Range=1600,RangeValue=203)
	MechanicalRanges(14)=(Range=1800,RangeValue=233)
	MechanicalRanges(15)=(Range=2000,RangeValue=271)
}
