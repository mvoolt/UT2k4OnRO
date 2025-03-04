//=============================================================================
// Wall projecting blood hit
//=============================================================================
class ProjectileBloodSplat extends Actor;

var Class<Actor>    BloodDecalClass;
var texture Splats[6];

simulated function PostNetBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer )
		WallSplat();
	else
		LifeSpan = 0.2;
}

simulated function WallSplat()
{
	local vector WallHit, WallNormal;
	local Actor WallActor;

	if ( Level.bDropDetail || (BloodDecalClass == None) )
		return;

	WallActor = Trace(WallHit, WallNormal, Location + 350 * vector(Rotation), Location, false);
	if ( WallActor != None )
		spawn(BloodDecalClass,,,WallHit + 20 * (WallNormal + VRand()), rotator(-WallNormal));
}

static function PrecacheContent(LevelInfo Level)
{
	local int i;

	if ( Default.BloodDecalClass != None )
	{
		for ( i=0; i<6; i++ )
			Level.AddPrecacheMaterial(Default.splats[i]);
	}
}

defaultproperties
{
	splats(0)=Texture'Effects_Tex.Splatter_001'
	splats(1)=Texture'Effects_Tex.Splatter_002'
	splats(2)=Texture'Effects_Tex.Splatter_003'
	splats(3)=Texture'Effects_Tex.Splatter_004'
	splats(4)=Texture'Effects_Tex.Splatter_005'
	splats(5)=Texture'Effects_Tex.Splatter_006'

    BloodDecalClass=class'ROBloodSplatter'
    bDirectional=true

    DrawScale=1.000000
    ScaleGlow=1.000000
    CollisionRadius=0.000000
    CollisionHeight=0.000000
    LifeSpan=3.5

    bOnlyRelevantToOwner=true
    RemoteRole=ROLE_SimulatedProxy
	bNetTemporary=true

	// inherited vars
    DrawType=DT_Particle
    Style=STY_Normal
	Physics=PHYS_None
	bUnlit=true
	bGameRelevant=true

    bCollideActors=false
    bAcceptsProjectors=false

    bActorShadows=false

    LightEffect=LE_QuadraticNonIncidence
    bNetInitialRotation=true

	bNotOnDedServer=true
}


