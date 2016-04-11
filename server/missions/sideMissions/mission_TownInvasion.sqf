// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_TownInvasion.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev, Zenophon
//  @file Information: JoSchaap's Lite version of 'Infantry Occupy House' Original was made by: Zenophon

if (!isServer) exitwith {};

#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_townName", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly", "_tent1", "_chair1", "_chair2", "_cFire1"];

_setupVars =
{
	_missionType = "Town Invasion";
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };

	// settings for this mission
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;

};

_setupObjects =
{
	_spawnlist = 
	[
	"HostileJet_1",
	"HostileJet_2",
	"HostileJet_3",
	"HostileJet_4",
	"HostileJet_5",
	"HostileJet_6",
	"HostileJet_7",
	"HostileJet_8"
	];
	_Heli_spawn_Pos = markerPos (_spawnlist call BIS_fnc_selectRandom);

	_heliChoices =
	[
		["B_Heli_Transport_03_unarmed_green_F"],
		["B_Heli_Transport_03_unarmed_F"]
	];

	_HeliVeh = _heliChoices call BIS_fnc_selectRandom;
	
	_veh1 = _HeliVeh select 0;

	_vehicle = createVehicle [_veh1, _Heli_spawn_Pos, [], 90, "FLY"]; // Added to make it fly
	_vehicle setVariable ["R3F_LOG_disabled", true, true];
	_vehicle flyInHeight 200;
	_vehicle setVariable [call vChecksum, true, false];

	// add pilot
	_GrpPilot = createGroup RESISTANCE;
	_GrpPilot setBehaviour "COMBAT";
	_GrpPilot setCombatMode "RED";
	_Pilot = [_grpPilot, _Heli_spawn_Pos] call createRandomPilot; 
	_Pilot setSkill 1;
	_Pilot moveInDriver _vehicle;

	
	_grpCount = 5;							//default: 5 - this is our minimum number of paratroopers
	_grpReinforce = floor(random 3)+1;		//number of additional paratroopers 1-3
	_total_grpCount = _grpCount + _grpReinforce;
	
	_aiGroup = createGroup CIVILIAN;
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setCombatMode "RED";

	_towninvision_pos = _aiGroup addWaypoint [_missionPos, 0];

	
	for "_i" from 1 to (_total_grpCount) do
		{
			// Create Unit(s)
			_unit = [_aiGroup, _Heli_spawn_Pos] call createRandomSoldier;
			_unit addBackpackGlobal "B_Parachute";

			_unit assignAsCargoIndex [_vehicle, 1];
			_unit moveInCargo _vehicle;


			_unit setRank "Private";
		};
	
	[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
	
	//set waypoint for helicopter
	_wpPosition =_grpPilot addWaypoint [_missionPos, 0];
	_wpPosition setWaypointType "MOVE";
	_wpPosition setWaypointSpeed "FULL";
	_wpPosition setWaypointBehaviour "COMBAT";
	//waitUntil {currentWaypoint _aiGroup >= 1};
	
	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");
	_missionHintText = format ["An armed <t color='%2'>%1</t> is patrolling the island. Shoot it down and kill the pilot to recover the money and weapons!", _vehicleName, sideMissionColor];
		
	waitUntil {(_vehicle distance2D _missionPos) < 75};
	
	{
        doGetOut  _x;
        unassignVehicle _x
    } foreach units _aigroup;
	
	_backhome_heli = _GrpPilot addWaypoint [_Heli_spawn_Pos, 0];
	
	waitUntil {(_vehicle distance2D _Heli_spawn_Pos) < 75};
	
	deletevehicle _vehicle;


};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{

};

_successExec =
{
	_successHintMessage = format ["Nice work!<br/><br/><t color='%1'>%2</t><br/>is a safe place again!<br/>Their belongings are now yours to take!", sideMissionColor, _townName];
};

_this call sideMissionProcessor;
