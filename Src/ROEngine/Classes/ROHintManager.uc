//=============================================================================
// ROHintManager
//=============================================================================
// This class manages (most) of the hinting system stuff. It is spawned and
// referenced in ROPlayer. It also interfaces with ROHud to display the hints
// on screen. Finally, config variables are used to
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Mathieu Mallet
//=============================================================================

class ROHintManager extends Info
    config(User);

// Data structures
struct HintInfo
{
    var() int                   type;
    var() int                   priority; // 1 = highest priority, 2 = lower than 0, etc
    var() int                   delay; // how many seconds to wait before displaying the hint
    var() localized string      title;
    var() localized string      hint;   // actual hint text
    var int                     index; // set in code, do not use!
};

// Constants
const                           MAX_HINT_TYPES = 25;
const                           MAX_HINTS = 50;

// config variables
var()   float                   PostHintDisplayDelay;           // How long to wait before displaying any other hint (value higher than 0 needed)
var()   float                   SameHintTypePostDisplayDelay;   // How long to wait before authorizing a hint from same type to be displayed (value higher than 0 needed)
var()   HintInfo                Hints[MAX_HINTS];
var     config  int             bUsedUpHints[MAX_HINTS]; // 0 = hint unused, 1 = hint used before
var     float                   RandomHintTimerDelay;

// Hints array
var     int                     HintsAvailableByType[MAX_HINT_TYPES];
var     array<HintInfo>         SortedHints;

// State variables
var     HintInfo                CurrentHint; // Copy of hint for convenience
var     int                     CurrentHintIndex; // Index in the SortedHints array
var     float                   LastHintDisplayTime;
var     int                     LastHintType;


function PostBeginPlay()
{
    super.PostBeginPlay();
    LastHintType = -1;
    LoadHints();
}

static function StaticReset()
{
    local int i;
    for (i = 0; i < MAX_HINT_TYPES; i++)
        default.bUsedUpHints[i] = 0;
    StaticSaveConfig();
}

function NonStaticReset()
{
    local int i;
    for (i = 0; i < MAX_HINT_TYPES; i++)
        bUsedUpHints[i] = 0;
    SaveConfig();
    Reload();
}

function Reload()
{
    StopHinting();
    LoadHints();
}

function LoadHints()
{
    local int i, j, index, priority;

    // Initialize arrays to 0
    SortedHints.Length = 0;
    for (i = 0; i < MAX_HINT_TYPES; i++)
        HintsAvailableByType[i] = 0;

    // Sort hints in the SortedHints by priority -- highest priority hints
    // get placed first. At same time, build array of available hints
    // using id of used hints
    for (i = 0; i < MAX_HINT_TYPES; i++)
    {
        Hints[i].index = i;

        // Check if we should add this hint
        if (bUsedUpHints[i] == 0 && Hints[i].title != "")
        {
            HintsAvailableByType[Hints[i].type]++;

            // Find where we should insert the new hint
            priority = Hints[i].priority;
            index = -1;
            for (j = 0; j < SortedHints.Length; j++)
                if (SortedHints[j].priority >= priority)
                {
                    index = j;
                    break;
                }

            // Add hint to proper position
            if (index == -1)
                SortedHints[SortedHints.Length] = Hints[i];
            else
            {
                SortedHints.Insert(index, 1);
                SortedHints[index] = Hints[i];
            }
        }
    }
}


function CheckForHint(int hintType)
{
    local int i;

    if (HintsAvailableByType[hintType] == 0)
        return;

    // Check if we're allowed to display a hint of this type at this time
    if (LastHintType == hintType)
        if (level.TimeSeconds - LastHintDisplayTime < SameHintTypePostDisplayDelay)
            return;

    // We have available hints! Search array for first non-used hint of that type.
    // (first == highest priority)
    for (i = 0; i < SortedHints.Length; i++)
    {
        if (SortedHints[i].type == hintType)
        {
            CurrentHint = SortedHints[i];
            CurrentHintIndex = i;
            SetTimer(0, false);
            GotoState('PreHintDelay');
            return;
        }
    }

    // If we got here it means that hint couldn't be found. wtf?
    warn("Unable to find hint type '" $ hintType $ "' in SortedHints array, even though HintsAvailableByType"
        $ " indicates that there are " $ HintsAvailableByType[hintType] $ " hints of that type available!");
}

function StopHinting()
{
    GotoState('');
    SetTimer(0, false);
}

// Implemented in WaitHintDone state
function NotifyHintRenderingDone() {}

