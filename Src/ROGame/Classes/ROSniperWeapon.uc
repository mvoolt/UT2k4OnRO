//===================================================================
// ROSniperWeapon
// started by Antarian 8/5/03
//
// Copyright (C) 2003 John Gibson and Jeffrey Nakai
//
// Base class for the Red Orchestra Sniper Weapons
//===================================================================

class ROSniperWeapon extends ROProjectileWeapon
	abstract;

//=============================================================================
// Execs
//=============================================================================

#exec OBJ LOAD FILE=Weapons1st_tex.utx
#exec OBJ LOAD FILE=..\textures\ScopeShaders.utx
#exec OBJ LOAD FILE=InterfaceArt_tex.utx


//=============================================================================
// Variables
//=============================================================================

var()		int			lenseMaterialID;		// used since material id's seem to change alot

var()		float		scopePortalFOVHigh;		// The FOV to zoom the scope portal by.
var()		float		scopePortalFOV;			// The FOV to zoom the scope portal by.

// Not sure if these pitch vars are still needed now that we use Scripted Textures. We'll keep for now in case they are. - Ramm 08/14/04
var()		int			scopePitch;				// Tweaks the pitch of the scope firing angle
var()		int			scopeYaw;				// Tweaks the yaw of the scope firing angle
var()		int			scopePitchHigh;			// Tweaks the pitch of the scope firing angle high detail scope
var()		int			scopeYawHigh;			// Tweaks the yaw of the scope firing angle high detail scope

// 3d Scope vars
var   ScriptedTexture   ScopeScriptedTexture;   // Scripted texture for 3d scopes
var	  Shader		    ScopeScriptedShader;   	// The shader that combines the scripted texture with the sight overlay
var   Material          ScriptedTextureFallback;// The texture to render if the users system doesn't support shaders

// new scope vars
var   Combiner			ScriptedScopeCombiner;

var   texture           TexturedScopeTexture;

var	  bool				bInitializedScope;		// Set to true when the scope has been initialized

//=============================================================================
// Functions
//=============================================================================

//===========================================
// Used for debugging the weapons and scopes- Ramm
//===========================================

// Commented out for the release build
/*
exec function pfov(int thisFOV)
{
	if( !class'ROEngine.ROLevelInfo'.static.RODebugMode() )
		return;

	scopePortalFOV = thisFOV;
}

exec function pPitch(int num)
{
	if( !class'ROEngine.ROLevelInfo'.static.RODebugMode() )
		return;

	scopePitch = num;
	scopePitchHigh = num;
}

exec function pYaw(int num)
{
	if( !class'ROEngine.ROLevelInfo'.static.RODebugMode() )
		return;

	scopeYaw = num;
	scopeYawHigh = num;
}

simulated exec function TexSize(int i, int j)
{
	if( !class'ROEngine.ROLevelInfo'.static.RODebugMode() )
		return;

	ScopeScriptedTexture.SetSize(i, j);
}*/

// Helper function for the scope system. The scope system checks here to see when it should draw the portal.
// If you want to limit any times the portal should/shouldn't be drawn, add them here.
// Ramm 10/27/03
simulated function bool ShouldDrawPortal()
{
	local 	name	thisAnim;
	local	float 	animframe;
	local	float 	animrate;

	GetAnimParams(0, thisAnim,animframe,animrate);

	if(bUsingSights && (IsInState('Idle') || IsInState('PostFiring')) && thisAnim != 'scope_shoot_last')
		return true;
	else
		return false;
}

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

    // Get new scope detail value from ROWeapon
    ScopeDetail = class'ROEngine.ROWeapon'.default.ScopeDetail;

	UpdateScopeMode();
}

