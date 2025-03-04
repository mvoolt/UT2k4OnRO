class RocketCorona extends Effects;

auto state Start
{
    simulated function Tick(float dt)
    {
        SetDrawScale(FMin(DrawScale + dt*2.0, 0.20));
        if (DrawScale >= 0.20)
        {
            SetDrawScale(0.20);
			GotoState('');
        }
    }
}

defaultproperties
{
    RemoteRole=ROLE_None
    Physics=PHYS_Trailer
    DrawType=DT_Sprite
    Style=STY_Additive//STY_Translucent
    Texture=Texture'Effects_Tex.fire_quad' // For Petes Sake REPLACEME
    Skins(0)=Texture'Effects_Tex.fire_quad' // For Petes Sake REPLACEME
    DrawScale=0.01
    //DrawScale3D=(X=0.35,Y=0.35,Z=0.35)
    bTrailerSameRotation=true
    bUnlit=true
    Mass=13.0
}
