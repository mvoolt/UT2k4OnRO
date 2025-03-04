class ROBloodSpurt extends Emitter;

var class<ProjectedDecal> SplatterClass;
var class<ProjectedDecal> DripClass;

// Used for precaching splat textures
var texture Splats[9];

var	float	DripInterval;

simulated function Timer()
{
	local float TimeLeft;

    TimeLeft = LifeSpan/Default.LifeSpan;

   	Emitters[0].ParticlesPerSecond = Emitters[0].InitialParticlesPerSecond * TimeLeft;

	if ( Level.NetMode != NM_DedicatedServer )
		Drip();

	DripInterval += DripInterval * 0.1;

	SetTimer(DripInterval,false);

	//log("Timeleft = "$TimeLeft$" ParticlesPerSecond = "$Emitters[0].ParticlesPerSecond);
}

simulated function PostNetBeginPlay()
{
	SetTimer(DripInterval,false);
	if ( Level.NetMode != NM_DedicatedServer )
		GroundSplat();
	Super.PostNetBeginPlay();
}

simulated function GroundSplat()
{
	local vector WallHit, WallNormal;
	local Actor WallActor;

	if ( FRand() > 0.8 )
		return;
	WallActor = Trace(WallHit, WallNormal, Location + vect(0,0,-200), Location, false);
	if ( WallActor != None )
		spawn(SplatterClass,,,WallHit + 20 * (WallNormal + VRand()), rotator(-WallNormal));
}

simulated function Drip()
{
	local vector WallHit, WallNormal;
	local Actor WallActor;

	if ( FRand() > 0.8 )
		return;
	WallActor = Trace(WallHit, WallNormal, Location + vect(0,0,-200), Location, false);
	if ( WallActor != None )
		spawn(DripClass,,,WallHit + 20 * (WallNormal + VRand()), rotator(-WallNormal));
}

static function PrecacheContent(LevelInfo Level)
{
	local int i;

	for ( i=0; i<9; i++ )
		Level.AddPrecacheMaterial(Default.splats[i]);
}


defaultproperties
{
	SplatterClass=class'ROBloodSplatter'
	DripClass=class'ROSmallBloodDrops'
    LifeSpan=7//3.5
    DripInterval=0.75

    DrawScale=1.000000
    ScaleGlow=1.000000
    bUnlit=false
    bNetTemporary=true
    RemoteRole=ROLE_None
	//AutoDestroy=True
    Style=STY_Alpha
    bDirectional=True
    bNoDelete=false

	splats(0)=Texture'Effects_Tex.Splatter_001'
	splats(1)=Texture'Effects_Tex.Splatter_002'
	splats(2)=Texture'Effects_Tex.Splatter_003'
	splats(3)=Texture'Effects_Tex.Splatter_004'
	splats(4)=Texture'Effects_Tex.Splatter_005'
	splats(5)=Texture'Effects_Tex.Splatter_006'
	splats(6)=Texture'Effects_Tex.Drip_001'
	splats(7)=Texture'Effects_Tex.Drip_002'
	splats(8)=Texture'Effects_Tex.Drip_003'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        FadeIn=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        UseVelocityScale=True
        Acceleration=(Z=-100.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=30
        Name="SpriteEmitter1"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=-0.075000,Max=0.075000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=0.370000,RelativeSize=2.200000)
        SizeScale(3)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=0.250000,Max=0.750000))
        ParticlesPerSecond=10.000000
        InitialParticlesPerSecond=10.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'Effects_Tex.GoreEmitters.BloodCircle'
        LifetimeRange=(Min=1.000000,Max=2.000000)
        StartVelocityRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.500000,Max=0.500000))
        VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
        VelocityScale(1)=(RelativeTime=0.500000,RelativeVelocity=(X=0.200000,Y=1.000000,Z=1.000000))
        VelocityScale(2)=(RelativeTime=1.000000,RelativeVelocity=(Y=0.400000,Z=0.400000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'



}
