//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROOstSkin extends WebSkin;

function Init(UTServerAdmin WebAdmin)
{
	WebAdmin.SkinPath = "";
	WebAdmin.SiteBG = DefaultBGColor;
	WebAdmin.SiteCSSFile = SkinCSS;
}

DefaultProperties
{
	DisplayName="Standard RO:Ost"
}
