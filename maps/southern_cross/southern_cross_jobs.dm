// Pilots

var/const/SAR 				=(1<<11)
var/const/PILOT 			=(1<<13)
var/const/EXPLORER 			=(1<<14)

var/const/access_pilot = 67
var/const/access_explorer = 43

/datum/access/pilot
	id = access_pilot
<<<<<<< HEAD
	desc = JOB_PILOT
=======
	desc = "Pilot"
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
	region = ACCESS_REGION_SUPPLY

/datum/access/explorer
	id = access_explorer
<<<<<<< HEAD
	desc = JOB_EXPLORER
=======
	desc = "Explorer"
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
	region = ACCESS_REGION_GENERAL

//SC Jobs

/*

<<<<<<< HEAD
//Will see about getting working later. //CHOMPNote, do not use this
=======
//Will see about getting working later.
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))

/datum/job/captain
	title = "Station Director"
	flag = CAPTAIN
	department = "Command"
	head_position = 1
	department_flag = ENGSEC
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "company officials and Corporate Regulations"
	selection_color = "#1D1D4F"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14
	economic_modifier = 20

	minimum_character_age = 25
	ideal_character_age = 50 // Because 70 is a tad on the old side

	outfit_type = /decl/hierarchy/outfit/job/captain
	alt_titles = list("Site Manager", "Overseer")

/datum/job/captain/get_access()
	return get_all_station_access()
*/

<<<<<<< HEAD
/datum/job/pilot
	title = JOB_PILOT
	flag = PILOT
	department = DEPARTMENT_CIVILIAN
=======
/datum/department/planetside
	name = DEPARTMENT_PLANET
	color = "#555555"
	sorting_order = 2 // Same as cargo in importance.

/datum/job/pilot
	title = "Pilot"
	flag = PILOT
	departments = list(DEPARTMENT_PLANET)
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
	department_flag = CIVILIAN
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
<<<<<<< HEAD
	supervisors = "the head of personnel"
	selection_color = "#515151"
	economic_modifier = 4
	access = list(access_eva, access_maint_tunnels, access_external_airlocks, access_pilot, access_cargo, access_mining, access_mining_station)
	minimal_access = list(access_eva, access_maint_tunnels, access_external_airlocks, access_pilot, access_cargo, access_mining, access_mining_station)
	outfit_type = /decl/hierarchy/outfit/job/pilot

/datum/job/explorer
	title = JOB_EXPLORER
	flag = EXPLORER
	department = DEPARTMENT_CIVILIAN
	department_flag = CIVILIAN
	faction = FACTION_STATION
	total_positions = 4
	spawn_positions = 4
	supervisors = "the explorer leader and the head of personnel"
	selection_color = "#515151"
=======
	supervisors = "the Head of Personnel"
	selection_color = "#515151"
	economic_modifier = 4
	access = list(access_pilot, access_cargo, access_mining, access_mining_station)
	minimal_access = list(access_pilot, access_cargo, access_mining, access_mining_station)

	outfit_type = /decl/hierarchy/outfit/job/pilot
	job_description = "A Pilot flies one of the shuttles between the Southern Cross and the outpost on Sif."

/datum/job/explorer
	title = "Explorer"
	flag = EXPLORER
	departments = list(DEPARTMENT_RESEARCH, DEPARTMENT_PLANET)
	department_flag = MEDSCI
	faction = FACTION_STATION
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Research Director"
	selection_color =  "#633D63"
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
	economic_modifier = 4
	access = list(access_explorer, access_research)
	minimal_access = list(access_explorer, access_research)
	banned_job_species = list(SPECIES_ZADDAT)

	outfit_type = /decl/hierarchy/outfit/job/explorer2
<<<<<<< HEAD
=======
	job_description = "An Explorer searches for interesting things on the surface of Sif, and returns them to the station."

>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
/*
	alt_titles = list(
		JOB_ALT_EXPLORERE_TECHNICIAN = /decl/hierarchy/outfit/job/explorer2/technician,
		JOB_ALT_EXPLORER_MEDIC = /decl/hierarchy/outfit/job/explorer2/medic)
*/

/datum/job/sar
<<<<<<< HEAD
	title = JOB_SEARCH_AND_RESCUE
	flag = SAR
	department = DEPARTMENT_MEDICAL
=======
	title = "Search and Rescue"
	flag = SAR
	departments = list(DEPARTMENT_PLANET, DEPARTMENT_MEDICAL)
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
	department_flag = MEDSCI
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
<<<<<<< HEAD
	supervisors = "the chief medical officer"
=======
	supervisors = "the Chief Medical Officer"
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
	selection_color = "#515151"
	economic_modifier = 4
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_eva, access_maint_tunnels, access_external_airlocks, access_psychiatrist, access_explorer)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_explorer)
	min_age_by_species = list(SPECIES_PROMETHEAN = 2)

	outfit_type = /decl/hierarchy/outfit/job/medical/sar
<<<<<<< HEAD
	job_description = "A " + JOB_SEARCH_AND_RESCUE + " operative recovers individuals who are injured or dead on the surface of Sif."
=======
	job_description = "A Search and Rescue operative recovers individuals who are injured or dead on the surface of Sif."
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
