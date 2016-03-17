// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: VehiclePainter_Check.sqf
//	@file Author: LouD, Edited by John Paul
//	@file Description: Vehicle Paint check
_supporterLevel = player getVariable ["supporter", 0];

if(_supporterLevel > 0) then {
	if (!isNull objectFromNetId (player getVariable ['lastVehicleRidden', ''])) then
	{
		closeDialog 0;
		[] execVM 'addons\supporter_addons\VehiclePainter\VehiclePainter_Menu.sqf'
	}
	else
	{
		closeDialog 0;
		_text = format ["You have no last ridden vehicle!"];
		[_text, 10] call mf_notify_client;		
	};
}; 
if(_supporterLevel < 1) then {
	closeDialog 0;
	_text = format ["This is an supporter feature only!"];
	[_text, 10] call mf_notify_client;		
};