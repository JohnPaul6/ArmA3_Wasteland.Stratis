// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_geoCache.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, edit by CRE4MPIE & LouD
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_geoPos", "_geoCache", "_randomBox", "_randomCase", "_box1", "_para"];

_setupVars =
{
	_missionType = "Resupply Mission";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_geoPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);	//_geoPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_geoCache = createVehicle ["Land_SatellitePhone_F",[(_geoPos select 0), (_geoPos select 1),0],[], 0, "NONE"]; //Land_SurvivalRadio_F

	_missionHintText = "A Laptop has been marked on the map. Find this and a Resupply Crate containing <t color='%1'>General Supplies</t> will be parachuted!";
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_waitUntilSuccessCondition = {{isPlayer _x && _x distance _geoPos < 5} count playableUnits > 0};

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_GeoCache];
};

_successExec =
{
	// Mission completed
	{ deleteVehicle _x } forEach [_GeoCache];
	
	_heliType = "B_Heli_Transport_03_unarmed_F";
	_center = createCenter civilian;
	_grp = createGroup civilian;
	if(isNil("_grp2"))then{_grp2 = createGroup civilian;}else{_grp2 = _grp2;};
	_flyHeight = 350;
	//_dropSpot = [(position _missionPos select 0),(position _missionPos select 1),_flyHeight];
	_heliDirection = random 360;
	_flyHeight = 400;  //Distance from ground that heli will fly at
	_heliStartDistance = 5000;
	_spos=[(_geoPos select 0) - (sin _heliDirection) * _heliStartDistance, (_geoPos select 1) - (cos _heliDirection) * _heliStartDistance, (_flyHeight+200)];

	diag_log format ["AAA - Heli Spawned at %1", _spos];
	_heli = createVehicle [_heliType, _spos, [], 0, "FLY"];
	_heli allowDamage false;
	_heli setVariable ["R3F_LOG_disabled", true, true];
	[_heli] call vehicleSetup;

	_crew = [_grp, _spos] call createRandomSoldierC;
	_crew moveInDriver _heli;
	_crew allowDamage false;

	_heli setCaptive true;

	_heliDistance = 5000;
	_dir = ((_geoPos select 0) - (_spos select 0)) atan2 ((_geoPos select 1) - (_spos select 1));
	_flySpot = [(_geoPos select 0) + (sin _dir) * _heliDistance, (_geoPos select 1) + (cos _dir) * _heliDistance, _flyHeight];

	_grp setCombatMode "BLUE";
	_grp setBehaviour "SAFE";

	{_x disableAI "AUTOTARGET"; _x disableAI "TARGET";} forEach units _grp;

	_wp0 = _grp addWaypoint [_geoPos, 0, 1];
	[_grp,1] setWaypointBehaviour "SAFE";
	[_grp,1] setWaypointCombatMode "BLUE";
	[_grp,1] setWaypointCompletionRadius 20;
	_wp1 = _grp addWaypoint [_flySpot, 0, 2];
	[_grp,2] setWaypointBehaviour "SAFE";
	[_grp,2] setWaypointCombatMode "BLUE";
	[_grp,2] setWaypointCompletionRadius 1;
	_heli flyInHeight _flyHeight;
	
	_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) - 5];
	_object = createVehicle ["B_supplyCrate_F", _objectSpawnPos, [], 0, "None"];
	[_object, ["mission_USSpecial", "mission_Main_A3snipers","mission_USLaunchers"] call BIS_fnc_selectRandom] call fn_refillbox;
	_object setVariable ["A3W_purchasedStoreObject", true];
	_object setVariable ["R3F_LOG_disabled", false, true];
	_object attachTo [_heli, [0,0,-5]]; //Attach Object to the heli
	
	_object allowDamage false; //Let's not let these things get destroyed on the way there, shall we?
	
	waitUntil { currentWaypoint _grp >= 2; };
	
	detach _object;  //WHEEEEEEEEEEEEE
	_objectPosDrop = position _object;
	_heli fire "CMFlareLauncher";
	_heli fire "CMFlareLauncher";
	
	//Delete heli once it has proceeded to end point
	[_heli,_grp,_flySpot,_geoPos,_heliDistance] spawn {
		private ["_heli","_grp","_flySpot","_dropSpot","_heliDistance"];
		_heli = _this select 0;
		_grp = _this select 1;
		_flySpot = _this select 2;
		_geoPos = _this select 3;
		_heliDistance = _this select 4;
		while{([_heli, _flySpot] call BIS_fnc_distance2D)>200}do{
			if(!alive _heli || !canMove _heli)exitWith{};
			sleep 5;
		};
		waitUntil{([_heli, _dropSpot] call BIS_fnc_distance2D)>(_heliDistance * .5)};
		{ deleteVehicle _x; } forEach units _grp;
		deleteVehicle _heli;
	};

	//Time based deletion of the heli, in case it gets distracted
	[_heli,_grp] spawn {
		private ["_heli","_grp"];
		_heli = _this select 0;
		_grp = _this select 1;
		sleep 30;
		if (alive _heli) then
		{
			{ deleteVehicle _x; } forEach units _grp;
			deleteVehicle _heli;
			diag_log "AIRDROP SYSTEM - Deleted Heli after Drop";
		};
	};
	
	WaitUntil {(((position _object) select 2) < (_flyHeight-20))};
		_heli fire "CMFlareLauncher";
		_objectPosDrop = position _object;
		_para = createVehicle ["B_Parachute_02_F", _objectPosDrop, [], 0, ""];
		_object attachTo [_para,[0,0,-1.5]];
		
		_para setVectorUp [0,0,1];
		_para setVelocity [0, 0, (velocity _para) select 2];

		_smoke1= "SmokeShellGreen" createVehicle getPos _object;
		_smoke1 attachto [_object,[0,0,-0.5]];
		_flare1= "F_40mm_Green" createVehicle getPos _object;
		_flare1 attachto [_object,[0,0,-0.5]];

		if (_type == "vehicle") then {_object allowDamage true;}; //Turn on damage for vehicles once they're in the 'chute.  Could move this until they hit the ground.  Admins choice.
	
	_successHintMessage = "The GeoCache supplies have been delivered by parachute!";
};

_this call sideMissionProcessor;