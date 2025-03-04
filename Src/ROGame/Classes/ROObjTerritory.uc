//=============================================================================
// ROObjTerritory
//=============================================================================
// A territory that can be captured
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROObjTerritory extends ROObjective
	placeable;

//=============================================================================
// Variables
//=============================================================================

var()	float			MaxCaptureRate;
var()	float			BaseCaptureRate;
var		float			FallOffRate;

var		float			CurrentCapProgress;			// Stores the current progress on scale of 0-1

var()	bool			bRecaptureable;				// True if it can be taken back

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// PostBeginPlay - Handles setup
//-----------------------------------------------------------------------------

function PostBeginPlay()
{
	Super.PostBeginPlay();

	//CaptureTime = Max(CaptureTime, 1);
}

//-----------------------------------------------------------------------------
// Reset - Goes back to the initial state
//-----------------------------------------------------------------------------

function Reset()
{
	Super.Reset();

	CurrentCapProgress = 0.0;
	CurrentCapTeam = NEUTRAL_TEAM_INDEX;

	SetTimer(0.25, true);
}

//-----------------------------------------------------------------------------
// Timer - Handles the bulk of the work
//-----------------------------------------------------------------------------

function Timer()
{
	local byte CP;
	local int NumTotal[2], Num[2], NumForCheck[2], i;
	local Controller C;
	local Pawn pawn;
	local ROPawn P;

	local float	LeaderBonus[2], Rate[2];
	local ROVehicle ROVeh;
	local ROVehicleWeaponPawn VehWepPawn;
	local float oldCapProgress;
	local Controller firstCapturer;
	local byte CurrentCapAxisCappers, CurrentCapAlliesCappers;
	local ROPlayerReplicationInfo PRI;

	if (!bActive || ROTeamGame(Level.Game) == None || !ROTeamGame(Level.Game).IsInState('RoundInPlay'))
		return;

	oldCapProgress = CurrentCapProgress;

	LeaderBonus[AXIS_TEAM_INDEX] = 1.0;
	LeaderBonus[ALLIES_TEAM_INDEX] = 1.0;

	// Loop through the Controller list and determine how many players from each team are inside the attached volume, if any, or if there is no volume,
	// within the Radius that was set.
	for (C = Level.ControllerList; C != None; C = C.NextController)
	{

        if (C.bIsPlayer && C.PlayerReplicationInfo.Team != None && ((ROPlayer(C) != None && ROPlayer(C).GetRoleInfo() != None) || ROBot(C) != None))
		{
			//log("ROObjTerritory C = "$C);
            pawn = C.Pawn;
            //log("ROObjTerritory P = "$P);

		    PRI = ROPlayerReplicationInfo(C.PlayerReplicationInfo);

			if (pawn != None && pawn.Health > 0 && WithinArea(pawn))
			{
			    Num[C.PlayerReplicationInfo.Team.TeamIndex]++;
			    if (PRI != none && PRI.RoleInfo != none)
			        NumForCheck[C.PlayerReplicationInfo.Team.TeamIndex] += PRI.RoleInfo.ObjCaptureWeight;
			    else
				    NumForCheck[C.PlayerReplicationInfo.Team.TeamIndex]++;

				firstCapturer = C;  // Used so that first person to initiate capture doesn't get the 'map
				                    // updated' notification

				// Leader bonuses are given to a side if a leader is there
				if (ROPlayerReplicationInfo(C.PlayerReplicationInfo).RoleInfo.bIsLeader)
					LeaderBonus[C.PlayerReplicationInfo.Team.TeamIndex] = 1.25;
			}

			// Fixes the cap bug
			pawn = none;

            // Update total nums
            NumTotal[C.PlayerReplicationInfo.Team.TeamIndex]++;
		}
	}

	// Figure out the rate of capture that each side is capable of
	// Rate is defined as:
	// Number of players in the area * BaseCaptureRate * Leader bonus (if any) * Percentage of players on the team in the area
	for (i = 0; i < 2; i++)
	{
		if (NumTotal[i] > 0)
			Rate[i] = FMin(Num[i] * BaseCaptureRate * LeaderBonus[i] * float(Num[i]) / NumTotal[i], MaxCaptureRate);
		else
			Rate[i] = 0.0;
	}

    // Figure what the replicated # of cappers should be (to take into account
    // the leader bonus)
    CurrentCapAxisCappers = NumForCheck[AXIS_TEAM_INDEX]; // * int(4.0 * LeaderBonus[AXIS_TEAM_INDEX]);
    CurrentCapAlliesCappers = NumForCheck[ALLIES_TEAM_INDEX]; // * int(4.0 * LeaderBonus[ALLIES_TEAM_INDEX]);


	// Note: Comparing number of players as opposed to rates to decide which side has the advantage for
	// the capture for fear that rates could be abused in this instance
	if (ObjState != OBJ_Axis && NumForCheck[AXIS_TEAM_INDEX] > NumForCheck[ALLIES_TEAM_INDEX])
	{
		// Have to work down the progress the other team made first, but this is quickened since
		// the fall off rate still occurs
		if (CurrentCapTeam == ALLIES_TEAM_INDEX)
		{
			CurrentCapProgress -= 0.25 * (FallOffRate + Rate[AXIS_TEAM_INDEX]);
		}
		else
		{
			CurrentCapTeam = AXIS_TEAM_INDEX;
			CurrentCapProgress += 0.25 * Rate[AXIS_TEAM_INDEX];
		}

	}
	else if (ObjState != OBJ_Allies && NumForCheck[ALLIES_TEAM_INDEX] > NumForCheck[AXIS_TEAM_INDEX])
	{
		if (CurrentCapTeam == AXIS_TEAM_INDEX)
		{
			CurrentCapProgress -= 0.25 * (FallOffRate + Rate[ALLIES_TEAM_INDEX]);
		}
		else
		{
			CurrentCapTeam = ALLIES_TEAM_INDEX;
			CurrentCapProgress += 0.25 * Rate[ALLIES_TEAM_INDEX];
		}
	}
	else if (NumForCheck[ALLIES_TEAM_INDEX] == NumForCheck[AXIS_TEAM_INDEX] && NumForCheck[AXIS_TEAM_INDEX] != 0)
	{
	    // Stalemate! No change.
	}
	else
	{
		CurrentCapProgress -= 0.25 * FallOffRate;
	}

	CurrentCapProgress = FClamp(CurrentCapProgress, 0.0, 1.0);

	if (CurrentCapProgress == 0.0)
		CurrentCapTeam = NEUTRAL_TEAM_INDEX;
	else if (CurrentCapProgress == 1.0)
    	ObjectiveCompleted(None, CurrentCapTeam);

	// Go through and update capture bars
	for (C = Level.ControllerList; C != None; C = C.NextController)
	{
		P = ROPawn(C.Pawn);
		ROVeh = ROVehicle(C.Pawn);
		VehWepPawn = ROVehicleWeaponPawn(C.Pawn);

		if (!C.bIsPlayer)
		{
			continue;
		}

		if ( P != none )
        {
    		if (!bActive || !WithinArea(P))
    		{
    			if (P.CurrentCapArea == ObjNum)
    				P.CurrentCapArea = 255;
    		}
    		else
    		{
    			if (P.CurrentCapArea != ObjNum)
    				P.CurrentCapArea = ObjNum;

    			CP = byte(Ceil(CurrentCapProgress * 100));

    			// Hack to save on variables replicated (if Allies, add 100 so the range is 101-200 instead of 1-100, or just 0 if it is 0)
    			if (CurrentCapTeam == ALLIES_TEAM_INDEX && CurrentCapProgress != 0.0)
    				CP += 100;

    			if (P.CurrentCapProgress != CP)
    				P.CurrentCapProgress = CP;

    			// Replicate # of players in capture zone
    			if (P.CurrentCapAxisCappers != CurrentCapAxisCappers)
    			    P.CurrentCapAxisCappers = CurrentCapAxisCappers;
    			if (P.CurrentCapAlliesCappers != CurrentCapAlliesCappers)
    			    P.CurrentCapAlliesCappers = CurrentCapAlliesCappers;
    		}
		}


		// Draw the capture bar for rovehicles and rovehiclepawns
		if (  P == none && ROVeh != none )
		{
			if (!bActive || !WithinArea(ROVeh))
			{
				if (ROVeh.CurrentCapArea == ObjNum)
					ROVeh.CurrentCapArea = 255;
			}
			else
			{
				if (ROVeh.CurrentCapArea != ObjNum)
					ROVeh.CurrentCapArea = ObjNum;

				CP = byte(Ceil(CurrentCapProgress * 100));

				// Hack to save on variables replicated (if Allies, add 100 so the range is 101-200 instead of 1-100, or just 0 if it is 0)
				if (CurrentCapTeam == ALLIES_TEAM_INDEX && CurrentCapProgress != 0.0)
					CP += 100;

				if (ROVeh.CurrentCapProgress != CP)
					ROVeh.CurrentCapProgress = CP;

				// Replicate # of players in capture zone
    			if (ROVeh.CurrentCapAxisCappers != CurrentCapAxisCappers)
    			    ROVeh.CurrentCapAxisCappers = CurrentCapAxisCappers;
    			if (ROVeh.CurrentCapAlliesCappers != CurrentCapAlliesCappers)
    			    ROVeh.CurrentCapAlliesCappers = CurrentCapAlliesCappers;
			}
		}

		if (  P == none && ROVeh == none && VehWepPawn != none)
		{
			if (!bActive || !WithinArea(VehWepPawn))
			{
				if (VehWepPawn.CurrentCapArea == ObjNum)
					VehWepPawn.CurrentCapArea = 255;
			}
			else
			{
				if (VehWepPawn.CurrentCapArea != ObjNum)
					VehWepPawn.CurrentCapArea = ObjNum;

				CP = byte(Ceil(CurrentCapProgress * 100));

				// Hack to save on variables replicated (if Allies, add 100 so the range is 101-200 instead of 1-100, or just 0 if it is 0)
				if (CurrentCapTeam == ALLIES_TEAM_INDEX && CurrentCapProgress != 0.0)
					CP += 100;

				if (VehWepPawn.CurrentCapProgress != CP)
					VehWepPawn.CurrentCapProgress = CP;

				// Replicate # of players in capture zone
    			if (VehWepPawn.CurrentCapAxisCappers != CurrentCapAxisCappers)
    			    VehWepPawn.CurrentCapAxisCappers = CurrentCapAxisCappers;
    			if (VehWepPawn.CurrentCapAlliesCappers != CurrentCapAlliesCappers)
    			    VehWepPawn.CurrentCapAlliesCappers = CurrentCapAlliesCappers;
			}
		}
	}

	// Check if we should send map info change notification to players
	if ( !(oldCapProgress ~= CurrentCapProgress) )
	{
        // Check if we changed from 1.0 or from 0.0 (no need to send events
        // otherwise)
        if (oldCapProgress ~= 0 || oldCapProgress ~= 1)
            ROTeamGame(Level.Game).NotifyPlayersOfMapInfoChange(NEUTRAL_TEAM_INDEX, firstCapturer);
	}

	UpdateCompressedCapProgress();
}

