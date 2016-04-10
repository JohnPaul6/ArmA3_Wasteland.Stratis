// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
#include "player_sys.sqf"

class playerSettings {

	idd = playersys_DIALOG;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] execVM 'client\systems\playerMenu\item_list.sqf'";

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
			idc = -1;
			text = "Player Inventory";
			sizeEx = 0.04;
			shadow = 2;
			x = 0.56; y = 0.1; //x = 0.260; y = 0.1;
			w = 0.3; h = 0.05;
		};

		class waterIcon : w_RscPicture {
			idc = -1;
			text = "client\icons\water.paa";
			x = 0.15; y = 0.153; //x = -0.06; y = 0.153;
			w = 0.04 / (4/3); h = 0.04;
		};

		class foodIcon : w_RscPicture {
			idc = -1;
			text = "client\icons\food.paa";
			x = 0.15; y = 0.22; //x = -0.06; y = 0.22;
			w = 0.04 / (4/3); h = 0.04;
		};

		class moneyIcon : w_RscPicture {
			idc = -1;
			text = "client\icons\money.paa";
			x = 0.15; y = 0.28; //x = -0.06; y = 0.28;
			w = 0.04 / (4/3); h = 0.04;
		};

		class waterText : w_RscText {
			idc = water_text;
			text = "";
			sizeEx = 0.03;
			x = 0.19; y = 0.153; // x = -0.022; y = 0.153;
			w = 0.3; h = 0.05;
		};

		class foodText : w_RscText {
			idc = food_text;
			sizeEx = 0.03;
			text = "";
			x = 0.19; y = 0.22; //x = -0.022; y = 0.22;
			w = 0.3; h = 0.05;
		};

		class moneyText : w_RscText {
			idc = money_text;
			text = "";
			sizeEx = 0.03;
			x = 0.19; y = 0.28; //x = -0.022; y = 0.28;
			w = 0.3; h = 0.05;
		};

		class distanceText : w_RscText {
			idc = view_range_text;
			text = "View range:";
			sizeEx = 0.025;
			x = 0.17; y = 0.36; //x = -0.04; y = 0.36;
			w = 0.3; h = 0.02;
		};

		class uptimeText : w_RscText {
			idc = uptime_text;
			text = "";
			sizeEx = 0.030;
			x = 0.82; y = 0.69;
			w = 0.225; h = 0.03;
		};
	};

	class controls {

		class itemList : w_Rsclist {
			idc = item_list;
			x = 0.59; y = 0.185;
			w = 0.235; h = 0.325;
		};

		class DropButton : w_RscButton {
			idc = -1;
			text = "Drop";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "[1] execVM 'client\systems\playerMenu\itemfnc.sqf'";
			x = 0.710; y = 0.525;
			w = 0.116; h = 0.033 * safezoneH;
		};

		class UseButton : w_RscButton {
			idc = -1;
			text = "Use";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "[0] execVM 'client\systems\playerMenu\itemfnc.sqf'";
			x = 0.589; y = 0.525; //.309 0.289  difference 0.02
			w = 0.116; h = 0.033 * safezoneH;
		};

		class moneyInput: w_RscCombo {
			idc = money_value;
			x = 0.72; y = 0.618;
			w = .116; h = .030;
		};

		class DropcButton : w_RscButton {
			idc = -1;
			text = "Drop";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "[] execVM 'client\systems\playerMenu\dropMoney.sqf'";
			x = 0.589; y = 0.60;
			w = 0.116; h = 0.033 * safezoneH;
		};

		class CloseButton : w_RscButton {
			idc = close_button;
			text = "Close";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "[] execVM 'client\systems\playerMenu\closePlayerMenu.sqf'";
			x = 0.16; y = 0.70; //x = 0.02; y = 0.66; .138 differnce 
			w = 0.125; h = 0.033 * safezoneH;
		};

		class GroupsButton : w_RscButton {
			idc = groupButton;
			text = "Group Management";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "[] execVM 'client\systems\groups\loadGroupManagement.sqf'";
			x = 0.295; y = 0.70; //x = 0.158; y = 0.66;
			w = 0.225; h = 0.033 * safezoneH;
		};

		class btnDistanceNear : w_RscButton {
			idc = -1;
			text = "Near";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "setViewDistance 1100;";
			x = 0.16; y = 0.40; //x = 0.02; y = 0.43;
			w = 0.125; h = 0.033 * safezoneH;
		};

		class btnDistanceMedium : w_RscButton {
			idc = -1;
			text = "Medium";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "setViewDistance 2200;";
			x = 0.16; y = 0.47; //x = 0.02; y = 0.5;
			w = 0.125; h = 0.033 * safezoneH;
		};

		class btnDistanceFar : w_RscButton {
			idc = -1;
			text = "Far";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "setViewDistance 3300;";
			x = 0.16; y = 0.54; //x = 0.02; y = 0.57;
			w = 0.125; h = 0.033 * safezoneH;
		};
		/*
		class btnDistanceInsane : w_RscButton {
			text = "Insane";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "setViewDistance 5000;";
			x = 0.02; y = 0.60;
			w = 0.125; h = 0.033 * safezoneH;
		};
		*/
		class btnDistanceCustom : w_RscButton {
			idc = -1;
			text = "Custom";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "call CHVD_fnc_openDialog";
			x = 0.16; y = 0.61;
			w = 0.125; h = 0.033 * safezoneH;
		};
		
		class Donatorbutton : w_RscButton {
			idc = supporter_button;
			text = "Supporter";
			onButtonClick = "[] execVM 'client\systems\supporter\Donatorinit.sqf'";
			colorBackground[] = {0, 0, 0, 0};
			colorDisabled[] = {1,1,1,0.300000 };
			x = 0.295; y = 0.61; //x = 0.158; y = 0.57;
			w = 0.125; h = 0.033 * safezoneH;
		};
		/*
		class btnJTS_PM : w_RscButton {
			idc = -1;
			text = "Messages";
			onButtonClick = "[] execVM 'addons\JTS_PM\JTS_PM.sqf'";
			x = 0.02; y = 0.57;
			w = 0.125; h = 0.033 * safezoneH;
		};
		*/
	};
};
