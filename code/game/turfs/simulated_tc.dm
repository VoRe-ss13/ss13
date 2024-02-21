/turf/simulated/New()
	. = ..()

/turf/simulated/Initialize(mapload)
	. = ..()
	if(mapload)
		return INITIALIZE_HINT_LATELOAD

/turf/simulated/LateInitialize()
	if(check_for_sun())
		if(is_outdoors())
			var/turf/T = GetAbove(src)
			if(T && !istype(T,/turf/simulated/open))
				make_indoors()
		AddComponent(/datum/component/sunlight_handler)
		SEND_SIGNAL(src,COMSIG_SUNLIGHT_INIT)

/datum/component/sunlight_handler
	var/datum/sun_holder/sun
	var/turf/simulated/holder
	var/effect_str_r = 0
	var/effect_str_g = 0
	var/effect_str_b = 0
	var/list/datum/lighting_corner/affected = list()
	var/sunlight = FALSE
	var/inherited = FALSE

/datum/component/sunlight_handler/New()
	. = ..()
	holder = parent

/datum/component/sunlight_handler/InheritComponent(datum/component/sunlight_handler/old)
	effect_str_r = old.effect_str_r
	effect_str_g = old.effect_str_g
	effect_str_b = old.effect_str_b
	sunlight = old.sunlight
	affected = old.affected
	inherited = TRUE

/datum/component/sunlight_handler/Initialize()
	RegisterSignal(parent, COMSIG_TURF_UPDATE, /datum/component/sunlight_handler/proc/turf_update)
	RegisterSignal(parent, COMSIG_SUNLIGHT_CHECK, /datum/component/sunlight_handler/proc/sunlight_check)
	RegisterSignal(parent, COMSIG_SUNLIGHT_UPDATE, /datum/component/sunlight_handler/proc/sunlight_update)
	RegisterSignal(parent, COMSIG_SUNLIGHT_INIT, /datum/component/sunlight_handler/proc/manualInit)

//Moved initialization here to make sure that it doesn't happen too early when replacing turfs.
/datum/component/sunlight_handler/proc/manualInit()
	if(!holder.lighting_corners_initialised)
		holder.generate_missing_corners()
	var/corners = list(holder.lighting_corner_NE,holder.lighting_corner_NW,holder.lighting_corner_SE,holder.lighting_corner_SW)
	for(var/datum/lighting_corner/corner in corners)
		if(corner.sunlight == SUNLIGHT_NONE)
			corner.sunlight = SUNLIGHT_POSSIBLE
	if(SSplanets && SSplanets.z_to_planet.len >= holder.z && SSplanets.z_to_planet[holder.z])
		var/datum/planet/planet = SSplanets.z_to_planet[holder.z]
		sun = planet.sun_holder
	if(!inherited)
		SEND_SIGNAL(holder,COMSIG_SUNLIGHT_CHECK)
	else
		SEND_SIGNAL(holder,COMSIG_SUNLIGHT_UPDATE)
		for(var/dir in (cardinal + cornerdirs))
			SEND_SIGNAL(get_step(holder, dir),COMSIG_SUNLIGHT_UPDATE)

/datum/component/sunlight_handler/proc/turf_update()
	//var/oldtype = args[2]
	var/old_density = args[3]
	var/turf/new_turf = args[4]
	var/above = args[5]
	if(above)
		sunlight_check()
		return
	if(new_turf.density && !old_density && sunlight) //This has the potential to cut off our sunlight
		sunlight_check()
	else if (!new_turf.density && old_density && !sunlight) //This has the potential to introduce sunlight
		sunlight_check()

