//=============================================================================
// ROSoundAttachment
//=============================================================================
// A generic actor which can be used to attach to other actors and given
// An ambient sound. Allows 3d positional audio effects while in vehicles
// and also allows multiple ambient sounds.
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 John Gibson
//=============================================================================

class ROSoundAttachment extends Actor;

defaultproperties
{
     DrawType=DT_None
     // Debug draw
     //DrawType=DT_Sprite
     //Texture=S_Actor
     //DrawScale=+00001.000000
	 //DrawScale3D=(X=1,Y=1,Z=1)
     SoundVolume=0
}