// Updates the CompressedCapProgress variable. That variable only has 6 different values
// so that it doesn't need to be replicated as often.
function UpdateCompressedCapProgress()
{
    if (!bActive)
    {
        if (CompressedCapProgress != 0)
            CompressedCapProgress = 0;  // = 0.00
    }
    else if (CurrentCapProgress ~= 0)
    {
        if (CompressedCapProgress != 0)
            CompressedCapProgress = 0;  // = 0.00
    }
    else if (CurrentCapProgress ~= 1)
    {
        if (CompressedCapProgress != 5)
            CompressedCapProgress = 5;  // = 1.00
    }
    else if (CurrentCapProgress < 0.25)
    {
        if (CompressedCapProgress != 1)
            CompressedCapProgress = 1;  // = 0-0.25
    }
    else if (CurrentCapProgress < 0.50)
    {
        if (CompressedCapProgress != 2)
            CompressedCapProgress = 2;  // = 0.25-0.50
    }
    else if (CurrentCapProgress < 0.75)
    {
        if (CompressedCapProgress != 3)
            CompressedCapProgress = 3;  // = 0.50-0.75
    }
    else if (CurrentCapProgress < 1.00)
    {
        if (CompressedCapProgress != 4)
            CompressedCapProgress = 4;  // = 0.75-1.00
    }
}

