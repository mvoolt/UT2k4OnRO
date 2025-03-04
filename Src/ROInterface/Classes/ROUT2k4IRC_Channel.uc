//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROUT2k4IRC_Channel extends UT2k4IRC_Channel;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.Initcomponent(MyController, MyOwner);

    class'ROInterfaceUtil'.static.SetROStyle(MyController, Controls);
}

DefaultProperties
{
     IRCTextColor=(B=160,G=160,R=160)
     IRCNickColor=(B=150,G=150,R=255)
     IRCActionColor=(G=200,R=230)
     IRCInfoColor=(B=130,G=130,R=160)
     IRCLinkColor=(B=150,G=150,R=255)
}
