#include "..\..\script_macros.hpp"

disableSerialization;
_display        = findDisplay 6600;
_taxiListbox    = _display displayCtrl 6601;
if !(lbCurSel _taxiListbox >=0) exitWith {hint "Error";};
_player         = _taxiListbox lbData (lbCurSel _taxiListbox);
_player = call compile _player;

hint format ["Vous avez accepté l'appel de taxi de %1. Il est à %2 mètres de votre position actuelle. L'emplacement a été marqué sur votre carte.",name _player,player distance _player];

life_taxiCustomer = _player;

[player,_player] remoteExec ["TON_fnc_acceptedTaxiCall",2];
[2,player] remoteExec ["life_fnc_taxi_respond",_player];

_markerText = createMarkerLocal ["Taxilocation", getPos _player];
"Taxilocation" setMarkerColorLocal "ColorRed";
"Taxilocation" setMarkerTextLocal format ["!!!!!!!!! DERNIÈRE POSITION DE %1 !!!!!!!!!",name _player];
"Taxilocation" setMarkerTypeLocal "mil_warning";

life_isOnDutyTaxi = false;
closeDialog 0;

taxi_ActionToLeave = player addAction ["<t color='#B70800'>Arrêter la course</t>", {
	if (alive life_taxiCustomer) then {
[6] remoteExec ["life_fnc_taxi_respond",life_taxiCustomer];
		player removeAction taxi_ActionToLeave;
	} else {
		player removeAction taxi_ActionToLeave;
		_message = parseText format ["Vous avez arrêté la course, mais le client semble être mort ou n'est plus en ligne. Vous avez reçu la dernière sauvegarde d'argent ($%1).",life_taxiTotalPriceBACKUP];
		titleText[format["%1",_message],"PLAIN"];
		CASH = CASH + life_taxiTotalPriceBACKUP;
		life_isOnDutyTaxi = true;
[player] remoteExec ["TON_fnc_goOnDuty",2];
	};
}];

life_taxiTotalPriceBACKUP = 0;

while {player distance _player > 10} do { "Taxilocation" setMarkerPosLocal getPos _player; };

deleteMarkerLocal "Taxilocation";