// Used to dump hint info to console
function DumpHints()
{
    local int i;
    log("Hint availability list:");
    for (i = 0; i < MAX_HINT_TYPES; i++)
        log("#" $ i $ " availability: " $ HintsAvailableByType[i]);
    log("Max number of hints in db: " $ MAX_HINT_TYPES);
    for (i = 0; i < MAX_HINT_TYPES; i++)
        log("#" $ i $ ", type = " $ hints[i].type
            $ ", pri = " $ hints[i].priority
            $ ", delay = " $ hints[i].delay
            $ ", used = " $ bUsedUpHints[i]
            $ ", title = '" $ hints[i].title $ "'"
            $ ", text = '" $ hints[i].hint $ "'");
    log("Hints in sorted array: " $ SortedHints.Length);
    for (i = 0; i < SortedHints.length; i++)
        log("#" $ i $ ", type = " $ SortedHints[i].type
            $ ", pri = " $ SortedHints[i].priority
            $ ", delay = " $ SortedHints[i].delay
            $ ", used = " $ bUsedUpHints[SortedHints[i].index]
            $ ", title = '" $ SortedHints[i].title $ "'"
            $ ", text = '" $ SortedHints[i].hint $ "'");

}

simulated function Timer()
{
    CheckForHint(18);
}

// This state is used when we want to show a hint.
state PreHintDelay
{
    function BeginState()
    {
        if (CurrentHint.delay ~= 0)
            GotoState('WaitHintDone');
        else
            SetTimer(CurrentHint.delay, false);
    }

    // Don't allow another hint to be scheduled when we have one scheduled already
    function CheckForHint(int hintType) {}

    function Timer()
    {
        GotoState('WaitHintDone');
    }
}

state WaitHintDone
{
    function BeginState()
    {
        local ROPlayer player;
        // Tell ROHud to display the hint
        player = ROPlayer(Owner);
        if (player != none &&
            ROHud(player.myHud) != none &&
            !ROHud(player.myHud).bHideHud)
        {
            ROHud(player.myHud).ShowHint(CurrentHint.title, CurrentHint.hint);
        }
        else
        {
            SetTimer(RandomHintTimerDelay, true);
            GotoState('');
        }
    }

    // Don't allow another hint to be scheduled when we're displaying one already
    function CheckForHint(int hintType) {}

    function NotifyHintRenderingDone()
    {
        // Hurray, hint done rendering! Switch to post-hint state.
        GotoState('PostDisplay');
    }
}

state PostDisplay
{
    function BeginState()
    {
        LastHintType = CurrentHint.type;
        LastHintDisplayTime = Level.TimeSeconds;
        SetTimer(PostHintDisplayDelay, false);
    }

    // Don't allow another hint to be scheduled until post-display delay is completed.
    function CheckForHint(int hintType) {}

    function Timer()
    {
        // Mark this hint as used up
        //log("setting hint #" $ CurrentHint.index $ " as used up.");
        bUsedUpHints[CurrentHint.index] = 1;
        SaveConfig();

        // Update hint availability list
        HintsAvailableByType[CurrentHint.type]--;

        // Remove current hint from hints list
        //log("Removing from sortedhints array. old length = " $ SortedHints.Length);
        SortedHints.Remove(CurrentHintIndex, 1);
        //log("                                 new length = " $ SortedHints.Length);

        // Go back to 'idle' state
        SetTimer(RandomHintTimerDelay, true);
        GotoState('');
    }
}

