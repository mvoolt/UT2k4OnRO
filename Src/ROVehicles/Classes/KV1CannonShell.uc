class KV1CannonShell extends ROTankCannonShell;

defaultproperties
{
	BallisticCoefficient=1.55
	Speed=39529 //655 M/S
	MaxSpeed=39529
	SpeedFudgeScale=0.50
	bDebugBallistics=False
	bOpticalAiming=True
	bMechanicalAiming=True

    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=350
    //Physics=PHYS_Falling

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

    OpticalRanges(0)=(Range=0,RangeValue=0.3577)
    OpticalRanges(1)=(Range=400,RangeValue=0.3722)
    OpticalRanges(2)=(Range=600,RangeValue=0.387)
    OpticalRanges(3)=(Range=800,RangeValue=0.402)
    OpticalRanges(4)=(Range=1000,RangeValue=0.417)
    OpticalRanges(5)=(Range=1200,RangeValue=0.432)
    OpticalRanges(6)=(Range=1400,RangeValue=0.447)
    OpticalRanges(7)=(Range=1600,RangeValue=0.462)
    OpticalRanges(8)=(Range=1800,RangeValue=0.477)
    OpticalRanges(9)=(Range=2000,RangeValue=0.492)
    OpticalRanges(10)=(Range=2200,RangeValue=0.507)
    OpticalRanges(11)=(Range=2400,RangeValue=0.522)
    OpticalRanges(12)=(Range=2600,RangeValue=0.537)
    OpticalRanges(13)=(Range=2800,RangeValue=0.552)
    OpticalRanges(14)=(Range=3000,RangeValue=0.567)
    OpticalRanges(15)=(Range=3200,RangeValue=0.580)
    OpticalRanges(16)=(Range=3400,RangeValue=0.593)
    OpticalRanges(17)=(Range=3600,RangeValue=0.608)
    OpticalRanges(18)=(Range=3800,RangeValue=0.623)
    OpticalRanges(19)=(Range=4000,RangeValue=0.637)
    OpticalRanges(20)=(Range=4200,RangeValue=0.652)
    OpticalRanges(21)=(Range=4400,RangeValue=0.667)
    OpticalRanges(22)=(Range=4600,RangeValue=0.682)
    OpticalRanges(23)=(Range=4800,RangeValue=0.697)
    OpticalRanges(24)=(Range=5000,RangeValue=0.712)
    OpticalRanges(25)=(Range=5200,RangeValue=0.727)
    OpticalRanges(26)=(Range=5400,RangeValue=0.742)
    OpticalRanges(27)=(Range=5600,RangeValue=0.757)
    OpticalRanges(28)=(Range=5800,RangeValue=0.772)
    OpticalRanges(29)=(Range=6000,RangeValue=0.787)

    MechanicalRanges(0)=(Range=0,RangeValue=0)
    MechanicalRanges(1)=(Range=400,RangeValue=-5)
    MechanicalRanges(2)=(Range=600,RangeValue=-15)
    MechanicalRanges(3)=(Range=800,RangeValue=-25)
    MechanicalRanges(4)=(Range=1000,RangeValue=-40)
    MechanicalRanges(5)=(Range=1200,RangeValue=-45)
    MechanicalRanges(6)=(Range=1400,RangeValue=-50)
    MechanicalRanges(7)=(Range=1600,RangeValue=-55)
    MechanicalRanges(8)=(Range=1800,RangeValue=-40)
    MechanicalRanges(9)=(Range=2000,RangeValue=-32)
    MechanicalRanges(10)=(Range=2200,RangeValue=-18)
    MechanicalRanges(11)=(Range=2400,RangeValue=-2)
    MechanicalRanges(12)=(Range=2600,RangeValue=-26)
    MechanicalRanges(13)=(Range=2800,RangeValue=-50)
    MechanicalRanges(14)=(Range=3000,RangeValue=-86)
    MechanicalRanges(15)=(Range=3200,RangeValue=-129)
    MechanicalRanges(16)=(Range=3400,RangeValue=-182)
    MechanicalRanges(17)=(Range=3600,RangeValue=-233)
    MechanicalRanges(18)=(Range=3800,RangeValue=-291)
	//Range below is an estimate because it hit the ceiling on the test map
    MechanicalRanges(19)=(Range=4000,RangeValue=-350)
    // TODO - dial in the rest of these ranges
    MechanicalRanges(20)=(Range=4200,RangeValue=0)
    MechanicalRanges(21)=(Range=4400,RangeValue=0)
    MechanicalRanges(22)=(Range=4600,RangeValue=0)
    MechanicalRanges(23)=(Range=4800,RangeValue=0)
    MechanicalRanges(24)=(Range=5000,RangeValue=0)
    MechanicalRanges(25)=(Range=5200,RangeValue=0)
    MechanicalRanges(26)=(Range=5400,RangeValue=0)
    MechanicalRanges(27)=(Range=5600,RangeValue=0)
    MechanicalRanges(28)=(Range=5800,RangeValue=0)
    MechanicalRanges(29)=(Range=6000,RangeValue=0)
}
