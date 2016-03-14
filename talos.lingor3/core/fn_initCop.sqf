#include "..\script_macros.hpp"
/*
	File: fn_initCop.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Cop Initialization file.
*/
private "_end";
player addRating 9999999;
waitUntil {!(isNull (findDisplay 46))};
_end = false;

if(life_blacklisted) exitWith
{
	["Blacklisted",false,true] call BIS_fnc_endMission;
	sleep 30;
};

if((FETCH_CONST(life_coplevel)) < 1) exitWith {
	["NotWhitelisted",FALSE,TRUE] call BIS_fnc_endMission;
	sleep 35;
};

if((str(player) in ["cop_0","cop_1","cop_2","cop_3","cop_4","cop_5","cop_6","cop_7","cop_8","cop_9","cop_10","cop_11","cop_12","cop_13","cop_14","cop_15","cop_16","cop_17","cop_18"])) then {
	if((FETCH_CONST(life_coplevel) > 7) && (FETCH_CONST(life_adminlevel) == 0)) then {
		["NotWhitelisted",false,true] call BIS_fnc_endMission;
		sleep 35;
	};
};

if((str(player) in ["cop_19","cop_20","cop_21","cop_22","cop_23","cop_24","cop_25","cop_26","cop_27","cop_28"])) then {
	if((FETCH_CONST(life_coplevel) < 8) && (FETCH_CONST(life_adminlevel) == 0)) then {
		["NotWhitelistedMilitaire",false,true] call BIS_fnc_endMission;
		sleep 35;
	};
};


player setVariable["rank",(FETCH_CONST(life_coplevel)),true];
[] spawn life_fnc_placeablesInit;
[] call life_fnc_spawnMenu;
waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.
[] execVM "core\msgbienvenue.sqf";