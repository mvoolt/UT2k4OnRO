class ROTurretController extends TurretController;

function Possess(Pawn aPawn)
{
	Super.Possess(aPawn);

	if (VehicleWeaponPawn(aPawn) != None && VehicleWeaponPawn(aPawn).Gun != None)
		VehicleWeaponPawn(aPawn).Gun.bActive = true;
}


simulated function int GetTeamNum()
{
	if( Pawn != none && VehicleWeaponPawn(Pawn) != none )
		return VehicleWeaponPawn(Pawn).GetVehicleBase().GetTeamNum();
	else return super.GetTeamNum();
}



//function bool SameTeamAs(Controller C)
//{
//	if (ONSStationaryWeaponPawn(Pawn) == None || ONSStationaryWeaponPawn(Pawn).bPowered)
//		return Super.SameTeamAs(C);
//
//	return true; //don't shoot at anybody when unpowered
//}

auto state Searching
{
	event SeePlayer(Pawn SeenPlayer)
	{
		if ( IsTargetRelevant( SeenPlayer ) )
		{
			Enemy = SeenPlayer;
			GotoState('Engaged');
		}
	}

	function ScanRotation()
	{
		local actor HitActor;
		local vector HitLocation, HitNormal, Dir;
		local float BestDist, Dist;
		local rotator Pick;

		DesiredRotation.Yaw = Pawn.Rotation.Yaw + 16384 + Rand(32768);//0;
		DesiredRotation.Pitch = 0;//Rotation.Pitch + 16384 + Rand(32768);
		Dir = vector(DesiredRotation);

		// check new pitch not a blocked direction
		HitActor = Trace(HitLocation,HitNormal,Pawn.Location + 2000 * Dir,Pawn.Location,false);
		if ( HitActor == None )
			return;
		BestDist = vsize(HitLocation - Pawn.Location);
		Pick = DesiredRotation;

		DesiredRotation.Yaw += 32768;
		//DesiredRotation.Pitch += 32768;
		Dir = vector(DesiredRotation);
		// check new pitch not a blocked direction
		HitActor = Trace(HitLocation,HitNormal,Pawn.Location + 2000 * Dir,Pawn.Location,false);
		if ( HitActor == None )
			return;
		Dist = vsize(HitLocation - Pawn.Location);
		if ( Dist > BestDist )
		{
			BestDist = Dist;
			Pick = DesiredRotation;
		}

		DesiredRotation.Yaw += 32768;
		//DesiredRotation.Pitch += 16384;
		Dir = vector(DesiredRotation);
		// check new pitch not a blocked direction
		HitActor = Trace(HitLocation,HitNormal,Pawn.Location + 2000 * Dir,Pawn.Location,false);
		if ( HitActor == None )
			return;
		Dist = vsize(HitLocation - Pawn.Location);
		if ( Dist > BestDist )
		{
			BestDist = Dist;
			Pick = DesiredRotation;
		}

        DesiredRotation.Yaw += 32768;
		//DesiredRotation.Pitch += 32768;
		Dir = vector(DesiredRotation);
		// check new pitch not a blocked direction
		HitActor = Trace(HitLocation,HitNormal,Pawn.Location + 2000 * Dir,Pawn.Location,false);
		if ( HitActor == None )
			return;
		Dist = vsize(HitLocation - Pawn.Location);
		if ( Dist > BestDist )
		{
			BestDist = Dist;
			Pick = DesiredRotation;
		}

		DesiredRotation = Pick;
	}

	function BeginState()
	{
		Enemy = None;
		Focus = None;
		StopFiring();
	}

Begin:
	ScanRotation();
	FocalPoint = Pawn.Location + 1000 * vector(DesiredRotation);
	Sleep(10 + 3*FRand());
	Goto('Begin');
}



state Engaged
{
	function BeginState()
	{
		Focus = Enemy;
		Target = Enemy;
		bFire = 1;
		Pawn.Fire(0);
	}
}

State WaitForTarget
{
	function BeginState()
	{
		Target = Enemy;
		bFire = 1;
		Pawn.Fire(0);
	}
}
