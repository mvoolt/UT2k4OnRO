class MuzzleFlash1stNagant_simple extends ROMuzzleFlash1st;

simulated function Trigger(Actor Other, Pawn EventInstigator)
{
	Emitters[0].SpawnParticle(2);
}

defaultproperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        Opacity=0.5
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        UseSubdivisionScale=True
        CoordinateSystem=PTCS_Relative
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.500000,RelativeSize=3.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.000000)
        StartSizeRange=(X=(Min=8.000000,Max=12.000000))
        DrawStyle=PTDS_Brighten
        Texture=Texture'Effects_Tex.Weapons.Karmuzzle_2frame'
        TextureUSubdivisions=2
        TextureVSubdivisions=1
        SubdivisionScale(0)=0.500000
        LifetimeRange=(Min=0.115000,Max=0.115000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

}
