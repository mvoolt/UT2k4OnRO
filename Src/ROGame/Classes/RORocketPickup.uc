//=================================================
// ROGrenadePickup
// created by Antarian on 12/28/03
//
// Copyright (C) 2003 Jeffrey Nakai
//
// TEMPORARY class
//=================================================

class RORocketPickup extends ROPlaceableAmmoPickup
	abstract;

// Ramm: Refactor
// This class and all of its subclasses are crap. Lets fix it


//var class<LocalMessage> TouchMessageClass;
//var() localized string TouchMessage; // Human readable description when touched up.


function RespawnEffect()
{
	//spawn(class'PlayerSpawnEffect');
}

//====================================================================
// Reset(UT) - Destroy any remaining pickups when the round restarts
//====================================================================
//function Reset()
//{
//	Destroy();
//}

function InitDroppedPickupFor(Inventory Inv)
{
    SetPhysics(PHYS_Falling);
	Inventory = none;
	bAlwaysRelevant = false;
	bOnlyReplicateHidden = false;
	bUpdateSimulatedPosition = true;
    bDropped = true;
    DropLifeTime += rand(10);
    LifeSpan = DropLifeTime + 10;
	bIgnoreEncroachers=false; // handles case of dropping stuff on lifts etc
	GotoState('ROFallingPickup');
}


// HUD Messages

static function string GetLocalString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2
	)
{
	switch(Switch)
	{
		case 0:
			return Default.PickupMessage;

		case 1:
			return default.TouchMessage;
	}
}

event Landed(Vector HitNormal)
{
    GotoState('ROPickup','Begin');
}

function AnnounceTouch( Pawn Receiver )
{
    local ROPlayer myController;

	if(( Receiver != none ) && (ROPawn(Receiver).Controller != None) )
	{
	     myController =  ROPlayer(ROPawn(Receiver).Controller);
	     myController.ReceiveLocalizedMessage(TouchMessageClass,1,,,class);
	}
}

//=============================================================================
// ROPickup state: this inventory item is sitting on the ground.

auto state ROPickup
{
	function bool ReadyToPickup(float MaxWait)
	{
		return true;
	}

	function bool ValidTouch( actor Other )
	{
		// make sure its a live player
		if ( (Pawn(Other) == None) || !Pawn(Other).bCanPickupInventory || (Pawn(Other).Health <= 0) )
			return false;

		if( ROPawn(Other) != none && ROPawn(Other).AutoTraceActor != none && ROPawn(Other).AutoTraceActor == self )
		{
			// do nothing
		}
		// make sure not touching through wall
		else if ( !FastTrace(Other.Location, Location) )
			return false;

		// make sure game will let player pick me up
		if( Level.Game.PickupQuery(Pawn(Other), self) )
		{
			TriggerEvent(Event, self, Pawn(Other));
			return true;
		}
		return false;
	}

	function Touch( actor Other )
	{
		// need this to fix an accessed none, likely caused by dead
		// actors touching pickups
		if( (Other == none) || (Other.Instigator == none) || (ROPawn(Other) == none)
			|| !Pawn(Other).IsHumanControlled() )
		{
			return;
		}

		AnnounceTouch(Other.Instigator);
	}

	// Make sure no pawn already touching (while touch was disabled in sleep).
	function CheckTouching()
	{
		local Pawn P;

		ForEach TouchingActors(class'Pawn', P)
			Touch(P);
	}

	function UsedBy( Pawn user )
	{
    	local Inventory Copy;

		if( user != none  )
		{
			//log("In pickup, ROExplosiveWeapon(user.weapon).Ammo[0].MaxAmmo is "$ROExplosiveWeapon(user.weapon).Ammo[0].MaxAmmo);
			// if you have a full load of clips, you can't pick up a new one
			if( ROExplosiveWeapon(user.weapon) != none && ROExplosiveWeapon(user.weapon).AmmoMaxed(0) )
			{
				return;
			}

            // valid touch will pickup the object
			if( ValidTouch( user ) )
			{
				Copy = SpawnCopy(user);
				AnnouncePickup(user);
            	if ( Copy != None )
					Copy.PickupFunction(user);
            	Destroy();
			}
		}
	}

	function Timer()
	{
		self.Destroy();
		if ( bDropped )
			GotoState('ROFadeOut');
	}

	function BeginState()
	{
		if ( bDropped )
        {
			AddToNavigation();
		    SetTimer(DropLifeTime, false);
        }
	}

	function EndState()
	{
		if ( bDropped )
			RemoveFromNavigation();
	}

Begin:
	CheckTouching();
}

state ROFallingPickup extends Pickup
{
	ignores Touch;

	function CheckTouching()
	{
	}

	function Timer()
	{
		GotoState('ROFadeOut');
	}

	function BeginState()
	{
	    SetTimer(8, false);
	}
}

state ROFadeOut
{
	function BeginState()
	{
		Destroy();
		//LifeSpan = 0.0;
		//SetPhysics(PHYS_None);
	}
}

//=============================================================================
// Sleeping state: Sitting hidden waiting to respawn.
function float GetRespawnTime()
{
	return RespawnTime;
}

defaultproperties
{
    MessageClass=class'PickupMessagePlus'
    TouchMessageClass=class'ROTouchMessagePlus'
    DrawType=DT_StaticMesh
    DrawScale=1.0
    MaxDesireability=0
	CollisionRadius=+20.0
	CollisionHeight=+4.0
    Physics=PHYS_Falling
    AmmoAmount = 1
}