// Handles initializing and swithing between different scope modes
simulated function UpdateScopeMode()
{
	if (Level.NetMode != NM_DedicatedServer && Instigator != none && Instigator.IsLocallyControlled() &&
		Instigator.IsHumanControlled() )
    {
	    if( ScopeDetail == RO_ModelScope )
		{
			scopePortalFOV = default.scopePortalFOV;
			IronSightDisplayFOV = default.IronSightDisplayFOV;
			bPlayerFOVZooms = false;
			if (bUsingSights)
			{
				PlayerViewOffset = XoffsetScoped;
			}

			if( ScopeScriptedTexture == none )
			{
	        	ScopeScriptedTexture = ScriptedTexture(Level.ObjectPool.AllocateObject(class'ScriptedTexture'));
			}

	        ScopeScriptedTexture.FallBackMaterial = ScriptedTextureFallback;
	        ScopeScriptedTexture.SetSize(512,512);
	        ScopeScriptedTexture.Client = Self;

			if( ScriptedScopeCombiner == none )
			{
				// Construct the Combiner
				ScriptedScopeCombiner = Combiner(Level.ObjectPool.AllocateObject(class'Combiner'));
	            ScriptedScopeCombiner.Material1 = Texture'ScopeShaders.Zoomblur.Xhair';
	            ScriptedScopeCombiner.FallbackMaterial = Shader'ScopeShaders.Zoomblur.LensShader';
	            ScriptedScopeCombiner.CombineOperation = CO_Multiply;
	            ScriptedScopeCombiner.AlphaOperation = AO_Use_Mask;
	            ScriptedScopeCombiner.Material2 = ScopeScriptedTexture;
	        }

			if( ScopeScriptedShader == none )
			{
	            // Construct the scope shader
				ScopeScriptedShader = Shader(Level.ObjectPool.AllocateObject(class'Shader'));
				ScopeScriptedShader.Diffuse = ScriptedScopeCombiner;
				ScopeScriptedShader.SelfIllumination = ScriptedScopeCombiner;
				ScopeScriptedShader.FallbackMaterial = Shader'ScopeShaders.Zoomblur.LensShader';
			}

	        bInitializedScope = true;
		}
		else if( ScopeDetail == RO_ModelScopeHigh )
		{
			scopePortalFOV = scopePortalFOVHigh;
			IronSightDisplayFOV = default.IronSightDisplayFOVHigh;
			bPlayerFOVZooms = false;
			if (bUsingSights)
			{
				PlayerViewOffset = XoffsetHighDetail;
			}

			if( ScopeScriptedTexture == none )
			{
	        	ScopeScriptedTexture = ScriptedTexture(Level.ObjectPool.AllocateObject(class'ScriptedTexture'));
	        }
			ScopeScriptedTexture.FallBackMaterial = ScriptedTextureFallback;
	        ScopeScriptedTexture.SetSize(1024,1024);
	        ScopeScriptedTexture.Client = Self;

			if( ScriptedScopeCombiner == none )
			{
				// Construct the Combiner
				ScriptedScopeCombiner = Combiner(Level.ObjectPool.AllocateObject(class'Combiner'));
	            ScriptedScopeCombiner.Material1 = Texture'ScopeShaders.Zoomblur.Xhair';
	            ScriptedScopeCombiner.FallbackMaterial = Shader'ScopeShaders.Zoomblur.LensShader';
	            ScriptedScopeCombiner.CombineOperation = CO_Multiply;
	            ScriptedScopeCombiner.AlphaOperation = AO_Use_Mask;
	            ScriptedScopeCombiner.Material2 = ScopeScriptedTexture;
	        }

			if( ScopeScriptedShader == none )
			{
	            // Construct the scope shader
				ScopeScriptedShader = Shader(Level.ObjectPool.AllocateObject(class'Shader'));
				ScopeScriptedShader.Diffuse = ScriptedScopeCombiner;
				ScopeScriptedShader.SelfIllumination = ScriptedScopeCombiner;
				ScopeScriptedShader.FallbackMaterial = Shader'ScopeShaders.Zoomblur.LensShader';
			}

            bInitializedScope = true;
		}
		else if (ScopeDetail == RO_TextureScope)
		{
			IronSightDisplayFOV = default.IronSightDisplayFOV;
			PlayerViewOffset.X = default.PlayerViewOffset.X;
			bPlayerFOVZooms = true;

			bInitializedScope = true;
		}
	}
}

