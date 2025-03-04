class PanzerIIICannonShellAPCR extends ROTankCannonShell;

defaultproperties
{
	BallisticCoefficient=0.27
	Speed=71313 //1180 M/S
	MaxSpeed=71313
	SpeedFudgeScale=0.4
	bDebugBallistics=false
	bMechanicalAiming=True
	LifeSpan=10
	StaticMesh=StaticMesh'WeaponPickupSM.Ammo.76mm_Shell'

    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=250

	// PanzerIV F2
	PenetrationTable(0)=20
	PenetrationTable(1)=19
	PenetrationTable(2)=18
	PenetrationTable(3)=17
	PenetrationTable(4)=15
	PenetrationTable(5)=13
	PenetrationTable(6)=11
	PenetrationTable(7)=0
	PenetrationTable(8)=0
	PenetrationTable(9)=0
	PenetrationTable(10)=0

	MechanicalRanges(0)=(Range=0,RangeValue=0)
	MechanicalRanges(1)=(Range=100,RangeValue=4)
	MechanicalRanges(2)=(Range=200,RangeValue=10)
	MechanicalRanges(3)=(Range=300,RangeValue=15)
	MechanicalRanges(4)=(Range=400,RangeValue=22)
	MechanicalRanges(5)=(Range=500,RangeValue=31)
	MechanicalRanges(6)=(Range=600,RangeValue=42)
	MechanicalRanges(7)=(Range=700,RangeValue=55)
	MechanicalRanges(8)=(Range=800,RangeValue=76)
	MechanicalRanges(9)=(Range=900,RangeValue=97)
	MechanicalRanges(10)=(Range=1000,RangeValue=130)
	MechanicalRanges(11)=(Range=1200,RangeValue=204)
	MechanicalRanges(12)=(Range=1400,RangeValue=293)
	MechanicalRanges(13)=(Range=1600,RangeValue=432)
	MechanicalRanges(14)=(Range=1800,RangeValue=597)
	MechanicalRanges(15)=(Range=2000,RangeValue=772)
}
