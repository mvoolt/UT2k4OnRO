class Vignette extends Actor
    abstract
    transient
    native
;

var() string MapName;
var() class<GameInfo> GameClass;
var() bool bVACSecured;

simulated event Init();
simulated event DrawVignette( Canvas C, float Progress );

defaultproperties
{
	DrawType=DT_None
	Physics=PHYS_None
    RemoteRole=ROLE_None
	bUnlit=True
	bNetTemporary=true
	bGameRelevant=true
	CollisionRadius=+0.00000
	CollisionHeight=+0.00000
	bVACSecured=false
}
