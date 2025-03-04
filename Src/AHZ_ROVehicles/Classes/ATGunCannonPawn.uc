//==============================================================================
// ATGunCannonPawn
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// Base Class for AT Gun Cannon Pawns
//==============================================================================
class ATGunCannonPawn extends RussianTankCannonPawn
       abstract;

//==============================================================================
// Functions
//==============================================================================

// Overriden because the animation needs to play on the server for this vehicle for the commanders hit detection
function ServerChangeViewPoint(bool bForward)
{
	if (bForward)
	{
		if ( DriverPositionIndex < (DriverPositions.Length - 1) )
		{
			LastPositionIndex = DriverPositionIndex;
			DriverPositionIndex++;

			if(  Level.Netmode == NM_Standalone  || Level.NetMode == NM_ListenServer )
			{
				NextViewPoint();
			}

			if( Level.NetMode == NM_DedicatedServer )
			{
				AnimateTransition();
			}
		}
     }
     else
     {
		if ( DriverPositionIndex > 0 )
		{
			LastPositionIndex = DriverPositionIndex;
			DriverPositionIndex--;

			if(  Level.Netmode == NM_Standalone || Level.Netmode == NM_ListenServer )
			{
				NextViewPoint();
			}

			if( Level.NetMode == NM_DedicatedServer )
			{
				AnimateTransition();
			}
		}
     }
}

// 1.0 = 0% reloaded, 0.0 = 100% reloaded (e.g. finished reloading)
//Adjusted for faster reloading times.
function float getAmmoReloadState()
{
    local ROTankCannon cannon;

    cannon = ROTankCannon(gun);

    if (cannon == none)
        return 0.0;

    switch (cannon.CannonReloadState)
    {
        case CR_ReadyToFire:    return 0.00;
        case CR_Empty:
        case CR_ReloadedPart1:  return 1.00;
        //case CR_ReloadedPart2:  return 0.75;
        case CR_ReloadedPart3:  return 0.66;
        case CR_ReloadedPart4:  return 0.33;
    }

    return 0.0;
}

// Overriden to handle vehicle exiting better for fixed AT Cannons
function bool PlaceExitingDriver()
{
	local int i;
	local vector tryPlace, Extent, ZOffset;

	Extent = Driver.default.CollisionRadius * vect(1,1,0);
	Extent.Z = Driver.default.CollisionHeight;
	ZOffset = Driver.default.CollisionHeight * vect(0,0,0.5);

	for(i=0; i<ExitPositions.Length; i++)
	{
		if ( bRelativeExitPos )
		{
		    if (VehicleBase != None)
		    	tryPlace = VehicleBase.Location + (ExitPositions[i] >> VehicleBase.Rotation) + ZOffset;
        	    else if (Gun != None)
                	tryPlace = Gun.Location + (ExitPositions[i] >> Gun.Rotation) + ZOffset;
	            else
        	        tryPlace = Location + (ExitPositions[i] >> Rotation);
	        }
		else
			tryPlace = ExitPositions[i];

		// First, do a line check (stops us passing through things on exit).
		// Skip this line check, sometimes there are close objects that will cause this
		// check to fail, even when the area that you are trying to place  the exiting
		// driver is clear. - Ramm
//		if ( bRelativeExitPos )
//		{
//			if (VehicleBase != None)
//			{
//				if (VehicleBase.Trace(HitLocation, HitNormal, tryPlace, VehicleBase.Location + ZOffset, false, Extent) != None)
//					continue;
//			}
//			else
//				if (Trace(HitLocation, HitNormal, tryPlace, Location + ZOffset, false, Extent) != None)
//					continue;
//		}

		// Then see if we can place the player there.
		if ( !Driver.SetLocation(tryPlace) )
			continue;

		return true;
	}

	return false;
}


//Options
//1: Implemented: Modified PlaceExitingDriver so that it handles placing the player on exit better. - Ramm
//2: Implemented: Keep the player at his current position and send him a msg.  if they are smart, they can suicide to get off the gun.
//
//This is a combination of the KDriverLeave over-rides in VehicleWeaponPawn and ROVehicleWeaponPawn.
//When the leaves fails (returns false) it jumps into ServerChangeDriverPosition if there is not a place to put the player,
//    Which then puts the player in the driver's seat.
event bool KDriverLeave( bool bForceLeave )
{
    local bool bSuperDriverLeave;
	local Controller C;
	local PlayerController	PC;

    C = Controller;

	if( !bForceLeave && !Level.Game.CanLeaveVehicle(self, Driver) )
		return false;

	if ( (PlayerReplicationInfo != None) && (PlayerReplicationInfo.HasFlag != None) )
		Driver.HoldFlag(PlayerReplicationInfo.HasFlag);

	// Do nothing if we're not being driven
	if (Controller == None )
		return false;

    Driver.bHardAttach = false;
	Driver.bCollideWorld = true;
	Driver.SetCollision(true, true);

    //Let's look for an unobstructed exit point.  If we find one then we know we can dismount the gun.
    if ( PlaceExitingDriver())
    {
        DriverPositionIndex=0;

        bDriving = False;

	    // Reconnect Controller to Driver.
	    if (C.RouteGoal == self)
		   C.RouteGoal = None;
	    if (C.MoveTarget == self)
		   C.MoveTarget = None;
	    C.bVehicleTransition = true;
	    Controller.UnPossess();

	    if ( (Driver != None) && (Driver.Health > 0) )
	    {
		   Driver.SetOwner( C );
		   C.Possess( Driver );

		   PC = PlayerController(C);
		   if ( PC != None )
			  PC.ClientSetViewTarget( Driver ); // Set playercontroller to view the person that got out

		   Driver.StopDriving( self );
	    }
	    C.bVehicleTransition = false;

	    if ( C == Controller )	// if controller didn't change, clear it...
		   Controller = None;

	    Level.Game.DriverLeftVehicle(self, Driver);

	    // Car now has no driver
	    Driver = None;
	    DriverLeft();

        bSuperDriverLeave = true;
    }
    else
    {
        C.Pawn.ReceiveLocalizedMessage(class'ATCannonMessage', 5);
        bSuperDriverLeave = false;
    }

    return bSuperDriverLeave;
}

