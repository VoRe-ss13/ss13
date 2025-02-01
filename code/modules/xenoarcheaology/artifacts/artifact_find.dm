/datum/artifact_find
	var/artifact_id
	var/artifact_find_type

/datum/artifact_find/New()

	artifact_id = "[pick("kappa","sigma","antaeres","beta","omicron","iota","epsilon","omega","gamma","delta","tau","alpha")]-[rand(100,999)]"

	artifact_find_type = pick(
<<<<<<< HEAD
	5;/obj/machinery/power/supermatter,
	5;/obj/structure/constructshell,
	5;/obj/machinery/syndicate_beacon/virgo,	// VOREStation Edit: use virgo-specific subtype that doesn't create 'real' antags,
	25;/obj/machinery/power/supermatter/shard,
	100;/obj/machinery/auto_cloner,
	100;/obj/machinery/giga_drill,
	100;/obj/machinery/replicator/clothing, 	//VOREStation Edit: use virgo-specific subtype that allows TF into items.
	100;/obj/machinery/replicator/vore, 		//VOREStation Edit: use virgo-specific subtype that allows TF into mobs.
	150;/obj/structure/crystal,
	1000;/obj/machinery/artifact)
=======
	300;/obj/machinery/artifact,
	25;/obj/machinery/auto_cloner,
	25;/obj/machinery/replicator/vore,
	25;/obj/structure/constructshell,
	25;/obj/machinery/replicator/clothing,
	25;/obj/structure/crystal,
	15;/obj/machinery/giga_drill,
	5;/obj/machinery/syndicate_beacon/virgo,
	2;/obj/machinery/power/supermatter/shard,
	1;/obj/machinery/power/supermatter)

	// Calculations:
	// TO do the math calculation:
	// OBJECT_WEIGHT = The weight of the object. (Ex: supermatter is 1)
	// TOTAL_WEIGHT = The weight of ALL the objects added together
	// To calculate the chance of an artifact spawning, do: ((OBJECT_WEIGHT  / TOTAL_WEIGHT) * 100) and that is your %
>>>>>>> b3541a5384 ([MIRROR] More xenoarch tweaks (#10036))
