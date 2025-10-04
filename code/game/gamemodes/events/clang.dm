/*
Immovable rod random event.
The rod will spawn at some location outside the station, and travel in a straight line to the opposite side of the station
Everything solid in the way will be ex_act()'d
In my current plan for it, 'solid' will be defined as anything with density == 1

--NEOFite
*/

/obj/effect/immovablerod
	name = "Immovable Rod"
	desc = "What the fuck is that?"
	icon = 'icons/obj/objects.dmi'
	icon_state = "immrod"
	throwforce = 100
	density = TRUE
	anchored = TRUE
<<<<<<< HEAD
=======
	movement_type = UNSTOPPABLE
	var/turf/despawn_loc = null
	var/has_hunted_unlucky = FALSE

/obj/effect/immovablerod/proc/TakeFlight(var/turf/end)
	despawn_loc = end
	walk_towards(src, despawn_loc, 1)
	explosion(loc, 2, 3, 5) // start out with a bang

	// Get steps needed and then await that to despawn
	var/despawn_time = sqrt(((end.x - loc.x)**2) + ((end.y - loc.y)**2)) // distance of a line...
	QDEL_IN(src, despawn_time + 5 SECONDS) //Give a small extra time before we disappear entirely.
>>>>>>> b8fe8fa68d ([MIRROR] Unlucky trait (#11775))

/obj/effect/immovablerod/Bump(atom/clong)
	if(istype(clong, /turf/simulated/shuttle)) //Skip shuttles without actually deleting the rod
		return
<<<<<<< HEAD
=======

	if(prob(10) && !has_hunted_unlucky)
		hunt_unlucky()
>>>>>>> b8fe8fa68d ([MIRROR] Unlucky trait (#11775))

	else if (istype(clong, /turf) && !istype(clong, /turf/unsimulated))
		if(clong.density)
			clong.ex_act(2)
			for (var/mob/O in hearers(src, null))
				O.show_message("CLANG", 2)

	else if (istype(clong, /obj))
		if(clong.density)
			clong.ex_act(2)
			for (var/mob/O in hearers(src, null))
				O.show_message("CLANG", 2)

	else if (istype(clong, /mob))
		if(clong.density || prob(10))
			clong.ex_act(2)
	else
		qdel(src)

	if(clong && prob(25))
		src.loc = clong.loc

<<<<<<< HEAD
=======
/obj/effect/immovablerod/proc/resume_path()
	walk(src, 0)
	walk_towards(src, despawn_loc, 1)

>>>>>>> b8fe8fa68d ([MIRROR] Unlucky trait (#11775))
/obj/effect/immovablerod/Destroy()
	walk(src, 0) // Because we might have called walk_towards, we must stop the walk loop or BYOND keeps an internal reference to us forever.
	return ..()

/proc/immovablerod()
	var/startx = 0
	var/starty = 0
	var/endy = 0
	var/endx = 0
	var/startside = pick(GLOB.cardinal)

	switch(startside)
		if(NORTH)
			starty = 187
			startx = rand(41, 199)
			endy = 38
			endx = rand(41, 199)
		if(EAST)
			starty = rand(38, 187)
			startx = 199
			endy = rand(38, 187)
			endx = 41
		if(SOUTH)
			starty = 38
			startx = rand(41, 199)
			endy = 187
			endx = rand(41, 199)
		if(WEST)
			starty = rand(38, 187)
			startx = 41
			endy = rand(38, 187)
			endx = 199

	//rod time!
	var/obj/effect/immovablerod/immrod = new /obj/effect/immovablerod(locate(startx, starty, 1))
//	to_world("Rod in play, starting at [start.loc.x],[start.loc.y] and going to [end.loc.x],[end.loc.y]")
	var/end = locate(endx, endy, 1)
	spawn(0)
		walk_towards(immrod, end,1)
	sleep(1)
	while (immrod)
		if (isNotStationLevel(immrod.z))
			immrod.z = pick(using_map.station_levels)
		if(immrod.loc == end)
			qdel(immrod)
		sleep(10)
	for(var/obj/effect/immovablerod/imm in world)
		return
	sleep(50)
	command_announcement.Announce("What the fuck was that?!", "General Alert")
