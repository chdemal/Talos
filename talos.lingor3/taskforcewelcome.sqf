#include "..\script_macros.hpp"
if(!(FETCH_CONST(life_adminlevel) == 0)) exitwith {};
[] spawn {
    waitUntil {life_session_completed};
    while {true} do {
        _server = [] call TFAR_fnc_getTeamSpeakServerName;
        _channel = [] call TFAR_fnc_getTeamSpeakChannelName;
 
        if(!([] call TFAR_fnc_isTeamSpeakPluginEnabled)) then {
       
            cutText["Veuillez activer le plugin TFR sur TeamSpeak pour pouvoir revenir en jeu","BLACK"];
            waitUntil {([] call TFAR_fnc_isTeamSpeakPluginEnabled)};
            cutText["","PLAIN"];
           
        };
 
        if(_server != "Talos-Serveur  | AltisLifeRPG | GarrysMod - DarkRP" or _channel != "TaskForceRadio") then {
           
            cutText["Veuillez aller dans le channel TFR pour revenir en jeu.","BLACK",0,true];
            waitUntil {([] call TFAR_fnc_getTeamSpeakServerName) == "Talos-Serveur  | AltisLifeRPG | GarrysMod - DarkRP" and ([] call TFAR_fnc_getTeamSpeakChannelName) == "TaskForceRadio"};
            cutText["","PLAIN"];
       
        };
       
        sleep 10;
    };
};