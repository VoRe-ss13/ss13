<<<<<<< HEAD
/obj/machinery/computer/shuttle_control/multi/heist
=======
/obj/machinery/computer/shuttle_control/web/heist
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
	name = "skipjack control console"
	req_access = list(access_syndicate)
	shuttle_tag = "Skipjack"

<<<<<<< HEAD
/datum/shuttle/autodock/multi/heist
=======
/datum/shuttle/autodock/web_shuttle/heist
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
	name = "Skipjack"
	warmup_time = 0
	can_cloak = TRUE
	cloaked = TRUE
<<<<<<< HEAD
	shuttle_area = /area/shuttle/skipjack
	current_location = "skipjack_start"
	docking_controller_tag = "skipjack_shuttle"
	move_direction = NORTH
	destination_tags = list(
		"skipjack_start",
		"d1_aux_b",
		"d1_aux_c",
		"d2_w1_e",
		"d2_w2_e",
		"d2_w3_e",
		"d1_near_ne",
		"d1_near_nw",
		"d1_near_se",
		"d1_near_sw",
		"d2_near_ne",
		"d2_near_nw",
		"d2_near_se",
		"d2_near_sw",
		"d3_near_w"
	)
=======
	shuttle_area = /area/skipjack_station/start
	current_location = "skipjack_start"
//	docking_controller_tag = "skipjack_shuttle"
	web_master_type = /datum/shuttle_web_master/heist

/datum/shuttle_web_master/heist
	destination_class = /datum/shuttle_destination/heist
	starting_destination = /datum/shuttle_destination/heist/root



/datum/shuttle_destination/heist/root
	name = "Raider Outpost"
	my_landmark = "skipjack_start"
	preferred_interim_tag = "skipjack_transit"

//	dock_target = "skipjack_base"

	routes_to_make = list(
		/datum/shuttle_destination/heist/orbit = 1 MINUTE,
	)

/datum/shuttle_destination/heist/orbit
	name = "Orbit of Sif"
	my_landmark = "skipjack_orbit"
	preferred_interim_tag = "skipjack_transit"

	routes_to_make = list(
		/datum/shuttle_destination/heist/outside_SC_1d = 30 SECONDS,
		/datum/shuttle_destination/heist/outside_SC_2d = 30 SECONDS,
		/datum/shuttle_destination/heist/outside_SC_3d = 30 SECONDS,
		/datum/shuttle_destination/heist/sky = 30 SECONDS,
	)

/datum/shuttle_destination/heist/outside_SC_1d
	name = "NLS Southern Cross - Aft of First Deck"
	my_landmark = "skipjack_firstdeck"
	preferred_interim_tag = "skipjack_transit"

	routes_to_make = list(
		/datum/shuttle_destination/heist/outside_SC_2d = 0,
		/datum/shuttle_destination/heist/outside_SC_3d = 0,
		/datum/shuttle_destination/heist/docked_SC = 0
	)

/datum/shuttle_destination/heist/outside_SC_2d
	name = "NLS Southern Cross - Fore of Second Deck"
	my_landmark = "skipjack_seconddeck"
	preferred_interim_tag = "skipjack_transit"

	routes_to_make = list(
		/datum/shuttle_destination/heist/outside_SC_1d = 0,
		/datum/shuttle_destination/heist/outside_SC_3d = 0,
		/datum/shuttle_destination/heist/docked_SC = 0
	)

/datum/shuttle_destination/heist/outside_SC_3d
	name = "NLS Southern Cross - Starboard of Third Deck"
	my_landmark = "skipjack_thirddeck"
	preferred_interim_tag = "skipjack_transit"

	routes_to_make = list(
		/datum/shuttle_destination/heist/outside_SC_1d = 0,
		/datum/shuttle_destination/heist/outside_SC_2d = 0,
		/datum/shuttle_destination/heist/docked_SC = 0
	)


/datum/shuttle_destination/heist/docked_SC
	name = "NLS Southern Cross - Arrivals Docking Port"
	my_landmark = "skipjack_arrivals_dock"
	preferred_interim_tag = "skipjack_transit"

//	dock_target = "skipjack_shuttle_dock_airlock"
	announcer = "Southern Cross Docking Computer"

/datum/shuttle_destination/heist/docked_SC/get_arrival_message()
	return "Attention, [master.my_shuttle.visible_name] has arrived to the Arrivals Dock."

/datum/shuttle_destination/heist/docked_SC/get_departure_message()
	return "Attention, [master.my_shuttle.visible_name] has departed the Arrivals Dock."

/datum/shuttle_destination/heist/sky
	name = "Skies of Sif"
	my_landmark = "skipjack_sky"
	preferred_interim_tag = "skipjack_sky_transit"

	routes_to_make = list(
		/datum/shuttle_destination/heist/planet = 15 SECONDS
	)

/datum/shuttle_destination/heist/planet
	name = "Sif Surface"
	my_landmark = "skipjack_planet"
	preferred_interim_tag = "skipjack_sky_transit"
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
