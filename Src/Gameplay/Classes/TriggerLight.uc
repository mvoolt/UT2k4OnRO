//=============================================================================
// TriggerLight.
// A lightsource which can be triggered on or off.
//=============================================================================
class TriggerLight extends Light;

//-----------------------------------------------------------------------------
// Variables.

var() float ChangeTime;        // Time light takes to change from on to off.
var() bool  bInitiallyOn;      // Whether it's initially on.
var() bool  bDelayFullOn;      // Delay then go full-on.
var() float RemainOnTime;      // How long the TriggerPound effect lasts

var   float InitialBrightness; // Initial brightness.
var   float Alpha, Direction;
var   actor SavedTrigger;
var   float poundTime;

//-----------------------------------------------------------------------------
// Engine functions.

// Called at start of gameplay.
simulated function BeginPlay()
{
	// Remember initial light type and set new one.
	InitialBrightness = LightBrightness;
	if( bInitiallyOn )
	{
		Alpha     = 1.0;
		Direction = 1.0;
	}
	else
	{
		Alpha     = 0.0;
		Direction = -1.0;
	}
	SetDrawType(DT_None);
}

// Called whenever time passes.
// if_RO_
simulated function Tick( float DeltaTime )
// else
//function Tick( float DeltaTime )
{
	Alpha += Direction * DeltaTime / ChangeTime;
	if( Alpha > 1.0 )
	{
		Alpha = 1.0;
		Disable( 'Tick' );
		if( SavedTrigger != None )
			SavedTrigger.EndEvent();
	}
	else if( Alpha < 0.0 )
	{
		Alpha = 0.0;
		Disable( 'Tick' );
		if( SavedTrigger != None )
			SavedTrigger.EndEvent();
	}
	if( !bDelayFullOn )
		LightBrightness = Alpha * InitialBrightness;
	else if( (Direction>0 && Alpha!=1) || Alpha==0 )
		LightBrightness = 0;
	else
		LightBrightness = InitialBrightness;
}

//-----------------------------------------------------------------------------
// Public states.

// Trigger turns the light on.
// if_RO_
simulated state() TriggerTurnsOn
// else
//state() TriggerTurnsOn
{
	// if_RO_
	simulated function Trigger( actor Other, pawn EventInstigator )
	// else
	//function Trigger( actor Other, pawn EventInstigator )
	{
		if( SavedTrigger!=None )
			SavedTrigger.EndEvent();
		SavedTrigger = Other;
		SavedTrigger.BeginEvent();
		Direction = 1.0;
		Enable( 'Tick' );
	}
}

// Trigger turns the light off.
// if_RO_
simulated state() TriggerTurnsOff
// else
//state() TriggerTurnsOff
{
	// if_RO_
	simulated function Trigger( actor Other, pawn EventInstigator )
	// else
	//function Trigger( actor Other, pawn EventInstigator )
	{
		if( SavedTrigger!=None )
			SavedTrigger.EndEvent();
		SavedTrigger = Other;
		SavedTrigger.BeginEvent();
		Direction = -1.0;
		Enable( 'Tick' );
	}
}

// Trigger toggles the light.
// if_RO_
simulated state() TriggerToggle
// else
//state() TriggerToggle
{
	// if_RO_
	simulated function Trigger( actor Other, pawn EventInstigator )
	// else
	//function Trigger( actor Other, pawn EventInstigator )
	{
		if( SavedTrigger!=None )
			SavedTrigger.EndEvent();
		SavedTrigger = Other;
		SavedTrigger.BeginEvent();
		Direction *= -1;
		Enable( 'Tick' );
	}
}

// Trigger controls the light.
simulated state() TriggerControl
// else
//state() TriggerControl
{
	// if_RO_
	simulated function Trigger( actor Other, pawn EventInstigator )
	// else
	//function Trigger( actor Other, pawn EventInstigator )
	{
		if( SavedTrigger!=None )
			SavedTrigger.EndEvent();
		SavedTrigger = Other;
		SavedTrigger.BeginEvent();
		if( bInitiallyOn ) Direction = -1.0;
		else               Direction = 1.0;
		Enable( 'Tick' );
	}
	// if_RO_
	simulated function UnTrigger( actor Other, pawn EventInstigator )
	// else
	//function UnTrigger( actor Other, pawn EventInstigator )
	{
		if( SavedTrigger!=None )
			SavedTrigger.EndEvent();
		SavedTrigger = Other;
		SavedTrigger.BeginEvent();
		if( bInitiallyOn ) Direction = 1.0;
		else               Direction = -1.0;
		Enable( 'Tick' );
	}
}
simulated state() TriggerPound
// else
//state() TriggerPound
{
	// if_RO_
	simulated function Timer ()
	// else
	//function Timer ()
	{

		if (poundTime >= RemainOnTime) {

			Disable ('Timer');
		}
		poundTime += ChangeTime;
		Direction *= -1;
		SetTimer (ChangeTime, false);
	}

	// if_RO_
	simulated function Trigger( actor Other, pawn EventInstigator )
	// else
	//function Trigger( actor Other, pawn EventInstigator )
	{

		if( SavedTrigger!=None )
			SavedTrigger.EndEvent();
		SavedTrigger = Other;
		SavedTrigger.BeginEvent();
		Direction = 1;
		poundTime = ChangeTime;			// how much time will pass till reversal
		SetTimer (ChangeTime, false);		// wake up when it's time to reverse
		Enable   ('Timer');
		Enable   ('Tick');
	}
}

defaultproperties
{
	RemoteRole=ROLE_SimulatedProxy
	 bHidden=False
     bStatic=False
     bMovable=True
     bDynamicLight=True
}
