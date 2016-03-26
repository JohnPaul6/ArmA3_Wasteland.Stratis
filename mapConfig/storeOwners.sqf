// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: storeOwners.sqf
//	@file Author: AgentRev, JoSchaap, His_Shadow

// Notes: Gun and general stores have position of spawned crate, vehicle stores have an extra air spawn direction
//
// Array contents are as follows:
// Name, Building Position, Desk Direction (or [Desk Direction, Front Offset]), Excluded Buttons
storeOwnerConfig = compileFinal str
[
	["GenStore1", 1, 270, []],
	["GenStore2", 6, 30, []],
	["GenStore3", 4, 340, []],
	["GenStore4", 1, 210, []],

	["GunStore1", 0, 5, []],
	["GunStore2", 1, 130, []],
	["GunStore3", 5, 85, []],
	["GunStore4", 1, 320, []],
	["GunStore5", 1, [330,-2], []],

	// Buttons you can disable: "Land", "Armored", "Tanks", "Helicopters", "Boats", "Planes"
	["VehStore1", 0, 195, ["Planes"]],
	["VehStore2", 2, 285, ["Boats"]],
	["VehStore3", 1, 320, ["Planes","Boats"]]
];

// Outfits for store owners
storeOwnerConfigAppearance = compileFinal str
[
	["GenStore1", [["weapon", "srifle_EBR_ARCO_pointer_snds_F"], ["uniform", "U_Rangemaster"]]],
	["GenStore2", [["weapon", "srifle_EBR_ARCO_pointer_snds_F"], ["uniform", "U_Rangemaster"]]],
	["GenStore3", [["weapon", "srifle_EBR_ARCO_pointer_snds_F"], ["uniform", "U_Rangemaster"]]],
	["GenStore4", [["weapon", "srifle_EBR_ARCO_pointer_snds_F"], ["uniform", "U_Rangemaster"]]],

	["GunStore1", [["weapon", "srifle_DMR_02_sniper_F"], ["uniform", "U_B_FullGhillie_lsh"]]],
	["GunStore2", [["weapon", "MMG_02_camo_F"], ["uniform", "U_B_FullGhillie_sard"]]],
	["GunStore3", [["weapon", "srifle_DMR_06_olive_F"], ["uniform", "U_B_FullGhillie_ard"]]],
	["GunStore4", [["weapon", "srifle_DMR_05_DMS_snds_F"], ["uniform", "U_O_FullGhillie_lsh"]]],
	["GunStore5", [["weapon", "MMG_01_hex_F"], ["uniform", "U_O_FullGhillie_sard"]]],

	["VehStore1", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore2", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore3", [["weapon", ""], ["uniform", "U_Competitor"]]]
];
