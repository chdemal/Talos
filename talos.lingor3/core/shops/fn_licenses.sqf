#include "..\..\script_macros.hpp"
/*
	File: fn_licenses.sqf
	Author: RichHomieQuan
	
	Description:
	Open the licenses menu
*/
["_display","_listbox","_shortname","_sideFlag","_varName","_longname","_price","_hasLicense","_displayname"];
 
_buyables = _this select 3;
 
 
if(!dialog) then
{
if(!(createDialog "LicenseShop")) exitWith {};
};
disableSerialization;
 
_display = findDisplay 5546;
if(isNull _display) exitWith {};
_listbox = _display displayCtrl 55126;
_mylic = _display displayCtrl 55131;
_struct = "";
 
{
_shortname = _x;

 _sideFlag = M_CONFIG(getText,"Licenses",_shortname,"side");
 _varName = M_CONFIG(getText,"Licenses",_shortname,"variable");
_longname = LICENSE_VARNAME(_varName,_sideFlag);
_displayname = localize M_CONFIG(getText,"Licenses",_shortname,"displayName");
_price = M_CONFIG(getNumber,"Licenses",_shortname,"price");
_hasLicense = missionNamespace getVariable _longname;
 
	if(!_hasLicense) then
	{
		_listbox lbAdd format["%1 ($%2)", _displayname, _price];
		_listbox lbSetData [(lbSize _listbox) - 1, _shortname];
	}
	
	else
	{
		_mylic lbAdd format["%1", _displayname];
		_mylic lbSetData [(lbSize _mylic) - 1, _shortname];
	};
}
foreach _buyables;