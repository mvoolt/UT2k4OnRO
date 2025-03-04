//==============================================================================
// ROTreadCraftWithRiders
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// Tank Passenger class
//==============================================================================
class ROTreadCraftWithRiders extends ROTreadCraft;

//==============================================================================
// Variables
//==============================================================================
var()    bool    bAllowRiders;                    //allow the mapper to control the ability for tank riders.  True by default.

/*
//I believe HP_Normal could be used, but if it is used for something else in the future then I have introduced a bug for no reason.
enum RHitPointType     //Additional Hit Point Types for Passengers.
{
	HP_TankRider,
};

var		RHitPointType					RiderHitPointType;
*/

/*
// Information for each specific hit area
struct native RiderHitPoint
{
	var() float           	PointRadius;     	// Squared radius of the head of the pawn that is vulnerable to headshots
	var() float           	PointHeight;     	// Distance from base of neck to center of head - used for headshot calculation
	var() float				PointScale;
	var() name				PointBone;
	var() vector			PointOffset;		// Amount to offset the hitpoint from the bone
    var() int               RiderPos;           // The index of the rider's weapon pawn in the PassengerWeapons array.
	//var() RHitPointType		RiderHitPointType;  // What type of hit point this is.
};

var() 	array<RiderHitPoint>		RiderHitPoints; 	 	// An array of possible points that can be hit for a passenger.
*/

//==============================================================================
// Functions
//==============================================================================

// Overridden to allow passengers on a tank.
function bool TryToDrive(Pawn P)
{
	local int x;

	//don't allow vehicle to be stolen when somebody is in a turret
	if (!bTeamLocked && P.GetTeamNum() != VehicleTeam)
	{
		for (x = 0; x < WeaponPawns.length; x++)
			if (WeaponPawns[x].Driver != None)
			{
				DenyEntry( P, 2 );
				return false;
			}
	}

	if ( P.bIsCrouched ||  bNonHumanControl || (P.Controller == None) || (Driver != None) || (P.DrivenVehicle != None) || !P.Controller.bIsPlayer
	     || P.IsA('Vehicle') || Health <= 0 )
		return false;

	if( !Level.Game.CanEnterVehicle(self, P) )
		return false;

	// Check vehicle Locking....
	if ( bTeamLocked && ( P.GetTeamNum() != VehicleTeam ))
	{
		DenyEntry( P, 1 );
		return false;
	}
	else if( bMustBeTankCommander && !ROPlayerReplicationInfo(P.Controller.PlayerReplicationInfo).RoleInfo.bCanBeTankCrew && P.IsHumanControlled())
	{
	    //They mut be a non-tanker role so let's go through the available rider positions and find a place for them to sit.
        //Check first to ensure riders are allowed.
        if ( !bAllowRiders )
        {
            DenyEntry( P, 3 );
	        return false;
        }

        //cycle through the available passanger positions.  Check the class type to see if it is ROPassengerPawn
        for (x = 1; x < WeaponPawns.length; x++)    //skip over the turret
        {
            //If riders are allowed, the WeaponPawn is free and it is a passenger pawn class then climb aboard.
            if ( WeaponPawns[x].Driver == none && WeaponPawns[X].IsA('ROPassengerPawn') )
			{
                WeaponPawns[x].KDriverEnter(P);
                return true;
			}
        }

        DenyEntry( P, 4 );
	    return false;
	}
	else
	{
		if ( bEnterringUnlocks && bTeamLocked )
			bTeamLocked = false;

		KDriverEnter( P );
		return true;
	}
}

// Send a message on why they can't get in the vehicle
function DenyEntry( Pawn P, int MessageNum )
{
	P.ReceiveLocalizedMessage(class'AHZ_VehicleMessage', MessageNum);
}