simulated event RenderOverlays( Canvas Canvas )
{
	local int m;
    local rotator RollMod;
    local ROPlayer Playa;
	//For lean - Justin
	local ROPawn rpawn;
	local int leanangle;
	// Drawpos actor
	local rotator RotOffset;
	local float posx, overlap;

    if (Instigator == None)
    	return;

    // Lets avoid having to do multiple casts every tick - Ramm
    Playa = ROPlayer(Instigator.Controller);

    if(!bInitializedScope && Playa != none )
    {
    	  UpdateScopeMode();
    }

    // draw muzzleflashes/smoke for all fire modes so idle state won't
    // cause emitters to just disappear
	Canvas.DrawActor(None, false, true); // amb: Clear the z-buffer here

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
    	if (FireMode[m] != None)
        {
        	FireMode[m].DrawMuzzleFlash(Canvas);
        }
    }

	// these seem to set the current position and rotation of the weapon
	// in relation to the player

	//Adjust weapon position for lean
	rpawn = ROPawn(Instigator);
	if (rpawn != none && rpawn.LeanAmount != 0)
	{
		leanangle += rpawn.LeanAmount;
	}

	SetLocation( Instigator.Location + Instigator.CalcDrawOffset(self) );

	if( bUsesFreeAim && !bUsingSights )
	{
    	// Remove the roll component so the weapon doesn't tilt with the terrain
    	RollMod = Instigator.GetViewRotation();

    	if( Playa != none )
		{
			RollMod.Pitch += Playa.WeaponBufferRotation.Pitch;
			RollMod.Yaw += Playa.WeaponBufferRotation.Yaw;

			RotOffset.Pitch -= Playa.WeaponBufferRotation.Pitch;
			RotOffset.Yaw -= Playa.WeaponBufferRotation.Yaw;
    	}

		RollMod.Roll += leanangle;

		if( IsCrawling() )
		{
			RollMod.Pitch = CrawlWeaponPitch;
			RotOffset.Pitch = CrawlWeaponPitch;
		}
    }
    else
    {
    	RollMod = Instigator.GetViewRotation();
		RollMod.Roll += leanangle;

		if( IsCrawling() )
		{
			RollMod.Pitch = CrawlWeaponPitch;
			RotOffset.Pitch = CrawlWeaponPitch;
		}
   	}

 	if(bUsingSights && Playa != none && (ScopeDetail == RO_ModelScope || ScopeDetail == RO_ModelScopeHigh))
 	{
 		if (ShouldDrawPortal())
 		{
			if ( ScopeScriptedTexture != none )
			{
				Skins[LenseMaterialID] = ScopeScriptedShader;
				ScopeScriptedTexture.Client = Self;   // Need this because this can get corrupted - Ramm
				ScopeScriptedTexture.Revision = (ScopeScriptedTexture.Revision +1);
			}
 		}

		bDrawingFirstPerson = true;
 	    Canvas.DrawBoundActor(self, false, false,DisplayFOV,Playa.Rotation,Playa.WeaponBufferRotation,Instigator.CalcZoomedDrawOffset(self));
      	bDrawingFirstPerson = false;
 	}
    // Added "bInIronViewCheck here. Hopefully it prevents us getting the scope overlay when not zoomed.
    // Its a bit of a band-aid solution, but it will work til we get to the root of the problem - Ramm 08/12/04
	else if( ScopeDetail == RO_TextureScope && bPlayerViewIsZoomed && bUsingSights)
 	{
		Skins[LenseMaterialID] = ScriptedTextureFallback;

        if ( !bUsingSights )
        {
           log("Warning, drawing overlay texture and we aren't zoomed!!!");
        }

		Canvas.DrawColor.A = 255;
    	Canvas.Style = ERenderStyle.STY_Alpha;

    	// Calculate reticle drawing position (and position to draw black bars at)
        posx = float(Canvas.SizeX - Canvas.SizeY) / 2.0;

        // Draw the reticle
		Canvas.SetPos(posx, 0);
      	Canvas.DrawTile(TexturedScopeTexture, Canvas.SizeY, Canvas.SizeY, 0.0, 0.0, TexturedScopeTexture.USize, TexturedScopeTexture.VSize );

		// Draw black bars on the sides
		overlap = 58.0 / float(TexturedScopeTexture.VSize) * Canvas.SizeY;
		Canvas.SetPos(0, 0);
		Canvas.DrawTile(Texture'Engine.BlackTexture', posx + overlap, Canvas.SizeY, 0, 0, 8, 8);
		Canvas.SetPos(Canvas.SizeX - posx - overlap, 0);
		Canvas.DrawTile(Texture'Engine.BlackTexture', posx + overlap, Canvas.SizeY, 0, 0, 8, 8);

 	}
 	else
 	{
		Skins[LenseMaterialID] = ScriptedTextureFallback;
		SetRotation( RollMod );
		bDrawingFirstPerson = true;
		Canvas.DrawActor(self, false, false, DisplayFOV);
		bDrawingFirstPerson = false;
 	}
}

