class TigerCannonShell extends ROTankCannonShell;

defaultproperties
{
	BallisticCoefficient=2.2
	Speed=46650 //773 M/S
	MaxSpeed=46650
	SpeedFudgeScale=0.5
	bDebugBallistics=false
	bMechanicalAiming=True
	StaticMesh=StaticMesh'WeaponPickupSM.Ammo.122mm_Shell'

    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=450

	PenetrationTable(0)=23//21
	PenetrationTable(1)=22//20
	PenetrationTable(2)=22//20
	PenetrationTable(3)=22//20
	PenetrationTable(4)=22//20
	PenetrationTable(5)=21//19
	PenetrationTable(6)=21//19
	PenetrationTable(7)=20//18
	PenetrationTable(8)=20//18
	PenetrationTable(9)=19//17
	PenetrationTable(10)=19//17

	MechanicalRanges(0)=(Range=0,RangeValue=0)
	MechanicalRanges(1)=(Range=100,RangeValue=8)
	MechanicalRanges(2)=(Range=200,RangeValue=18)
	MechanicalRanges(3)=(Range=300,RangeValue=29)
	MechanicalRanges(4)=(Range=400,RangeValue=38)
	MechanicalRanges(5)=(Range=500,RangeValue=45)
	MechanicalRanges(6)=(Range=600,RangeValue=55)
	MechanicalRanges(7)=(Range=700,RangeValue=67)
	MechanicalRanges(8)=(Range=800,RangeValue=75)
	MechanicalRanges(9)=(Range=900,RangeValue=87)
	MechanicalRanges(10)=(Range=1000,RangeValue=98)
	MechanicalRanges(11)=(Range=1200,RangeValue=120)
	MechanicalRanges(12)=(Range=1400,RangeValue=145)
	MechanicalRanges(13)=(Range=1600,RangeValue=170)
	MechanicalRanges(14)=(Range=1800,RangeValue=205)
	MechanicalRanges(15)=(Range=2000,RangeValue=230)
	MechanicalRanges(16)=(Range=2200,RangeValue=260)
	MechanicalRanges(17)=(Range=2400,RangeValue=295)
	MechanicalRanges(18)=(Range=2600,RangeValue=325)
	MechanicalRanges(19)=(Range=2800,RangeValue=363)
	MechanicalRanges(20)=(Range=3000,RangeValue=403)
	MechanicalRanges(21)=(Range=3200,RangeValue=448)
	MechanicalRanges(22)=(Range=3400,RangeValue=493)
	MechanicalRanges(23)=(Range=3600,RangeValue=541)
	MechanicalRanges(24)=(Range=3800,RangeValue=589)
	MechanicalRanges(25)=(Range=4000,RangeValue=639)
}
