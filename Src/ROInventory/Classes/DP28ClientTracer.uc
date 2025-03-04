//=============================================================================
// DP28ClientTracer
//=============================================================================
// Client side DP28 bullet with a tracer effect
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John Ramm-Jaeger" Gibson
//=============================================================================

class DP28ClientTracer extends ROClientTracer;

defaultproperties
{
	BallisticCoefficient=0.370
	Speed=44082 // 2760 fps
	SpeedFudgeScale=0.5
 	mTracerClass = class'ROEffects.RORussianGreenTracer'
 	DrawType=DT_StaticMesh
 	StaticMesh=StaticMesh'EffectsSM.Russ_Tracer'
 	DeflectedMesh=StaticMesh'EffectsSM.Russ_Tracer_Ball'
 	DrawScale=2.0//3.5
}
