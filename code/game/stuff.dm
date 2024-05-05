/world
	loop_checks = 0

/proc/get_stuff()
	var/list/types_count = list()
	for(var/datum/thing in world)
		add_types(thing, types_count)
	for(var/datum/thing)
		add_types(thing, types_count)
	sortTim(types_count, /proc/cmp_numeric_asc, TRUE)
	var/output = ""
	for(var/type in types_count)
		output += "[type] - [types_count[type]]\n"
	rustg_file_write(output, "stuff.txt")
	output = ""
	var/list/list_count = list()
	var/list/exclude_vars = list("overlays","underlays","vis_contents","vis_locs","contents","vars","verbs")
	for(var/datum/thing in world)
		for(var/variable in thing.vars)
			if(variable in exclude_vars)
				continue
			if(islist(thing.vars[variable]))
				if(thing.type in list_count) list_count[thing.type]++
				else list_count[thing.type] = 1
	sortTim(list_count, /proc/cmp_numeric_asc, TRUE)
	for(var/type in list_count)
		var/lists_per_instance = list_count[type] / types_count[type]
		output += "[type] - [list_count[type]] lists total - [lists_per_instance] per instance \n"
	rustg_file_write(output, "lists.txt")

/proc/add_types(var/datum/thing, var/list/L)
	var/type = thing::type
	var/p_type = thing::parent_type
	if(type in L) L[type]++
	else L[type] = 1
	if(p_type) add_types(p_type, L)

/datum/controller/master/SetRunLevel(new_runlevel)
	if(new_runlevel == RUNLEVEL_LOBBY)
		get_stuff()
	. = ..(new_runlevel)
