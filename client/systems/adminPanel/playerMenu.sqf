// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: playerMenu.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:19
//	@file Args:

#define playerMenuDialog 55500
#define playerMenuPlayerList 55505
#define TPPtoM_Button 55611
#define TPMtoP_Button 55612
#define Server_event_1 55613

disableSerialization;

private ["_start","_dialog","_playerListBox","_decimalPlaces","_health","_namestr","_index","_punishCount","_side"];
_uid = getPlayerUID player;
if (_uid call isAdmin) then
{
	_start = createDialog "PlayersMenu";
	_dialog = findDisplay playerMenuDialog;
	_playerListBox = _dialog displayCtrl playerMenuPlayerList;
	
	_TPPtoM_Button = _dialog displayCtrl TPPtoM_Button;
	_TPMtoP_Button = _dialog displayCtrl TPMtoP_Button;
	_Server_event_1 = _dialog displayCtrl Server_event_1;
	
	if !([_uid, highAdmins] call isAdmin || [_uid, serverOwners] call isAdmin) then
	{
		_TPPtoM_Button ctrlEnable false;
		_TPPtoM_Button ctrlSetTooltip "Admin & Above only";
		_TPMtoP_Button ctrlEnable false;
		_TPMtoP_Button ctrlSetTooltip "Admin & Above only";
		_Server_event_1 ctrlEnable false;
		_Server_event_1 ctrlSetTooltip "Admin & Above only";
	};

	{
		_uid = getPlayerUID _x;
		_punishCount = 0;
		_lockedSide = "None";
		{ if (_x select 0 == _uid) exitWith { _punishCount = _x select 1 } } forEach pvar_teamKillList;
		{ if (_x select 0 == _uid) exitWith { _lockedSide = _x select 1 } } forEach pvar_teamSwitchList;
		_namestr = format ["%1 [Side:%3] [TLock:%4] [Punishes:%5]", name _x , getplayerUID _x, side _x, _lockedSide, _punishCount];
		_index = _playerListBox lbAdd _namestr;
		_playerListBox lbSetData [_index, _uid];
		_punishCount = 0;
	} forEach allPlayers;

	lbSort _playerListBox;
};
