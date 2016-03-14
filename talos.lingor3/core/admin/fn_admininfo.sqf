#include "..\..\script_macros.hpp"
/*
	File: fn_admininfo.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Output information received to admin menu.
*/
private["_ret","_unit","_prim","_sec","_vest","_uni","_bp","_attach","_steamName"];
_ret = _this;
disableSerialization;

_unit = SEL(_ret,3);
_prim = if(!(EQUAL(primaryWeapon _unit,""))) then { FETCH_CONFIG2(getText,CONFIG_WEAPONS,primaryWeapon _unit,"displayName")} else {"None"};
_sec = if(!(EQUAL(handgunWeapon _unit,""))) then { FETCH_CONFIG2(getText,CONFIG_WEAPONS,handgunWeapon _unit,"displayName")} else {"None"};
_vest = if(!(EQUAL(vest _unit,""))) then { FETCH_CONFIG2(getText,CONFIG_WEAPONS,vest _unit,"displayName")} else {"None"};
_uni = if(!(EQUAL(uniform _unit,""))) then { FETCH_CONFIG2(getText,CONFIG_WEAPONS,uniform _unit,"displayName")} else {"None"};
_bp = if(!(EQUAL(backpack _unit,""))) then {FETCH_CONFIG2(getText,CONFIG_VEHICLES,backpack _unit,"displayName")} else {"None"};

_attach = [];
if(!(EQUAL(primaryWeapon _unit,""))) then {
	{
		if(!(EQUAL(_x,""))) then {
			_attach pushBack (FETCH_CONFIG2(getText,CONFIG_WEAPONS,_x,"displayName"));
		};
	} foreach (primaryWeaponItems _unit);
};

_steamName = SEL(_ret,4);
if(!(SEL(_ret,4) isEqualType "")) then {
	_steamName = "Not a Steam User!";
};

if(EQUAL(count _attach,0)) then {_attach = "None"};
CONTROL(2900,2903) ctrlSetStructuredText parseText format["<t size='.8'>Nom: %1<br/>Nom Steam: %10<br/>Player UID: %11<br/>Faction: %12<br/>Banque: %2<br/>Argent: %3<br/>Uniforme: %4<br/>Veste: %5<br/>Sac à Dos: %6<br/>Primaire: %7<br/>Pistolet: %8<br/><t align='center'>Accessoire Primaire</t><br/>%9</t>",
_unit GVAR ["realname",name _unit],[SEL(_ret,0)] call life_fnc_numberText,[SEL(_ret,1)] call life_fnc_numberText, _uni,_vest,_bp,_prim,_sec,_attach,_steamName,SEL(_ret,5),SEL(_ret,6)];