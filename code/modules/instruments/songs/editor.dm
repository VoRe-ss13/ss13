/datum/song/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "InstrumentEditor", parent.name)
		ui.open()

/datum/song/tgui_host(mob/user)
	return parent

/datum/song/tgui_data(mob/user)
	var/list/data = ..()
	data["id"] = id
	data["using_instrument"] = using_instrument?.name || "No instrument loaded!"
	data["note_shift"] = note_shift
	data["octaves"] = round(note_shift / 12, 0.01)
	data["sustain_mode"] = sustain_mode
	switch(sustain_mode)
		if(SUSTAIN_LINEAR)
			data["sustain_mode_button"] = "Linear Sustain Duration (in seconds)"
			data["sustain_mode_duration"] = sustain_linear_duration / 10
			data["sustain_mode_min"] = INSTRUMENT_MIN_TOTAL_SUSTAIN
			data["sustain_mode_max"] = INSTRUMENT_MAX_TOTAL_SUSTAIN
		if(SUSTAIN_EXPONENTIAL)
			data["sustain_mode_button"] = "Exponential Falloff Factor (% per decisecond)"
			data["sustain_mode_duration"] = sustain_exponential_dropoff
			data["sustain_mode_min"] = INSTRUMENT_EXP_FALLOFF_MIN
			data["sustain_mode_max"] = INSTRUMENT_EXP_FALLOFF_MAX
	data["instrument_ready"] = using_instrument?.ready()
	data["volume"] = volume
	data["volume_dropoff_threshold"] = sustain_dropoff_volume
	data["sustain_indefinitely"] = full_sustain_held_note
	data["playing"] = playing
	data["repeat"] = repeat
	data["bpm"] = round(60 SECONDS / tempo)
	data["lines"] = list()
	var/linecount
	for(var/line in lines)
		linecount++
		data["lines"] += list(list(
			"line_count" = linecount,
			"line_text" = line,
		))
	return data

/datum/song/tgui_static_data(mob/user)
	var/list/data = ..()
	data["can_switch_instrument"] = (length(allowed_instrument_ids) > 1)
	data["possible_instruments"] = list()
	for(var/instrument in allowed_instrument_ids)
		UNTYPED_LIST_ADD(data["possible_instruments"], list("name" = SSinstruments.instrument_data[instrument], "id" = instrument))
	data["sustain_modes"] = SSinstruments.note_sustain_modes
	data["max_repeats"] = max_repeats
	data["min_volume"] = min_volume
	data["max_volume"] = max_volume
	data["note_shift_min"] = note_shift_min
	data["note_shift_max"] = note_shift_max
	data["max_line_chars"] = MUSIC_MAXLINECHARS
	data["max_lines"] = MUSIC_MAXLINES
	return data

