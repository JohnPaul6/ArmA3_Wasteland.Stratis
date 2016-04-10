// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
#define DonatorDialog 95510
#define DonatorVehPaintButton 95514
#define DonatorBodyPaintButton 95513
#define DonatorTitle 95521
#define Donatornon 95522

class Donator {

	idd = DonatorDialog;
	movingEnable = true;
	enableSimulation = true;

	class controlsBackground {

		class MainBG : w_RscPicture {
			idc = -1;
			text = "client\systems\playerMenu\dialog\img\SGW-Inventory.paa";
			moving = false;
			x = 0; 
			y = -0.25;
			w = 1; 
			h = 1.35;
		};
		
		class MainTitle : w_RscText {
			idc = DonatorTitle;
			text = "Supporter Panel";
			sizeEx = 0.04;
			shadow = 2;
			x = 0.360; y = 0.10;
			w = 0.3; h = 0.05;
		};
		

		class Donatornon_text : w_RscText {
			idc = Donatornon;
			text = "You appear not to be a supporter. Donate @ Strayagaming.com.au";
			sizeEx = 0.04;
			shadow = 2;
			x = 0.0375; y = 0.155; 
			w = 0.7; h = 0.050;
		};
	};

	class controls {
		class CloseButton : w_RscButton {
			idc = -1;
			text = "Close";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "closeDialog 0;";
			x = 0.16; y = 0.70; //x = 0.02; y = 0.66; .138 differnce 
			w = 0.125; h = 0.033 * safezoneH;
		};
		
		class DonatorVehPaintButton : w_RscButton {
			idc = DonatorVehPaintButton; 
			text = "Paint Vehicle";
			onButtonClick = "[] execVM 'addons\supporter_addons\VehiclePainter\VehiclePainter_Check.sqf'";
			x = 0.4075; y = 0.200;
			w = 0.16; h = 0.033 * safezoneH;
		};

		class DonatorBodyPaintButton : w_RscButton {
			idc = DonatorBodyPaintButton;
			text = "Paint Player";
			onButtonClick = "[] execVM 'addons\supporter_addons\UniformPainter\UniformPainter_Menu.sqf'";
			x = 0.4075; y = 0.270;
			w = 0.16; h = 0.033 * safezoneH;
		};
	};
};

