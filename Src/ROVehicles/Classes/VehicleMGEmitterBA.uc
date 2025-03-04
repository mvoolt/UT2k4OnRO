//-----------------------------------------------------------
//   VehicleMGEmitterBA - Ambient Emitter class for RO vehicle MGs
//	Muzzle flash and shell ejection
//-----------------------------------------------------------
class  VehicleMGEmitterBA extends WeaponAmbientEmitter;

simulated function SetEmitterStatus(bool bEnabled)
{
	Emitters[0].UseCollision = ( !Level.bDropDetail && (Level.DetailMode != DM_Low) && (VSize(Level.GetLocalPlayerController().ViewTarget.Location - Location) < 1600));
	if(bEnabled)
	{
		Emitters[0].ParticlesPerSecond = 14.0;
		Emitters[0].InitialParticlesPerSecond = 14.0;
		Emitters[0].AllParticlesDead = false;

		Emitters[1].ParticlesPerSecond = 30.0;
		Emitters[1].InitialParticlesPerSecond = 30.0;
		Emitters[1].AllParticlesDead = false;
	}
	else
	{
		Emitters[0].ParticlesPerSecond = 0.0;
		Emitters[0].InitialParticlesPerSecond = 0.0;

		Emitters[1].ParticlesPerSecond = 0.0;
		Emitters[1].InitialParticlesPerSecond = 0.0;
	}
}

DefaultProperties
{
    Begin Object Class=MeshEmitter Name=MeshEmitter0
        StaticMesh=StaticMesh'WeaponPickupSM.shells.S762_Rifle_MG'
        UseCollision=True
        RespawnDeadParticles=False
        SpawnOnlyInDirectionOfNormal=True
        SpinParticles=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-500.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        MaxParticles=30
        StartLocationOffset=(X=-40.000000,Y=3.000000,Z=0.000000)//(X=-25.000000,Y=-15.000000,Z=-10.000000)
        MeshNormal=(Z=0.000000)
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000),Y=(Min=0.100000,Max=1.000000),Z=(Min=0.100000,Max=1.000000))
        LifetimeRange=(Min=1.500000,Max=1.500000)
        StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=25.000000,Max=100.000000),Z=(Min=1.000000,Max=1.000000))
        StartVelocityRadialRange=(Min=-250.000000,Max=250.000000)
    End Object
    Emitters(0)=MeshEmitter'MeshEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
	FadeOut=False
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        Opacity=.45
        CoordinateSystem=PTCS_Relative
        Name="SpriteEmitter1"
        StartLocationOffset=(X=-8.000000)
        StartLocationShape=PTLS_Box
        UseRotationFrom=PTRS_Normal
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.500000,RelativeSize=2.500000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=4.000000,Max=5.000000))
	DrawStyle=PTDS_Brighten
        Texture=Texture'Effects_Tex.Weapons.STGmuzzleflash_4frame'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.100000,Max=0.100000)
        End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    DrawScale3D=(X=1.000000,Y=1.000000,Z=1.000000)
    bUnlit=False
    bNoDelete=False
    bHardAttach=True
	RemoteRole=ROLE_None
	Physics=PHYS_None
	bBlockActors=False
	CullDistance=4000.0
}
