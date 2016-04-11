//Delete Items by Isaac Harding
waitUntil 
{ 
	{ 
		if(agent _x isKindOf "Land_Suitcase_F" || agent _x isKindOf "Land_BottlePlastic_V1_F" || agent _x typeof "Land_BakedBeans_F") then 
		{ 
			deleteVehicle agent _x; 
		}; 
	}forEach agents; 
	sleep 1; false; 
};