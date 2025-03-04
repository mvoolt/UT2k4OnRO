class PantherCannonShell extends ROTankCannonShell;

defaultproperties
{
	BallisticCoefficient=1.8
	Speed=56427 //935 M/S
	MaxSpeed=56427
	SpeedFudgeScale=0.5
	bDebugBallistics=false
	bMechanicalAiming=True

    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=450
    //Physics=PHYS_Falling

	PenetrationTable(0)=24
	PenetrationTable(1)=23
	PenetrationTable(2)=23
	PenetrationTable(3)=23
	PenetrationTable(4)=23
	PenetrationTable(5)=22
	PenetrationTable(6)=22
	PenetrationTable(7)=21
	PenetrationTable(8)=21
	PenetrationTable(9)=20
	PenetrationTable(10)=20

	MechanicalRanges(0)=(Range=0,RangeValue=0)
	MechanicalRanges(1)=(Range=100,RangeValue=4)
	MechanicalRanges(2)=(Range=200,RangeValue=12)
	MechanicalRanges(3)=(Range=300,RangeValue=18)
	MechanicalRanges(4)=(Range=400,RangeValue=25)
	MechanicalRanges(5)=(Range=500,RangeValue=32)
	MechanicalRanges(6)=(Range=600,RangeValue=40)
	MechanicalRanges(7)=(Range=700,RangeValue=47)
	MechanicalRanges(8)=(Range=800,RangeValue=55)
	MechanicalRanges(9)=(Range=900,RangeValue=62)
	MechanicalRanges(10)=(Range=1000,RangeValue=70)
	MechanicalRanges(11)=(Range=1200,RangeValue=88)
	MechanicalRanges(12)=(Range=1400,RangeValue=106)
	MechanicalRanges(13)=(Range=1600,RangeValue=129)
	MechanicalRanges(14)=(Range=1800,RangeValue=150)
	MechanicalRanges(15)=(Range=2000,RangeValue=167)
	MechanicalRanges(16)=(Range=2200,RangeValue=187)
	MechanicalRanges(17)=(Range=2400,RangeValue=215)
	MechanicalRanges(18)=(Range=2600,RangeValue=242)
	MechanicalRanges(19)=(Range=2800,RangeValue=263)
	MechanicalRanges(20)=(Range=3000,RangeValue=294)
}
