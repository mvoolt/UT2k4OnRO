//=============================================================================
// ROBloodPuff
//=============================================================================
// Blood puff for when a bullet hits a player
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - David Hensley & John "Ramm-Jaeger" Gibson
//=============================================================================

class ROBloodPuff extends Emitter;

defaultproperties
{
    //blood spray
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        ResetAfterChange=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-80.000000)
        ColorScale(0)=(Color=(B=250,G=250,R=250))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeInEndTime=0.050000
        MaxParticles=1
        Name="SpriteEmitter5"
        StartLocationRange=(X=(Max=20.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
        SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.500000)
        SizeScale(2)=(RelativeTime=0.500000,RelativeSize=2.000000)
        SizeScale(3)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=5.000000,Max=11.000000),Y=(Min=5.000000,Max=11.000000),Z=(Min=5.000000,Max=11.000000))
        InitialParticlesPerSecond=1000.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'Effects_Tex.GoreEmitters.BloodCircle'
        TextureUSubdivisions=1
        TextureVSubdivisions=1
        LifetimeRange=(Min=0.500000,Max=0.750000)
        StartVelocityRange=(X=(Min=-60.000000,Max=-40.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=75.000000))
        MaxAbsVelocity=(X=1000.000000,Y=1000.000000,Z=1000.000000)
        VelocityLossRange=(X=(Min=0.250000,Max=0.250000))
        GetVelocityDirectionFrom=PTVD_OwnerAndStartPosition
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-200.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=3
        Name="SpriteEmitter6"
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=-180.000000,Max=180.000000),Y=(Min=-180.000000,Max=180.000000),Z=(Min=-180.000000,Max=180.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
        InitialParticlesPerSecond=1000.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'Effects_Tex.GoreEmitters.BloodCircle'
        LifetimeRange=(Min=0.500000,Max=0.750000)
        StartVelocityRange=(X=(Min=-100.000000,Max=-50.000000),Z=(Min=25.000000,Max=50.000000))
        VelocityLossRange=(X=(Min=0.250000,Max=0.250000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(A=255))
        Opacity=0.500000
        FadeOutStartTime=0.400000
        MaxParticles=3
        Name="SpriteEmitter7"
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=0.250000,RelativeSize=2.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.750000)
        StartSizeRange=(X=(Min=9.000000,Max=11.000000))
        InitialParticlesPerSecond=5000.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'Effects_Tex.BulletHits.metalsmokefinal'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.800000,Max=0.800000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'

	AutoDestroy=True
    Style=STY_Alpha
    bDirectional=True
    bNoDelete=false
    //required because this is spawned on server during netplay.
    RemoteRole=ROLE_DumbProxy
    //make sure initial rotation is replicated
    bNetInitialRotation=true
    LifeSpan = 1.5
}
