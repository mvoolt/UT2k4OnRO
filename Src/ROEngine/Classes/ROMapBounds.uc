//=============================================================================
// ROMapBounds
//=============================================================================
// Used to define the borders of the map
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 John Gibson
//=============================================================================

class ROMapBounds extends Actor
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	bHidden=true
	bAlwaysRelevant=true
	RemoteRole=ROLE_DumbProxy
	//bSkipActorPropertyReplication=true
	bOnlyDirtyReplication=true
}
