//=============================================================================
// ROPawnSoundGroup
//=============================================================================
// Player sounds. Some functionality copied from xPawnSoundGroup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John Gibson
//=============================================================================

class ROPawnSoundGroup extends Object
    abstract;

var() array<Sound>  Sounds;
var() sound         HeadShotDeathSoundGroup;
var() sound         UpperBodyShotDeathSoundGroup;
var() sound         LowerBodyShotDeathSoundGroup;
var() sound         LimbShotDeathSoundGroup;
var() sound         GenericDeathSoundGroup;
var() sound         FallingPainSoundGroup;
var() sound         WoundingPainSoundGroup;

var() Sound         LandSounds[20]; // Indexed by ESurfaceTypes (sorry about the literal).
var() Sound         JumpSounds[20]; // Indexed by ESurfaceTypes (sorry about the literal).

Enum ESoundType
{
    EST_Land,
    EST_CorpseLanded,
    EST_HitUnderWater,
    EST_Jump,
    EST_LandGrunt,
    EST_Gasp,
    EST_Drown,
    EST_BreatheAgain,
	EST_TiredJump,
    EST_Dodge,
    EST_DoubleJump,
    EST_DiveLand
};

static function Sound GetHitSound(optional class<DamageType> DamageType)
{
    //If they are taking damage because they fell, return a falling pain sound
    if ( DamageType.Name == 'Fell' )
        return default.FallingPainSoundGroup;

    //Otherwise, return a wounding pain sound
    return default.WoundingPainSoundGroup;
}

static function Sound GetDeathSound(optional int HitIndex)
{
    //Check for a Head shot
    if( HitIndex == 1 )
        return default.HeadShotDeathSoundGroup;
    //Check for Upper Torso shot
    else if( HitIndex == 2 )
        return default.UpperBodyShotDeathSoundGroup;
    //Check for Lower Torso shot
    else if( HitIndex == 3 )
        return default.LowerBodyShotDeathSoundGroup;
    //Check for Arm/Hand and Leg/Foot shot
    else if( HitIndex >= 4 && HitIndex <= 15 )
        return default.LimbShotDeathSoundGroup;

    //Hit somewhere without a group, return a generic sound
    return default.GenericDeathSoundGroup;
}

static function Sound GetSound(ESoundType SoundType, optional int SurfaceID)
{
    if( SoundType == EST_Land )
	{
		return default.LandSounds[SurfaceID];
	}
	else if( SoundType == EST_Jump )
	{
	  	return default.JumpSounds[SurfaceID];
	}
	else
	{
        return default.Sounds[int(SoundType)];
    }
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	Sounds(0)=Sound'Inf_Player.LandDirt'
	Sounds(1)=None
	Sounds(2)=Sound'Inf_Player.Wounding' // do we really need a hit underwater sound? A player hit sound should be fine
	Sounds(3)=None
	Sounds(4)=None
	Sounds(5)=None
	Sounds(6)=None
	Sounds(7)=None
	Sounds(8)=Sound'Inf_Player.JumpTired'
	Sounds(9)=None
	Sounds(10)=None
	Sounds(11)=Sound'Inf_Player.Land_Prone'

	LandSounds(0)=Sound'Inf_Player.LandDirt'
	LandSounds(1)=Sound'Inf_Player.LandAsphalt' // Rock
	LandSounds(2)=Sound'Inf_Player.LandDirt'
	LandSounds(3)=Sound'Inf_Player.LandMetal' // Metal
	LandSounds(4)=Sound'Inf_Player.LandWood' // Wood
	LandSounds(5)=Sound'Inf_Player.LandGrass' // Plant
	LandSounds(6)=Sound'Inf_Player.LandDirt' // Flesh
	LandSounds(7)=Sound'Inf_Player.LandSnowRough' // Ice
	LandSounds(8)=Sound'Inf_Player.LandSnowHard'
	LandSounds(9)=Sound'Inf_Player.LandWaterShallow'
	LandSounds(10)=Sound'Inf_Player.LandDirt' // Glass- Replaceme
	LandSounds(11)=Sound'Inf_Player.LandDirt' // Gravel
	LandSounds(12)=Sound'Inf_Player.LandAsphalt' // Concrete
	LandSounds(13)=Sound'Inf_Player.LandWood' // HollowWood
	LandSounds(14)=Sound'Inf_Player.LandMud' // Mud
	LandSounds(15)=Sound'Inf_Player.LandMetal' // MetalArmor
	LandSounds(16)=Sound'Inf_Player.LandAsphalt' // Paper
	LandSounds(17)=Sound'Inf_Player.LandDirt' // Cloth
	LandSounds(18)=Sound'Inf_Player.LandDirt' // Rubber
	LandSounds(19)=Sound'Inf_Player.LandDirt' // Crap

	JumpSounds(0)=Sound'Inf_Player.JumpDirt'
	JumpSounds(1)=Sound'Inf_Player.JumpAsphalt' // Rock
	JumpSounds(2)=Sound'Inf_Player.JumpDirt'
	JumpSounds(3)=Sound'Inf_Player.JumpMetal' // Metal
	JumpSounds(4)=Sound'Inf_Player.JumpWood' // Wood
	JumpSounds(5)=Sound'Inf_Player.JumpGrass' // Plant
	JumpSounds(6)=Sound'Inf_Player.JumpDirt' // Flesh
	JumpSounds(7)=Sound'Inf_Player.JumpSnowRough' // Ice
	JumpSounds(8)=Sound'Inf_Player.JumpSnowHard'
	JumpSounds(9)=Sound'Inf_Player.JumpWaterShallow'
	JumpSounds(10)=Sound'Inf_Player.JumpDirt' // Glass- Replaceme
	JumpSounds(11)=Sound'Inf_Player.JumpDirt' // Gravel
	JumpSounds(12)=Sound'Inf_Player.JumpAsphalt' // Concrete
	JumpSounds(13)=Sound'Inf_Player.JumpWood' // HollowWood
	JumpSounds(14)=Sound'Inf_Player.JumpMud' // Mud
	JumpSounds(15)=Sound'Inf_Player.JumpMetal' // MetalArmor
	JumpSounds(16)=Sound'Inf_Player.JumpAsphalt' // Paper
	JumpSounds(17)=Sound'Inf_Player.JumpDirt' // Cloth
	JumpSounds(18)=Sound'Inf_Player.JumpDirt' // Rubber
	JumpSounds(19)=Sound'Inf_Player.JumpDirt' // Crap

    HeadShotDeathSoundGroup=Sound'Inf_Player.Headshot'
    UpperBodyShotDeathSoundGroup=Sound'Inf_Player.UpperBodyShot'
    LowerBodyShotDeathSoundGroup=Sound'Inf_Player.LowerBodyShot'
    LimbShotDeathSoundGroup=Sound'Inf_Player.LimbShot'
    GenericDeathSoundGroup=Sound'Inf_Player.Generic'

    FallingPainSoundGroup=Sound'Inf_Player.Falling'
    WoundingPainSoundGroup=Sound'Inf_Player.Wounding'
}
