#include "..\..\script_macros.hpp"

_cash = _this select 0;
_pricePerM = _this select 1;
_totalDistance = (_cash/_pricePerM);
_totalDistance = floor _totalDistance;
CASH = CASH + _cash;
player removeAction taxi_ActionToLeave;
_message = parseText format ["Votre client a arrêté la course. Vous avez reçu $%1 pour l'avoir transporté %2 mètres. Vous avez été remis dans la liste des chauffeurs en service !.",_cash,_totalDistance];
titleText[format["%1",_message],"PLAIN"];
life_isOnDutyTaxi = true;
[player] remoteExec ["TON_fnc_goOnDuty",2];
