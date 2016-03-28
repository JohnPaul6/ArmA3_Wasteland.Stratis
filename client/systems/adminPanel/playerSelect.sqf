// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: playerSelect.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:19
//	@file Args:

#define playerMenuDialog 55500
#define playerMenuPlayerList 55505
#define playerMenuSpectateButton 55506
#define playerMenuWarnMessage 55509

disableSerialization;

private ["_dialog","_playerListBox","_spectateButton","_switch","_index","_modSelect","_playerData","_target","_check","_spectating","_camadm","_rnum","_warnText","_targetUID","_playerName"];
_uid = getPlayerUID player;
_Name = profileName;
if (_uid call isAdmin) then
{
	_dialog = findDisplay playerMenuDialog;
	_playerListBox = _dialog displayCtrl playerMenuPlayerList;
	_spectateButton = _dialog displayCtrl playerMenuSpectateButton;
	_warnMessage = _dialog displayCtrl playerMenuWarnMessage;

	_switch = _this select 0;
	_index = lbCurSel _playerListBox;
	_playerData = _playerListBox lbData _index;

	{
		if (getPlayerUID _x == _playerData) exitWith
		{
			_target = _x;
		};
	} forEach allPlayers;
	

	switch (_switch) do
	{
		case 0: //Spectate
		{
			if (isNil "_target" || {isNull _target}) exitWith{};
			
			if (!isNil "_target") then
			{
				_spectating = ctrlText _spectateButton;
				if (_spectating == "Spectate") then
				{
					if (!([player] call camera_enabled)) then
					{
						[] call camera_toggle;
						["PlayerMgmt_Spectate", format ["%1 (%2)", name _target, getPlayerUID _target]] call notifyAdminMenu;
					};

					[player, _target] call camera_attach_to_target;
					player commandChat format ["Viewing %1.", name _target];
					_spectateButton ctrlSetText "Spectating";
				} else {
					_spectateButton ctrlSetText "Spectate";
					player commandChat format ["No Longer Viewing.", name _target];

					if ([player] call camera_enabled) then
					{
						[] call camera_toggle;
					};
				};
			};
		};
		case 1: //Warn
		{
			if (isNil "_target" || {isNull _target}) exitWith{};
			
			_warnText = ctrlText _warnMessage;
			_playerName = name player;
			[format ["Message from %2: %1", _warnText, _Name], "A3W_fnc_titleTextMessage", _target, false] call A3W_fnc_MP;
			["PlayerMgmt_Warn", format ["%1 (%2) - %3", name _target, getPlayerUID _target, _warnText]] call notifyAdminMenu;
		};
		case 2: //Slay
		{
			if (isNil "_target" || {isNull _target}) exitWith{};
			

			if (damage _target < 1) then { _target setDamage 1 }; // if check required to prevent "Killed" EH from getting triggered twice
			["PlayerMgmt_Slay", format ["%1 (%2)", name _target, getPlayerUID _target]] call notifyAdminMenu;
		};
		case 3: //Unlock Team Switcher
		{
			if (isNil "_target" || {isNull _target}) exitWith{};
		
			pvar_teamSwitchUnlock = getPlayerUID _target;
			publicVariableServer "pvar_teamSwitchUnlock";
			["PlayerMgmt_UnlockTeamSwitch", format ["%1 (%2)", name _target, getPlayerUID _target]] call notifyAdminMenu;
		};
		case 4: //Unlock Team Killer
		{
			if (isNil "_target" || {isNull _target}) exitWith{};
		
			pvar_teamKillUnlock = getPlayerUID _target;
			publicVariableServer "pvar_teamKillUnlock";
			["PlayerMgmt_UnlockTeamKill", format ["%1 (%2)", name _target, getPlayerUID _target]] call notifyAdminMenu;
		};
		case 5: //Remove All Money
		{
			if (isNil "_target" || {isNull _target}) exitWith{};
			
			_targetUID = getPlayerUID _target;
			{
				if(getPlayerUID _x == _targetUID) exitWith
				{
					_x setVariable["cmoney",0,true];
				};
			}forEach playableUnits;
			["PlayerMgmt_RemoveMoney", format ["%1 (%2)", name _target, getPlayerUID _target]] call notifyAdminMenu;
		};
		case 6: //Unstuck Selected Player
		{
			if (isNil "_target" || {isNull _target}) exitWith{};
			
			_targetUID = getPlayerUID _target;
			{
				if(getPlayerUID _x == _targetUID) exitWith
				{
					_unstuck = [(getPosASL _x select 0), (getPosASL _x select 1), (getPosASL _x select 2) + 1000]; 
					_x setposATL _unstuck
				};
			}forEach playableUnits;
			["PlayerMgmt_Unstuck", format ["%1 (%2)", name _target, getPlayerUID _target]] call notifyAdminMenu;
		};
		case 7: //Teleport Player to Me
		{
			if (isNil "_target" || {isNull _target}) exitWith{};
			
			_targetUID = getPlayerUID _target;
			{
				if(getPlayerUID _x == _targetUID) exitWith
				{
					vehicle _x setPos (position player);
				};
			}forEach playableUnits;

			["PlayerMgmt_TP_Player_to_Me", format ["%1 (%2)", name _target, getPlayerUID _target]] call notifyAdminMenu;
		};
		case 8: //Teleport Me to Player
		{
			_targetUID = getPlayerUID _target;
			{
				if (isNil "_target" || {isNull _target}) exitWith{};
				
				if(getPlayerUID _x == _targetUID) exitWith
				{
					vehicle player setPos (position _x);
				};
			}forEach playableUnits;
			["PlayerMgmt_TP_Me_to_Player", format ["%1 (%2)", name _target, getPlayerUID _target]] call notifyAdminMenu;
		};
		case 9: //Kick to Independent
		{
			if (isNil "_target" || {isNull _target}) exitWith{};
			
			_targetUID = getPlayerUID _target;
			pvar_punishTeamKiller = [_target, getPlayerUID _target, 1, _Name];
			publicVariableServer "pvar_punishTeamKiller";
			["PlayerMgmt_Kick_to_Indie", format ["%1 (%2)", name _target, getPlayerUID _target]] call notifyAdminMenu;
		};
		case 10: //Message All
		{
			if (["Are you sure you want to message everyone this message?", "Confirm", "Yes", true] call BIS_fnc_guiMessage) then
			{
				_warnText = ctrlText _warnMessage;
				[format ["Global Message from %2: %1", _warnText, _Name], "A3W_fnc_titleTextMessage"] call A3W_fnc_MP;
				["PlayerMgmt_WarnAll", format ["%1", _warnText]] call notifyAdminMenu;
			};
		};
	};
};