//-----------------------------------------------------------------------------
// HandleCompletion - Overridden for new functionality
//-----------------------------------------------------------------------------

function HandleCompletion(PlayerReplicationInfo CompletePRI, int Team)
{

   	local Controller C;
	local Pawn P;

	CurrentCapProgress = 0.0;

	// If it's not recapturable, make it inactive
	if (!bRecaptureable)
	{
		bActive = false;
		SetTimer(0.0, false);
		DisableCapBarsForThisObj();
	}

	// Give players points for helping with the capture
	for (C = Level.ControllerList; C != None; C = C.NextController)
	{
		P = ROPawn(C.Pawn);

		if(P == none)
		{
			P = ROVehicle(C.Pawn);

			if(P == none)
			{
				P = ROVehicleWeaponPawn(C.Pawn);

				// This check might be a little redundant, since we do it in the next line - Ramm
				if(P == none)
					continue;
			}
		}

		if ( !C.bIsPlayer || P == None || C.PlayerReplicationInfo.Team == None || C.PlayerReplicationInfo.Team.TeamIndex != Team )
			continue;
		else if ( !WithinArea(P) )
		{
			if ( ROSteamStatsAndAchievements(C.PlayerReplicationInfo.SteamStatsAndAchievements) != none )
			{
				ROSteamStatsAndAchievements(C.PlayerReplicationInfo.SteamStatsAndAchievements).NotInCapturedObjective();
			}
			continue;
		}

		Level.Game.ScoreObjective(C.PlayerReplicationInfo, 10);
	}

	BroadcastLocalizedMessage(class'ROObjectiveMsg', Team, None, None, self);
}

