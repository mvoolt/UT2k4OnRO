// Russian RKKA Fall Uniforms

class ROSU_Winter_RKKA extends ROSU_RKKA_Units
	abstract;

defaultproperties
{
	Models(0)="R_RKKAWinter1"
	Models(1)="R_RKKAWinter2"
	Models(2)="R_RKKAWinter3"
	Models(3)="R_RKKAWinter4"
	Models(4)="R_RKKAWinter5"

    RolePawnClass="RORoles.RUWinterPawn"

	SleeveTexture=Texture'Weapons1st_tex.RussianSnow_Sleeves'
	DetachedArmClass=class'SeveredArmSovSnow'
	DetachedLegClass=class'SeveredLegSovSnow'
}
