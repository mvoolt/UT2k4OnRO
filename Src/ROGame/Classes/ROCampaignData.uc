class ROCampaignData extends Object;

var() string CurrentMap;

// Camera orientations for Matinee
enum MapState
{
	MS_None,
	MS_Allied,
	MS_Axis,
};


struct CampaignRecord
{
   var string MapName;
   var MapState MapWinner;
};

var array<CampaignRecord> CampaignMaps;
var string AlliedFinalMap;
var string AxisFinalMap;
var string StartMap;
var int MapNum;


defaultproperties
{
    CurrentMap="Default"
}
