//===================================================================
// PanzerFaustRocket
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// The panzerfaust rocket projectile
//===================================================================

class PanzerFaustRocket extends RORocketProj;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
    speed=8000.0
    MaxSpeed=8000.0
    Damage=100.0
    DamageRadius=220.0
    MomentumTransfer=50000
    MyDamageType=class'PanzerFaustDamType'
    ShellImpactDamage=class'PanzerFaustImpactDamType'
    ExplosionDecal=class'RocketMarkDirt'
    ExplosionDecalSnow=class'RocketMarkSnow'
    RemoteRole=ROLE_SimulatedProxy
    LifeSpan=8.0
    bNetTemporary=false

    DestroyTime=0.2

	ExplodeSound(0)=sound'Inf_Weapons.faust_explode01'
	ExplodeSound(1)=sound'Inf_Weapons.faust_explode02'
	ExplodeSound(2)=sound'Inf_Weapons.faust_explode03'

    DrawType=DT_StaticMesh
    StaticMesh=StaticMesh'WeaponPickupSM.Ammo.Warhead3rd'
    DrawScale=1.0
    AmbientGlow=96
    bUnlit=True
    LightType=LT_Steady
    LightEffect=LE_QuadraticNonIncidence
    LightBrightness=255
    LightHue=28
    LightRadius=5
    bDynamicLight=true
    bBounce=false
    bFixedRotationDir=True
    RotationRate=(Roll=50000)
    DesiredRotation=(Roll=30000)
    ForceType=FT_Constant
    ForceScale=5.0
    ForceRadius=100.0
    bCollideWorld=true
    FluidSurfaceShootStrengthMod=10.0

    CullDistance=+7500.0

	PenetrationTable(0)=26
	PenetrationTable(1)=26
	PenetrationTable(2)=0
	PenetrationTable(3)=0
	PenetrationTable(4)=0
	PenetrationTable(5)=0
	PenetrationTable(6)=0
	PenetrationTable(7)=0
	PenetrationTable(8)=0
	PenetrationTable(9)=0
	PenetrationTable(10)=0
}