DefaultProperties
{
    PostHintDisplayDelay=10
    SameHintTypePostDisplayDelay=30
    //PostHintDisplayDelay=3
    //SameHintTypePostDisplayDelay=10
    RandomHintTimerDelay=29


    // Hint types:

    // Type 0: player respawned (beginstate of PlayerWalking state in ROPlayer)
    Hints(00)=(type=0,priority=0,delay=3,title="Welcome",hint="Welcome to Red Orchestra!||These hint messages will show up periodically in the game. Pay attention to them, your survival might depend on it! They can be disabled from the HUD tab in the configuration menu.")
    Hints(04)=(type=0,priority=15,delay=3,title="Role Selection",hint="You can change your weapons and role at any time by hitting the %SHOWMENU% key. The changes you make will take effect when you respawn.")
    Hints(09)=(type=0,priority=15,delay=3,title="Situation Map",hint="You can see a map of the objectives that need to be captured or defended by pressing %SHOWOBJECTIVES%.")
    Hints(31)=(type=0,priority=15,delay=3,title="Diving to Prone",hint="You can dive to prone by pressing %PRONE% while running, allowing you to quickly take cover. You can also use this to dive over small obstacles and take cover behind them.")

    // Type 1: player jumped
    Hints(02)=(type=1,priority=1,delay=2,title="Jumping",hint="Jumping quickly drains your player's stamina. Use in moderation!")

    // Type 2: Firing weapon
    Hints(05)=(type=2,priority=10,delay=3,title="Iron sights",hint="Press %ROIronSights% to aim down you weapon's sights. This substantially increases the accuracy of your weapon.")
    Hints(06)=(type=2,priority=20,delay=3,title="Accuracy",hint="Automatic weapons are most accurate when fired in short, controllable bursts.")
    Hints(28)=(type=2,priority=20,delay=3,title="Accuracy",hint="Crouching and going prone stabilizes your weapon and lowers recoil when firing. Press the %duck% key to crouch, or the %prone% key to go prone.")
    Hints(33)=(type=2,priority=30,delay=3,title="Weapon Deployment",hint="You can stabilize all projectile weapons by simply resting them on a horizontal or vertical surface. An icon will appear in the lower right corner of the screen if the surface is deployable.")

    // Type 3 - Got in vehicle
    Hints(07)=(type=3,priority=10,delay=2,title="Positions",hint="Use the number keys (%SWITCHWEAPON 1%, %SWITCHWEAPON 2%, %SWITCHWEAPON 3%, ...) to change between various positions in the vehicle.");
    Hints(08)=(type=3,priority=15,delay=2,title="Crew Members",hint="A fully crewed tank is more effective than one driven by a lone player. Try to pick up players along the way to your objectives.");
    Hints(34)=(type=3,priority=30,delay=2,title="Position Views",hint="Use the %PREVWEAPON% and %NEXTWEAPON% keys to cycle between the various views available for each vehicle position. Be careful when sticking your head out of the commander or driver hatch: you are then vulnerable to enemy fire.")
    Hints(35)=(type=3,priority=20,delay=2,title="Tank Control",hint="Use the movement keys to steer and control your vehicle's throttle. Use the %JUMP% key to brake.")
    Hints(36)=(type=3,priority=40,delay=2,title="Armor Usage",hint="When combating other tanks, remember that your armor is strongest at the front. Try to angle the front of your vehicle slightly away from enemy fire.")

    // Type 4: Fired tank cannon
    Hints(10)=(type=4,priority=10,delay=2,title="Weak Points",hint="Each tank has its weak points. Try aiming for the driver's window or the seam between the tank body and turret.")
    Hints(11)=(type=4,priority=10,delay=2,title="Ammo Types",hint="Press %SwitchFireMode% to switch between the various available tank ammo types.")
    Hints(37)=(type=4,priority=10,delay=2,title="Cannon Fire Range",hint="Use the %LEANLEFT% and %LEANRIGHT% keys to adjust the range of your tank sights. The range you have your sights set to is displayed, in meters, in the lower right corner of the screen.")
    Hints(38)=(type=4,priority=50,delay=2,title="Coaxial MG",hint="Most tanks have a coaxial machine gun alongside the main gun. You can fire it from the commander's view by pressing %ALTFIRE%. Note: range adjustments have no effect on the coaxial MG.")

    // Type 5: Died
    //Hints(17)=(type=5,priority=10,delay=1,title="Death Becomes You",hint="You died.");

    // Type 6: Weapon empty
    Hints(12)=(type=6,priority=10,delay=1,title="Reloading",hint="Use the %ROManualReload% key to reload your weapon. A 'Magazine Heavy' message indicates that the magazine you're loading is more than half full of ammunition.");

    // Type 7: Selected satchel
    Hints(39)=(type=7,priority=10,delay=1,title="Satchels",hint="Satchels contain high explosives. They are useful for destroying enemy vehicles and certain objectives. While not all maps have destroyable objectives, those that do have those objectives specially marked on the situation map.")

    // Type 8: Selected binoculars
    Hints(14)=(type=8,priority=10,delay=1,title="Rally Points",hint="When you have the binoculars in Iron Sights, use the %AltFire% button to set a Rally Point. Rally points are visible to all team members on their Situation Map.");
    Hints(15)=(type=8,priority=15,delay=1,title="Artillery Coordinates",hint="When you have the binoculars in Iron Sights, use the %Fire% button to save Artillery Strike coordinates. Once coordinates are marked, find a radio and press %USE% to call an artillery strike on the saved position.");

    // Type 9: Selected grenade
    Hints(13)=(type=9,priority=10,delay=1,title="Soviet grenades",hint="To prime ('cook') Soviet grenades, press and hold the %FIRE%, then click the %ALTFIRE% button. Release the %FIRE% button when you are ready to throw the grenade. Be careful, if you cook it for too long it can go off in your hand!");
    Hints(40)=(type=9,priority=15,delay=1,title="German grenades",hint="The fuse of German grenades will begin burning as soon as you hit the %FIRE% or %ALTFIRE% button.");

    // Type 10: Selected MG
    Hints(41)=(type=10,priority=10,delay=1,title="Deploying MG",hint="To fire your Machine Gun properly, you need to deploy it. You can do this while prone or on any convenient surface: the deployment icon will appear in the bottom right corner of the HUD. Press %Deploy% to deploy when you see the icon.");
    Hints(16)=(type=10,priority=15,delay=1,title="Reloading MGs",hint="You can reload your Machine Gun ONLY when in the deployed state.");
    Hints(17)=(type=10,priority=20,delay=1,title="Requesting Resupply",hint="When you're running low on Machine Gun ammo, you can use the voice menu to request a resupply. Players will see the resupply icon on their Situation Map. Press %SpeechMenuToggle% to open the voice menu.");
    Hints(29)=(type=10,priority=30,delay=1,title="Changing Barrels",hint="You can change the barrels on the MGs by using the %ROMGOperation%. Note that the barrel on the DP 28 cannot be changed, so be careful not to overheat!");
    Hints(18)=(type=10,priority=30,delay=1,title="Deployed MGs",hint="Machine Gunners should never setup alone, find a comrade to watch your back.");

    // Type 11: Select any projectile weapon
    Hints(19)=(type=11,priority=10,delay=1,title="Bayonet",hint="Many weapons support bayonet attachments. Press %Deploy% to attach or detach the bayonet to your weapon and %AltFire% to stab enemies with it.");

    // Type 12: Selected Panzerfaust
    Hints(20)=(type=12,priority=10,delay=1,title="Panzerfaust Aiming",hint="You can change the range that your Panzerfaust will target at by pressing the %Deploy% button. Match the distance of your enemy with the selected range displayed on the Panzerfaust sight.");

    // Type 13: Grenade exploded nearby
    Hints(21)=(type=13,priority=10,delay=1,title="Grenades",hint="Grenades have a dangerous blast radius - get under cover or away from them!");

    // Type 14: Situation map opened
    Hints(23)=(type=14,priority=20,delay=1,title="Rally Points",hint="Squad Leaders can set rally points by clicking on the Situation Map. Those rally points are visible to all team members on their Situation Map.");
    Hints(24)=(type=14,priority=30,delay=1,title="Orders & Requests",hint="Squad leaders can set attack/defend orders to specific objectives. Those objectives show up on the map with a different icon. Similarly, MGs requesting resupply will show up as an icon on the Situation Map.");

    // Type 15: 'Map updated' event
    Hints(22)=(type=15,priority=10,delay=1,title="Objectives Under Attack",hint="Objectives with a flashing icon are objectives which are under attack. Whether the objective is being attacked or defended by your team, they can probably use your help.");

    // Type 16: Reloading weapon
    //Hints(25)=(type=16,priority=10,delay=1,title="Reloading",hint="(reload weapon hint)");

    // Type 17: Objective captured
    Hints(26)=(type=17,priority=20,delay=1,title="Points",hint="You receive 10 points for helping to capture an objective.");
    Hints(30)=(type=17,priority=30,delay=1,title="Officers",hint="When taking an objective, the presence of an officer boosts morale and makes your task easier!");

    // Type 18: Random timer hint (called every 29 seconds, assuming no hint has
    //          been dispatched meanwhile)
    Hints(01)=(type=18,priority=10,delay=0,title="Stamina",hint="Running or jumping will deplete your player's stamina. When it is depleted, you will be unable to run or jump until you have stopped for a bit to catch your breath.")
    Hints(03)=(type=18,priority=20,delay=0,title="Leaning",hint="Press %LeanRight% or %LeanLeft% to lean around corners. Leaning lets you peak around corners without exposing your whole body to the enemy.")
    Hints(27)=(type=18,priority=30,delay=0,title="Capturing Objectives",hint="To capture an objective, you must first enter the objective area. A capture bar will appear on your HUD when you have entered the objective area. You'll likely need more than one additional teammate to initiate and complete the capture.")
    Hints(32)=(type=18,priority=40,delay=0,title="Attacking MGs",hint="Machine Gunners have a limited field of vision while deployed, so try attacking them from the side.")
    Hints(25)=(type=18,priority=40,delay=0,title="Resupplying MGs",hint="Use the %ThrowMGAmmo% to resupply Machine Gunners who need it.")
    Hints(42)=(type=18,priority=40,delay=0,title="Melee Attacks",hint="You can bash an enemy soldier with your weapon by pressing the %ALTFIRE% button. The longer you keep the key pressed, the more powerful your attack will be. Aim for the head for a quick kill!")
    Hints(43)=(type=18,priority=40,delay=0,title="Manual Bolting",hint="When using a bolt-action rifle, you have to manually work your bolt. After you fire your weapon, press the %FIRE% key again to bolt your rifle. Double click the key when firing to bolt quickly after your shot.")
    Hints(44)=(type=18,priority=40,delay=0,title="Critical Messages",hint="Critical messages are displayed in the upper left corner of the screen. Pay attention to them to remain aware of the state of the battle.")

}
