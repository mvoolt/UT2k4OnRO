//=====================================================
// ROKrasnyi_glass2_Emitter
// designed by ?
// coded by emh
//
// Copyright (C) 2004 John Gibson
//
// class to make breaking glass effects
//=====================================================

class ROKrasnyi_glass2_Emitter extends Emitter;

defaultproperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter109
        UseDirectionAs=PTDU_UpAndNormal
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
        DampingFactorRange=(X=(Min=0.800000,Max=0.900000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.200000,Max=0.400000))
        MaxCollisions=(Min=3.000000,Max=5.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.750000
        MaxParticles=200
        Name="SpriteEmitter44"
        StartLocationRange=(Y=(Min=-48.000000,Max=48.000000),Z=(Min=-32.000000,Max=32.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.500000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=1.000000,Max=10.000000))
        InitialParticlesPerSecond=50000.000000
        Texture=Texture'SpecialEffects.Glass.brokeglass_pieces_texture'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.500000,Max=3.000000)
        StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-100.000000,Max=100.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter109'

    AutoDestroy=True
    SurfaceType=EST_Glass
    bDirectional=True

    bNoDelete=false
    RemoteRole=ROLE_SimulatedProxy
    bNetTemporary=true
    LifeSpan=5
}

