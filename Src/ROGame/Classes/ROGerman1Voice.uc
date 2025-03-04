//------------------------------------------------------------------------------
// $Id: ROGerman1Voice.uc,v 1.6 2004/02/13 17:10:57 bwright Exp $
//------------------------------------------------------------------------------
class ROGerman1Voice extends ROVoicePack;

#exec OBJ LOAD FILE=..\Sounds\voice_ger_infantry.uax
#exec OBJ LOAD FILE=..\Sounds\voice_ger_vehicle.uax

/*
  Order (only available to squad leader, all shouts)
- Attack/Carry out
--- (Territorial Objective) -- "Form up and assault the objective"
--- (Satchel Objective) -- "Let's move out and support the engineer so we can blow the objective"
- Defend
--- (Objectives) -- "Defend the objective"
- Hold this position -- "Hold this position"
- Get over here -- "Get over here" -- Has uses with objectives, basically a "Need more men" without the exact number for simplicity
- Move out -- "Move out", "Go, go, go"
- Retreat -- "Retreat", "Fall back"
- Engage -- "Engage", "Engage the enemy"
- Cease fire -- "Cease fire"

Acknowledge (these are for replying to orders and requests for assistance, medium volume)
- Yes, sir -- "Yes, sir"
- Cannot comply -- "I can't do that"
- On my way -- "I'm on my way"

Shout (these are loud voice messages with bigger radius)
- Enemy spotted -- "Enemy spotted!"
- Need assistance -- "I need assistance!", "I could use some help over here!"
- Taking heavy fire -- "Taking heavy fire!"
- Cover me -- "Cover me", "Watch my back"
- Take cover -- "Take cover!", "Get down!"
- Sniper - "Sniper!"
- Machine gun - "Machine gun!"
- Grenade - "Grenade!" -- fine, i'll compromise....
- Friendly fire -- "Friendly fire!", "I'm on your side!"

Whisper (these are soft messages with a small radius)
- Enemy ahead -- "Enemy ahead"
- Cover me -- "Cover me", "Watch my back"
- Take cover -- "Take cover", "Get down"
- Throwing grenade -- "I'm throwing a grenade" -- another compromise....

Gesture (these are just gestures with nothing spoken, always in forward direction)
- Beckon -- Cupped hand gesturing to come here
- Halt -- Hold out hand gesturing to stop
- Point -- Outstretch arm and point finger forward
*/
defaultproperties
{
    // Support sound groups
    SupportSound[0]=SoundGroup'voice_ger_infantry.requests.need_help'
    SupportSound[1]=SoundGroup'voice_ger_infantry.requests.need_help_at'
    SupportSound[2]=SoundGroup'voice_ger_infantry.requests.need_ammo'
    SupportSound[3]=SoundGroup'voice_ger_infantry.requests.need_sniper'
    SupportSound[4]=SoundGroup'voice_ger_infantry.requests.need_MG'
    SupportSound[5]=SoundGroup'voice_ger_infantry.requests.need_AT'
    SupportSound[6]=SoundGroup'voice_ger_infantry.requests.need_demolitions'
    SupportSound[7]=SoundGroup'voice_ger_infantry.requests.need_tank'
    SupportSound[8]=SoundGroup'voice_ger_infantry.requests.need_artillery'
    SupportSound[9]=SoundGroup'voice_ger_infantry.requests.need_transport'

    // Ack sound groups
    AckSound[0]=SoundGroup'voice_ger_infantry.responses.yes'
    AckSound[1]=SoundGroup'voice_ger_infantry.responses.no'
    AckSound[2]=SoundGroup'voice_ger_infantry.responses.thanks'
    AckSound[3]=SoundGroup'voice_ger_infantry.responses.sorry'

    // Enemy sound groups
    EnemySound[0]=SoundGroup'voice_ger_infantry.spotted.infantry'
    EnemySound[1]=SoundGroup'voice_ger_infantry.spotted.MG'
    EnemySound[2]=SoundGroup'voice_ger_infantry.spotted.sniper'
    EnemySound[3]=SoundGroup'voice_ger_infantry.spotted.pioneer'
    EnemySound[4]=SoundGroup'voice_ger_infantry.spotted.AT_soldier'
    EnemySound[5]=SoundGroup'voice_ger_infantry.spotted.Vehicle'
    EnemySound[6]=SoundGroup'voice_ger_infantry.spotted.tank'
    EnemySound[7]=SoundGroup'voice_ger_infantry.spotted.heavy_tank'
    EnemySound[8]=SoundGroup'voice_ger_infantry.spotted.artillery'

    // Alert sound groups
    AlertSound[0]=SoundGroup'voice_ger_infantry.alerts.Grenade'
    AlertSound[1]=SoundGroup'voice_ger_infantry.alerts.gogogo'
    AlertSound[2]=SoundGroup'voice_ger_infantry.alerts.take_cover'
    AlertSound[3]=SoundGroup'voice_ger_infantry.alerts.Stop'
    AlertSound[4]=SoundGroup'voice_ger_infantry.commander.follow_me'
    AlertSound[5]=SoundGroup'voice_ger_infantry.alerts.satchel_planted'
    AlertSound[6]=SoundGroup'voice_ger_infantry.alerts.covering_fire'
    AlertSound[7]=SoundGroup'voice_ger_infantry.alerts.friendly_fire'
    AlertSound[8]=SoundGroup'voice_ger_infantry.alerts.under_attack_at'
    AlertSound[9]=SoundGroup'voice_ger_infantry.commander.retreat'

    // Vehicle direction sound groups
    vehicleDirectionSound[0]=SoundGroup'voice_ger_vehicle.directions.go_to_objective'
    vehicleDirectionSound[1]=SoundGroup'voice_ger_vehicle.directions.forwards'
    vehicleDirectionSound[2]=SoundGroup'voice_ger_vehicle.directions.Stop'
    vehicleDirectionSound[3]=SoundGroup'voice_ger_vehicle.directions.Reverse'
    vehicleDirectionSound[4]=SoundGroup'voice_ger_vehicle.directions.Left'
    vehicleDirectionSound[5]=SoundGroup'voice_ger_vehicle.directions.Right'
    vehicleDirectionSound[6]=SoundGroup'voice_ger_vehicle.directions.nudge_forward'
    vehicleDirectionSound[7]=SoundGroup'voice_ger_vehicle.directions.nudge_back'
    vehicleDirectionSound[8]=SoundGroup'voice_ger_vehicle.directions.nudge_left'
    vehicleDirectionSound[9]=SoundGroup'voice_ger_vehicle.directions.nudge_right'

    // Vehicle alert sound groups
    vehicleAlertSound[0]=SoundGroup'voice_ger_vehicle.alerts.enemy_forward'
    vehicleAlertSound[1]=SoundGroup'voice_ger_vehicle.alerts.enemy_left'
    vehicleAlertSound[2]=SoundGroup'voice_ger_vehicle.alerts.enemy_right'
    vehicleAlertSound[3]=SoundGroup'voice_ger_vehicle.alerts.enemy_behind'
    vehicleAlertSound[4]=SoundGroup'voice_ger_vehicle.alerts.enemy_infantry'
    vehicleAlertSound[5]=SoundGroup'voice_ger_vehicle.alerts.yes'
    vehicleAlertSound[6]=SoundGroup'voice_ger_vehicle.alerts.no'
    vehicleAlertSound[7]=SoundGroup'voice_ger_vehicle.alerts.we_are_burning'
    vehicleAlertSound[8]=SoundGroup'voice_ger_vehicle.alerts.get_out'
    vehicleAlertSound[9]=SoundGroup'voice_ger_vehicle.alerts.Loaded'

    // Commander sound groups
    OrderSound[0]=SoundGroup'voice_ger_infantry.commander.attack_objective'
    OrderSound[1]=SoundGroup'voice_ger_infantry.commander.defend_objective'
    OrderSound[2]=SoundGroup'voice_ger_infantry.commander.hold_this_position'
    OrderSound[3]=SoundGroup'voice_ger_infantry.commander.follow_me'
    OrderSound[4]=SoundGroup'voice_ger_infantry.commander.Attack'
    OrderSound[5]=SoundGroup'voice_ger_infantry.commander.retreat'
    OrderSound[6]=SoundGroup'voice_ger_infantry.commander.fire_at_will'
    OrderSound[7]=SoundGroup'voice_ger_infantry.commander.cease_fire'

    // Extras sound groups
    ExtraSound[0]=SoundGroup'voice_ger_infantry.insults.i_will_kill_you'
    ExtraSound[1]=SoundGroup'voice_ger_infantry.insults.no_retreat'
    ExtraSound[2]=SoundGroup'voice_ger_infantry.insults.insult'

    bUseAxisStrings=true
}
