//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROUT2k4Browser_MOTD extends UT2k4Browser_MOTD;

var String myMOTD;

var String getRequest;
var String getResponse;
var String newsIPAddr;
var int		myRetryCount;
var int		myRetryMax;

var ROBufferedTCPLink myLink;
var string LinkClassName;
var bool sendGet;
var bool pageWait;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.Initcomponent(MyController, MyOwner);

    class'ROInterfaceUtil'.static.SetROStyle(MyController, Controls);

    GetNewNews();
    lb_MOTD.MyScrollText.SetContent(myMOTD);
}

event Opened(GUIComponent Sender)
{
	l_Version.Caption = VersionString@PlayerOwner().Level.ROVersion;

	super(Ut2k4Browser_Page).Opened(Sender);
}

protected function ROBufferedTCPLink CreateNewLink()
{
	local class<ROBufferedTCPLink> NewLinkClass;
	local ROBufferedTCPLink NewLink;

	if ( PlayerOwner() == None )
		return None;

	if ( LinkClassName != "" )
	{
		NewLinkClass = class<ROBufferedTCPLink>(DynamicLoadObject( LinkClassName, class'Class'));
    }
    if ( NewLinkClass != None )
    {
        NewLink = PlayerOwner().Spawn( NewLinkClass );
    }

    NewLink.ResetBuffer();

    return NewLink;
}


function ReceivedMOTD( MasterServerClient.EMOTDResponse Command, string Data )
{
}

function GetNewNews()
{
    if(myLink == None)
    {
        myLink = CreateNewLink();
    }
    if(myLink != None)
    {
        myLink.ServerIpAddr.Port = 0;

        sendGet = true;
        myLink.Resolve(newsIPAddr);  // NOTE: This is a non-blocking operation

        SetTimer(ReReadyPause, true);
    }
    else
    {
        myMOTD = myMOTD$"|| myLink is None";
    }
}

event Timer()
{
    local string text;
    local string page;
    local string command;


    if(myLink != None)
    {
        if ( myLink.ServerIpAddr.Port != 0)
        {
            if(myLink.IsConnected())
            {
                if(sendGet)
                {
                     command = getRequest$myLink.CRLF$"Host: "$newsIPAddr$myLink.CRLF$myLink.CRLF;
                     myLink.SendCommand(command);
                     pageWait = true;
                     myLink.WaitForCount(1,20,1); // 20 sec timeout
                     sendGet = false;
                }
                else
                {
                    if(pageWait)
                    {
                        myMOTD = myMOTD$".";
                        lb_MOTD.MyScrollText.SetContent(myMOTD);
                    }
                }
            }
            else
            {
                if(sendGet)
                {
                    myMOTD = myMOTD$"|| Could not connect to news server";
                    lb_MOTD.MyScrollText.SetContent(myMOTD);
                }
            }
        }
        else
        {
        	if (myRetryCount++ > myRetryMax)
        	{
                myMOTD = myMOTD$"|| Retries Failed";
                KillTimer();
                lb_MOTD.MyScrollText.SetContent(myMOTD);
        	}
        }
        if(myLink.PeekChar() != 0)
        {
            pageWait = false;
            // data waiting
            page = "";
            while(myLink.ReadBufferedLine(text))
            {
                page = page$text;
            }
            NewsParse(page);
            myMOTD = "||"$page;
            lb_MOTD.MyScrollText.SetContent(myMOTD);
            myLink.DestroyLink();
            myLink = none;
            KillTimer();
        }
    }
    SetTimer(ReReadyPause, true);

}

function NewsParse(out string page)
{
    local string junk;
    local int i;

    junk = page;
    Caps(junk);
    i = InStr(junk, "<BODY>");
    if(i > -1)
    {
         // remove all header from string
         page = Right(page,len(page)-i-6);
    }
    junk = page;
    Caps(junk);
    i = InStr(junk, "</BODY>");
    if(i > -1)
    {
         // remove all footers from string
         page = Left(page,i);
    }
    page = Repl(page, "<br>","|", false);
}


DefaultProperties
{
     Begin Object Class=GUIScrollTextBox Name=MyMOTDText
         bNoTeletype=True
         CharDelay=0.050000
         EOLDelay=0.100000
         bVisibleWhenEmpty=True
         OnCreateComponent=MyMOTDText.InternalOnCreateComponent
         WinTop=0.002679
         WinHeight=0.833203
         RenderWeight=0.600000
         TabOrder=1
         bNeverFocus=True
     End Object
     lb_MOTD=GUIScrollTextBox'ROInterface.ROUT2k4Browser_MOTD.MyMOTDText'

     Begin Object Class=GUILabel Name=VersionNum
         TextAlign=TXTA_Right
         StyleName="TextLabel"
         WinTop=-0.043415
         WinLeft=0.743500
         WinWidth=0.252128
         WinHeight=0.040000
         RenderWeight=20.700001
     End Object
     l_Version=GUILabel'GUI2K4.UT2k4Browser_MOTD.VersionNum'

     VersionString="RO Version"
     PanelCaption="News from Tripwire Interactive"

     b_QuickConnect=None

//     myMOTD = "||No life was untouched by the Great War of the 20th century. Young men from lands across the globe were thrust into deadly battle against one another. For some, it was a mission of global domination. For others, it was in defense of their homeland. For all, it was a struggle that would define the course of modern civilization. ||Choose your allegiance and prepare for the most intense PC multiplayer combat experience. Red Orchestra puts you on the front lines of the Eastern conflict of World War II. Take up arms with your Soviet comrades, or fall in line with the German army and battle over the precious lands of the European theatre. ||Fight your way through crumbling cities, resonating with the deafening sounds of battle. Immerse yourself in breathtaking recreations of real-world inspired locales. Communicate strategies with your team ||| Checkout the latest news at:||   http://www.redorchestramod.com/"
     myMOTD = "||Connecting To News Server"

     newsIPAddr = "redorchestragame.com"
     getRequest = "GET /ingamenews.htm HTTP/1.1"

     ReReadyPause=0.250000
     myRetryCount=0
     myRetryMax=40

     LinkClassName="ROInterface.ROBufferedTCPLink"
     sendGet = true;

}
