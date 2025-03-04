// =================================================================================== *
// RODebugTracer
// Author: Ramm
// =================================================================================== *
//	A small tracer to aid in debugging.
// =================================================================================== */

class RODebugTracer extends actor;

defaultproperties
{
	DrawType=DT_StaticMesh
	StaticMesh=StaticMesh'DebugObjects.debugarrow1'
	DrawScale=1.0

	bHidden=false
	bBlockActors=false
	bBlockKarma=false
	bBlockNonZeroExtentTraces=false
	bBlockPlayers=false
	bBlockZeroExtentTraces=false
	bCollideActors=false
	bCollideWorld=false
	bUseCylinderCollision=false
	bStatic=false
	bWorldGeometry=false
}
