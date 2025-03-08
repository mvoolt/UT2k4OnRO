//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ONSShockTankShieldEffectRed extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2k4XP.utx"

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter18
         StaticMesh=StaticMesh'AW-2k4XP.Weapons.ShockShield2'
         UseParticleColor=True
         UseColorScale=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=64,G=64,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         InitialParticlesPerSecond=5000.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(0)=MeshEmitter'OnslaughtBP.ONSShockTankShieldEffectRed.MeshEmitter18'

     bNoDelete=False
     AmbientGlow=254
     bHardAttach=True
}
