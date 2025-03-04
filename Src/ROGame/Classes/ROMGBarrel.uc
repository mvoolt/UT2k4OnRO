//=============================================================================
// ROMGBarrel
//=============================================================================
// this is the base MG barrel class.
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - Jeffrey "Antarian" Nakai & John "Ramm-Jaeger" Gibson
//=============================================================================

class ROMGBarrel extends Actor;

//=============================================================================
// Variables
//=============================================================================

var 	float 		ROMGCelsiusTemp;			// current barrel temp
var 	float		ROMGSteamTemp,              // temp barrel begins to steam
					ROMGCriticalTemp,			// temp barrel steams alot and conefire error introduced
					ROMGFailTemp,				// temp at which barrel fails and unusable
					BarrelCoolingRate,			// rate/second the barrel cools at
					FiringHeatIncrement;		// deg C/shot the barrel heat is increased

var 	bool 		bBarrelFailed,			    // if barrel passes ROMGFailTemp, becomes true and barrel unusable
					bBarrelSteaming,            // if barrel passes ROMGSteamTemp, we'll start steaming the barrel
					bBarrelDamaged;				// if barrel passes ROMGCriticalTemp, becomes true and conefire error introduced

var		int			LevelCTemp;                 //  The temperature of the level we're playing in

var		float		BarrelTimerRate;			// How fast to call the timer for this barrel. We don't really need to cool the Barrel every tick

//=============================================================================
// Functions
//=============================================================================
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

    if( (Role == ROLE_Authority) && (ROTeamGame(Level.Game).LevelInfo != none) )
    {
    	LevelCTemp = FtoCelsiusConversion( ROTeamGame(Level.Game).LevelInfo.TempFahrenheit );
		ROMGCelsiusTemp = LevelCTemp;
		//log("ROMGBarrel::PostBeginPlay - ROMGCelsiusTemp is "$ROMGCelsiusTemp);
	}
}

simulated function Destroyed()
{
	// if the barrel is destroyed and is steaming, de-activate the steam effect
	if( bBarrelSteaming )
		ROMGBase(Owner).ToggleBarrelSteam(false);

	if( bBarrelDamaged )
		ROMGBase(Owner).bBarrelDamaged = false;

	super.Destroyed();
}

//------------------------------------------------------------------------------
// FtoCelciusConversion(RO) - This is executed on the authority, used to set the
//	MG C temp using the map ambient Fahrenheit temp
//------------------------------------------------------------------------------
function float FtoCelsiusConversion( INT Fahrenheit )
{
	local float NewCTemp;

	Fahrenheit -= 32;
	NewCTemp = Fahrenheit * 5.0;
	NewCTemp = NewCTemp/9.0;
	//log("ROMGBarrel::FtoCelsiusConversion - NewCTemp is "$NewCTemp);

	return NewCTemp;
}

//------------------------------------------------------------------------------
// WeaponFired(RO) - This is a server-side function that will handle
//	barrel heating whenver the mg fires
//------------------------------------------------------------------------------
function WeaponFired()
{
    // Increment the barrel temp by 1 deg C for firing
	ROMGCelsiusTemp += FiringHeatIncrement;

	// Only CheckBarrelSteaming if the barrel isn't steaming yet
	if( !bBarrelSteaming && (ROMGCelsiusTemp > ROMGSteamTemp) )
	{
    	bBarrelSteaming = true;
    	ROMGBase(Owner).ToggleBarrelSteam(bBarrelSteaming);
	}

    if( ROMGCelsiusTemp > ROMGFailTemp )
    {
    	bBarrelFailed = true;
	}

    UpdateBarrelStatus();

	//log( "ROMGCelsiusTemp on the server is "$ROMGCelsiusTemp);
    //log("bBarrelFailed is "$bBarrelFailed);
}

// Will update this barrel and the weapons's barrel status
function UpdateBarrelStatus()
{
    if( bBarrelFailed )
	{
    	if( ROMGbase(Owner) != none )
			ROMGbase(Owner).bBarrelFailed = true;
	}

	if( !bBarrelSteaming && (ROMGCelsiusTemp > ROMGSteamTemp) )
	{
    	bBarrelSteaming = true;
    	ROMGBase(Owner).ToggleBarrelSteam(bBarrelSteaming);
	}

	if( !bBarrelDamaged && (ROMGCelsiusTemp > ROMGCriticalTemp) )
	{
		bBarrelDamaged = true;
		ROMGBase(Owner).bBarrelDamaged = true;
	}
}

