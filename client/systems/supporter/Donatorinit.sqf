//	@file Version: 1.0
//	@file Name: Donatorinit.sqf
//	@file Author: John Paul
//	@file Created: 25/10/2015 

#define DonatorDialog 95510
#define DonatorVehPaintButton 95514
#define DonatorBodyPaintButton 95513
#define DonatorTitle 95521
#define Donatornon 95522

disableSerialization;

_supporterLevel = player getVariable ["supporter", 0];

_start = createDialog "Donator";
waitUntil{!isNull(findDisplay DonatorDialog)};
_dialog = findDisplay DonatorDialog;
_DonatorVehPaint = _dialog displayCtrl DonatorVehPaintButton;
_DonatorPaintSelf = _dialog displayCtrl DonatorBodyPaintButton;
_DonatorTitle = _dialog displayCtrl DonatorTitle;
_Donatornon = _dialog displayCtrl Donatornon;

// Non Donator Dialogs by default are displayed
_Donatornon ctrlShow true;
_DonatorTitle ctrlShow true;

// Donator Dialogs by default are hidden
_DonatorVehPaint ctrlShow false;
_DonatorPaintSelf ctrlShow false;

// Change dialogs that are shown based off _supporterLevel
switch (_supporterLevel) do {
	case 1: {
		_Donatornon ctrlShow false;
		_DonatorTitle ctrlShow true;
		_DonatorVehPaint ctrlShow true;
		_DonatorPaintSelf ctrlShow true;
	};
	case 2: {
		_Donatornon ctrlShow false;
		_DonatorTitle ctrlShow true;
		_DonatorVehPaint ctrlShow true;
		_DonatorPaintSelf ctrlShow true;
	};
	case 3: {
		_Donatornon ctrlShow false;
		_DonatorTitle ctrlShow true;
		_DonatorVehPaint ctrlShow true;
		_DonatorPaintSelf ctrlShow true;
	};
	case 4: {
		_Donatornon ctrlShow false;
		_DonatorTitle ctrlShow true;
		_DonatorVehPaint ctrlShow true;
		_DonatorPaintSelf ctrlShow true;
	};
	default {
		_Donatornon ctrlShow true;
		_DonatorTitle ctrlShow true;
		_DonatorVehPaint ctrlShow false;
		_DonatorPaintSelf ctrlShow false;
	};
};
