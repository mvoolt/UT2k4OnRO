//=============================================================================
// ROSteamStatsAndAchievements
//=============================================================================
// Red Orchestra's Steam Stats/Achievements
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2009 Tripwire Interactive LLC
// Created by Dayle Flowers
//=============================================================================

class ROSteamStatsAndAchievements extends SteamStatsAndAchievementsBase;

//=============================================================================
// Stats
//=============================================================================
const ROSTAT_WonArad				= 0;
const ROSTAT_WonBaksanValley		= 1;
const ROSTAT_WonBarashka			= 2;
const ROSTAT_WonBasovka				= 3;
const ROSTAT_WonBerezina			= 4;
const ROSTAT_WonBlackDayJuly		= 5;
const ROSTAT_WonBondarevo			= 6;
const ROSTAT_WonDanzig				= 7;
const ROSTAT_WonFallenHeroes		= 8;
const ROSTAT_WonHedgeHog			= 9;
const ROSTAT_WonKaukasus			= 10;
const ROSTAT_WonKonigsplatz			= 11;
const ROSTAT_WonKrasnyiOktyabr		= 12;
const ROSTAT_WonKrivoiRog			= 13;
const ROSTAT_WonKryukovo			= 14;
const ROSTAT_WonKurlandKessel		= 15;
const ROSTAT_WonLeningrad			= 16;
const ROSTAT_WonLyesKrovy			= 17;
const ROSTAT_WonMannikkala			= 18;
const ROSTAT_WonOdessa				= 19;
const ROSTAT_WonOgledow				= 20;
const ROSTAT_WonRakowice			= 21;
const ROSTAT_WonSmolenskStalemate	= 22;
const ROSTAT_WonStaligradKessel		= 23;
const ROSTAT_WonTcherkassy			= 24;
const ROSTAT_WonTulaOutskirts		= 25;
const ROSTAT_WonZhitomir1941		= 26;
const ROSTAT_CommanderKills			= 27;
const ROSTAT_KnockedOutTracks		= 28;
const ROSTAT_LMGKills				= 29;
const ROSTAT_MeleeKills				= 30;
const ROSTAT_MGResupplies			= 31;
const ROSTAT_SniperKills			= 32;
const ROSTAT_Kills					= 33;

// Map Won Stats(0 = Haven't Won, 1 = Won As German, 2 = Won As Russian, 3 = Won As Both)
var	const SteamStatInt 	WonArad;
var int					SavedWonArad;
var	const SteamStatInt 	WonBaksanValley;
var int					SavedWonBaksanValley;
var	const SteamStatInt 	WonBarashka;
var int					SavedWonBarashka;
var	const SteamStatInt 	WonBasovka;
var int					SavedWonBasovka;
var	const SteamStatInt 	WonBerezina;
var int					SavedWonBerezina;
var	const SteamStatInt 	WonBlackDayJuly;
var int					SavedWonBlackDayJuly;
var	const SteamStatInt 	WonBondarevo;
var int					SavedWonBondarevo;
var	const SteamStatInt 	WonDanzig;
var int					SavedWonDanzig;
var	const SteamStatInt 	WonFallenHeroes;
var int					SavedWonFallenHeroes;
var	const SteamStatInt 	WonHedgeHog;
var int					SavedWonHedgeHog;
var	const SteamStatInt 	WonKaukasus;
var int					SavedWonKaukasus;
var	const SteamStatInt 	WonKonigsplatz;
var int					SavedWonKonigsplatz;
var	const SteamStatInt 	WonKrasnyiOktyabr;
var int					SavedWonKrasnyiOktyabr;
var	const SteamStatInt 	WonKrivoiRog;
var int					SavedWonKrivoiRog;
var	const SteamStatInt 	WonKryukovo;
var int					SavedWonKryukovo;
var	const SteamStatInt 	WonKurlandKessel;
var int					SavedWonKurlandKessel;
var	const SteamStatInt 	WonLeningrad;
var int					SavedWonLeningrad;
var	const SteamStatInt 	WonLyesKrovy;
var int					SavedWonLyesKrovy;
var	const SteamStatInt 	WonMannikkala;
var int					SavedWonMannikkala;
var	const SteamStatInt 	WonOdessa;
var int					SavedWonOdessa;
var	const SteamStatInt 	WonOgledow;
var int					SavedWonOgledow;
var	const SteamStatInt 	WonRakowice;
var int					SavedWonRakowice;
var	const SteamStatInt 	WonSmolenskStalemate;
var int					SavedWonSmolenskStalemate;
var	const SteamStatInt 	WonStaligradKessel;
var int					SavedWonStaligradKessel;
var	const SteamStatInt 	WonTcherkassy;
var int					SavedWonTcherkassy;
var	const SteamStatInt 	WonTulaOutskirts;
var int					SavedWonTulaOutskirts;
var	const SteamStatInt 	WonZhitomir1941;
var int					SavedWonZhitomir1941;

// Capture All Objectives Stats
var	bool	bInAllCapturesWithoutDying;
var	bool	bRussianSquadLeaderInAllCaptures;

// Destroy Fully Loaded Halftrack or UniCarrier Stats
var	bool				bDestroyedHalftrack;
var	bool				bDestroyedUniCarrier;
var	const SteamStatInt 	PassengerCountStat;

// Misc Stats
var	const SteamStatInt	CommanderKillsStat;
var	int					SavedCommanderKillsStat;
var	const SteamStatInt	KnockedOutTracksStat;
var	int					SavedKnockedOutTracksStat;
var	const SteamStatInt	DestroyedTanksWithPanzerfausts;
var	const SteamStatInt	DestroyedTanksWithPTRD;
var	const SteamStatInt	LMGKillsStat;
var	int					SavedLMGKillsStat;
var	const SteamStatInt	EnemyTanksKilledThisMatch;
var	const SteamStatInt	MeleeKillsStat;
var	int					SavedMeleeKillsStat;
var	const SteamStatInt	InfantryKilledWithTankShellsStat;
var	const SteamStatInt	MGResuppliesStat;
var	int					SavedMGResuppliesStat;
var	const SteamStatInt	DestroyedVehiclesFromTigerStat;
var	const SteamStatInt	SniperKillsStat;
var	int					SavedSniperKillsStat;
var	const SteamStatInt	KillsAsAssaultStat;
var	const SteamStatInt	ArtilleryKillsStat;
var	const SteamStatInt	NonSniperKillsWithEnemySniperRifleStat;
var	const SteamStatInt	KillsStat;
var	int					SavedKillsStat;

//=============================================================================
// Achievements
//=============================================================================
const ROACHIEVEMENT_WinAllMapsGerman					= 0;
const ROACHIEVEMENT_WinAllMapsRussian					= 1;
const ROACHIEVEMENT_Kill1TankCommander					= 2;
const ROACHIEVEMENT_Kill10TankCommanders				= 3;
const ROACHIEVEMENT_Kill25TankCommanders				= 4;
const ROACHIEVEMENT_KillFrom100MetersWithBolt			= 5;
const ROACHIEVEMENT_KillFrom200MetersWithBolt			= 6;
const ROACHIEVEMENT_KillFrom400MetersWithBolt			= 7;
const ROACHIEVEMENT_DestroyTankFrom1000Meters			= 8;
const ROACHIEVEMENT_DestroyTankFrom1500Meters			= 9;
const ROACHIEVEMENT_DestroyTankFrom2000Meters			= 10;
const ROACHIEVEMENT_KnockOff1TanksTracks				= 11;
const ROACHIEVEMENT_KnockOff10TanksTracks				= 12;
const ROACHIEVEMENT_KnockOff20TanksTracks				= 13;
const ROACHIEVEMENT_Destroy3TanksWithPanzerfausts		= 14;
const ROACHIEVEMENT_Destroy3TanksWithPTRD				= 15;
const ROACHIEVEMENT_Kill200EnemiesWithLMG				= 16;
const ROACHIEVEMENT_Kill500EnemiesWithLMG				= 17;
const ROACHIEVEMENT_Kill1000EnemiesWithLMG				= 18;
const ROACHIEVEMENT_DestroyTigerTankWithT3476			= 19;
const ROACHIEVEMENT_Destroy25TanksInOneMatch			= 20;
const ROACHIEVEMENT_MeleeKill25Enemies					= 21;
const ROACHIEVEMENT_MeleeKill100Enemies					= 22;
const ROACHIEVEMENT_MeleeKill500Enemies					= 23;
const ROACHIEVEMENT_Kill10InfantryWithTankShells		= 24;
const ROACHIEVEMENT_Resupply10MGers						= 25;
const ROACHIEVEMENT_Resupply100MGers					= 26;
const ROACHIEVEMENT_Resupply250MGers					= 27;
const ROACHIEVEMENT_Destroy5VehiclesWithTiger			= 28;
const ROACHIEVEMENT_Destroy10VehiclesWithTiger			= 29;
const ROACHIEVEMENT_Destroy20VehiclesWithTiger			= 30;
const ROACHIEVEMENT_Kill50EnemiesWithSniperRifle		= 31;
const ROACHIEVEMENT_Kill200EnemiesWithSniperRifle		= 32;
const ROACHIEVEMENT_Kill500EnemiesWithSniperRifle		= 33;
const ROACHIEVEMENT_KillSniperAsSniper					= 34;
const ROACHIEVEMENT_Kill10EnemiesAsAssaultClass			= 35;
const ROACHIEVEMENT_Kill10EnemiesInOneArtillery			= 36;
const ROACHIEVEMENT_CapAllObjectivesWithoutDying		= 37;
const ROACHIEVEMENT_RussianSLCapAllObjectives			= 38;
const ROACHIEVEMENT_NonSniperKill10WithEnemySniperRifle	= 39;
const ROACHIEVEMENT_DestroyFullyLoadedAPC				= 40;
const ROACHIEVEMENT_10Kills								= 41;
const ROACHIEVEMENT_50Kills 							= 42;
const ROACHIEVEMENT_100Kills 							= 43;

