/*
	Author: CanadienFr
	Description: Suppression des objets cibles
*/
if(typeOf (cursorTarget) in ["cl3_Checkpoint_red_white_board_short","cl3_Checkpoint_red_white_board_short_lights","cl3_Checkpoint_roadblock_barrier_heavy","cl3_Checkpoint_roadblock_roadcone", "cl_road_lightR", "cl3_Checkpoint_move_left_light", "cl3_Checkpoint_move_right_light", "Land_PortableLight_double_F"]) then {deleteVehicle cursorTarget};