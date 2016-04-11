// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: Server_event_1.sqf
//	@file Author: John Paul
private ["_vehicle", "_marker"];

_Admin_ran_by = _this select 1;

//Random Colour array with names of the colours.
_color = "#(rgb,1,1,1)color";
_colourlist_array = [
["Black", _color + "(0.01,0.01,0.01,1)"], // #(argb,8,8,3)color(0.1,0.1,0.1,0.1)
["Gray", _color + "(0.15,0.151,0.152,1)"], // #(argb,8,8,3)color(0.5,0.51,0.512,0.3)
["White", _color + "(0.75,0.75,0.75,1)"], // #(argb,8,8,3)color(1,1,1,0.5)
["Dark Blue", _color + "(0,0.05,0.15,1)"], // #(argb,8,8,3)color(0,0.3,0.6,0.05)
["Blue", _color + "(0,0.03,0.5,1)"], // #(argb,8,8,3)color(0,0.2,1,0.75)
["Teal", _color + "(0,0.3,0.3,1)"], // #(argb,8,8,3)color(0,1,1,0.15)
["Green", _color + "(0,0.5,0,1)"], // #(argb,8,8,3)color(0,1,0,0.15)
["Yellow", _color + "(0.5,0.4,0,1)"], // #(argb,8,8,3)color(1,0.8,0,0.4)
["Orange", _color + "(0.4,0.09,0,1)"], // #(argb,8,8,3)color(1,0.5,0,0.4)
["Red", _color + "(0.45,0.005,0,1)"], // #(argb,8,8,3)color(1,0.1,0,0.3)
["Pink", _color + "(0.5,0.03,0.3,1)"], // #(argb,8,8,3)color(1,0.06,0.6,0.5)
["Purple", _color + "(0.1,0,0.3,1)"] // #(argb,8,8,3)color(0.8,0,1,0.1)
];
//Selects the random colour for the array above
_random_colour_array = _colourlist_array call BIS_fnc_selectRandom;

//List of spawn locations for the jet
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
_JetPos = markerPos (_spawnlist call BIS_fnc_selectRandom);

//Setups wipeout and moves player into the vehicle and paints it with the random colour
_vehicle = createVehicle ["B_Plane_CAS_01_F", _JetPos, [], 0, "FLY"]; // Added to make it fly
_vehicle setDir 0;
_vehicle setVelocity [0, 300, 0];
_vehicle setObjectTextureGlobal [0, (_random_colour_array select 1)]; //set it on player
_vehicle setObjectTextureGlobal [1, (_random_colour_array select 1)]; //set it on player
_vehicle setVehicleVarName "Server_event_jet";
//_vehicle setVariable [call vChecksum, true, false];
player moveInDriver _vehicle;
_vehicle setVariable ["R3F_LOG_disabled", true, true];
_vehicle removeMagazineTurret ["2Rnd_Missile_AA_04_F",[-1]];
_vehicle removeMagazineTurret ["6Rnd_Missile_AGM_02_F",[-1]];
_vehicle removeMagazineTurret ["7Rnd_Rocket_04_HE_F",[-1]];
_vehicle removeMagazineTurret ["7Rnd_Rocket_04_AP_F",[-1]];
_vehicle removeMagazineTurret ["4Rnd_Bomb_04_F",[-1]];

_warntext = format ["A hostile jet has been spotted. Shoot down the %1 Jet and recover the 100k!", (_random_colour_array select 0) ];;
hint format ["Hello %1, your vehicle has been painted %2 and good luck!",name player, (_random_colour_array select 0) ];
[format ["Global Message from %2: %1", _warnText, _Admin_ran_by], "A3W_fnc_titleTextMessage"] call A3W_fnc_MP;

//Creates marker for server event
_marker1 = createMarker ["Marker1", position player];
_marker1 setMarkerType "mil_destroy";
_marker1 setMarkerSize [1.25, 1.25];
_marker1 setMarkerColor "ColorRed";
_marker1 setMarkerText "Jet - Server Event";

//Updates marker while jet is alive.
while{(getDammage _vehicle) < 0.99} do {
"Marker1" setmarkerpos position _vehicle;
sleep 0.1; };

//Waits until the vehicle is dead
waitUntil {!alive _vehicle};

[] spawn {sleep 20; "Marker1" setmarkerpos getPos _vehicle; };

_marker1 setMarkerType "mil_destroy";
_marker1 setMarkerSize [1.25, 1.25];
_marker1 setMarkerColor "ColorOrange";
_marker1 setMarkerText "Fallen Jet - Server Event - $100,000";

waitUntil{getPos _vehicle select 2 < 2;};

sleep 10;

for "_i" from 1 to 4 do
	{
		_cash = createVehicle ["Land_Money_F", position _vehicle, [], 5, "None"];
		_cash setPos ([position _vehicle, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 25000, true];
		_cash setVariable ["owner", "world", true];
	};
	
[] spawn {sleep 300; deleteMarker "Marker1";};