// Used to debug where the exit positions are. First type "show sky" in
// console to turn the sky off (debug lines won't render otherwise.
// Then hop in the ATCannon and type "DebugExit" and cylinders will
// appear showing where the exit positions for the player are.
exec function DebugExit()
{
    local int i;
    local vector X, Y, Z;
    local vector tryPlace, ZOffset;

    if( Level.Netmode != NM_Standalone )
        return;

    GetAxes(VehicleBase.Rotation, X,Y,Z);

    ClearStayingDebugLines();
    for(i=0; i < ExitPositions.Length; i++)
    {
		if ( bRelativeExitPos )
		{
		    if (VehicleBase != None)
		    	tryPlace = VehicleBase.Location + (ExitPositions[i] >> VehicleBase.Rotation) + ZOffset;
        	    else if (Gun != None)
                	tryPlace = Gun.Location + (ExitPositions[i] >> Gun.Rotation) + ZOffset;
	            else
        	        tryPlace = Location + (ExitPositions[i] >> Rotation);
	        }
		else
			tryPlace = ExitPositions[i];

       DrawStayingDebugLine(VehicleBase.Location, tryPlace, 0,255,0);

       DrawDebugCylinder(tryPlace,X,Y,Z,class'ROEngine.ROPawn'.default.CollisionRadius,class'ROEngine.ROPawn'.default.CollisionHeight,10,0, 255, 0);

    }
}

// Draws a debugging cylinder out of wireframe lines
simulated function DrawDebugCylinder(vector Base,vector X, vector Y,vector Z, FLOAT Radius,float HalfHeight,int NumSides, byte R, byte G, byte B)
{
	local float AngleDelta;
	local vector LastVertex, Vertex;
	local int SideIndex;



	AngleDelta = 2.0f * PI / NumSides;
	LastVertex = Base + X * Radius;

	for(SideIndex = 0;SideIndex < NumSides;SideIndex++)
	{
		Vertex = Base + (X * Cos(AngleDelta * (SideIndex + 1)) + Y * Sin(AngleDelta * (SideIndex + 1))) * Radius;

        DrawStayingDebugLine( LastVertex - Z * HalfHeight,Vertex - Z * HalfHeight,R,G,B);
        DrawStayingDebugLine( LastVertex + Z * HalfHeight,Vertex + Z * HalfHeight,R,G,B);
        DrawStayingDebugLine( LastVertex - Z * HalfHeight,LastVertex + Z * HalfHeight,R,G,B);

		LastVertex = Vertex;
	}
}

//==============================================================================
// defaultproperties
//==============================================================================
defaultproperties
{
	HudName="Gunner"

    EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0

    ExitPositions(0)=(X=-60,Y=-5,Z=50)
    ExitPositions(1)=(X=-60,Y=-5,Z=60)
    ExitPositions(2)=(X=-60,Y=25,Z=50)
    ExitPositions(3)=(X=-60,Y=-25,Z=50)
    ExitPositions(4)=(X=0,Y=68,Z=50)
    ExitPositions(5)=(X=0,Y=-68,Z=50)
    ExitPositions(6)=(X=0,Y=68,Z=25)
    ExitPositions(7)=(X=0,Y=-68,Z=25)
    ExitPositions(8)=(X=-60,Y=-5,Z=25)
    ExitPositions(9)=(X=-90,Y=0,Z=50)
    ExitPositions(10)=(X=-90,Y=-45,Z=50)
    ExitPositions(11)=(X=-90,Y=45,Z=50)
    ExitPositions(12)=(X=-90,Y=0,Z=20)
    ExitPositions(13)=(X=-90,Y=0,Z=75)
    ExitPositions(14)=(X=-125,Y=0,Z=60)
    ExitPositions(15)=(X=-250,Y=0,Z=75)

	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=false //true
	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=50,Z=120)
	TPCamDistance=300
	DrivePos=(X=0.0,Y=0.0,Z=0.0)

    bDrawDriverInTP=true
    bDrawMeshInFP=True

	DriverDamageMult=1.0
	bPCRelativeFPRotation=true
 	bHasAltFire=False

	PitchUpLimit=6000
	PitchDownLimit=64000

    DriveAnim=crouch_idle_binoc

    bMustBeTankCrew=false
 	bHasFireImpulse=True
}