/datum/song/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	. = ..()
	var/mob/user = ui.user
	if(!istype(user))
		return FALSE

	switch(action)
		//SETTINGS
		if("play_music")
			if(!playing)
				INVOKE_ASYNC(src, PROC_REF(start_playing), user)
			else
				stop_playing()
			return TRUE
		if("set_instrument_id")
			var/new_id = reject_bad_name(LOWER_TEXT(params["id"]), max_length = 20, allow_numbers = TRUE, cap_after_symbols = FALSE)
			if(new_id)
				id = new_id
			return TRUE
		if("change_instrument")
			var/new_instrument = params["new_instrument"]
			//only one instrument, so no need to bother changing it.
			if(!length(allowed_instrument_ids))
				return FALSE
			if(!(new_instrument in allowed_instrument_ids))
				return FALSE
			set_instrument(new_instrument)
			return TRUE
		if("tempo")
			var/move_direction = params["tempo_change"]
			var/tempo_diff
			if(move_direction == "increase_speed")
				tempo_diff = world.tick_lag
			else
				tempo_diff = -world.tick_lag
			tempo = sanitize_tempo(tempo + tempo_diff)
			return TRUE

		//SONG MAKING
		if("import_song")
			var/song_text = ""
			do
				song_text = tgui_input_text(user, "Please paste the entire song, formatted:", name, max_length = (MUSIC_MAXLINES * MUSIC_MAXLINECHARS), multiline = TRUE)
				if(!in_range(parent, user))
					return

				if(length_char(song_text) >= MUSIC_MAXLINES * MUSIC_MAXLINECHARS)
					var/should_continue = tgui_alert(user, "Your message is too long! Would you like to continue editing it?", "Warning", list("Yes", "No"))
					if(should_continue != "Yes")
						break
			while(length_char(song_text) > MUSIC_MAXLINES * MUSIC_MAXLINECHARS)
			ParseSong(user, song_text)
			return TRUE
		if("start_new_song")
			name = ""
			lines = new()
			tempo = sanitize_tempo(5) // default 120 BPM
			return TRUE
		if("add_new_line")
			var/newline = tgui_input_text(user, "Enter your line", parent.name, max_length = MUSIC_MAXLINECHARS)
			if(!newline || !in_range(parent, user))
				return
			if(lines.len > MUSIC_MAXLINES)
				return
			if(length(newline) > MUSIC_MAXLINECHARS)
				newline = copytext(newline, 1, MUSIC_MAXLINECHARS)
			lines.Add(newline)
		if("delete_line")
			var/line_to_delete = params["line_deleted"]
			if(line_to_delete > lines.len || line_to_delete < 1)
				return FALSE
			lines.Cut(line_to_delete, line_to_delete + 1)
			return TRUE
		if("modify_line")
			var/line_to_edit = params["line_editing"]
			if(line_to_edit > lines.len || line_to_edit < 1)
				return FALSE
			var/new_line_text = tgui_input_text(user, "Enter your line ", parent.name, lines[line_to_edit], max_length = MUSIC_MAXLINECHARS)
			if(isnull(new_line_text) || !in_range(parent, user))
				return FALSE
			lines[line_to_edit] = new_line_text
			return TRUE

		//MODE STUFF
		if("set_sustain_mode")
			var/new_mode = params["new_mode"]
			if(isnull(new_mode) || !(new_mode in SSinstruments.note_sustain_modes))
				return FALSE
			sustain_mode = new_mode
			return TRUE
		if("set_note_shift")
			var/amount = params["amount"]
			if(!isnum(amount))
				return FALSE
			note_shift = clamp(amount, note_shift_min, note_shift_max)
			return TRUE
		if("set_volume")
			var/new_volume = params["amount"]
			if(!isnum(new_volume))
				return FALSE
			set_volume(new_volume)
			return TRUE
		if("set_dropoff_volume")
			var/dropoff_threshold = params["amount"]
			if(!isnum(dropoff_threshold))
				return FALSE
			set_dropoff_volume(dropoff_threshold)
			return TRUE
		if("toggle_sustain_hold_indefinitely")
			full_sustain_held_note = !full_sustain_held_note
			return TRUE
		if("set_repeat_amount")
			if(playing)
				return
			var/repeat_amount = params["amount"]
			if(!isnum(repeat_amount))
				return FALSE
			set_repeats(repeat_amount)
			return TRUE
		if("edit_sustain_mode")
			var/sustain_amount = params["amount"]
			if(isnull(sustain_amount) || !isnum(sustain_amount))
				return
			switch(sustain_mode)
				if(SUSTAIN_LINEAR)
					set_linear_falloff_duration(sustain_amount)
				if(SUSTAIN_EXPONENTIAL)
					set_exponential_drop_rate(sustain_amount)

/**
 * Parses a song the user has input into lines and stores them.
 */
/datum/song/proc/ParseSong(mob/user, new_song)
	set waitfor = FALSE
	//split into lines
	lines = islist(new_song) ? new_song : splittext(new_song, "\n")
	if(lines.len)
		var/bpm_string = "BPM: "
		if(findtext(lines[1], bpm_string, 1, length(bpm_string) + 1))
			var/divisor = text2num(copytext(lines[1], length(bpm_string) + 1)) || 120 // default
			tempo = sanitize_tempo(BPM_TO_TEMPO_SETTING(divisor))
			lines.Cut(1, 2)
		else
			tempo = sanitize_tempo(5) // default 120 BPM
		if(lines.len > MUSIC_MAXLINES)
			if(user)
				to_chat(user, "Too many lines!")
			lines.Cut(MUSIC_MAXLINES + 1)
		var/linenum = 1
		for(var/l in lines)
			if(length_char(l) > MUSIC_MAXLINECHARS)
				if(user)
					to_chat(user, "Line [linenum] too long!")
				lines.Remove(l)
			else
				linenum++
<<<<<<< HEAD
		updateDialog(usr) // make sure updates when complete