// Achievement Status
var	bool	bWinAllMapsGermanCompleted;
var	bool	bWinAllMapsRussianCompleted;
var	bool	bKill1TankCommanderCompleted;
var	bool	bKill10TankCommandersCompleted;
var	bool	bKill25TankCommandersCompleted;
var	bool	bKillFrom100MetersWithBoltCompleted;
var	bool	bKillFrom200MetersWithBoltCompleted;
var	bool	bKillFrom400MetersWithBoltCompleted;
var	bool	bDestroyTankFrom1000MetersCompleted;
var	bool	bDestroyTankFrom1500MetersCompleted;
var	bool	bDestroyTankFrom2000MetersCompleted;
var	bool	bKnockOff1TanksTracksCompleted;
var	bool	bKnockOff10TanksTracksCompleted;
var	bool	bKnockOff20TanksTracksCompleted;
var	bool	bDestroy3TanksWithPanzerfaustsCompleted;
var	bool	bDestroy3TanksWithPTRDCompleted;
var	bool	bKill200EnemiesWithLMGCompleted;
var	bool	bKill500EnemiesWithLMGCompleted;
var	bool	bKill1000EnemiesWithLMGCompleted;
var	bool	bDestroyTigerTankWithT3476Completed;
var	bool	bDestroy25TanksInOneMatchCompleted;
var	bool	bMeleeKill25EnemiesCompleted;
var	bool	bMeleeKill100EnemiesCompleted;
var	bool	bMeleeKill500EnemiesCompleted;
var	bool	bKill10InfantryWithTankShellsCompleted;
var	bool	bResupply10MGersCompleted;
var	bool	bResupply100MGersCompleted;
var	bool	bResupply250MGersCompleted;
var	bool	bDestroy5VehiclesWithTigerCompleted;
var	bool	bDestroy10VehiclesWithTigerCompleted;
var	bool	bDestroy20VehiclesWithTigerCompleted;
var	bool	bKill50EnemiesWithSniperRifleCompleted;
var	bool	bKill200EnemiesWithSniperRifleCompleted;
var	bool	bKill500EnemiesWithSniperRifleCompleted;
var	bool	bKillSniperAsSniperCompleted;
var	bool	bKill10EnemiesAsAssaultClassCompleted;
var	bool	bKill10EnemiesInOneArtilleryCompleted;
var	bool	bCapAllObjectivesWithoutDyingCompleted;
var	bool	bRussianSLCapAllObjectivesCompleted;
var	bool	bNonSniperKill10WithEnemySniperRifleCompleted;
var	bool	bDestroyFullyLoadedAPCCompleted;
var	bool	b10KillsAchievementCompleted;
var	bool	b50KillsAchievementCompleted;
var	bool	b100KillsAchievementCompleted;

replication
{
	reliable if ( bFlushStatsToClient && Role == ROLE_Authority )
		WonArad, WonBaksanValley, WonBarashka, WonBasovka, WonBerezina, WonBlackDayJuly,
		WonBondarevo, WonDanzig, WonFallenHeroes, WonHedgeHog, WonKaukasus, WonKonigsplatz,
		WonKrasnyiOktyabr, WonKrivoiRog, WonKryukovo, WonKurlandKessel, WonLeningrad,
		WonLyesKrovy, WonMannikkala, WonOdessa, WonOgledow, WonRakowice, WonSmolenskStalemate,
		WonStaligradKessel, WonTcherkassy, WonTulaOutskirts, WonZhitomir1941,
		CommanderKillsStat, KnockedOutTracksStat, LMGKillsStat, MeleeKillsStat,
		MGResuppliesStat, SniperKillsStat, KillsStat;
}

