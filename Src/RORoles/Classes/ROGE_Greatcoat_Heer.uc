class ROGE_Greatcoat_Heer extends ROGE_Heer_Units
	abstract;

defaultproperties
{
	Models(0)="G_HeerGreatcoat1"
	Models(1)="G_HeerGreatcoat2"
	Models(2)="G_HeerGreatcoat3"
	Models(3)="G_HeerGreatcoat4"
	Models(4)="G_HeerGreatcoat5"
	Models(5)="G_HeerGreatcoat6"

	RolePawnClass="RORoles.GEGreatCoatPawn"

	SleeveTexture=Texture'Weapons1st_tex.GermanCoatSleeves'
	DetachedArmClass=class'SeveredArmGerGreat'
	DetachedLegClass=class'SeveredLegGerGreat'
}
