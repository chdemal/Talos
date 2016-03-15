// Exceptions

if (life_calledTaxi) exitWith { hint "Vous avez déjà appelé un taxi!"; };
if (life_isOnDutyTaxi) exitWith { hint "Vous ne pouvez pas appeler de taxi lorsque vous êtes un chauffeur de taxi!"; };

// Main

life_calledTaxi = true;
[player] remoteExec ["TON_fnc_callTaxiDrivers",2];
hint "Vous avez appeler un taxi. Veuillez patienter que chauffeur accepte votre course. Votre demande de taxi sera automatique supprimer après 60 secondes";
