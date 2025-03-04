//==============================================================================
// ATCannonDamagedEffect
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// Damaged gun effect for AT-Guns
//==============================================================================
class ATCannonDamagedEffect extends VehicleDamagedEffect;


simulated function PostBeginPlay()
{
	local ATGun G;

	Super.PostBeginPlay();

	G = ATGun(Owner);
	if (G != None)
	{
		SetEffectScale(G.DamagedEffectScale);
		UpdateDamagedEffect(false, 0, true, false);    //turn on medium smoke
	}
}

defaultproperties
{
	// Damaged Light Grey smoke
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(X=10.000000,Z=10.000000)
        ColorScale(0)=(Color=(B=128,G=128,R=128,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=192,G=192,R=192,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
        FadeOutStartTime=0.500000
        FadeInEndTime=0.250000
        MaxParticles=100
        Name="SpriteEmitter46"
        RotationOffset=(Yaw=1274,Roll=13107)
        SpinCCWorCW=(Y=1.000000,Z=1.000000)
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Max=0.100000),Z=(Min=1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-0.250000,Max=0.250000),Y=(Min=8000.000000,Max=10000.000000),Z=(Min=4500.000000,Max=6000.000000))
        SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
        StartSizeRange=(X=(Min=6.000000,Max=12.000000),Y=(Min=6.000000,Max=12.000000),Z=(Min=6.000000,Max=12.000000))  //(X=(Min=25.000000,Max=50.000000),Y=(Min=25.000000,Max=50.000000),Z=(Min=25.000000,Max=50.000000))
        ParticlesPerSecond=3.000000
        InitialParticlesPerSecond=3.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'Effects_Tex.explosions.DSmoke_2'
        LifetimeRange=(Min=6.000000,Max=6.000000)
        StartVelocityRange=(Z=(Min=50.000000,Max=100.000000))
        VelocityLossRange=(X=(Max=0.025000),Y=(Max=0.025000),Z=(Max=0.025000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    // There has to be a better way to negate the effect of the emitter than using "none".
    // Since UpdateDamagedEffect is called from Native code I have to extend from the parent.
    // It's a quandery....
	// Damaged fire
    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        UseVelocityScale=True
        Acceleration=(Z=50.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255))
        ColorScale(1)=(RelativeTime=0.250000,Color=(B=100,G=177,R=230,A=255))
        ColorScale(2)=(RelativeTime=0.750000,Color=(B=5,R=230,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.598000
        Name="SpriteEmitter47"
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
        StartSizeRange=(X=(Min=50.000000,Max=70.000000))
        ParticlesPerSecond=5.000000
        InitialParticlesPerSecond=5.000000
        DrawStyle=PTDS_Brighten
        Texture=none //Texture'Effects_Tex.explosions.fire_16frame'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        LifetimeRange=(Min=1.000000,Max=1.150000)
        VelocityScale(0)=(RelativeTime=0.100000,RelativeVelocity=(X=0.100000,Y=0.100000,Z=0.100000))
        VelocityScale(1)=(RelativeTime=0.500000,RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
        VelocityScale(2)=(RelativeTime=1.000000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

	// Really damaged dark smoke
    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(X=10.000000,Z=10.000000)
        ColorScale(0)=(Color=(A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
        FadeOutStartTime=3.180000
        FadeInEndTime=0.420000
        MaxParticles=100
        Name="SpriteEmitter0"
        StartLocationOffset=(Z=30.000000)
        RotationOffset=(Yaw=1092,Roll=13107)
        SpinCCWorCW=(Y=1.000000,Z=1.000000)
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Max=0.100000),Z=(Min=1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-0.500000,Max=0.500000),Y=(Min=16000.000000,Max=20000.000000),Z=(Min=9000.000000,Max=12000.000000))
        SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
        StartSizeRange=(X=(Min=25.000000,Max=50.000000),Y=(Min=25.000000,Max=50.000000),Z=(Min=25.000000,Max=50.000000))
        ParticlesPerSecond=4.000000
        InitialParticlesPerSecond=4.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=none //Texture'Effects_Tex.explosions.DSmoke_1'
        LifetimeRange=(Min=8.000000,Max=8.000000)
        StartVelocityRange=(Z=(Min=50.000000,Max=100.000000))
        VelocityLossRange=(X=(Max=0.050000),Y=(Max=0.050000),Z=(Max=0.050000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'

}
