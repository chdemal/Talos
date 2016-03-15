
disableSerialization;
createDialog "life_taxiMenu";
_display        = findDisplay 6600;
_taxiListbox    = _display displayCtrl 6601;

if (!life_isOnDutyTaxi) exitWith {hint "Vous n'êtes pas en service ou vous avez déjà accepté une demande!";closeDialog 0;};

[player] remoteExec ["TON_fnc_goOnDuty",2];
sleep 1;
if (count TaxiCallsClient > 0) then
{
	{
		_taxiListbox lbAdd format ["%1 (%2 mètres)",name _x,(_x distance player)];
		_taxiListbox lbSetData [(lbSize _taxiListbox)-1,format ["%1",_x]];
	} forEach TaxiCallsClient;
};

hint "Les demandes de taxi on été charger avec succès, veuillez sélectionner une mission pour continuer.";
