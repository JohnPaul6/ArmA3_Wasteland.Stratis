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
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,0};
			text = "client\systems\playerMenu\dialog\img\SGC_Tab_1.paa";
			moving = true;
			/*x = 0.0; y = 0.1;
			w = 0.745; h = 0.65; */
			x = -0.30; //was 0.28
			y = -0.25;
			w = 1.3; 
			h = 1.35;
		};
		/*
		class Paint_Menu_background:w_RscPicture
		{
			idc=-1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,0};
			text = "#(argb,8,8,3)color(0,0,0,0.6)";
			x=0.28;
			y=0.10;
			w=0.3505;
			h=0.70;
		};

		class TopBar: w_RscPicture
		{
			idc = -1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,0};
			text = "#(argb,8,8,3)color(0.546,0.59,0.363,0.4)";

			x=0.28;
			y=0.10;
			w=0.3505;
			h=0.05;
		};
		*/
		
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
			x=0.15; //x=0.30;
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
			x=0.325;
			y=0.70;
			w = 0.125; 
			h = 0.033 * safezoneH;
		};
		
		class CloseButton : w_RscButton {
			idc = close_button;
			text = "Close";
			colorBackground[] = {0, 0, 0, 0};
			onButtonClick = "closeDialog 0;";
			x = -0.14; y = 0.70; //x = 0.02; y = 0.66; .138 differnce 
			w = 0.125; h = 0.033 * safezoneH;
		};

	};
};