function DisableCapBarsForThisObj()
{
    local Pawn apawn;
    local ROPawn P;
    local ROVehicle ROVeh;
    local ROVehicleWeaponPawn VehWepPawn;

	// Go through and update capture bars
	foreach DynamicActors(class'pawn', apawn)
	{
		P = ROPawn(apawn);
		ROVeh = ROVehicle(apawn);
		VehWepPawn = ROVehicleWeaponPawn(apawn);

		if ( P != none )
        {
    		if (P.CurrentCapArea == ObjNum)
    			P.CurrentCapArea = 255;
		}

		// Disable the capture bar for rovehicles
		if (  P == none && ROVeh != none )
		{
			if (ROVeh.CurrentCapArea == ObjNum)
				ROVeh.CurrentCapArea = 255;
		}

        // Disable the capture bar for rovehiclepawns
		if (  P == none && ROVeh == none && VehWepPawn != none)
		{
			if (VehWepPawn.CurrentCapArea == ObjNum)
				VehWepPawn.CurrentCapArea = 255;
        }
	}
}

// fix for bug #2433
function NotifyStateChanged()
{
    super.NotifyStateChanged();

    if (!bActive)
    {
        CurrentCapProgress = 0;
        DisableCapBarsForThisObj();
    }

    UpdateCompressedCapProgress();
}

// fix for bug #2433
function SetActive( bool bActiveStatus )
{
	super.SetActive(bActiveStatus);
	NotifyStateChanged();
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MaxCaptureRate=0.066667
	BaseCaptureRate=0.08333
	FallOffRate=0.08333
}
