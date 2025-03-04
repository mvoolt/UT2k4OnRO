//=============================================================================
// ROGermanYellowOrangeTracer
//=============================================================================
// Green tracer for the Russian MG's
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John Ramm-Jaeger" Gibson
//=============================================================================

class RORussianGreenTracer extends Emitter;

defaultproperties
{
	Begin Object Class=TrailEmitter Name=TrailEmitter0
        TrailShadeType=PTTST_PointLife
        TrailLocation=PTTL_FollowEmitter
        MaxPointsPerTrail=150
        DistanceThreshold=80.000000
        UseCrossedSheets=True
        PointLifeTime=0.2//0.800000
        UseColorScale=True
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(G=255,R=108))
        ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=108))
        Opacity=0.65//0.500000
        MaxParticles=1
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=2.000000,Max=5.000000))
        InitialParticlesPerSecond=2000.000000
		Texture=texture'Effects_tex.Weapons.TrailBlur'
        SecondsBeforeInactive=0.000000
    	LifetimeRange=(Min=10.000000,Max=10.000000)
    End Object
    Emitters(0)=TrailEmitter'TrailEmitter0'

	AutoDestroy=True
    Physics=PHYS_Trailer
    bNoDelete=False
    bHardAttach=True
}


