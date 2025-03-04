class T60CannonShell extends PTRDBullet;

// Straight up ripped from ROTankCannonShell since the T60CannonShell is somewhere between a regular bullet and a cannon shell. Maybe
// refactor this later - Ramm
struct RangePoint
{
	var() int           	Range;     			// Meter distance for this range setting
	var() float           	RangeValue;     	// The adjustment value for this range setting
};

var() 	array<RangePoint>	MechanicalRanges; 	// The range setting values for tank cannons that do mechanical pitch adjustments for aiming
var() 	array<RangePoint>	OpticalRanges;    	// The range setting values for tank cannons that do optical sight adjustments for aiming

// for tank cannon aiming. Returns the proper pitch adjustment to hit a target at a particular range
simulated static function int GetPitchForRange(int Range)
{
	local int i;

	for (i = 0; i < default.MechanicalRanges.Length; i++)
	{
		if( default.MechanicalRanges[i].Range >= Range )
		{
			return default.MechanicalRanges[i].RangeValue;
		}
	}

	return 0;
}
// for tank cannon aiming. Returns the proper Y adjustment of the scope to hit a target at a particular range
simulated static function float GetYAdjustForRange(int Range)
{
	local int i;

	for (i = 0; i < default.OpticalRanges.Length; i++)
	{
		if( default.OpticalRanges[i].Range >= Range )
		{
			return default.OpticalRanges[i].RangeValue;
		}
	}

	return 0;
}

simulated function Destroyed()
{
	if( ROTankCannonPawn(Instigator) != none && ROTankCannon(ROTankCannonPawn(Instigator).Gun) != none)
	{
		ROTankCannon(ROTankCannonPawn(Instigator).Gun).HandleShellDebug(Location);
	}

	super.Destroyed();
}

defaultproperties
{
	BallisticCoefficient=0.27
	Speed=45866 //760 M/S
	MaxSpeed=45866
	SpeedFudgeScale=1.0
	bDebugBallistics=False

	MyDamageType=class'T60CannonShellDamType'
    Damage=135

	PenetrationTable(0)=7
	PenetrationTable(1)=6
	PenetrationTable(2)=5
	PenetrationTable(3)=5
	PenetrationTable(4)=4
	PenetrationTable(5)=4
	PenetrationTable(6)=3
	PenetrationTable(7)=2
	PenetrationTable(8)=1
	PenetrationTable(9)=0
	PenetrationTable(10)=0

    OpticalRanges(0)=(Range=0,RangeValue=0.48)
    OpticalRanges(1)=(Range=400,RangeValue=0.521)
    OpticalRanges(2)=(Range=600,RangeValue=0.537)
    OpticalRanges(3)=(Range=800,RangeValue=0.552)
    OpticalRanges(4)=(Range=1000,RangeValue=0.585)

    MechanicalRanges(0)=(Range=0,RangeValue=0)
    MechanicalRanges(1)=(Range=400,RangeValue=-130)
    MechanicalRanges(2)=(Range=600,RangeValue=-190)
    MechanicalRanges(3)=(Range=800,RangeValue=-195)
    MechanicalRanges(4)=(Range=1000,RangeValue=-190)
}
