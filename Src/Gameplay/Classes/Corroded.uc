class Corroded extends DamageType
	abstract;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	return Default.PawnDamageEffect;
}

defaultproperties
{
    DeathString="%o was dissolved by %k's."
    FemaleSuicide="%o dissolved in slime."
    MaleSuicide="%o dissolved in slime."

    FlashFog=(X=450,Y=700,Z=230)

    bLocationalHit=false
}