// Used to only send the Stats/Achievements that have changed to Steam
simulated event PostNetReceive()
{
	local bool bFlushStatsToDatabase;

	if ( bDebugStats )
		log("STEAMSTATS: PostNetReceive called");

	if ( WonArad.Value != SavedWonArad )
	{
		FlushStatToSteamInt(WonArad, SteamNameStat[ROSTAT_WonArad]);

		SavedWonArad = WonArad.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonBaksanValley.Value != SavedWonBaksanValley )
	{
		FlushStatToSteamInt(WonBaksanValley, SteamNameStat[ROSTAT_WonBaksanValley]);

		SavedWonBaksanValley = WonBaksanValley.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonBarashka.Value != SavedWonBarashka )
	{
		FlushStatToSteamInt(WonBarashka, SteamNameStat[ROSTAT_WonBarashka]);

		SavedWonBarashka = WonBarashka.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonBasovka.Value != SavedWonBasovka )
	{
		FlushStatToSteamInt(WonBasovka, SteamNameStat[ROSTAT_WonBasovka]);

		SavedWonBasovka = WonBasovka.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonBerezina.Value != SavedWonBerezina )
	{
		FlushStatToSteamInt(WonBerezina, SteamNameStat[ROSTAT_WonBerezina]);

		SavedWonBerezina = WonBerezina.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonBlackDayJuly.Value != SavedWonBlackDayJuly )
	{
		FlushStatToSteamInt(WonBlackDayJuly, SteamNameStat[ROSTAT_WonBlackDayJuly]);

		SavedWonBlackDayJuly = WonBlackDayJuly.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonBondarevo.Value != SavedWonBondarevo )
	{
		FlushStatToSteamInt(WonBondarevo, SteamNameStat[ROSTAT_WonBondarevo]);

		SavedWonBondarevo = WonBondarevo.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonDanzig.Value != SavedWonDanzig )
	{
		FlushStatToSteamInt(WonDanzig, SteamNameStat[ROSTAT_WonDanzig]);

		SavedWonDanzig = WonDanzig.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonFallenHeroes.Value != SavedWonFallenHeroes )
	{
		FlushStatToSteamInt(WonFallenHeroes, SteamNameStat[ROSTAT_WonFallenHeroes]);

		SavedWonFallenHeroes = WonFallenHeroes.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonHedgeHog.Value != SavedWonHedgeHog )
	{
		FlushStatToSteamInt(WonHedgeHog, SteamNameStat[ROSTAT_WonHedgeHog]);

		SavedWonHedgeHog = WonHedgeHog.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonKaukasus.Value != SavedWonKaukasus )
	{
		FlushStatToSteamInt(WonKaukasus, SteamNameStat[ROSTAT_WonKaukasus]);

		SavedWonKaukasus = WonKaukasus.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonKonigsplatz.Value != SavedWonKonigsplatz )
	{
		FlushStatToSteamInt(WonKonigsplatz, SteamNameStat[ROSTAT_WonKonigsplatz]);

		SavedWonKonigsplatz = WonKonigsplatz.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonKrasnyiOktyabr.Value != SavedWonKrasnyiOktyabr )
	{
		FlushStatToSteamInt(WonKrasnyiOktyabr, SteamNameStat[ROSTAT_WonKrasnyiOktyabr]);

		SavedWonKrasnyiOktyabr = WonKrasnyiOktyabr.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonKrivoiRog.Value != SavedWonKrivoiRog )
	{
		FlushStatToSteamInt(WonKrivoiRog, SteamNameStat[ROSTAT_WonKrivoiRog]);

		SavedWonKrivoiRog = WonKrivoiRog.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonKryukovo.Value != SavedWonKryukovo )
	{
		FlushStatToSteamInt(WonKryukovo, SteamNameStat[ROSTAT_WonKryukovo]);

		SavedWonKryukovo = WonKryukovo.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonKurlandKessel.Value != SavedWonKurlandKessel )
	{
		FlushStatToSteamInt(WonKurlandKessel, SteamNameStat[ROSTAT_WonKurlandKessel]);

		SavedWonKurlandKessel = WonKurlandKessel.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonLeningrad.Value != SavedWonLeningrad )
	{
		FlushStatToSteamInt(WonLeningrad, SteamNameStat[ROSTAT_WonLeningrad]);

		SavedWonLeningrad = WonLeningrad.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonLyesKrovy.Value != SavedWonLyesKrovy )
	{
		FlushStatToSteamInt(WonLyesKrovy, SteamNameStat[ROSTAT_WonLyesKrovy]);

		SavedWonLyesKrovy = WonLyesKrovy.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonMannikkala.Value != SavedWonMannikkala )
	{
		FlushStatToSteamInt(WonMannikkala, SteamNameStat[ROSTAT_WonMannikkala]);

		SavedWonMannikkala = WonMannikkala.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonOdessa.Value != SavedWonOdessa )
	{
		FlushStatToSteamInt(WonOdessa, SteamNameStat[ROSTAT_WonOdessa]);

		SavedWonOdessa = WonOdessa.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonOgledow.Value != SavedWonOgledow )
	{
		FlushStatToSteamInt(WonOgledow, SteamNameStat[ROSTAT_WonOgledow]);

		SavedWonOgledow = WonOgledow.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonRakowice.Value != SavedWonRakowice )
	{
		FlushStatToSteamInt(WonRakowice, SteamNameStat[ROSTAT_WonRakowice]);

		SavedWonRakowice = WonRakowice.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonSmolenskStalemate.Value != SavedWonSmolenskStalemate )
	{
		FlushStatToSteamInt(WonSmolenskStalemate, SteamNameStat[ROSTAT_WonSmolenskStalemate]);

		SavedWonSmolenskStalemate = WonSmolenskStalemate.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonStaligradKessel.Value != SavedWonStaligradKessel )
	{
		FlushStatToSteamInt(WonStaligradKessel, SteamNameStat[ROSTAT_WonStaligradKessel]);

		SavedWonStaligradKessel = WonStaligradKessel.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonTcherkassy.Value != SavedWonTcherkassy )
	{
		FlushStatToSteamInt(WonTcherkassy, SteamNameStat[ROSTAT_WonTcherkassy]);

		SavedWonTcherkassy = WonTcherkassy.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonTulaOutskirts.Value != SavedWonTulaOutskirts )
	{
		FlushStatToSteamInt(WonTulaOutskirts, SteamNameStat[ROSTAT_WonTulaOutskirts]);

		SavedWonTulaOutskirts = WonTulaOutskirts.Value;
		bFlushStatsToDatabase = true;
	}

	if ( WonZhitomir1941.Value != SavedWonZhitomir1941 )
	{
		FlushStatToSteamInt(WonZhitomir1941, SteamNameStat[ROSTAT_WonZhitomir1941]);

		SavedWonZhitomir1941 = WonZhitomir1941.Value;
		bFlushStatsToDatabase = true;
	}

	if ( CommanderKillsStat.Value != SavedCommanderKillsStat )
	{
		if ( bDebugStats )
			log("STEAMSTATS: Sending Commander Kills off to Steam - NewValue="$CommanderKillsStat.Value);

		FlushStatToSteamInt(CommanderKillsStat, SteamNameStat[ROSTAT_CommanderKills]);

		SavedCommanderKillsStat = CommanderKillsStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( KnockedOutTracksStat.Value != SavedKnockedOutTracksStat )
	{
		if ( bDebugStats )
			log("STEAMSTATS: Sending Knocked Out Tracks off to Steam - NewValue="$KnockedOutTracksStat.Value);

		FlushStatToSteamInt(KnockedOutTracksStat, SteamNameStat[ROSTAT_KnockedOutTracks]);

		SavedKnockedOutTracksStat = KnockedOutTracksStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( LMGKillsStat.Value != SavedLMGKillsStat )
	{
		if ( bDebugStats )
			log("STEAMSTATS: Sending LMG Kills off to Steam - NewValue="$LMGKillsStat.Value);

		FlushStatToSteamInt(LMGKillsStat, SteamNameStat[ROSTAT_LMGKills]);

		SavedLMGKillsStat = LMGKillsStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( MeleeKillsStat.Value != SavedMeleeKillsStat )
	{
		if ( bDebugStats )
			log("STEAMSTATS: Sending Melee Kills off to Steam - NewValue="$MeleeKillsStat.Value);

		FlushStatToSteamInt(MeleeKillsStat, SteamNameStat[ROSTAT_MeleeKills]);

		SavedMeleeKillsStat = MeleeKillsStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( MGResuppliesStat.Value != SavedMGResuppliesStat )
	{
		if ( bDebugStats )
			log("STEAMSTATS: Sending MG Resupplies off to Steam - NewValue="$MGResuppliesStat.Value);

		FlushStatToSteamInt(MGResuppliesStat, SteamNameStat[ROSTAT_MGResupplies]);

		SavedMGResuppliesStat = MGResuppliesStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( SniperKillsStat.Value != SavedSniperKillsStat )
	{
		if ( bDebugStats )
			log("STEAMSTATS: Sending Sniper Kills off to Steam - NewValue="$SniperKillsStat.Value);

		FlushStatToSteamInt(SniperKillsStat, SteamNameStat[ROSTAT_SniperKills]);

		SavedSniperKillsStat = SniperKillsStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( KillsStat.Value != SavedKillsStat )
	{
		if ( bDebugStats )
			log("STEAMSTATS: Sending Kills off to Steam - NewValue="$KillsStat.Value);

		FlushStatToSteamInt(KillsStat, SteamNameStat[ROSTAT_Kills]);

		SavedKillsStat = KillsStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( bFlushStatsToDatabase )
	{
		FlushStatsToSteamDatabase();
	}
}

// Event Callback for each GetStatsAndAchievements call
// NETWORK: Client only
simulated event OnStatsAndAchievementsReady()
{
	GetStatInt(WonArad, SteamNameStat[ROSTAT_WonArad]);
	SavedWonArad = WonArad.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonArad, WonArad.Value);

	GetStatInt(WonBaksanValley, SteamNameStat[ROSTAT_WonBaksanValley]);
	SavedWonBaksanValley = WonBaksanValley.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonBaksanValley, WonBaksanValley.Value);

	GetStatInt(WonBarashka, SteamNameStat[ROSTAT_WonBarashka]);
	SavedWonBarashka = WonBarashka.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonBarashka, WonBarashka.Value);

	GetStatInt(WonBasovka, SteamNameStat[ROSTAT_WonBasovka]);
	SavedWonBasovka = WonBasovka.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonBasovka, WonBasovka.Value);

	GetStatInt(WonBerezina, SteamNameStat[ROSTAT_WonBerezina]);
	SavedWonBerezina = WonBerezina.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonBerezina, WonBerezina.Value);

	GetStatInt(WonBlackDayJuly, SteamNameStat[ROSTAT_WonBlackDayJuly]);
	SavedWonBlackDayJuly = WonBlackDayJuly.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonBlackDayJuly, WonBlackDayJuly.Value);

	GetStatInt(WonBondarevo, SteamNameStat[ROSTAT_WonBondarevo]);
	SavedWonBondarevo = WonBondarevo.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonBondarevo, WonBondarevo.Value);

	GetStatInt(WonDanzig, SteamNameStat[ROSTAT_WonDanzig]);
	SavedWonDanzig = WonDanzig.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonDanzig, WonDanzig.Value);

	GetStatInt(WonFallenHeroes, SteamNameStat[ROSTAT_WonFallenHeroes]);
	SavedWonFallenHeroes = WonFallenHeroes.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonFallenHeroes, WonFallenHeroes.Value);

	GetStatInt(WonHedgeHog, SteamNameStat[ROSTAT_WonHedgeHog]);
	SavedWonHedgeHog = WonHedgeHog.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonHedgeHog, WonHedgeHog.Value);

	GetStatInt(WonKaukasus, SteamNameStat[ROSTAT_WonKaukasus]);
	SavedWonKaukasus = WonKaukasus.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonKaukasus, WonKaukasus.Value);

	GetStatInt(WonKonigsplatz, SteamNameStat[ROSTAT_WonKonigsplatz]);
	SavedWonKonigsplatz = WonKonigsplatz.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonKonigsplatz, WonKonigsplatz.Value);

	GetStatInt(WonKrasnyiOktyabr, SteamNameStat[ROSTAT_WonKrasnyiOktyabr]);
	SavedWonKrasnyiOktyabr = WonKrasnyiOktyabr.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonKrasnyiOktyabr, WonKrasnyiOktyabr.Value);

	GetStatInt(WonKrivoiRog, SteamNameStat[ROSTAT_WonKrivoiRog]);
	SavedWonKrivoiRog = WonKrivoiRog.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonKrivoiRog, WonKrivoiRog.Value);

	GetStatInt(WonKryukovo, SteamNameStat[ROSTAT_WonKryukovo]);
	SavedWonKryukovo = WonKryukovo.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonKryukovo, WonKryukovo.Value);

	GetStatInt(WonKurlandKessel, SteamNameStat[ROSTAT_WonKurlandKessel]);
	SavedWonKurlandKessel = WonKurlandKessel.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonKurlandKessel, WonKurlandKessel.Value);

	GetStatInt(WonLeningrad, SteamNameStat[ROSTAT_WonLeningrad]);
	SavedWonLeningrad = WonLeningrad.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonLeningrad, WonLeningrad.Value);

	GetStatInt(WonLyesKrovy, SteamNameStat[ROSTAT_WonLyesKrovy]);
	SavedWonLyesKrovy = WonLyesKrovy.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonLyesKrovy, WonLyesKrovy.Value);

	GetStatInt(WonMannikkala, SteamNameStat[ROSTAT_WonMannikkala]);
	SavedWonMannikkala = WonMannikkala.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonMannikkala, WonMannikkala.Value);

	GetStatInt(WonOdessa, SteamNameStat[ROSTAT_WonOdessa]);
	SavedWonOdessa = WonOdessa.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonOdessa, WonOdessa.Value);

	GetStatInt(WonOgledow, SteamNameStat[ROSTAT_WonOgledow]);
	SavedWonOgledow = WonOgledow.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonOgledow, WonOgledow.Value);

	GetStatInt(WonRakowice, SteamNameStat[ROSTAT_WonRakowice]);
	SavedWonRakowice = WonRakowice.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonRakowice, WonRakowice.Value);

	GetStatInt(WonSmolenskStalemate, SteamNameStat[ROSTAT_WonSmolenskStalemate]);
	SavedWonSmolenskStalemate = WonSmolenskStalemate.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonSmolenskStalemate, WonSmolenskStalemate.Value);

	GetStatInt(WonStaligradKessel, SteamNameStat[ROSTAT_WonStaligradKessel]);
	SavedWonStaligradKessel = WonStaligradKessel.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonStaligradKessel, WonStaligradKessel.Value);

	GetStatInt(WonTcherkassy, SteamNameStat[ROSTAT_WonTcherkassy]);
	SavedWonTcherkassy = WonTcherkassy.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonTcherkassy, WonTcherkassy.Value);

	GetStatInt(WonTulaOutskirts, SteamNameStat[ROSTAT_WonTulaOutskirts]);
	SavedWonTulaOutskirts = WonTulaOutskirts.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonTulaOutskirts, WonTulaOutskirts.Value);

	GetStatInt(WonZhitomir1941, SteamNameStat[ROSTAT_WonZhitomir1941]);
	SavedWonZhitomir1941 = WonZhitomir1941.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_WonZhitomir1941, WonZhitomir1941.Value);

	GetStatInt(CommanderKillsStat, SteamNameStat[ROSTAT_CommanderKills]);
	SavedCommanderKillsStat = CommanderKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_CommanderKills, CommanderKillsStat.Value);

	GetStatInt(KnockedOutTracksStat, SteamNameStat[ROSTAT_KnockedOutTracks]);
	SavedKnockedOutTracksStat = KnockedOutTracksStat.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_KnockedOutTracks, KnockedOutTracksStat.Value);

	GetStatInt(LMGKillsStat, SteamNameStat[ROSTAT_LMGKills]);
	SavedLMGKillsStat = LMGKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_LMGKills, LMGKillsStat.Value);

	GetStatInt(MeleeKillsStat, SteamNameStat[ROSTAT_MeleeKills]);
	SavedMeleeKillsStat = MeleeKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_MeleeKills, MeleeKillsStat.Value);

	GetStatInt(MGResuppliesStat, SteamNameStat[ROSTAT_MGResupplies]);
	SavedMGResuppliesStat = MGResuppliesStat.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_MGResupplies, MGResuppliesStat.Value);

	GetStatInt(SniperKillsStat, SteamNameStat[ROSTAT_SniperKills]);
	SavedSniperKillsStat = SniperKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_SniperKills, SniperKillsStat.Value);

	GetStatInt(KillsStat, SteamNameStat[ROSTAT_Kills]);
	SavedKillsStat = KillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(ROSTAT_Kills, KillsStat.Value);

	bWinAllMapsGermanCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_WinAllMapsGerman]);
	bWinAllMapsRussianCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_WinAllMapsRussian]);
	bKill1TankCommanderCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill1TankCommander]);
	bKill10TankCommandersCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill10TankCommanders]);
	bKill25TankCommandersCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill25TankCommanders]);
	bKillFrom100MetersWithBoltCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_KillFrom100MetersWithBolt]);
	bKillFrom200MetersWithBoltCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_KillFrom200MetersWithBolt]);
	bKillFrom400MetersWithBoltCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_KillFrom400MetersWithBolt]);
	bDestroyTankFrom1000MetersCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_DestroyTankFrom1000Meters]);
	bDestroyTankFrom1500MetersCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_DestroyTankFrom1500Meters]);
	bDestroyTankFrom2000MetersCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_DestroyTankFrom2000Meters]);
	bKnockOff1TanksTracksCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_KnockOff1TanksTracks]);
	bKnockOff10TanksTracksCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_KnockOff10TanksTracks]);
	bKnockOff20TanksTracksCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_KnockOff20TanksTracks]);
	bDestroy3TanksWithPanzerfaustsCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Destroy3TanksWithPanzerfausts]);
	bDestroy3TanksWithPTRDCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Destroy3TanksWithPTRD]);
	bKill200EnemiesWithLMGCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill200EnemiesWithLMG]);
	bKill500EnemiesWithLMGCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill500EnemiesWithLMG]);
	bKill1000EnemiesWithLMGCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill1000EnemiesWithLMG]);
	bDestroyTigerTankWithT3476Completed = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_DestroyTigerTankWithT3476]);
	bDestroy25TanksInOneMatchCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Destroy25TanksInOneMatch]);
	bMeleeKill25EnemiesCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_MeleeKill25Enemies]);
	bMeleeKill100EnemiesCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_MeleeKill100Enemies]);
	bMeleeKill500EnemiesCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_MeleeKill500Enemies]);
	bKill10InfantryWithTankShellsCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill10InfantryWithTankShells]);
	bResupply10MGersCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Resupply10MGers]);
	bResupply100MGersCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Resupply100MGers]);
	bResupply250MGersCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Resupply250MGers]);
	bDestroy5VehiclesWithTigerCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Destroy5VehiclesWithTiger]);
	bDestroy10VehiclesWithTigerCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Destroy10VehiclesWithTiger]);
	bDestroy20VehiclesWithTigerCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Destroy20VehiclesWithTiger]);
	bKill50EnemiesWithSniperRifleCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill50EnemiesWithSniperRifle]);
	bKill200EnemiesWithSniperRifleCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill200EnemiesWithSniperRifle]);
	bKill500EnemiesWithSniperRifleCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill500EnemiesWithSniperRifle]);
	bKillSniperAsSniperCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_KillSniperAsSniper]);
	bKill10EnemiesAsAssaultClassCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill10EnemiesAsAssaultClass]);
	bKill10EnemiesInOneArtilleryCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_Kill10EnemiesInOneArtillery]);
	bCapAllObjectivesWithoutDyingCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_CapAllObjectivesWithoutDying]);
	bRussianSLCapAllObjectivesCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_RussianSLCapAllObjectives]);
	bNonSniperKill10WithEnemySniperRifleCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_NonSniperKill10WithEnemySniperRifle]);
	bDestroyFullyLoadedAPCCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_DestroyFullyLoadedAPC]);
	b10KillsAchievementCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_10Kills]);
	b50KillsAchievementCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_50Kills]);
	b100KillsAchievementCompleted = GetAchievementCompleted(SteamNameAchievement[ROACHIEVEMENT_100Kills]);

	super.OnStatsAndAchievementsReady();
}

