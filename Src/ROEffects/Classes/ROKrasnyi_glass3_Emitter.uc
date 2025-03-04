//=====================================================
// ROKrasnyi_glass3_Emitter
// designed by ?
// coded by emh
//
// Copyright (C) 2004 John Gibson
//
// class to make breaking glass effects
//=====================================================

class ROKrasnyi_glass3_Emitter extends Emitter;

defaultproperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter120
        UseCollision=True
        UseMaxCollisions=True
        RespawnDeadParticles=False
        //Disabled=True
        Backup_Disabled=True
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-950.000000)
        DampingFactorRange=(X=(Min=0.800000,Max=0.900000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.100000,Max=0.200000))
        MaxCollisions=(Min=3.000000,Max=5.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.750000
        MaxParticles=75
        Name="SpriteEmitter120"
        StartLocationRange=(Y=(Min=-32.000000,Max=32.000000),Z=(Min=-48.000000,Max=48.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.500000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=1.000000,Max=10.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'SpecialEffects.Glass.brokeglass_pieces_texture'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=3.000000,Max=6.000000)
        StartVelocityRange=(X=(Min=-100.000000,Max=200.000000),Y=(Min=-100.000000,Max=100.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter120'

    AutoDestroy=True
    SurfaceType=EST_Glass
    bDirectional=True

    bNoDelete=false
    RemoteRole=ROLE_SimulatedProxy
    bNetTemporary=true
    LifeSpan=5
}

