#include "..\..\script_macros.hpp"

_mode = [_this, 0, -1] call BIS_fnc_param;
_info = [_this, 1, -1] call BIS_fnc_param;
pricePerM = 2;

switch (_mode) do
{
	case 1:
	{
		TaxiCallsClient = _info;
		systemChat "Votre liste de course de taxi a été mise à jour!";
	};
	case 2:
	{
		hint format ["Le chauffeur %1 a accepté votre appel, Il est actuellement %2 mètres de votre position actuelle.",name _info,floor (player distance _info)];
		life_taxiDriver = _info;
		life_calledTaxi = true;
		taxi_eventHandlerID1 = player addEventHandler ["GetIn", {
			sleep 0.1;
			if (life_taxiDriver == (driver vehicle player)) then {life_inTaxi = true;};
		}];
		taxi_ActionToLeave = player addAction ["<t color='#B70800'>Arrêter la course</t>", {
			hint format ["Vous avez arrêté la course, vous avez payé $%1 pour la course.",life_taxiTotalPrice];
			life_calledTaxi = false;
			life_inTaxi = false;
			if (BANK<life_taxiTotalPrice) then {BANK = 0;} else { BANK = BANK - life_taxiTotalPrice;};
[life_taxiTotalPrice,pricePerM] remoteExec ["life_fnc_finishRide",life_taxiDriver];
			player removeAction taxi_ActionToLeave;
		}];
		_oldTaxiPos = getPos player;
		life_taxiTotalPrice = 0;
		_updateCount = 0;
		sleep 5;
		while {life_calledTaxi && !(player getVariable "restrained")} do {
			uiSleep 0.1;
			_updateCount = _updateCount + 1;
			hintSilent parseText format ["TAXIMÈTRE<br/><br/><t align='left'>Distance parcourue</t><t align='right'>%1</t><br/><t align='left'>Prix</t><t align='right'>%2</t>",floor (life_taxiTotalPrice/pricePerM),life_taxiTotalPrice];
			if ((_oldTaxiPos distance player >= 1)&&(life_taxiDriver == (driver vehicle player))) then { life_taxiTotalPrice = life_taxiTotalPrice + pricePerM; _oldTaxiPos = getPos player; };
			if (_updateCount>=200) then {
[5,life_taxiTotalPrice] remoteExec ["life_fnc_respond",life_taxiDriver];
			};
		};
		if (life_inTaxi) then {
			hint format ["Vous avez arrêté la course, vous avez payé $%1 pour la course.",life_taxiTotalPrice];
			life_calledTaxi = false;
			life_inTaxi = false;
			if (BANK<life_taxiTotalPrice) then {BANK = 0;} else { BANK = BANK - life_taxiTotalPrice;};
[life_taxiTotalPrice,pricePerM] remoteExec ["life_fnc_finishRide",life_taxiDriver];
			player removeAction taxi_ActionToLeave;
		};
	};
	case 3:
	{
		hint "Aucun chauffeur de taxi n'a accepté votre course, votre demande a été supprimé. Vous pouvez refaire un appel.";
		life_calledTaxi = false;
    };
    case 4:
    {
    	hint "Il n'y a aucun chauffeur en ligne.";
    	life_calledTaxi = false;
	};
	case 5:
	{
		life_taxiTotalPriceBACKUP = _info;
	};
	case 6:
	{
			life_calledTaxi = false;
			sleep 0.2;
			hint format ["Le chauffeur a arrêté la course, vous avez payé $%1 pour la course.",life_taxiTotalPrice];
			life_inTaxi = false;
			if (BANK<life_taxiTotalPrice) then {BANK = 0;} else { BANK = BANK - life_taxiTotalPrice;};
[life_taxiTotalPrice,pricePerM] remoteExec ["life_fnc_finishRide",life_taxiDriver];
			player removeAction taxi_ActionToLeave;
	};
};
