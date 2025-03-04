//====================================================================
//  Written by Ron Prestenback
//  (c) 2003, Epic Games, Inc.  All Rights Reserved
// ====================================================================
class UT2K4Browser_PlayersListBox extends ServerBrowserMCListBox;

var UT2K4Browser_ServerListPageBuddy tp_Buddy;

var localized string ContextMenuText[2];

event Opened(GUIComponent Sender)
{
	Super.Opened(Sender);

	// Prevent updating of list if scrolling
	MyScrollBar.MyGripButton.OnMousePressed = tp_Anchor.MousePressed;
	MyScrollBar.MyGripButton.OnMouseRelease = tp_Anchor.MouseReleased;
}

function InternalOnClick(GUIContextMenu Sender, int Index)
{
	local int i;
	local UT2K4Browser_PlayersList L;

	L = UT2K4Browser_PlayersList(List);
	if ( L != None )
	{
		i = L.CurrentListId();
		if ( i >= 0 && i < L.Players.Length )
		{
			if ( !NotifyContextSelect(Sender, Index) )
			{
				switch (Sender.ContextItems[Index])
				{
					case ContextMenuText[0]:
						Controller.LaunchURL("http://ut2004stats.epicgames.com/playerstats.php?player="$L.Players[i].StatsID);
						break;

					case ContextMenuText[1]:
						if (tp_Buddy != None)
// if _RO_
                            if ( tp_Buddy.FindBuddyIndex(UT2K4Browser_PlayersList(List).Players[i].PlayerName) == -1 )
// end if _RO_
                            tp_Buddy.AddBuddy(UT2K4Browser_PlayersList(List).Players[i].PlayerName);
						break;
				}
			}
		}
	}
}

function bool InternalOnOpen(GUIContextMenu Menu)
{
	local int i;

// if _RO_
// else
//	Menu.AddItem(ContextMenuText[0]);
// end if _RO_

	i = List.CurrentListId();
	if (tp_Buddy != None)
	{
// if _RO_
// else
//		if ( tp_Buddy.FindBuddyIndex(UT2K4Browser_PlayersList(List).Players[i].PlayerName) == -1 )
// end if _RO_
			Menu.AddItem(ContextMenuText[1]);
	}

	return Super.InternalOnOpen(Menu);
}

function bool InternalOnClose(GUIContextMenu Sender)
{
	Sender.ContextItems.Remove(0, Sender.ContextItems.Length);
	return Super.InternalOnClose(Sender);
}

DefaultProperties
{
	Begin Object Class=GUIContextMenu Name=RCMenu
		OnSelect=InternalOnClick
		OnOpen=InternalOnOpen
		OnClose=InternalOnClose
	End Object

	ContextMenuText[0]="Show Player's Stats"
	ContextMenuText[1]="Add To Buddy List"

	ContextMenu=RCMenu
	DefaultListClass="GUI2K4.UT2K4Browser_PlayersList"
}