state BarrelInUse
{
    function BeginState()
    {
    	// if the barrel is being put on and is steaming, turn on the steam emitter
        if( bBarrelSteaming )
        	ROMGBase(Owner).ToggleBarrelSteam(true);

        // if the barrel is being put on and is damaged, set the weapon to have
        // a damaged barrel
        if( bBarrelDamaged )
			ROMGBase(Owner).bBarrelDamaged = true;

		SetTimer(BarrelTimerRate, true);
    }

	//------------------------------------------------------------------------------
	// Timer - This is a server-side function that will handle barrel heat
	//	related operations such as barrel steaming and cone fire activation calls
	//------------------------------------------------------------------------------
	function Timer()
	{
		// make sure this is done on the authority
		// if temp is at the level temp, don't bother with anything else
		if( (Role < ROLE_Authority) || (ROMGCelsiusTemp == LevelCTemp))
		{
			return;
		}

		// lower the barrel temp or set to Level ambient temp if it goes below
		if( ROMGCelsiusTemp > LevelCTemp )
		{
			//log("In ROMGBarrel tick, time is "$level.timeseconds$" ROMGCelsiusTemp is "$ROMGCelsiusTemp);
			ROMGCelsiusTemp -= (BarrelTimerRate * BarrelCoolingRate);
		}
		else if( ROMGCelsiusTemp < LevelCTemp )
		{
			ROMGCelsiusTemp = LevelCTemp;
		}

		if( bBarrelSteaming && (ROMGCelsiusTemp < ROMGSteamTemp) )
		{
	    	bBarrelSteaming = false;
	    	ROMGBase(Owner).ToggleBarrelSteam(bBarrelSteaming);
		}

		// Questionable, once the barrel is damaged, does it ever really get better again?
		if( bBarrelDamaged && (ROMGCelsiusTemp < ROMGCriticalTemp) )
		{
			bBarrelDamaged = false;
			ROMGBase(Owner).bBarrelDamaged = false;
		}
	}
}

//------------------------------------------------------------------------------
// Allows Barrel heat to continue to be tracked, but without the steam or cone
//	fire toggling calls to the MG
//------------------------------------------------------------------------------
state BarrelOff
{
	function BeginState()
	{
		// if the barrel is being removed and is steaming, shut off the steam
		// emitter
		if( bBarrelSteaming )
		{
		    ROMGBase(Owner).ToggleBarrelSteam(false);
		}

		SetTimer(BarrelTimerRate, true);
	}

	function Timer()
	{
		// make sure this is done on the authority
		if( (Role < ROLE_Authority) || (ROMGCelsiusTemp == LevelCTemp))
		{
			return;
		}

		// lower the barrel temp or set to Level ambient temp if it goes below
		if( ROMGCelsiusTemp > LevelCTemp )
		{
			//log("In ROMGBarrel tick, time is "$level.timeseconds$" ROMGCelsiusTemp is "$ROMGCelsiusTemp);
			ROMGCelsiusTemp -= (BarrelTimerRate * BarrelCoolingRate);
		}

		else if( ROMGCelsiusTemp < LevelCTemp )
		{
			ROMGCelsiusTemp = LevelCTemp;
		}

		if( bBarrelSteaming && (ROMGCelsiusTemp < ROMGSteamTemp) )
		{
    		bBarrelSteaming = false;
		}

		if( bBarrelDamaged && (ROMGCelsiusTemp < ROMGCriticalTemp) )
		{
			bBarrelDamaged = false;
		}
	}
}

defaultproperties
{
	// Only exists on the server
	RemoteRole=ROLE_None
	DrawType=DT_None
	NetPriority=1.4
	bHidden=true
	Physics=PHYS_None
	bReplicateMovement=false

	ROMGSteamTemp = 100
	ROMGCriticalTemp = 150
	ROMGFailTemp = 200
	BarrelCoolingRate = 1.0
	FiringHeatIncrement = 1.25
	BarrelTimerRate=0.1
}
