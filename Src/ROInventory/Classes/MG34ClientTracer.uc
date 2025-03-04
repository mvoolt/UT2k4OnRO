//=============================================================================
// MG34ClientTracer
//=============================================================================
// Client side MG34 bullet with a tracer effect
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John Ramm-Jaeger" Gibson
//=============================================================================

class MG34ClientTracer extends ROClientTracer;

defaultproperties
{
	BallisticCoefficient=0.390
	Speed=37808 // 2363 fps
	SpeedFudgeScale=0.5
 	mTracerClass=class'ROEffects.ROGermanYellowOrangeTracer'
 	DrawType=DT_StaticMesh
 	StaticMesh=StaticMesh'EffectsSM.Ger_Tracer'
 	DeflectedMesh=StaticMesh'EffectsSM.Ger_Tracer_Ball'
 	DrawScale=2.0//3.5
}
