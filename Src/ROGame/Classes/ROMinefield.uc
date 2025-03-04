//=============================================================================
// ROMinefield
//=============================================================================
// Used to create a minefield with random mine locations
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class ROMinefield extends ROMinefieldBase
	placeable;

//=============================================================================
// Variables
//=============================================================================

var()	int		XWidth;
var()	int		YWidth;
var()	int		NumMines;
var()	class<ROMine>	MineClass;

var	array<ROMine>	Mines;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// PostBeginPlay - Spawn the mines
//-----------------------------------------------------------------------------

function PostBeginPlay()
{
	local int i;

	for (i = 0; i < NumMines; i++)
		Mines[Mines.Length] = Spawn(MineClass, self);
}

//-----------------------------------------------------------------------------
// Reset - Sets a new location for all the mines
//-----------------------------------------------------------------------------

function Reset()
{
	local int i;

	// Turn off collision on all mines so mines already placed don't get in the way
	for (i = 0; i < Mines.Length; i++)
		Mines[i].SetCollision(false, false, false);

	for (i = 0; i < Mines.Length; i++)
	{
		Mines[i].SetLocation(FindMineLocation());
		Mines[i].SetCollision(true, false, false);
	}
}

//-----------------------------------------------------------------------------
// Deactivate - Turns off the collision on all of the mines
//-----------------------------------------------------------------------------

function Deactivate()
{
	local int i;

	// Turn off collision on all mines so mines already placed don't get in the way
	for (i = 0; i < Mines.Length; i++)
		Mines[i].SetCollision(false, false, false);
}

//-----------------------------------------------------------------------------
// FindMineLocation - Finds a suitable mine location
//-----------------------------------------------------------------------------

function vector FindMineLocation()
{
	local Actor HitActor;
	local vector HitLoc, HitNormal, TraceEnd, TraceStart;
	local int Num;
	local Material M;
	local bool bFoundSpot;

	while (!bFoundSpot)
	{
		TraceStart.X = Location.X + RandRange(-XWidth, XWidth);
		TraceStart.Y = Location.Y + RandRange(-YWidth, YWidth);
		TraceStart.Z = Location.Z;

		TraceEnd = TraceStart - vect(0,0,2048);

		HitActor = Trace(HitLoc, HitNormal, TraceEnd, TraceStart, true, vect(32,32,32), M);

		// Make sure the surface hit is a TerrainInfo and has a material you can actually bury a mine in
		if (TerrainInfo(HitActor) != none)
		{
			if (M.SurfaceType == EST_Default || M.SurfaceType == EST_Dirt || M.SurfaceType == EST_Snow || M.SurfaceType == EST_Plant ||
				 M.SurfaceType == EST_Flesh || M.SurfaceType == EST_Gravel || M.SurfaceType == EST_Mud)
				bFoundSpot = true;
		}

		// Prevent runaway loops from occuring if there's no good places to put a mine
		Num++;

		if (Num > 15)
		{
			//log("ROMinefield: Unable to find a suitable mine location");
			return vect(0,0,0);
		}
	}

	return HitLoc + vect(0,0,8);
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	XWidth=256
	YWidth=256
	NumMines=8
	MineClass=class'ROSchuMine'
	RemoteRole=ROLE_None
	bHidden=true
}
