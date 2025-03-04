class HECannonShell extends ROTankCannonShell;

var		float		HEPenetrationNumber;
var		sound		ExplosionSound[4];          // sound of the round exploding
var		bool		bPenetrated;				// This shell penetrated what it hit

simulated function int GetPenetrationNumber(vector Distance)
{
	return HEPenetrationNumber;
}

simulated function ProcessTouch(Actor Other, Vector HitLocation)
{
	local ROVehicle HitVehicle;
	local ROVehicleWeapon HitVehicleWeapon;
	local bool bHitVehicleDriver;

	HitVehicleWeapon = ROVehicleWeapon(Other);
	HitVehicle = ROVehicle(Other.Base);

    if( Other == none || (SavedTouchActor != none && SavedTouchActor == Other) || Other.bDeleteMe ||
		ROBulletWhipAttachment(Other) != none )
    {
    	return;
    }

    SavedTouchActor = Other;

	if ( (Other != instigator) && (Other.Base != instigator) && (!Other.IsA('Projectile') || Other.bProjTarget) )
	{
	    if( HitVehicleWeapon != none && HitVehicle != none )
	    {
		    SavedHitActor = Pawn(Other.Base);

			if ( HitVehicleWeapon.HitDriverArea(HitLocation, Velocity) )
			{
				if( HitVehicleWeapon.HitDriver(HitLocation, Velocity) )
				{
					bHitVehicleDriver = true;
				}
				else
				{
					return;
				}
			}

		    if( HitVehicle.IsA('ROTreadCraft') && !ROTreadCraft(HitVehicle).ShouldPenetrate(HitLocation, Normal(Velocity), GetPenetrationNumber(LaunchLocation-HitLocation)))
		    {
				NonPenetrateExplode(HitLocation + ExploWallOut * Normal(-Velocity), Normal(-Velocity));

				// Don't update the position any more and don't move the projectile any more.
				bUpdateSimulatedPosition=false;
				SetPhysics(PHYS_None);
				SetDrawType(DT_None);

				HurtWall = None;
				if ( Role == ROLE_Authority )
				{
					MakeNoise(1.0);
				}
		        return;
		    }

            // Don't update the position any more and don't move the projectile any more.
			bUpdateSimulatedPosition=false;
			SetPhysics(PHYS_None);
			SetDrawType(DT_None);

			if ( Role == ROLE_Authority )
			{
				if ( !Other.Base.bStatic && !Other.Base.bWorldGeometry )
				{
					if ( Instigator == None || Instigator.Controller == None )
					{
						Other.Base.SetDelayedDamageInstigatorController( InstigatorController );
						if( bHitVehicleDriver )
						{
						    Other.SetDelayedDamageInstigatorController( InstigatorController );
						}
					}

					if ( savedhitactor != none )
					{
						Other.Base.TakeDamage(ImpactDamage, instigator, Location, MomentumTransfer * Normal(Velocity), ShellImpactDamage);
					}

					if( bHitVehicleDriver )
					{
						Other.TakeDamage(ImpactDamage, instigator, Location, MomentumTransfer * Normal(Velocity), ShellImpactDamage);
					}

					if (DamageRadius > 0 && Vehicle(Other.Base) != None && Vehicle(Other.Base).Health > 0)
						Vehicle(Other.Base).DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, HitLocation);
					HurtWall = Other.Base;
				}
				MakeNoise(1.0);
			}
			Explode(HitLocation + ExploWallOut * Normal(-Velocity), Normal(-Velocity));
			HurtWall = None;

            return;
	    }
	    else
	    {
			if ( (Pawn(Other) != none || RODestroyableStaticMesh(Other) != none) && Role==Role_Authority )
			{
		        	Other.TakeDamage(ImpactDamage, instigator, Location, MomentumTransfer * Normal(Velocity), ShellImpactDamage);
			}
	        Explode(HitLocation,Vect(0,0,1));
	    }
	}
}

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	local PlayerController PC;

    if ( Wall.Base != none && Wall.Base == instigator )
     	return;

	if (bDebugBallistics)
	{
		log("BulletImpactVel = "$VSize(Velocity) / ScaleFactor$" BulletDist = "$(VSize(Location - OrigLoc) / 60.352)$" BulletDrop = "$(((TraceHitLoc.Z - Location.Z) / ScaleFactor) * 12));

		if (Level.NetMode != NM_DedicatedServer)
			Spawn(class 'RODebugTracer',self,,Location,Rotation);
	}

    if( Wall.IsA('ROTreadCraft') && !ROTreadCraft(Wall).ShouldPenetrate(Location, Normal(Velocity), GetPenetrationNumber(LaunchLocation-Location)))
    {
		if ( Role == ROLE_Authority )
		{
			MakeNoise(1.0);
		}
		NonPenetrateExplode(Location + ExploWallOut * HitNormal, HitNormal);

		// Don't update the position any more and don't move the projectile any more.
		bUpdateSimulatedPosition=false;
		SetPhysics(PHYS_None);
		SetDrawType(DT_None);

		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer)  )
		{
			if ( ExplosionDecal.Default.CullDistance != 0 )
			{
				PC = Level.GetLocalPlayerController();
				if ( !PC.BeyondViewDistance(Location, ExplosionDecal.Default.CullDistance) )
					Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
				else if ( (Instigator != None) && (PC == Instigator.Controller) && !PC.BeyondViewDistance(Location, 2*ExplosionDecal.Default.CullDistance) )
					Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
			}
			else
				Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
		}
		HurtWall = None;
        return;
    }

    if ((SavedHitActor == Wall) || (Wall.bDeleteMe) )
     	return;

    // Don't update the position any more and don't move the projectile any more.
	bUpdateSimulatedPosition=false;
	SetPhysics(PHYS_None);
	SetDrawType(DT_None);

    SavedHitActor = Pawn(Wall);


	if ( Role == ROLE_Authority )
	{
		if ((!Wall.bStatic && !Wall.bWorldGeometry) || RODestroyableStaticMesh(Wall) != none || Mover(Wall) != none)
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );

			if ( savedhitactor != none || RODestroyableStaticMesh(Wall) != none || Mover(Wall) != none)
			{
				Wall.TakeDamage(ImpactDamage, instigator, Location, MomentumTransfer * Normal(Velocity), ShellImpactDamage);
			}

			if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
				Vehicle(Wall).DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);
			HurtWall = Wall;
		}
		MakeNoise(1.0);
	}
	Explode(Location + ExploWallOut * HitNormal, HitNormal);
	// We do this in the explode logic
	if ( !bCollided && (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer)  )
	{
		if ( ExplosionDecal.Default.CullDistance != 0 )
		{
			PC = Level.GetLocalPlayerController();
			if ( !PC.BeyondViewDistance(Location, ExplosionDecal.Default.CullDistance) )
				Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
			else if ( (Instigator != None) && (PC == Instigator.Controller) && !PC.BeyondViewDistance(Location, 2*ExplosionDecal.Default.CullDistance) )
				Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
		}
		else
			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
	}
	HurtWall = None;
	//log(" Shell flew "$(VSize(LaunchLocation - Location)/52.48)$" meters total");
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local vector TraceHitLocation, TraceHitNormal;
	local Material HitMaterial;
	local ESurfaceTypes ST;
	local bool bShowDecal, bSnowDecal;

	bPenetrated = true;

    if ( SavedHitActor == none )
    {
       Trace(TraceHitLocation, TraceHitNormal, Location + Vector(Rotation) * 16, Location, false,, HitMaterial);
    }

	if( !bDidExplosionFX )
	{
	    if (HitMaterial == None)
			ST = EST_Default;
		else
			ST = ESurfaceTypes(HitMaterial.SurfaceType);

	    if ( SavedHitActor != none )
	    {
	         PlaySound(VehicleHitSound,,5.5*TransientSoundVolume);
	        if ( EffectIsRelevant(Location,false) )
	        {
	        	Spawn(ShellHitVehicleEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
	    		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
	    			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
	        }
	    }
	    else
	    {
	    	PlaySound(DirtHitSound,,5.5*TransientSoundVolume);
	        if ( EffectIsRelevant(Location,false) )
	        {
				Switch(ST)
				{
					case EST_Snow:
					case EST_Ice:
						Spawn(ShellHitSnowEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
						bShowDecal = true;
						bSnowDecal = true;
						break;
					case EST_Rock:
					case EST_Gravel:
					case EST_Concrete:
						Spawn(ShellHitRockEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
						bShowDecal = true;
						break;
					case EST_Wood:
					case EST_HollowWood:
						Spawn(ShellHitWoodEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
						bShowDecal = true;
						break;
					case EST_Water:
						Spawn(ShellHitWaterEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
						PlaySound(WaterHitSound,,5.5*TransientSoundVolume);
						bShowDecal = false;
						break;
					default:
						Spawn(ShellHitDirtEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
						bShowDecal = true;
						break;
				}

	    		if ( bShowDecal && Level.NetMode != NM_DedicatedServer )
	    		{
	    			if( bSnowDecal && ExplosionDecalSnow != None)
					{
	    				Spawn(ExplosionDecalSnow,self,,Location, rotator(-HitNormal));
	    			}
	    			else if( ExplosionDecal != None)
					{
	    				Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
	    			}
	    		}
	        }
	    }
	    PlaySound(ExplosionSound[Rand(4)],,5.5*TransientSoundVolume);
	}

	if ( Corona != None )
		Corona.Destroy();

    super(ROAntiVehicleProjectile).Explode(HitLocation, HitNormal);
}

// HE Shell explosion for when it hit a tank but didn't penetrate
simulated function NonPenetrateExplode(vector HitLocation, vector HitNormal)
{
	if( bCollided )
		return;

	if( !bDidExplosionFX )
	{
 	    PlaySound(VehicleDeflectSound,,5.5*TransientSoundVolume);
	    if ( EffectIsRelevant(Location,false) )
	    {
	    	Spawn(ShellDeflectEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
	    }

	    PlaySound(ExplosionSound[Rand(4)],,5.5*TransientSoundVolume);

	    bDidExplosionFX=true;
    }

	if ( Corona != None )
		Corona.Destroy();

	// Save the hit info for when the shell is destroyed
	SavedHitLocation = HitLocation;
	SavedHitNormal = HitNormal;
	AmbientSound=none;

	BlowUp(HitLocation);

	// Give the bullet a little time to play the hit effect client side before destroying the bullet
	if (Level.NetMode == NM_DedicatedServer)
	{
		bCollided = true;
		SetCollision(False,False);
	}
	else
	{
		Destroy();
	}
}

simulated function Destroyed()
{
	local vector TraceHitLocation, TraceHitNormal;
	local Material HitMaterial;
	local ESurfaceTypes ST;
	local bool bShowDecal, bSnowDecal;
	local ROPawn Victims;
	local float damageScale, dist;
	local vector dir, Start;

	// Move karma ragdolls around when this explodes
	if ( Level.NetMode != NM_DedicatedServer )
	{
		Start = Location + 32 * vect(0,0,1);

		foreach VisibleCollidingActors( class 'ROPawn', Victims, DamageRadius, Start )
		{
			// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
			if( Victims != self)
			{
				dir = Victims.Location - Start;
				dist = FMax(1,VSize(dir));
				dir = dir/dist;
				damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);

				if(Victims.Physics == PHYS_KarmaRagDoll )
				{
					Victims.DeadExplosionKarma(MyDamageType, damageScale * MomentumTransfer * dir, damageScale);
				}
			}
		}
	}

	if( !bDidExplosionFX )
	{
		if( bPenetrated )
		{
			if( bDebugBallistics && ROTankCannonPawn(Instigator) != none && ROTankCannon(ROTankCannonPawn(Instigator).Gun) != none)
			{
				ROTankCannon(ROTankCannonPawn(Instigator).Gun).HandleShellDebug(SavedHitLocation);
			}

		    if ( SavedHitActor == none )
		    {
		       Trace(TraceHitLocation, TraceHitNormal, Location + Vector(Rotation) * 16, Location, false,, HitMaterial);
		    }

		    if (HitMaterial == None)
				ST = EST_Default;
			else
				ST = ESurfaceTypes(HitMaterial.SurfaceType);

		    if ( SavedHitActor != none )
		    {
		         PlaySound(VehicleHitSound,,5.5*TransientSoundVolume);
		        if ( EffectIsRelevant(SavedHitLocation,false) )
		        {
		        	Spawn(ShellHitVehicleEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
		    		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
		    			Spawn(ExplosionDecal,self,,SavedHitLocation, rotator(-SavedHitNormal));
		        }
		    }
		    else
		    {
		    	PlaySound(DirtHitSound,,5.5*TransientSoundVolume);
		        if ( EffectIsRelevant(SavedHitLocation,false) )
		        {
					Switch(ST)
					{
						case EST_Snow:
						case EST_Ice:
							Spawn(ShellHitSnowEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							bShowDecal = true;
							bSnowDecal = true;
							break;
						case EST_Rock:
						case EST_Gravel:
						case EST_Concrete:
							Spawn(ShellHitRockEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							bShowDecal = true;
							break;
						case EST_Wood:
						case EST_HollowWood:
							Spawn(ShellHitWoodEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							bShowDecal = true;
							break;
						case EST_Water:
							Spawn(ShellHitWaterEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							PlaySound(WaterHitSound,,5.5*TransientSoundVolume);
							bShowDecal = false;
							break;
						default:
							Spawn(ShellHitDirtEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							bShowDecal = true;
							break;
					}

		    		if ( bShowDecal && Level.NetMode != NM_DedicatedServer )
		    		{
		    			if( bSnowDecal && ExplosionDecalSnow != None)
						{
		    				Spawn(ExplosionDecalSnow,self,,SavedHitLocation, rotator(-SavedHitNormal));
		    			}
		    			else if( ExplosionDecal != None)
						{
		    				Spawn(ExplosionDecal,self,,SavedHitLocation, rotator(-SavedHitNormal));
		    			}
		    		}
		        }
		    }
		    PlaySound(ExplosionSound[Rand(4)],,5.5*TransientSoundVolume);
	    }
	    else
	    {
		    PlaySound(VehicleDeflectSound,,5.5*TransientSoundVolume);
		    if ( EffectIsRelevant(Location,false) )
		    {
		    	Spawn(ShellDeflectEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
		    }

		    PlaySound(ExplosionSound[Rand(4)],,5.5*TransientSoundVolume);
	    }
    }

	if ( Corona != None )
		Corona.Destroy();

	// Don't want to spawn the effect on the super
	super(ROAntiVehicleProjectile).Destroyed();
}



//-----------------------------------------------------------------------------
// PhysicsVolumeChange - Blow up HE rounds when they hit water
//-----------------------------------------------------------------------------
simulated function PhysicsVolumeChange( PhysicsVolume Volume )
{
	if (Volume.bWaterVolume)
	{
		Explode(Location, vector(Rotation * -1));
	}
}

defaultproperties
{
    Speed=500//22000//15000.0
    MaxSpeed=22000//15000.0
    MomentumTransfer=10000//125000
    Damage=150.0
    DamageRadius=300.0//660.0
    AmbientSound=sound'Vehicle_Weapons.Misc.projectile_whistle01'//projectile_whistle
    SoundVolume=255
    SoundRadius=1000
    TransientSoundVolume=1.0
    TransientSoundRadius=1000
    bFullVolume=false
    MyDamageType=class'HECannonShellDamage'
	ExplosionDecal=class'ArtilleryMarkDirt'
	ExplosionDecalSnow=class'ArtilleryMarkSnow'
    RemoteRole=ROLE_SimulatedProxy
    LifeSpan=10.0
    DrawType=DT_StaticMesh
    // MergeTODO: Replace with a proper static mesh
    StaticMesh=StaticMesh'WeaponPickupSM.Ammo.Warhead3rd'//StaticMesh'WeaponStaticMesh.RocketProj'
    AmbientGlow=96
    bUnlit=True
    bBounce=false
    bFixedRotationDir=True
    RotationRate=(Roll=50000)
    DesiredRotation=(Roll=30000)
    ForceType=FT_Constant
    ForceScale=5.0
    ForceRadius=100.0
    bCollideWorld=true
    FluidSurfaceShootStrengthMod=10.0
    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=400

    Physics = PHYS_Projectile
    bUpdateSimulatedPosition=true//false

	ExplosionSound(0)=sound'ProjectileSounds.cannon_rounds.OUT_HE_explode01'
	ExplosionSound(1)=sound'ProjectileSounds.cannon_rounds.OUT_HE_explode02'
	ExplosionSound(2)=sound'ProjectileSounds.cannon_rounds.OUT_HE_explode03'
	ExplosionSound(3)=sound'ProjectileSounds.cannon_rounds.OUT_HE_explode04'
    VehicleHitSound=Sound'ProjectileSounds.cannon_rounds.AP_penetrate'
    VehicleDeflectSound=Sound'ProjectileSounds.cannon_rounds.HE_Deflect'

    DirtHitSound=Sound'ProjectileSounds.cannon_rounds.AP_Impact_Dirt'
    ShellHitVehicleEffectClass=class'ROEffects.TankHEHitPenetrate'
    ShellDeflectEffectClass=class'ROEffects.TankHEHitDeflect'
    ShellHitDirtEffectClass=class'ROEffects.TankHEHitDirtEffect'
    ShellHitSnowEffectClass=class'ROEffects.TankHEHitSnowEffect'
    ShellHitWoodEffectClass=class'ROEffects.TankHEHitWoodEffect'
    ShellHitRockEffectClass=class'ROEffects.TankHEHitRockEffect'
    ShellHitWaterEffectClass=class'ROEffects.TankHEHitWaterEffect'

	bUseCollisionStaticMesh=true
}
