class PanzerIVF1CannonShell extends ROTankCannonShell;

defaultproperties
{
	BallisticCoefficient=1.8
	Speed=23234 //385 M/S
	MaxSpeed=23234
	SpeedFudgeScale=0.75
	bDebugBallistics=false
	bMechanicalAiming=True

    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=300

	// PanzerIV F2
	PenetrationTable(0)=11
	PenetrationTable(1)=10
	PenetrationTable(2)=10
	PenetrationTable(3)=10
	PenetrationTable(4)=10
	PenetrationTable(5)=9
	PenetrationTable(6)=9
	PenetrationTable(7)=8
	PenetrationTable(8)=8
	PenetrationTable(9)=7
	PenetrationTable(10)=7

	MechanicalRanges(0)=(Range=0,RangeValue=0)
	MechanicalRanges(1)=(Range=100,RangeValue=35)
	MechanicalRanges(2)=(Range=200,RangeValue=70)
	MechanicalRanges(3)=(Range=300,RangeValue=110)
	MechanicalRanges(4)=(Range=400,RangeValue=150)
	MechanicalRanges(5)=(Range=500,RangeValue=190)
	MechanicalRanges(6)=(Range=600,RangeValue=231)
	MechanicalRanges(7)=(Range=700,RangeValue=275)
	MechanicalRanges(8)=(Range=800,RangeValue=317)
	MechanicalRanges(9)=(Range=900,RangeValue=360)
	MechanicalRanges(10)=(Range=1000,RangeValue=405)
	MechanicalRanges(11)=(Range=1200,RangeValue=508)
	MechanicalRanges(12)=(Range=1400,RangeValue=607)
	MechanicalRanges(13)=(Range=1600,RangeValue=710)
	MechanicalRanges(14)=(Range=1800,RangeValue=812)
	MechanicalRanges(15)=(Range=2000,RangeValue=928)
}