// Called on Server to initialize Stats from Client replication, because Servers can't access Steam Stats directly
function InitializeSteamStatInt(int Index, int Value)
{
	if ( bDebugStats )
		log("STEAMSTATS: InitializeSteamStatInt called - Index="$Index @ "Value="$Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	switch ( Index )
	{
		case ROSTAT_WonArad:
			InitStatInt(WonArad, Value);
			break;

		case ROSTAT_WonBaksanValley:
			InitStatInt(WonBaksanValley, Value);
			break;

		case ROSTAT_WonBarashka:
			InitStatInt(WonBarashka, Value);
			break;

		case ROSTAT_WonBasovka:
			InitStatInt(WonBasovka, Value);
			break;

		case ROSTAT_WonBerezina:
			InitStatInt(WonBerezina, Value);
			break;

		case ROSTAT_WonBlackDayJuly:
			InitStatInt(WonBlackDayJuly, Value);
			break;

		case ROSTAT_WonBondarevo:
			InitStatInt(WonBondarevo, Value);
			break;

		case ROSTAT_WonDanzig:
			InitStatInt(WonDanzig, Value);
			break;

		case ROSTAT_WonFallenHeroes:
			InitStatInt(WonFallenHeroes, Value);
			break;

		case ROSTAT_WonHedgeHog:
			InitStatInt(WonHedgeHog, Value);
			break;

		case ROSTAT_WonKaukasus:
			InitStatInt(WonKaukasus, Value);
			break;

		case ROSTAT_WonKonigsplatz:
			InitStatInt(WonKonigsplatz, Value);
			break;

		case ROSTAT_WonKrasnyiOktyabr:
			InitStatInt(WonKrasnyiOktyabr, Value);
			break;

		case ROSTAT_WonKrivoiRog:
			InitStatInt(WonKrivoiRog, Value);
			break;

		case ROSTAT_WonKryukovo:
			InitStatInt(WonKryukovo, Value);
			break;

		case ROSTAT_WonKurlandKessel:
			InitStatInt(WonKurlandKessel, Value);
			break;

		case ROSTAT_WonLeningrad:
			InitStatInt(WonLeningrad, Value);
			break;

		case ROSTAT_WonLyesKrovy:
			InitStatInt(WonLyesKrovy, Value);
			break;

		case ROSTAT_WonMannikkala:
			InitStatInt(WonMannikkala, Value);
			break;

		case ROSTAT_WonOdessa:
			InitStatInt(WonOdessa, Value);
			break;

		case ROSTAT_WonOgledow:
			InitStatInt(WonOgledow, Value);
			break;

		case ROSTAT_WonRakowice:
			InitStatInt(WonRakowice, Value);
			break;

		case ROSTAT_WonSmolenskStalemate:
			InitStatInt(WonSmolenskStalemate, Value);
			break;

		case ROSTAT_WonStaligradKessel:
			InitStatInt(WonStaligradKessel, Value);
			break;

		case ROSTAT_WonTcherkassy:
			InitStatInt(WonTcherkassy, Value);
			break;

		case ROSTAT_WonTulaOutskirts:
			InitStatInt(WonTulaOutskirts, Value);
			break;

		case ROSTAT_WonZhitomir1941:
			InitStatInt(WonZhitomir1941, Value);
			break;

		case ROSTAT_CommanderKills:
			InitStatInt(CommanderKillsStat, Value);
			break;

		case ROSTAT_KnockedOutTracks:
			InitStatInt(KnockedOutTracksStat, Value);
			break;

		case ROSTAT_LMGKills:
			InitStatInt(LMGKillsStat, Value);
			break;

		case ROSTAT_MeleeKills:
			InitStatInt(MeleeKillsStat, Value);
			break;

		case ROSTAT_MGResupplies:
			InitStatInt(MGResuppliesStat, Value);
			break;

		case ROSTAT_SniperKills:
			InitStatInt(SniperKillsStat, Value);
			break;

		case ROSTAT_Kills:
			InitStatInt(KillsStat, Value);
			break;
	}
}

// Called from multiple locations on Client and Server to set Achievement booleans for later use
simulated event SetLocalAchievementCompleted(int Index)
{
	if ( bDebugStats )
		log("STEAMSTATS: SetLocalAchievementCompleted called - Name="$SteamNameAchievement[Index] @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	switch ( Index )
	{
		case ROACHIEVEMENT_WinAllMapsGerman:
			bWinAllMapsGermanCompleted = true;
			break;
		case ROACHIEVEMENT_WinAllMapsRussian:
			bWinAllMapsRussianCompleted = true;
			break;
		case ROACHIEVEMENT_Kill1TankCommander:
			bKill1TankCommanderCompleted = true;
			break;
		case ROACHIEVEMENT_Kill10TankCommanders:
			bKill10TankCommandersCompleted = true;
			break;
		case ROACHIEVEMENT_Kill25TankCommanders:
			bKill25TankCommandersCompleted = true;
			break;
		case ROACHIEVEMENT_KillFrom100MetersWithBolt:
			bKillFrom100MetersWithBoltCompleted = true;
			break;
		case ROACHIEVEMENT_KillFrom200MetersWithBolt:
			bKillFrom200MetersWithBoltCompleted = true;
			break;
		case ROACHIEVEMENT_KillFrom400MetersWithBolt:
			bKillFrom400MetersWithBoltCompleted = true;
			break;
		case ROACHIEVEMENT_DestroyTankFrom1000Meters:
			bDestroyTankFrom1000MetersCompleted = true;
			break;
		case ROACHIEVEMENT_DestroyTankFrom1500Meters:
			bDestroyTankFrom1500MetersCompleted = true;
			break;
		case ROACHIEVEMENT_DestroyTankFrom2000Meters:
			bDestroyTankFrom2000MetersCompleted = true;
			break;
		case ROACHIEVEMENT_KnockOff1TanksTracks:
			bKnockOff1TanksTracksCompleted = true;
			break;
		case ROACHIEVEMENT_KnockOff10TanksTracks:
			bKnockOff10TanksTracksCompleted = true;
			break;
		case ROACHIEVEMENT_KnockOff20TanksTracks:
			bKnockOff20TanksTracksCompleted = true;
			break;
		case ROACHIEVEMENT_Destroy3TanksWithPanzerfausts:
			bDestroy3TanksWithPanzerfaustsCompleted = true;
			break;
		case ROACHIEVEMENT_Destroy3TanksWithPTRD:
			bDestroy3TanksWithPTRDCompleted = true;
			break;
		case ROACHIEVEMENT_Kill200EnemiesWithLMG:
			bKill200EnemiesWithLMGCompleted = true;
			break;
		case ROACHIEVEMENT_Kill500EnemiesWithLMG:
			bKill500EnemiesWithLMGCompleted = true;
			break;
		case ROACHIEVEMENT_Kill1000EnemiesWithLMG:
			bKill1000EnemiesWithLMGCompleted = true;
			break;
		case ROACHIEVEMENT_DestroyTigerTankWithT3476:
			bDestroyTigerTankWithT3476Completed = true;
			break;
		case ROACHIEVEMENT_Destroy25TanksInOneMatch:
			bDestroy25TanksInOneMatchCompleted = true;
			break;
		case ROACHIEVEMENT_MeleeKill25Enemies:
			bMeleeKill25EnemiesCompleted = true;
			break;
		case ROACHIEVEMENT_MeleeKill100Enemies:
			bMeleeKill100EnemiesCompleted = true;
			break;
		case ROACHIEVEMENT_MeleeKill500Enemies:
			bMeleeKill500EnemiesCompleted = true;
			break;
		case ROACHIEVEMENT_Kill10InfantryWithTankShells:
			bKill10InfantryWithTankShellsCompleted = true;
			break;
		case ROACHIEVEMENT_Resupply10MGers:
			bResupply10MGersCompleted = true;
			break;
		case ROACHIEVEMENT_Resupply100MGers:
			bResupply100MGersCompleted = true;
			break;
		case ROACHIEVEMENT_Resupply250MGers:
			bResupply250MGersCompleted = true;
			break;
		case ROACHIEVEMENT_Destroy5VehiclesWithTiger:
			bDestroy5VehiclesWithTigerCompleted = true;
			break;
		case ROACHIEVEMENT_Destroy10VehiclesWithTiger:
			bDestroy10VehiclesWithTigerCompleted = true;
			break;
		case ROACHIEVEMENT_Destroy20VehiclesWithTiger:
			bDestroy20VehiclesWithTigerCompleted = true;
			break;
		case ROACHIEVEMENT_Kill50EnemiesWithSniperRifle:
			bKill50EnemiesWithSniperRifleCompleted = true;
			break;
		case ROACHIEVEMENT_Kill200EnemiesWithSniperRifle:
			bKill200EnemiesWithSniperRifleCompleted = true;
			break;
		case ROACHIEVEMENT_Kill500EnemiesWithSniperRifle:
			bKill500EnemiesWithSniperRifleCompleted = true;
			break;
		case ROACHIEVEMENT_KillSniperAsSniper:
			bKillSniperAsSniperCompleted = true;
			break;
		case ROACHIEVEMENT_Kill10EnemiesAsAssaultClass:
			bKill10EnemiesAsAssaultClassCompleted = true;
			break;
		case ROACHIEVEMENT_Kill10EnemiesInOneArtillery:
			bKill10EnemiesInOneArtilleryCompleted = true;
			break;
		case ROACHIEVEMENT_CapAllObjectivesWithoutDying:
			bCapAllObjectivesWithoutDyingCompleted = true;
			break;
		case ROACHIEVEMENT_RussianSLCapAllObjectives:
			bRussianSLCapAllObjectivesCompleted = true;
			break;
		case ROACHIEVEMENT_NonSniperKill10WithEnemySniperRifle:
			bNonSniperKill10WithEnemySniperRifleCompleted = true;
			break;
		case ROACHIEVEMENT_DestroyFullyLoadedAPC:
			bDestroyFullyLoadedAPCCompleted = true;
			break;
		case ROACHIEVEMENT_10Kills:
			b10KillsAchievementCompleted = true;
			break;
		case ROACHIEVEMENT_50Kills:
			b50KillsAchievementCompleted = true;
			break;
		case ROACHIEVEMENT_100Kills:
			b100KillsAchievementCompleted = true;
			break;
	}
}

// Called when the owner of this Stats Actor dies(used to reset "in one life" stats)
function PlayerDied()
{
	if ( bDebugStats )
		log("PlayerDied resetting 'in one life' Stats - Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	InitStatInt(DestroyedTanksWithPanzerfausts, 0);
	InitStatInt(DestroyedTanksWithPTRD, 0);
	InitStatInt(InfantryKilledWithTankShellsStat, 0);
	InitStatInt(DestroyedVehiclesFromTigerStat, 0);
	InitStatInt(KillsAsAssaultStat, 0);
	InitStatInt(NonSniperKillsWithEnemySniperRifleStat, 0);

	bInAllCapturesWithoutDying = false;
}

function NotInCapturedObjective()
{
	if ( bDebugStats )
		log("STEAMSTATS: NotInCapturedObjective - Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	bInAllCapturesWithoutDying = false;
	bRussianSquadLeaderInAllCaptures = false;
}

function WonRound()
{
	if ( bDebugStats )
		log("STEAMSTATS: WonRound - Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( bInAllCapturesWithoutDying && !bCapAllObjectivesWithoutDyingCompleted )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_CapAllObjectivesWithoutDying);
	}

	bInAllCapturesWithoutDying = true;
}

function MatchEnded()
{
	if ( bDebugStats )
		log("STEAMSTATS: MatchEnded - Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	// Reset any "per match" Stats
	InitStatInt(EnemyTanksKilledThisMatch, 0);

	// Reset any "per life" Stats
	PlayerDied();

	// Assume they are going to be in on All Captures until they are not in one
	bInAllCapturesWithoutDying = true;
	bRussianSquadLeaderInAllCaptures = true;
}

function WonMatch(string MapName, int TeamIndex, bool bRussianSquadLeader)
{
	if ( bDebugStats )
		log("STEAMSTATS: Won Round - MapName="$MapName @ "TeamIndex="$TeamIndex @ "bIsRussianSquadLeader="$bRussianSquadLeader @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	// If they won the Match, they obviously Won the Round
	WonRound();

	// If they were in all Objective Captures as a Squad Leader
	if ( bRussianSquadLeader && !bRussianSLCapAllObjectivesCompleted && bRussianSquadLeaderInAllCaptures )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_RussianSLCapAllObjectives);
	}

	// Set the New Value based on which Map was Won by which Team
	// Values: 0 = Map Not Won, 1 = Map Won As German, 2 = Map Won As Russian, 3 = Map Won As Both German and Russian
	if ( MapName ~= "RO-Arad" )
	{
		SetStatInt(WonArad, WonArad.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-BaksanValley" )
	{
		SetStatInt(WonBaksanValley, WonBaksanValley.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Barashka" )
	{
		SetStatInt(WonBarashka, WonBarashka.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Basovka" )
	{
		SetStatInt(WonBasovka, WonBasovka.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Berezina" )
	{
		SetStatInt(WonBerezina, WonBerezina.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-BlackDayJuly" )
	{
		SetStatInt(WonBlackDayJuly, WonBlackDayJuly.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Bondarevo" )
	{
		SetStatInt(WonBondarevo, WonBondarevo.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Danzig" )
	{
		SetStatInt(WonDanzig, WonDanzig.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-FallenHeroes" )
	{
		SetStatInt(WonFallenHeroes, WonFallenHeroes.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-HedgeHog" )
	{
		SetStatInt(WonHedgeHog, WonHedgeHog.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Kaukasus" )
	{
		SetStatInt(WonKaukasus, WonKaukasus.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Konigsplatz" )
	{
		SetStatInt(WonKonigsplatz, WonKonigsplatz.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-KrasnyiOktyabr" )
	{
		SetStatInt(WonKrasnyiOktyabr, WonKrasnyiOktyabr.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-KrivoiRog" )
	{
		SetStatInt(WonKrivoiRog, WonKrivoiRog.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Kryukovo" )
	{
		SetStatInt(WonKryukovo, WonKryukovo.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-KurlandKessel" )
	{
		SetStatInt(WonKurlandKessel, WonKurlandKessel.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Leningrad" )
	{
		SetStatInt(WonLeningrad, WonLeningrad.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-LyesKrovy" )
	{
		SetStatInt(WonLyesKrovy, WonLyesKrovy.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Mannikkala" )
	{
		SetStatInt(WonMannikkala, WonMannikkala.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Odessa" )
	{
		SetStatInt(WonOdessa, WonOdessa.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Ogledow" )
	{
		SetStatInt(WonOgledow, WonOgledow.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Rakowice" )
	{
		SetStatInt(WonRakowice, WonRakowice.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-SmolenskStalemate" )
	{
		SetStatInt(WonSmolenskStalemate, WonSmolenskStalemate.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-StaligradKessel" )
	{
		SetStatInt(WonStaligradKessel, WonStaligradKessel.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Tcherkassy" )
	{
		SetStatInt(WonTcherkassy, WonTcherkassy.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-TulaOutskirts" )
	{
		SetStatInt(WonTulaOutskirts, WonTulaOutskirts.Value | (TeamIndex + 1));
	}
	else if ( MapName ~= "RO-Zhitomir1941" )
	{
		SetStatInt(WonZhitomir1941, WonZhitomir1941.Value | (TeamIndex + 1));
	}

	if ( TeamIndex == AXIS_TEAM_INDEX )
	{
		if ( !bWinAllMapsGermanCompleted &&
			 (WonArad.Value & 1) == 1 && (WonBaksanValley.Value & 1) == 1 && (WonBarashka.Value & 1) == 1 &&
			 (WonBasovka.Value & 1) == 1 && (WonBerezina.Value & 1) == 1 && (WonBlackDayJuly.Value & 1) == 1 &&
			 (WonBondarevo.Value & 1) == 1 && (WonDanzig.Value & 1) == 1 && (WonFallenHeroes.Value & 1) == 1 &&
			 (WonHedgeHog.Value & 1) == 1 && (WonKaukasus.Value & 1) == 1 && (WonKonigsplatz.Value & 1) == 1 &&
			 (WonKrasnyiOktyabr.Value & 1) == 1 && (WonKrivoiRog.Value & 1) == 1 && (WonKryukovo.Value & 1) == 1 &&
			 (WonKurlandKessel.Value & 1) == 1 && (WonLeningrad.Value & 1) == 1 && (WonLyesKrovy.Value & 1) == 1 &&
			 (WonMannikkala.Value & 1) == 1 && (WonOdessa.Value & 1) == 1 && (WonOgledow.Value & 1) == 1 &&
			 (WonRakowice.Value & 1) == 1 && (WonSmolenskStalemate.Value & 1) == 1 && (WonStaligradKessel.Value & 1) == 1 &&
			 (WonTcherkassy.Value & 1) == 1 && (WonTulaOutskirts.Value & 1) == 1 && (WonZhitomir1941.Value & 1) == 1 )
		{
			SetSteamAchievementCompleted(ROACHIEVEMENT_WinAllMapsGerman);
		}
	}
	else if ( TeamIndex == ALLIES_TEAM_INDEX )
	{
		if ( !bWinAllMapsRussianCompleted &&
			 (WonArad.Value & 2) == 2 && (WonBaksanValley.Value & 2) == 2 && (WonBarashka.Value & 2) == 2 &&
			 (WonBasovka.Value & 2) == 2 && (WonBerezina.Value & 2) == 2 && (WonBlackDayJuly.Value & 2) == 2 &&
			 (WonBondarevo.Value & 2) == 2 && (WonDanzig.Value & 2) == 2 && (WonFallenHeroes.Value & 2) == 2 &&
			 (WonHedgeHog.Value & 2) == 2 && (WonKaukasus.Value & 2) == 2 && (WonKonigsplatz.Value & 2) == 2 &&
			 (WonKrasnyiOktyabr.Value & 2) == 2 && (WonKrivoiRog.Value & 2) == 2 && (WonKryukovo.Value & 2) == 2 &&
			 (WonKurlandKessel.Value & 2) == 2 && (WonLeningrad.Value & 2) == 2 && (WonLyesKrovy.Value & 2) == 2 &&
			 (WonMannikkala.Value & 2) == 2 && (WonOdessa.Value & 2) == 2 && (WonOgledow.Value & 2) == 2 &&
			 (WonRakowice.Value & 2) == 2 && (WonSmolenskStalemate.Value & 2) == 2 && (WonStaligradKessel.Value & 2) == 2 &&
			 (WonTcherkassy.Value & 2) == 2 && (WonTulaOutskirts.Value & 2) == 2 && (WonZhitomir1941.Value & 2) == 2 )
		{
			SetSteamAchievementCompleted(ROACHIEVEMENT_WinAllMapsRussian);
		}
	}

	if ( !bFlushStatsToClient )
	{
		FlushStatsToClient();
	}
}

function AddCommanderKill()
{
	SetStatInt(CommanderKillsStat, CommanderKillsStat.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Commander Kill - NewKills="$CommanderKillsStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bKill1TankCommanderCompleted && CommanderKillsStat.Value >= 1 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill1TankCommander);
	}

	if ( !bKill10TankCommandersCompleted && CommanderKillsStat.Value >= 10 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill10TankCommanders);
	}

	if ( !bKill25TankCommandersCompleted && CommanderKillsStat.Value >= 25 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill25TankCommanders);
	}
}

function PlayerKilledPlayerWithBoltActionRifle(float DistanceSquared)
{
	if ( bDebugStats )
		log("PlayerKilledPlayerWithBoltActionRifle - DistanceSquared="$DistanceSquared @ "Distance="$SqRt(DistanceSquared) @ "Meters="$SqRt(DistanceSquared) / 60.352);

	if ( !bKillFrom100MetersWithBoltCompleted && DistanceSquared > 36423639.04 ) // 100 meters squared in UUs - (100 * 60.352)^2
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_KillFrom100MetersWithBolt);
	}

	if ( !bKillFrom200MetersWithBoltCompleted && DistanceSquared > 145694556.16 ) // 200 meters squared in UUs - (200 * 60.352)^2
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_KillFrom200MetersWithBolt);
	}

	if ( !bKillFrom400MetersWithBoltCompleted && DistanceSquared > 582778224.64 ) // 400 meters squared in UUs - (400 * 60.352)^2
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_KillFrom400MetersWithBolt);
	}
}

function AddDestroyedTank(float DistanceSquared)
{
	SetStatInt(EnemyTanksKilledThisMatch, EnemyTanksKilledThisMatch.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Destroyed Tank - NewValue="$EnemyTanksKilledThisMatch.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bDestroy25TanksInOneMatchCompleted && EnemyTanksKilledThisMatch.Value >= 25 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Destroy25TanksInOneMatch);
	}

	if ( bDebugStats )
		log("DestroyedTankWithTankCannon - DistanceSquared="$DistanceSquared @ "Distance="$SqRt(DistanceSquared) @ "Meters="$SqRt(DistanceSquared) / 60.352);

	if ( !bDestroyTankFrom1000MetersCompleted && DistanceSquared > 3642363904.0 ) // 1000 meters squared in UUs - (1000 * 60.352)^2
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_DestroyTankFrom1000Meters);
	}

	if ( !bDestroyTankFrom1500MetersCompleted && DistanceSquared > 8195318784.0 ) // 1500 meters squared in UUs - (1500 * 60.352)^2
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_DestroyTankFrom1500Meters);
	}

	if ( !bDestroyTankFrom2000MetersCompleted && DistanceSquared > 14569455616.0 ) // 2000 meters squared in UUs - (2000 * 60.352)^2
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_DestroyTankFrom2000Meters);
	}
}

function AddKnockedOutTracks()
{
	SetStatInt(KnockedOutTracksStat, KnockedOutTracksStat.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Knocked Out Tracks - NewValue="$KnockedOutTracksStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bKnockOff1TanksTracksCompleted && KnockedOutTracksStat.Value >= 1 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_KnockOff1TanksTracks);
	}

	if ( !bKnockOff10TanksTracksCompleted && KnockedOutTracksStat.Value >= 10 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_KnockOff10TanksTracks);
	}

	if ( !bKnockOff20TanksTracksCompleted && KnockedOutTracksStat.Value >= 20 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_KnockOff20TanksTracks);
	}
}

function AddDestroyedTankWithPanzerfaust()
{
	SetStatInt(DestroyedTanksWithPanzerfausts, DestroyedTanksWithPanzerfausts.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Destroyed Tank With Panzerfaust - NewValue="$DestroyedTanksWithPanzerfausts.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bDestroy3TanksWithPanzerfaustsCompleted && DestroyedTanksWithPanzerfausts.Value >= 3 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Destroy3TanksWithPanzerfausts);
	}
}

function AddDestroyedTankWithPTRD()
{
	SetStatInt(DestroyedTanksWithPTRD, DestroyedTanksWithPTRD.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Destroyed Tank With PTRD - NewValue="$DestroyedTanksWithPTRD.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bDestroy3TanksWithPTRDCompleted && DestroyedTanksWithPTRD.Value >= 3 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Destroy3TanksWithPTRD);
	}
}

function AddLMGKill()
{
	SetStatInt(LMGKillsStat, LMGKillsStat.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding LMG Kill - NewKills="$LMGKillsStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bKill200EnemiesWithLMGCompleted && LMGKillsStat.Value >= 200 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill200EnemiesWithLMG);
	}

	if ( !bKill500EnemiesWithLMGCompleted && LMGKillsStat.Value >= 500 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill500EnemiesWithLMG);
	}

	if ( !bKill1000EnemiesWithLMGCompleted && LMGKillsStat.Value >= 1000 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill1000EnemiesWithLMG);
	}
}

function DestroyedTigerTankWithT3476()
{
	if ( !bDestroyTigerTankWithT3476Completed )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_DestroyTigerTankWithT3476);
	}
}

function AddMeleeKill()
{
	SetStatInt(MeleeKillsStat, MeleeKillsStat.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Melee Kill - NewKills="$MeleeKillsStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bMeleeKill25EnemiesCompleted && MeleeKillsStat.Value >= 25 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_MeleeKill25Enemies);
	}

	if ( !bMeleeKill100EnemiesCompleted && MeleeKillsStat.Value >= 100 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_MeleeKill100Enemies);
	}

	if ( !bMeleeKill500EnemiesCompleted && MeleeKillsStat.Value >= 500 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_MeleeKill500Enemies);
	}
}

function AddInfantryKillWithTankShell()
{
	SetStatInt(InfantryKilledWithTankShellsStat, InfantryKilledWithTankShellsStat.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Infantry Kill with Tank Shell - NewKills="$InfantryKilledWithTankShellsStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bKill10InfantryWithTankShellsCompleted && InfantryKilledWithTankShellsStat.Value >= 10 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill10InfantryWithTankShells);
	}
}

function AddMGResupply()
{
	SetStatInt(MGResuppliesStat, MGResuppliesStat.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding MG Resupply - NewValue="$MGResuppliesStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bResupply10MGersCompleted && MGResuppliesStat.Value >= 10 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Resupply10MGers);
	}

	if ( !bResupply100MGersCompleted && MGResuppliesStat.Value >= 100 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Resupply100MGers);
	}

	if ( !bResupply250MGersCompleted && MGResuppliesStat.Value >= 250 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Resupply250MGers);
	}
}

function AddDestroyedVehicleFromTiger()
{
	SetStatInt(DestroyedVehiclesFromTigerStat, DestroyedVehiclesFromTigerStat.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Destroyed Vehicle From Tiger - NewValue="$DestroyedVehiclesFromTigerStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bDestroy5VehiclesWithTigerCompleted && DestroyedVehiclesFromTigerStat.Value >= 5 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Destroy5VehiclesWithTiger);
	}

	if ( !bDestroy10VehiclesWithTigerCompleted && DestroyedVehiclesFromTigerStat.Value >= 10 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Destroy10VehiclesWithTiger);
	}

	if ( !bDestroy20VehiclesWithTigerCompleted && DestroyedVehiclesFromTigerStat.Value >= 20 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Destroy20VehiclesWithTiger);
	}
}

function AddSniperRifleKill(optional bool bIsNonSniperWithEnemySniperRifle)
{
	if ( bIsNonSniperWithEnemySniperRifle && !bNonSniperKill10WithEnemySniperRifleCompleted )
	{
		SetStatInt(NonSniperKillsWithEnemySniperRifleStat, NonSniperKillsWithEnemySniperRifleStat.Value + 1);

		if ( bDebugStats )
			log("STEAMSTATS: Adding Non Sniper With Enemy Sniper Rifle Kill - NewValue="$NonSniperKillsWithEnemySniperRifleStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

		if ( NonSniperKillsWithEnemySniperRifleStat.Value >= 10 )
		{
			SetSteamAchievementCompleted(ROACHIEVEMENT_NonSniperKill10WithEnemySniperRifle);
		}
	}

	SetStatInt(SniperKillsStat, SniperKillsStat.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Sniper Rifle Kill - NewValue="$SniperKillsStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bKill50EnemiesWithSniperRifleCompleted && SniperKillsStat.Value >= 50 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill50EnemiesWithSniperRifle);
	}

	if ( !bKill200EnemiesWithSniperRifleCompleted && SniperKillsStat.Value >= 200 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill200EnemiesWithSniperRifle);
	}

	if ( !bKill500EnemiesWithSniperRifleCompleted && SniperKillsStat.Value >= 500 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill500EnemiesWithSniperRifle);
	}
}

function SniperKilledSniper()
{
	if ( !bKillSniperAsSniperCompleted )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_KillSniperAsSniper);
	}
}

function AddKillAsAssault()
{
	SetStatInt(KillsAsAssaultStat, KillsAsAssaultStat.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Kill As Assault - NewKills="$KillsAsAssaultStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bKill10EnemiesAsAssaultClassCompleted && KillsAsAssaultStat.Value >= 10 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill10EnemiesAsAssaultClass);
	}
}

function PlayerCalledArtillery()
{
	InitStatInt(ArtilleryKillsStat, 0);
}

function AddArtilleryKill()
{
	SetStatInt(ArtilleryKillsStat, ArtilleryKillsStat.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Artillery Kill - NewKills="$ArtilleryKillsStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !bKill10EnemiesInOneArtilleryCompleted && ArtilleryKillsStat.Value >= 10 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_Kill10EnemiesInOneArtillery);
	}
}

function DestroyedHalfTrack(bool bHadController)
{
	if ( bHadController && !bDestroyFullyLoadedAPCCompleted )
	{
		bDestroyedHalftrack = true;
	}

	InitStatInt(PassengerCountStat, 0);
}

function DestroyedUniCarrier(bool bHadController)
{
	if ( bHadController && !bDestroyFullyLoadedAPCCompleted )
	{
		bDestroyedUniCarrier = true;
	}

	InitStatInt(PassengerCountStat, 0);
}

function KilledHalftrackPassenger(bool bHadController)
{
	if ( bHadController && bDestroyedHalftrack )
	{
		SetStatInt(PassengerCountStat, PassengerCountStat.Value + 1);

		if ( bDebugStats )
			log("STEAMSTATS: Adding Killed Halftrack Passenger - NewKills="$PassengerCountStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

		if ( !bDestroyFullyLoadedAPCCompleted && PassengerCountStat.Value >= 7 )
		{
			SetSteamAchievementCompleted(ROACHIEVEMENT_DestroyFullyLoadedAPC);
		}
	}
}

function KilledUniCarrierPassenger(bool bHadController)
{
	if ( bHadController && bDestroyedUniCarrier )
	{
		SetStatInt(PassengerCountStat, PassengerCountStat.Value + 1);

		if ( bDebugStats )
			log("STEAMSTATS: Adding Killed UniCarrier Passenger - NewKills="$PassengerCountStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

		if ( !bDestroyFullyLoadedAPCCompleted && PassengerCountStat.Value >= 5 )
		{
			SetSteamAchievementCompleted(ROACHIEVEMENT_DestroyFullyLoadedAPC);
		}
	}
}

function AddKill()
{
	SetStatInt(KillsStat, KillsStat.Value + 1);

	if ( bDebugStats )
		log("STEAMSTATS: Adding Kill - NewKills="$KillsStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	if ( !b10KillsAchievementCompleted && KillsStat.Value >= 10 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_10Kills);
	}

	if ( !b50KillsAchievementCompleted && KillsStat.Value >= 50 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_50Kills);
	}

	if ( !b100KillsAchievementCompleted && KillsStat.Value >= 100 )
	{
		SetSteamAchievementCompleted(ROACHIEVEMENT_100Kills);
	}
}

defaultproperties
{
	SteamNameStat[0]="WonArad"
	SteamNameStat[1]="WonBaksanValley"
	SteamNameStat[2]="WonBarashka"
	SteamNameStat[3]="WonBasovka"
	SteamNameStat[4]="WonBerezina"
	SteamNameStat[5]="WonBlackDayJuly"
	SteamNameStat[6]="WonBondarevo"
	SteamNameStat[7]="WonDanzig"
	SteamNameStat[8]="WonFallenHeroes"
	SteamNameStat[9]="WonHedgeHog"
	SteamNameStat[10]="WonKaukasus"
	SteamNameStat[11]="WonKonigsplatz"
	SteamNameStat[12]="WonKrasnyiOktyabr"
	SteamNameStat[13]="WonKrivoiRog"
	SteamNameStat[14]="WonKryukovo"
	SteamNameStat[15]="WonKurlandKessel"
	SteamNameStat[16]="WonLeningrad"
	SteamNameStat[17]="WonLyesKrovy"
	SteamNameStat[18]="WonMannikkala"
	SteamNameStat[19]="WonOdessa"
	SteamNameStat[20]="WonOgledow"
	SteamNameStat[21]="WonRakowice"
	SteamNameStat[22]="WonSmolenskStalemate"
	SteamNameStat[23]="WonStaligradKessel"
	SteamNameStat[24]="WonTcherkassy"
	SteamNameStat[25]="WonTulaOutskirts"
	SteamNameStat[26]="WonZhitomir1941"
	SteamNameStat[27]="CommanderKills"
	SteamNameStat[28]="KnockedOutTracks"
	SteamNameStat[29]="LMGKills"
	SteamNameStat[30]="MeleeKills"
	SteamNameStat[31]="MGResupplies"
	SteamNameStat[32]="SniperKills"
	SteamNameStat[33]="Kills"

	SteamNameAchievement[0]="WinAllMapsGerman"
	SteamNameAchievement[1]="WinAllMapsRussian"
	SteamNameAchievement[2]="Kill1TankCommander"
	SteamNameAchievement[3]="Kill10TankCommanders"
	SteamNameAchievement[4]="Kill25TankCommanders"
	SteamNameAchievement[5]="KillFrom100MetersWithBolt"
	SteamNameAchievement[6]="KillFrom200MetersWithBolt"
	SteamNameAchievement[7]="KillFrom400MetersWithBolt"
	SteamNameAchievement[8]="DestroyTankFrom1000Meters"
	SteamNameAchievement[9]="DestroyTankFrom1500Meters"
	SteamNameAchievement[10]="DestroyTankFrom2000Meters"
	SteamNameAchievement[11]="KnockOff1TanksTracks"
	SteamNameAchievement[12]="KnockOff10TanksTracks"
	SteamNameAchievement[13]="KnockOff20TanksTracks"
	SteamNameAchievement[14]="Destroy3TanksWithPanzerfausts"
	SteamNameAchievement[15]="Destroy3TanksWithPTRD"
	SteamNameAchievement[16]="Kill200EnemiesWithLMG"
	SteamNameAchievement[17]="Kill500EnemiesWithLMG"
	SteamNameAchievement[18]="Kill1000EnemiesWithLMG"
	SteamNameAchievement[19]="DestroyTigerTankWithT3476"
	SteamNameAchievement[20]="Destroy25TanksInOneMatch"
	SteamNameAchievement[21]="MeleeKill25Enemies"
	SteamNameAchievement[22]="MeleeKill100Enemies"
	SteamNameAchievement[23]="MeleeKill500Enemies"
	SteamNameAchievement[24]="Kill10InfantryWithTankShells"
	SteamNameAchievement[25]="Resupply10MGers"
	SteamNameAchievement[26]="Resupply100MGers"
	SteamNameAchievement[27]="Resupply250MGers"
	SteamNameAchievement[28]="Destroy5VehiclesWithTiger"
	SteamNameAchievement[29]="Destroy10VehiclesWithTiger"
	SteamNameAchievement[30]="Destroy20VehiclesWithTiger"
	SteamNameAchievement[31]="Kill50EnemiesWithSniperRifle"
	SteamNameAchievement[32]="Kill200EnemiesWithSniperRifle"
	SteamNameAchievement[33]="Kill500EnemiesWithSniperRifle"
	SteamNameAchievement[34]="KillSniperAsSniper"
	SteamNameAchievement[35]="Kill10EnemiesAsAssaultClass"
	SteamNameAchievement[36]="Kill10EnemiesInOneArtillery"
	SteamNameAchievement[37]="CapAllObjectivesWithoutDying"
	SteamNameAchievement[38]="RussianSLCapAllObjectives"
	SteamNameAchievement[39]="NonSniperKill10WithEnemySniperRifle"
	SteamNameAchievement[40]="DestroyFullyLoadedAPC"
	SteamNameAchievement[41]="Kills10"
	SteamNameAchievement[42]="Kills50"
	SteamNameAchievement[43]="Kills100"
}
