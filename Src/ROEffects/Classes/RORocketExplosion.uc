//=============================================================================
// RocketExplosion
//=============================================================================
class RORocketExplosion extends xEmitter;

// MergeTODO: Replace this with our artwork
#EXEC texture IMPORT NAME=Rexpt FILE=textures\explochunks.tga GROUP=Skins DXT=5

simulated function PostBeginPlay()
{
	Spawn(class'ROSmokeRing');
	if ( Level.bDropDetail )
		LightRadius = 7;
}

defaultproperties
{
    Style=STY_Additive
    mParticleType=PL_Sprite
    mDirDev=(X=1.0,Y=1.0,Z=1.0)
    mPosDev=(X=0.0,Y=0.0,Z=0.0)
    mLifeRange(0)=0.3
    mLifeRange(1)=1.2
    mSpeedRange(0)=3.0
    mSpeedRange(1)=10.0
    mSizeRange(0)=100.0
    mSizeRange(1)=200.0
    mMassRange(0)=0.0
    mMassRange(1)=0.0
    mSpinRange(0)=-20.0
    mSpinRange(1)=20.0
    mStartParticles=6
    mMaxParticles=6
    mAttenuate=true
    mRandOrient=true
    mRegen=false
    mRandTextures=false
    skins(0)=Texture'REXpt'
    LifeSpan=2.0
    bForceAffected=false

    bDynamicLight=true
    LightEffect=LE_QuadraticNonIncidence
    LightType=LT_FadeOut
    LightBrightness=255
    LightHue=28
    LightSaturation=90
    LightRadius=9
    LightPeriod=32
    LightCone=128
}
