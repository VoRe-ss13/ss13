/datum/configuration
	var/discord_whitelist = FALSE
	var/vote_autotransfer_hard = 2

/hook/startup/proc/read_tc_config()
	var/list/Lines = file2list("config/config.txt")
	for(var/t in Lines)
		if(!t)	continue

		t = trim(t)
		if (length(t) == 0)
			continue
		else if (copytext(t, 1, 2) == "#")
			continue

		var/pos = findtext(t, " ")
		var/name = null
		var/value = null

		if (pos)
			name = lowertext(copytext(t, 1, pos))
			value = copytext(t, pos + 1)
		else
			name = lowertext(t)

		if (!name)
			continue

		switch (name)
			if("discord_whitelist")
				config.discord_whitelist = TRUE
			if("vote_autotransfer_hard")
				config.vote_autotransfer_hard = text2num(value)

