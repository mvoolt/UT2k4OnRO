// =================================================================================== *
// RODebugTracerGreen
// Author: Ramm
// =================================================================================== *
//	A small green tracer to aid in debugging.
// =================================================================================== */

#exec OBJ LOAD FILE=..\StaticMeshes\DebugObjects.usx

class RODebugTracerGreen extends actor;

defaultproperties
{
	DrawType=DT_StaticMesh
	StaticMesh=StaticMesh'DebugObjects.debugarrow2'
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
