// Russian RKKA Great coat Uniforms

class ROSU_Greatcoat_RKKA extends ROSU_RKKA_Units
	abstract;

defaultproperties
{
	Models(0)="R_RKKAGreatcoat1"
	Models(1)="R_RKKAGreatcoat2"
	Models(2)="R_RKKAGreatcoat3"
	Models(3)="R_RKKAGreatcoat4"
	Models(4)="R_RKKAGreatcoat5"
	Models(5)="R_RKKAGreatcoat6"

    RolePawnClass="RORoles.RUWinterPawn"

	SleeveTexture=Texture'Weapons1st_tex.RussianSnow_Sleeves'
	DetachedArmClass=class'SeveredArmSovSnow'
	DetachedLegClass=class'SeveredLegSovSnow'
}
