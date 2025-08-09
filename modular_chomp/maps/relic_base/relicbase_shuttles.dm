// "Tram" Emergency Shuttler
// Becuase the tram only has its own doors and no corresponding station doors, a docking controller is overkill.
// Just open the gosh darn doors!  Also we avoid having a physical docking controller obj for gameplay reasons.
/datum/shuttle/autodock/ferry/emergency/escape
	var/tag_door_station = "escape_shuttle_hatch"
	var/tag_door_offsite = "escape_shuttle_hatch"
	var/frequency = 1380 // Why this frequency? BECAUSE! Thats what someone decided once.
	var/datum/radio_frequency/radio_connection
	move_direction = NORTH
	var/base_turf = /turf/simulated/floor/reinforced

/datum/shuttle/autodock/ferry/emergency/escape/dock()
	..()
	// Open Doorsunes
	var/datum/signal/signal = new
	signal.data["tag"] = location ? tag_door_offsite : tag_door_station
	signal.data["command"] = "secure_open"
	post_signal(signal)

/datum/shuttle/autodock/ferry/emergency/escape/undock()
	..()
	// Close Doorsunes
	var/datum/signal/signal = new
	signal.data["tag"] = location ? tag_door_offsite : tag_door_station
	signal.data["command"] = "secure_close"
	post_signal(signal)

/datum/shuttle/autodock/ferry/emergency/escape/proc/post_signal(datum/signal/signal, var/filter = null)
	signal.transmission_method = TRANSMISSION_RADIO
	if(radio_connection)
		return radio_connection.post_signal(src, signal, filter)
	else
		qdel(signal)

<<<<<<< HEAD
/datum/shuttle/autodock/ferry/arrivals/relicbase
	var/tag_door_station = "arrivals_shuttle_hatch"
	var/tag_door_offsite = "arrivals_shuttle_hatch"
	var/frequency = 1380
	var/datum/radio_frequency/radio_connection
	move_direction = NORTH
	name = "Arrivals"
	location = FERRY_LOCATION_OFFSITE
	shuttle_area = /area/shuttle/arrival/pre_game
	var/base_turf = /turf/simulated/floor/reinforced


/datum/shuttle/autodock/ferry/arrivals/relicbase/New()
	radio_connection = radio_controller.add_object(src, frequency, null)
	..()

/datum/shuttle/autodock/ferry/arrivals/relicbase/dock()
	..()
	// Open Doorsunes
	var/datum/signal/signal = new
	signal.data["tag"] = location ? tag_door_offsite : tag_door_station
	signal.data["command"] = "secure_open"
	post_signal(signal)

/datum/shuttle/autodock/ferry/arrivals/relicbase/undock()
	..()
	// Close Doorsunes
	var/datum/signal/signal = new
	signal.data["tag"] = location ? tag_door_offsite : tag_door_station
	signal.data["command"] = "secure_close"
	post_signal(signal)

/datum/shuttle/autodock/ferry/arrivals/relicbase/proc/post_signal(datum/signal/signal, var/filter = null)
	signal.transmission_method = TRANSMISSION_RADIO
	if(radio_connection)
		return radio_connection.post_signal(src, signal, filter)
	else
		qdel(signal)

/obj/machinery/computer/shuttle_control/arrivalstram
	name = "Arrivals Tram Control Console"
	shuttle_tag = "Arrivals"

// Arrivals ''''Shuttle''''
/datum/shuttle/autodock/ferry/arrivals/relicbase
	name = "Arrivals"
	location = FERRY_LOCATION_OFFSITE
	shuttle_area = /area/shuttle/arrival/pre_game
	landmark_offsite = "arrivals_offsite"
	landmark_station = "arrivals_station"
	docking_controller_tag = "arrivals_shuttle"
	move_time = SHUTTLE_TRANSIT_DURATION_RETURN

/obj/effect/shuttle_landmark/relicbase/arrivals/offsite
	name = "Transit to Station"
	landmark_tag = "arrivals_offsite"
	base_area = /area/space
	base_turf = /turf/simulated/floor/tiled/techfloor/grid

/obj/effect/shuttle_landmark/relicbase/arrivals/station
	name = "Relic Base Arrivals Station"
	landmark_tag = "arrivals_station"
	docking_controller = "arrivals_dock"

//Escape ''''Shuttle''''

/datum/shuttle/autodock/ferry/emergency/centcom
	name = "Escape"
	location = FERRY_LOCATION_OFFSITE
	warmup_time = 10
	shuttle_area = /area/shuttle/escape/centcom
	landmark_offsite = "escape_offsite"
	landmark_station = "escape_station"
	landmark_transition = "escape_transit"
	docking_controller_tag = "escape_shuttle"
	move_time = SHUTTLE_TRANSIT_DURATION_RETURN

/obj/effect/shuttle_landmark/relicbase/escape/offsite
	name = "Centcom"
	landmark_tag = "escape_offsite"
	docking_controller = "centcom_dock"
	base_area = /area/space
	base_turf = /turf/simulated/floor/tiled/techfloor/grid

/obj/effect/shuttle_landmark/relicbase/escape/station
	name = "Relic Base Departures Station"
	landmark_tag = "escape_station"
	docking_controller = "escape_dock"

/obj/effect/shuttle_landmark/relicbase/escape/transit
	landmark_tag = "escape_transit"

//mining elevator
/obj/machinery/computer/shuttle_control/exploration
	name = "Exploration Sling Control Console"
	shuttle_tag = "Exploration"

=======
>>>>>>> 651c8bc1af ([MIRROR] Simultaneous map definitions (#10295))
/datum/shuttle/autodock/ferry/mining
	name = "Mining"
	warmup_time = 10
	location = FERRY_LOCATION_STATION
	shuttle_area = /area/shuttle/minoutpost/base
	landmark_offsite = "mining_undermines"
	landmark_station = "mining_base"
	docking_controller_tag = "car_mining"

/datum/shuttle/autodock/ferry/research
	name = "Research"
	warmup_time = 10
	location = FERRY_LOCATION_STATION
	shuttle_area = /area/shuttle/research/station
	landmark_offsite = "rsr_undermines"
	landmark_station = "rsr_base"
	docking_controller_tag = "rsr_elevator"
