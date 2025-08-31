/obj/machinery/atmospherics/binary/pump/high_power
	icon = 'icons/atmos/volume_pump.dmi'
	icon_state = "map_off"
	construction_type = /obj/item/pipe/directional
	pipe_state = "volumepump"
	level = 1

	name = "high power gas pump"
	desc = "A pump that moves gas from one place to another. Has double the power rating of the standard gas pump."

	power_rating = 15000	//15000 W ~ 20 HP

<<<<<<< HEAD
/obj/machinery/atmospherics/binary/pump/high_power/on
	use_power = USE_POWER_IDLE
=======
	var/max_transfer_rate = ATMOS_DEFAULT_VOLUME_PUMP	// Ls
	var/transfer_rate = 20 // L

	var/frequency = ZERO_FREQ
	var/id = null
	var/datum/radio_frequency/radio_connection

	var/overclocked = FALSE
	var/mutable_appearance/overclock_overlay

/obj/machinery/atmospherics/binary/volume_pump/Initialize(mapload)
	. = ..()

	air1.volume = ATMOS_DEFAULT_VOLUME_PUMP
	air2.volume = ATMOS_DEFAULT_VOLUME_PUMP
	if(frequency)
		set_frequency(frequency)

/obj/machinery/atmospherics/binary/volume_pump/Destroy()
	unregister_radio(src, frequency)
	. = ..()

/obj/machinery/atmospherics/binary/pump/on
>>>>>>> 89704592dd ([MIRROR] jobs, access and radio to defines (#11546))
	icon_state = "map_on"

/obj/machinery/atmospherics/binary/pump/high_power/update_icon()
	if(!powered())
		icon_state = "off"
	else
		icon_state = "[use_power ? "on" : "off"]"