simulated event RenderTexture(ScriptedTexture Tex)
{
    local rotator RollMod;
    local ROPawn Rpawn;

    RollMod = Instigator.GetViewRotation();

	Rpawn = ROPawn(Instigator);
	// Subtract roll from view while leaning - Ramm
	if (Rpawn != none && rpawn.LeanAmount != 0)
	{
		RollMod.Roll += rpawn.LeanAmount;
	}

    if(Owner != none && Instigator != none && Tex != none && Tex.Client != none)
        Tex.DrawPortal(0,0,Tex.USize,Tex.VSize,Owner,(Instigator.Location + Instigator.EyePosition()), RollMod,  scopePortalFOV );
}

simulated state IronSightZoomIn
{
    simulated function EndState()
    {
		local float TargetDisplayFOV;
		local vector TargetPVO;

		if( Instigator.IsLocallyControlled() && Instigator.IsHumanControlled() )
		{
			if( ScopeDetail == RO_ModelScopeHigh )
			{
				TargetDisplayFOV = Default.IronSightDisplayFOVHigh;
				TargetPVO = Default.XoffsetHighDetail;
			}
			else if( ScopeDetail == RO_ModelScope )
			{
				TargetDisplayFOV = Default.IronSightDisplayFOV;
				TargetPVO = Default.XoffsetScoped;
			}
			else
			{
				TargetDisplayFOV = Default.IronSightDisplayFOV;
				TargetPVO = Default.PlayerViewOffset;
			}

			DisplayFOV = TargetDisplayFOV;
			PlayerViewOffset = TargetPVO;
		}

    	if( Instigator.IsLocallyControlled() && bPlayerFOVZooms)
		{
			PlayerViewZoom(true);
		}
	}
}

simulated state IronSightZoomOut
{
    simulated function BeginState()
    {
		if( Instigator.IsLocallyControlled() )
		{
	    	PlayAnim(IronPutDown, 1.0, 0.2 );

	    	if( bPlayerFOVZooms )
	    		PlayerViewZoom(false);
		}

	    SetTimer(GetAnimDuration(IronPutDown, 1.0) + FastTweenTime,false);
	}
}


simulated event Destroyed()
{
    if (ScopeScriptedTexture != None)
    {
        ScopeScriptedTexture.Client = None;
        Level.ObjectPool.FreeObject(ScopeScriptedTexture);
        ScopeScriptedTexture=None;
    }

    if (ScriptedScopeCombiner != None)
    {
		ScriptedScopeCombiner.Material2 = none;
		Level.ObjectPool.FreeObject(ScriptedScopeCombiner);
		ScriptedScopeCombiner = none;
    }

    if (ScopeScriptedShader != None)
    {
		ScopeScriptedShader.Diffuse = none;
		ScopeScriptedShader.SelfIllumination = none;
		Level.ObjectPool.FreeObject(ScopeScriptedShader);
		ScopeScriptedShader = none;
    }

    Super.Destroyed();
}

simulated function PreTravelCleanUp()
{
    if (ScopeScriptedTexture != None)
    {
        ScopeScriptedTexture.Client = None;
        Level.ObjectPool.FreeObject(ScopeScriptedTexture);
        ScopeScriptedTexture=None;
    }

    if (ScriptedScopeCombiner != None)
    {
		ScriptedScopeCombiner.Material2 = none;
		Level.ObjectPool.FreeObject(ScriptedScopeCombiner);
		ScriptedScopeCombiner = none;
    }

    if (ScopeScriptedShader != None)
    {
		ScopeScriptedShader.Diffuse = none;
		ScopeScriptedShader.SelfIllumination = none;
		Level.ObjectPool.FreeObject(ScopeScriptedShader);
		ScopeScriptedShader = none;
    }
}

//=============================================================================
// Default Properties
//=============================================================================


defaultproperties
{
/* RO SPECIFIC VARIABLES */
	bPlayerFOVZooms = false
	bIsSniper = true
 	bCanAttachOnBack = true
 	FreeAimRotationSpeed=6.0

	// new Portal Scope variable - Ramm
	scopePitch = 0

	//ScopeScriptedTexture=ScriptedTexture'ScopeShaders.ScriptedLense'
	//ScopeScriptedShader=Material'ScopeShaders.Zoomblur.LenseShaderScripted'
	ScriptedTextureFallback=Material'Weapons1st_tex.Zoomscope.LensShader'

	TexturedScopeTexture=none
	ScopeScriptedTexture=none
}