/datum/component/sunlight_handler/proc/sunlight_check()
	var/cur_sunlight = sunlight
	if(holder.is_outdoors())
		sunlight = SUNLIGHT_OVERHEAD
	if(holder.density)
		sunlight = FALSE
	if(holder.check_for_sun() && !holder.is_outdoors() && !holder.density)
		var/outside_near = FALSE
		outer_loop:
			for(var/dir in cardinal)
				var/steps = 1
				var/turf/cur_turf = get_step(holder,dir)
				while(cur_turf && !cur_turf.density && steps < (SUNLIGHT_RADIUS + 1))
					if(cur_turf.is_outdoors())
						outside_near = TRUE
						break outer_loop
					steps += 1
					cur_turf = get_step(cur_turf,dir)
		if(!outside_near) //If cardinal directions fail, then check diagonals.
			var/radius = ONE_OVER_SQRT_2 * SUNLIGHT_RADIUS + 1
			outer_loop:
				for(var/dir in cornerdirs)
					var/steps = 1
					var/turf/cur_turf = get_step(holder,dir)
					var/opp_dir = turn(dir,180)
					var/north_south = opp_dir & (NORTH|SOUTH)
					var/east_west = opp_dir & (EAST|WEST)

					while(cur_turf && !cur_turf.density && steps < radius)
						var/turf/vert_behind = get_step(cur_turf,north_south)
						var/turf/hori_behind = get_step(cur_turf,east_west)
						if(vert_behind.density && hori_behind.density) //Prevent light from passing infinitesimally small gaps
							break outer_loop
						if(cur_turf.is_outdoors())
							outside_near = TRUE
							break outer_loop
						steps += 1
						cur_turf = get_step(cur_turf,dir)
		if(outside_near)
			sunlight = TRUE
		else if(sunlight)
			sunlight = FALSE

	if(cur_sunlight != sunlight)
		sunlight_update()
		if(!sunlight)
			SSlighting.sunlight_queue -= holder
		else
			SSlighting.sunlight_queue += holder

/datum/component/sunlight_handler/proc/sunlight_update()
	var/list/corners = list(holder.lighting_corner_NE,holder.lighting_corner_NW,holder.lighting_corner_SE,holder.lighting_corner_SW)
	var/list/new_corners = list()
	var/list/removed_corners = list()
	for(var/datum/lighting_corner/corner in corners)
		switch(corner.sunlight)
			if(SUNLIGHT_NONE)
				if(sunlight)
					corner.sunlight = SUNLIGHT_CURRENT
					new_corners += corner
				else
					corner.sunlight = SUNLIGHT_POSSIBLE
			if(SUNLIGHT_POSSIBLE)
				if(sunlight)
					corner.sunlight = SUNLIGHT_CURRENT
					new_corners += corner
			if(SUNLIGHT_CURRENT)
				if((corner in affected) && !sunlight)
					affected -= corner
					removed_corners += corner
					corner.sunlight = SUNLIGHT_POSSIBLE

	if(!sun)
		if(SSplanets && SSplanets.z_to_planet.len >= holder.z && SSplanets.z_to_planet[holder.z])
			var/datum/planet/planet = SSplanets.z_to_planet[holder.z]
			sun = planet.sun_holder
		else
			return

	var/sunlight_mult = 0
	switch(sunlight)
		if(TRUE)
			sunlight_mult = 0.6
		if(SUNLIGHT_OVERHEAD)
			sunlight_mult = 1.0
	var/brightness = sun.our_brightness * sunlight_mult * sunlight * SSlighting.sun_mult
	var/list/color = hex2rgb(sun.our_color)
	var/red = brightness * (color[1] / 255.0)
	var/green = brightness * (color[2] / 255.0)
	var/blue = brightness * (color[3] / 255.0)
	var/delta_r = red - effect_str_r
	var/delta_g = green - effect_str_g
	var/delta_b = blue - effect_str_b

	for(var/datum/lighting_corner/corner in affected)
		corner.update_lumcount(delta_r,delta_g,delta_b)

	for(var/datum/lighting_corner/corner in new_corners)
		corner.update_lumcount(red,green,blue)
		affected += corner

	for(var/datum/lighting_corner/corner in removed_corners)
		corner.update_lumcount(-effect_str_r,-effect_str_g,-effect_str_b)

	effect_str_r = red
	effect_str_g = green
	effect_str_b = blue
