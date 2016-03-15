#include "..\..\script_macros.hpp"
if(!license_civ_taxi) exitwith {hint "Vous n'avez pas la licence de taxi"};
waitUntil {createDialog "SERVICETAXI";};

if(!life_isOnDutyTaxi) then {
ctrlShow[50003,false];
} else {
ctrlShow[50002,false];
};