/datum/song/Topic(href, href_list)
	if(!parent.CanUseTopic(usr))
		usr << browse(null, "window=instrument")
		usr.unset_machine()
		return

	parent.add_fingerprint(usr)

	if(href_list["newsong"])
		lines = new()
		tempo = sanitize_tempo(5) // default 120 BPM
		name = ""

	else if(href_list["import"])
		var/t = ""
		do
			t = html_encode(tgui_input_text(usr, "Please paste the entire song, formatted:", text("[]", name), t, multiline = TRUE, prevent_enter = TRUE))
			if(!in_range(parent, usr))
				return

			if(length_char(t) >= MUSIC_MAXLINES * MUSIC_MAXLINECHARS)
				var/cont = tgui_alert(usr, "Your message is too long! Would you like to continue editing it?", "Too long!", list("Yes", "No"))
				if(cont != "Yes")
					break
		while(length_char(t) > MUSIC_MAXLINES * MUSIC_MAXLINECHARS)
		ParseSong(t)

	else if(href_list["help"])
		help = text2num(href_list["help"]) - 1

	else if(href_list["edit"])
		editing = text2num(href_list["edit"]) - 1

	if(href_list["repeat"]) //Changing this from a toggle to a number of repeats to avoid infinite loops.
		if(playing)
			return //So that people cant keep adding to repeat. If the do it intentionally, it could result in the server crashing.
		repeat += round(text2num(href_list["repeat"]))
		if(repeat < 0)
			repeat = 0
		if(repeat > max_repeats)
			repeat = max_repeats

	else if(href_list["tempo"])
		tempo = sanitize_tempo(tempo + text2num(href_list["tempo"]))

	else if(href_list["play"])
		INVOKE_ASYNC(src, PROC_REF(start_playing), usr)

	else if(href_list["newline"])
		var/newline = html_encode(tgui_input_text(usr, "Enter your line: ", parent.name))
		if(!newline || !in_range(parent, usr))
			return
		if(lines.len > MUSIC_MAXLINES)
			return
		if(length(newline) > MUSIC_MAXLINECHARS)
			newline = copytext(newline, 1, MUSIC_MAXLINECHARS)
		lines.Add(newline)

	else if(href_list["deleteline"])
		var/num = round(text2num(href_list["deleteline"]))
		if(num > lines.len || num < 1)
			return
		lines.Cut(num, num+1)

	else if(href_list["modifyline"])
		var/num = round(text2num(href_list["modifyline"]),1)
		var/content = tgui_input_text(usr, "Enter your line: ", parent.name, lines[num], MUSIC_MAXLINECHARS, encode=TRUE)
		if(!content || !in_range(parent, usr))
			return
		if(num > lines.len || num < 1)
			return
		lines[num] = content

	else if(href_list["stop"])
		stop_playing()

	else if(href_list["setlinearfalloff"])
		var/amount = tgui_input_number(usr, "Set linear sustain duration in seconds", "Linear Sustain Duration", round_value=FALSE)
		if(!isnull(amount))
			set_linear_falloff_duration(round(amount * 10, world.tick_lag))

	else if(href_list["setexpfalloff"])
		var/amount = tgui_input_number(usr, "Set exponential sustain factor", "Exponential sustain factor", round_value=FALSE)
		if(!isnull(amount))
			set_exponential_drop_rate(round(amount, 0.00001))

	else if(href_list["setvolume"])
		var/amount = tgui_input_number(usr, "Set volume", "Volume")
		if(!isnull(amount))
			set_volume(round(amount, 1))

	else if(href_list["setdropoffvolume"])
		var/amount = tgui_input_number(usr, "Set dropoff threshold", "Dropoff Threshold Volume", round_value=FALSE)
		if(!isnull(amount))
			set_dropoff_volume(round(amount, 0.01))

	else if(href_list["switchinstrument"])
		if(!length(allowed_instrument_ids))
			return
		else if(length(allowed_instrument_ids) == 1)
			set_instrument(allowed_instrument_ids[1])
			return
		var/list/categories = list()
		for(var/i in allowed_instrument_ids)
			var/datum/instrument/I = SSinstruments.get_instrument(i)
			if(I)
				LAZYSET(categories[I.category || "ERROR CATEGORY"], I.name, I.id)
		var/cat = tgui_input_list(usr, "Select Category", "Instrument Category", categories)
		if(!cat)
			return
		var/list/instruments = categories[cat]
		var/choice = tgui_input_list(usr, "Select Instrument", "Instrument Selection", instruments)
		if(!choice)
			return
		choice = instruments[choice] //get id
		if(choice)
			set_instrument(choice)

	else if(href_list["setnoteshift"])
		var/amount = tgui_input_number(usr, "Set note shift", "Note Shift", null, note_shift_max, note_shift_min)
		if(!isnull(amount))
			note_shift = clamp(amount, note_shift_min, note_shift_max)

	else if(href_list["setsustainmode"])
		var/choice = tgui_input_list(usr, "Choose a sustain mode", "Sustain Mode", list("Linear", "Exponential"))
		switch(choice)
			if("Linear")
				sustain_mode = SUSTAIN_LINEAR
			if("Exponential")
				sustain_mode = SUSTAIN_EXPONENTIAL

	else if(href_list["togglesustainhold"])
		full_sustain_held_note = !full_sustain_held_note

	updateDialog()
=======
>>>>>>> d8408a2c59 ([MIRROR] Instrument Update (#11645))