/*
// Did an impact hit a rider
// Note: This is the same code as "IsPointShot" with an adjustment to process the RiderHitPoints array.
function bool IsRiderShot(vector loc, vector ray, float AdditionalScale, int index, optional float CheckDist)
{
	local coords C;
	local vector HeadLoc, B, M, diff;
	local float t, DotMM, Distance;

    log("IsRiderShot - CP1a", 'teuf');
    log("IsRiderShot - CP1b, index= "$index, 'teuf');

	if (RiderHitPoints[index].PointBone == '')
		return False;

    log("IsRiderShot - CP2", 'teuf');

	C = GetBoneCoords(RiderHitPoints[index].PointBone);

	HeadLoc = C.Origin + (RiderHitPoints[index].PointHeight * RiderHitPoints[index].PointScale * AdditionalScale * C.XAxis);
	//HeadLoc += VehHitpoints[index].PointOffset;
	HeadLoc = HeadLoc + (RiderHitPoints[index].PointOffset >> Rotation);

    log("IsRiderShot - CP3", 'teuf');

	// Express snipe trace line in terms of B + tM
	B = loc;

	if( CheckDist > 0 )
		M = Normal(ray) * CheckDist;
	else
		M = ray * (2.0 * CollisionHeight + 2.0 * CollisionRadius);

    log("IsRiderShot - CP4", 'teuf');

	// Find Point-Line Squared Distance
	diff = HeadLoc - B;
	t = M Dot diff;
	if (t > 0)
	{
		DotMM = M dot M;
		if (t < DotMM)
		{
			t = t / DotMM;
			diff = diff - (t * M);
		}
		else
		{
			t = 1;
			diff -= M;
		}
	}
	else
		t = 0;

    log("IsRiderShot - CP5", 'teuf');

	Distance = Sqrt(diff dot diff);

	log("IsRiderShot - CP6, RiderHitPoints[index].PointRadius= "$RiderHitPoints[index].PointRadius, 'teuf');
    log("IsRiderShot - CP6, RiderHitPoints[index].PointScale= "$RiderHitPoints[index].PointScale , 'teuf');
    log("IsRiderShot - CP6, AdditionalScale= "$AdditionalScale, 'teuf');

    return (Distance < (RiderHitPoints[index].PointRadius * RiderHitPoints[index].PointScale * AdditionalScale));
} */

//Over-riden to allow tank passengers to take damage.
//function TakeDamage(int Damage, Pawn instigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex)
//{
//    local int x;
//
//    log("TakeDamage - Start", 'teuf');
//
//    if ( bAllowRiders )
//    {
//        log("TakeDamage - CP1", 'teuf');
//
//        for(x=0; x<RiderHitPoints.Length; x++)
//	    {
//            log("TakeDamage - CP2, Length = "$RiderHitPoints.Length, 'teuf');
//            log("TakeDamage - CP2, RiderHitPoints[x].RiderPos = "$RiderHitPoints[x].RiderPos, 'teuf');
//
//            /*
//            if ( RiderHitPoints[x].RiderHitPointType == HP_TankRider )
//            {
//			    log("TakeDamage - CP3", 'teuf');
//            */
//
//                // Damage for large weapons
//			    //Teuf, this may cause the tank to explode also.  Need to test it.
//			    if(	class<ROWeaponDamageType>(DamageType) != none && class<ROWeaponDamageType>(DamageType).default.VehicleDamageModifier > 0.25 )
//			    {
//			        log("TakeDamage - CP4a", 'teuf');
//
//                    if ( IsRiderShot(Hitlocation, Momentum, 1.0, x)) // && WeaponPawns[RiderHitPoints[x].RiderPos].IsA('ROPassengerPawn') )
//			        {
//				        log("TakeDamage - CP4b", 'teuf');
//                        Level.Game.Broadcast(self, "HitRider-explosive");
//
//				        WeaponPawns[RiderHitPoints[x].RiderPos].Driver.TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
//			        }
//			    }
//			    // Damage for small (non penetrating) arms
//			    else
//                {
//				    log("TakeDamage - CP5a", 'teuf');
//                    log("TakeDamage - CP5a, DriverHitCheckDist= "$DriverHitCheckDist, 'teuf');
//
//                    //if ( IsRiderShot(Hitlocation, Momentum, 1.0, x, DriverHitCheckDist)) // && WeaponPawns[RiderHitPoints[x].RiderPos].IsA('ROPassengerPawn') )
//			        //{
//					    log("TakeDamage - CP5b", 'teuf');
//                        Level.Game.Broadcast(self, "HitRider-small arms");
//
//                        //The driver is not being found.  The "Driver" is the vehicle's driver, not the passenger.  Try to go into the WeaponPawn and access the driver (player pawn)
//                        WeaponPawns[RiderHitPoints[x].RiderPos].TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
//                    //}
//		        }
//            //}
//        }
//    }
//
//    log("TakeDamage - CP6", 'teuf');
//
//    super(ROTreadCraft).TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
//}


//==============================================================================
// Default Properties
//==============================================================================
defaultproperties
{
    bAllowRiders=true   //default is passengers
}
