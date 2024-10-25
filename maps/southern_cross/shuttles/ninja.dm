<<<<<<< HEAD
/obj/machinery/computer/shuttle_control/multi/ninja
	name = "stealth shuttle control console"
	req_access = list(access_syndicate)
	shuttle_tag = "Ninja Shuttle"

/datum/shuttle/autodock/multi/ninja
	name = "Ninja Shuttle"
	warmup_time = 0
	can_cloak = TRUE
	cloaked = TRUE
	shuttle_area = /area/shuttle/ninja
	current_location = "ninja_start"
	docking_controller_tag = "ninja_shuttle"
	move_direction = SOUTH
	destination_tags = list(
		"ninja_start",
		"d1_aux_d",
		"d2_w3_a",
		"d2_w3_c",
		"d1_near_ne",
		"d1_near_nw",
		"d1_near_se",
		"d1_near_sw",
		"d2_near_ne",
		"d2_near_nw",
		"d2_near_se",
		"d2_near_sw",
		"d3_near_w",
		"d3_near_se",
	)
=======
/obj/machinery/computer/shuttle_control/web/ninja
	name = "stealth shuttle control console"
	req_access = list(access_syndicate)
	shuttle_tag = "Ninja"

/datum/shuttle/autodock/web_shuttle/ninja
	name = "Ninja"
	visible_name = "Unknown Vessel"
	warmup_time = 0
	can_cloak = TRUE
	cloaked = TRUE
	shuttle_area = /area/ninja_dojo/start
	current_location = "ninja_start"
	docking_controller_tag = "ninja_shuttle"
	web_master_type = /datum/shuttle_web_master/ninja
	flight_time_modifier = 0.5	// Nippon steel.

/datum/shuttle_web_master/ninja
	destination_class = /datum/shuttle_destination/ninja
	starting_destination = /datum/shuttle_destination/ninja/root

/datum/shuttle_destination/ninja/root
	name = "Dojo Outpost"
	my_landmark = "ninja_start"
	preferred_interim_tag = "ninja_sky_transit"

	routes_to_make = list(
		/datum/shuttle_destination/ninja/sky = 15 SECONDS,
	)

/datum/shuttle_destination/ninja/orbit
	name = "Orbit of Sif"
	my_landmark = "ninja_orbit"
	preferred_interim_tag = "ninja_transit"

	routes_to_make = list(
		/datum/shuttle_destination/ninja/outside_SC_1d = 30 SECONDS,
		/datum/shuttle_destination/ninja/outside_SC_2d = 30 SECONDS,
		/datum/shuttle_destination/ninja/outside_SC_3d = 30 SECONDS,
		/datum/shuttle_destination/ninja/sky = 30 SECONDS,
	)

/datum/shuttle_destination/ninja/outside_SC_1d
	name = "NLS Southern Cross - Aft of First Deck"
	my_landmark = "ninja_firstdeck"
	preferred_interim_tag = "ninja_transit"

	routes_to_make = list(
		/datum/shuttle_destination/ninja/outside_SC_2d = 0,
		/datum/shuttle_destination/ninja/outside_SC_3d = 0,
		/datum/shuttle_destination/ninja/docked_SC = 0
	)

/datum/shuttle_destination/ninja/outside_SC_2d
	name = "NLS Southern Cross - Fore of Second Deck"
	my_landmark = "ninja_seconddeck"
	preferred_interim_tag = "ninja_transit"

	routes_to_make = list(
		/datum/shuttle_destination/ninja/outside_SC_1d = 0,
		/datum/shuttle_destination/ninja/outside_SC_3d = 0,
		/datum/shuttle_destination/ninja/docked_SC = 0
	)

/datum/shuttle_destination/ninja/outside_SC_3d
	name = "NLS Southern Cross - Port of Third Deck"
	my_landmark = "ninja_thirddeck"
	preferred_interim_tag = "ninja_transit"

	routes_to_make = list(
		/datum/shuttle_destination/ninja/outside_SC_1d = 0,
		/datum/shuttle_destination/ninja/outside_SC_2d = 0,
		/datum/shuttle_destination/ninja/docked_SC = 0
	)


/datum/shuttle_destination/ninja/docked_SC
	name = "NLS Southern Cross - Arrivals Docking Port"
	my_landmark = "ninja_arrivals_dock"
	preferred_interim_tag = "ninja_transit"

	announcer = "Southern Cross Docking Computer"

/datum/shuttle_destination/syndie/docked_SC/get_arrival_message()
	return "Attention, [master.my_shuttle.visible_name] has arrived to the Arrivals Dock."

/datum/shuttle_destination/syndie/docked_SC/get_departure_message()
	return "Attention, [master.my_shuttle.visible_name] has departed the Arrivals Dock."

/datum/shuttle_destination/ninja/sky
	name = "Skies of Sif"
	my_landmark = "ninja_sky"
	preferred_interim_tag = "ninja_sky_transit"

	routes_to_make = list(
		/datum/shuttle_destination/ninja/planet = 15 SECONDS
	)

/datum/shuttle_destination/ninja/planet
	name = "Sif Surface"
	my_landmark = "ninja_planet"
	preferred_interim_tag = "ninja_sky_transit"
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
