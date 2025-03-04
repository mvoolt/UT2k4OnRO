class ROTankShellExplosionDamage extends ROWeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
	// MergeTODO: Evaluate this, we really only need hit effects for the impact not the explosion right?

/*    HitEffects[0] = class'HitSmoke';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'HitFlameBig';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'HitFlame'; */
}

static function ScoreKill(Controller Killer, Controller Killed)
{
	if (Killed != None && Killer != Killed && Vehicle(Killed.Pawn) != None && Vehicle(Killed.Pawn).bCanFly)
	{
		//Maybe add to game stats?
		if (PlayerController(Killer) != None)
		//	PlayerController(Killer).ReceiveLocalizedMessage(class'ONSVehicleKillMessage', 5);
	}
}

defaultproperties
{
	DeathString="%o was killed by %k's tank shell shrapnel."
	MaleSuicide="%o fired his shell prematurely."
	FemaleSuicide="%o fired her shell prematurely."

	HUDIcon=Texture'InterfaceArt_tex.deathicons.Strike'

	GibModifier=4.0

//	WeaponClass=class'ROVehicleWeapon'
	bDetonatesGoop=true
	VehicleMomentumScaling=1.3
	bThrowRagdoll=true
	GibPerterbation=0.15
	bFlaming=true
	bDelayedDamage=true
	//VehicleClass=class'ROTreadCraft'
	bLocationalHit=false
	KDamageImpulse=5000
    KDeathVel=250.000000
	KDeathUpKick=50
	bExtraMomentumZ=true
	bArmorStops=false

	TankDamageModifier=0.05
	APCDamageModifier=0.25
	VehicleDamageModifier=0.5
	TreadDamageModifier=0.25

	DeathOverlayMaterial=Material'Effects_Tex.PlayerDeathOverlay'
	DeathOverlayTime=999
}

