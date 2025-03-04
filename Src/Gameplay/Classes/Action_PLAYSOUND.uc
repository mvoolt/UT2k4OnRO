class ACTION_PlaySound extends ScriptedAction;

var(Action)		sound	Sound;
var(Action)		float	Volume;
var(Action)		float	Pitch;
var(Action)		bool	bAttenuate;

function bool InitActionFor(ScriptedController C)
{
	// play appropriate sound
	if ( Sound != None )
		C.GetSoundSource().PlaySound(Sound,SLOT_Interact,Volume,true,,Pitch,bAttenuate);
	return false;	
}

function string GetActionString()
{
	return ActionString@Sound;
}

defaultproperties
{
	ActionString="play sound"
	Volume=+1.0
	Pitch=+1.0
	bAttenuate=true
}
