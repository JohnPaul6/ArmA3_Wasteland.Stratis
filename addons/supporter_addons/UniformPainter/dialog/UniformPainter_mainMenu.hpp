// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
#define Paint_Menu_dialog 17000
#define Paint_Menu_option 17001

class Paint_Menu
{
	idd = Paint_Menu_dialog;
	movingEnable=1;
	onLoad = "uiNamespace setVariable ['Paint_Menu', _this select 0]";

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
			text = "Paint Uniform Menu";
			sizeEx = 0.04;
			shadow = 2;
			x = 0.260; y = 0.10;
			w = 0.3; h = 0.05;
		};
	};

	class controls {

		class Paint_Menu_options:w_Rsclist
		{
			idc = Paint_Menu_option;
			x=0.25; //x=0.30;
			y=0.18;
			w=0.5; //w=0.31;
			h=0.49;
		};

		class Paint_Menu_activate:w_RscButton
		{
			idc=-1;
			text="Select";
			onButtonClick = "[0] execVM 'addons\supporter_addons\UniformPainter\UniformPainter_optionSelect.sqf'";
			colorBackground[] = {0, 0, 0, 0};
			x=0.425;
			y=0.70;
			w = 0.125; 
			h = 0.033 * safezoneH;
		};
		
		class CloseButton : w_RscButton {
			idc = -1;
			text = "Close";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "closeDialog 0;";
			x = 0.16; y = 0.70; //x = 0.02; y = 0.66; .138 differnce 
			w = 0.125; h = 0.033 * safezoneH;
		};
	};
};

