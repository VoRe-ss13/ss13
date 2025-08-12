SUBSYSTEM_DEF(ticker)
	name = "Ticker"
	priority = FIRE_PRIORITY_TICKER
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME

	/// state of current round (used by process()) Use the defines GAME_STATE_* !
	var/current_state = GAME_STATE_STARTUP
	/// Boolean to track if round should be forcibly ended next ticker tick.
	/// Set by admin intervention ([ADMIN_FORCE_END_ROUND])
	/// or a "round-ending" event, like summoning Nar'Sie, a blob victory, the nuke going off, etc. ([FORCE_END_ROUND])
	var/force_ending = END_ROUND_AS_NORMAL
	/// If TRUE, there is no lobby phase, the game starts immediately.
	var/start_immediately = FALSE
	/// Boolean to track and check if our subsystem setup is done.
	var/setup_done = FALSE

	var/hide_mode = FALSE
	var/datum/game_mode/mode = null

	var/login_music //music played in pregame lobby
	var/round_end_sound //music/jingle played when the world reboots
	var/round_end_sound_sent = TRUE //If all clients have loaded it

	var/list/datum/mind/minds = list() //The characters in the game. Used for objective tracking.

	var/delay_end = FALSE //if set true, the round will not restart on it's own
	var/admin_delay_notice = "" //a message to display to anyone who tries to restart the world after a delay
	var/ready_for_reboot = FALSE //all roundend preparation done with, all that's left is reboot

	var/tipped = FALSE //Did we broadcast the tip of the day yet?
	var/selected_tip // What will be the tip of the day?

	var/timeLeft //pregame timer
	var/start_at

	var/gametime_offset = 432000 //Deciseconds to add to world.time for station time.
	var/station_time_rate_multiplier = 12 //factor of station time progressal vs real time.

	/// Num of players, used for pregame stats on statpanel
	var/totalPlayers = 0
	/// Num of ready players, used for pregame stats on statpanel (only viewable by admins)
	var/totalPlayersReady = 0
	/// Num of ready admins, used for pregame stats on statpanel (only viewable by admins)
	var/total_admins_ready = 0

	var/queue_delay = 0
	var/list/queued_players = list() //used for join queues when the server exceeds the hard population cap

	/// What is going to be reported to other stations at end of round?
	var/news_report


	var/roundend_check_paused = FALSE

	var/round_start_time = 0
<<<<<<< HEAD
=======
	var/list/round_start_events
	var/list/round_end_events
	var/mode_result = "undefined"
	var/end_state = "undefined"
>>>>>>> 386c4f6756 ([MIRROR] Unit Test rework & Master/Ticker update (#11372))

	/// People who have been commended and will receive a heart
	var/list/hearts

	/// Why an emergency shuttle was called
	var/emergency_reason

	/// ID of round reboot timer, if it exists
	var/reboot_timer = null

	/// ### LEGACY VARS ###
	/// Default time to wait before rebooting in desiseconds.
	var/const/restart_timeout = 4 MINUTES
	/// Track where we are ending game/round
	var/end_game_state = END_GAME_NOT_OVER
	/// Time remaining until restart in desiseconds
	var/restart_timeleft
	/// world.time of last restart warning.
	var/last_restart_notify

/datum/controller/subsystem/ticker/Initialize()
	start_at = world.time + (CONFIG_GET(number/lobby_countdown) * 10)
	SSwebhooks.send(
		WEBHOOK_ROUNDPREP,
		list(
			"map" = station_name(),
			"url" = get_world_url()
		)
	)

	return SS_INIT_SUCCESS

/datum/controller/subsystem/ticker/fire(resumed = FALSE)
	switch(current_state)
		if(GAME_STATE_STARTUP)
			if(Master.initializations_finished_with_no_players_logged_in)
				start_at = world.time + (CONFIG_GET(number/lobby_countdown) * 10)
			for(var/client/C in GLOB.clients)
				window_flash(C, ignorepref = TRUE) //let them know lobby has opened up.
			to_chat(world, span_notice("<b>Welcome to [station_name()]!</b>"))
			current_state = GAME_STATE_PREGAME
			SEND_SIGNAL(src, COMSIG_TICKER_ENTER_PREGAME)

			fire()
		if(GAME_STATE_PREGAME)
			//lobby stats for statpanels
			if(isnull(timeLeft))
				timeLeft = max(0,start_at - world.time)
			totalPlayers = LAZYLEN(GLOB.new_player_list)
			totalPlayersReady = 0
			total_admins_ready = 0
			for(var/mob/new_player/player as anything in GLOB.new_player_list)
				if(player.ready == PLAYER_READY_TO_PLAY)
					++totalPlayersReady
					if(player.client?.holder)
						++total_admins_ready

			if(start_immediately)
				timeLeft = 0

			//countdown
			if(timeLeft < 0)
				return
			timeLeft -= wait

			//if(timeLeft <= 300 && !tipped)
			//	send_tip_of_the_round(world, selected_tip)
			//	tipped = TRUE

			if(timeLeft <= 0)
				SEND_SIGNAL(src, COMSIG_TICKER_ENTER_SETTING_UP)
				current_state = GAME_STATE_SETTING_UP
				Master.SetRunLevel(RUNLEVEL_SETUP)
				if(start_immediately)
					fire()

		if(GAME_STATE_SETTING_UP)
			if(!setup())
				//setup failed
				current_state = GAME_STATE_STARTUP
				start_at = world.time + (CONFIG_GET(number/lobby_countdown) * 10)
				timeLeft = null
				Master.SetRunLevel(RUNLEVEL_LOBBY)
				SEND_SIGNAL(src, COMSIG_TICKER_ERROR_SETTING_UP)

		if(GAME_STATE_PLAYING)
			mode.process() // So THIS is where we run mode.process() huh? Okay

			if(mode.explosion_in_progress)
				return // wait until explosion is done.

			if(force_ending)
				current_state = GAME_STATE_FINISHED
				declare_completion(force_ending)
				Master.SetRunLevel(RUNLEVEL_POSTGAME)
			else
				// Calculate if game and/or mode are finished (Complicated by the continuous_rounds config option)
				var/game_finished = FALSE
				var/mode_finished = FALSE
				if (CONFIG_GET(flag/continuous_rounds)) // Game keeps going after mode ends.
					game_finished = (emergency_shuttle.returned() || mode.station_was_nuked)
					mode_finished = ((end_game_state >= END_GAME_MODE_FINISHED) || mode.check_finished()) // Short circuit if already finished.
				else // Game ends when mode does
					game_finished = (mode.check_finished() || (emergency_shuttle.returned() && emergency_shuttle.evac == 1)) || GLOB.universe_has_ended
					mode_finished = game_finished

				if(game_finished && mode_finished)
					end_game_state = END_GAME_READY_TO_END
					current_state = GAME_STATE_FINISHED
					Master.SetRunLevel(RUNLEVEL_POSTGAME)
					INVOKE_ASYNC(src, PROC_REF(declare_completion))
				else if (mode_finished && (end_game_state < END_GAME_MODE_FINISHED))
					end_game_state = END_GAME_MODE_FINISHED // Only do this cleanup once!
					mode.cleanup()
					//call a transfer shuttle vote
					to_world(span_boldannounce("The round has ended!"))
					SSvote.start_vote(new /datum/vote/crew_transfer)

		// FIXME: IMPROVE THIS LATER!
		if(GAME_STATE_FINISHED)
			post_game_tick()

			if (world.time - last_restart_notify >= 1 MINUTE && !delay_end)
				to_world(span_boldannounce("Restarting in [round(restart_timeleft/600, 1)] minute\s."))
				last_restart_notify = world.time

/datum/controller/subsystem/ticker/proc/setup()
	to_chat(world, span_boldannounce("Starting game..."))
	var/init_start = world.timeofday

	CHECK_TICK
	setup_choose_gamemode()
	// TODO

<<<<<<< HEAD
	// Time to start the game!
	if(pregame_timeleft <= 0)
		//Fops edit Start
		if(length(GLOB.clients) == 0) //Don't start round unless at least 1 user is present
			return
		//Fops edit End
		current_state = GAME_STATE_SETTING_UP
		Master.SetRunLevel(RUNLEVEL_SETUP)
		if(start_immediately)
			fire() // Don't wait for next tick, do it now!
		return
=======
	CHECK_TICK
	setup_economy()
	create_characters() //Create player characters
	collect_minds()
	equip_characters()
>>>>>>> 386c4f6756 ([MIRROR] Unit Test rework & Master/Ticker update (#11372))

	//	data_core.manifest()

	for(var/I in round_start_events)
		var/datum/callback/cb = I
		cb.InvokeAsync()
	LAZYCLEARLIST(round_start_events)

	round_start_time = world.time //otherwise round_start_time would be 0 for the signals
	SEND_SIGNAL(src, COMSIG_TICKER_ROUND_STARTING, world.time)
	callHook("roundstart")

	log_world("Game start took [(world.timeofday - init_start)/10]s")
	INVOKE_ASYNC(SSdbcore, TYPE_PROC_REF(/datum/controller/subsystem/dbcore,SetRoundStart))

	to_chat(world, span_notice(span_bold("Welcome to [station_name()], enjoy your stay!")))
	world << sound('sound/AI/welcome.ogg') // Skie
	//SEND_SOUND(world, sound(SSstation.announcer.get_rand_welcome_sound()))

	current_state = GAME_STATE_PLAYING
	Master.SetRunLevel(RUNLEVEL_GAME)

	//Holiday Round-start stuff	~Carn
	Holiday_Game_Start()

	// TODO END

	PostSetup()

	return TRUE

/datum/controller/subsystem/ticker/proc/PostSetup()
	set waitfor = FALSE
	mode.post_setup()
	// TODO

	var/list/adm = get_admin_counts()
	var/list/allmins = adm["present"]
	// TODO: IMPLEMENT: send2adminchat("Server", "Round [GLOB.round_id ? "#[GLOB.round_id]" : ""] has started[allmins.len ? ".":" with no active admins online!"]")
	if(!allmins.len)
		send2adminirc("A round has started with no admins online.")

	setup_done = TRUE
	// TODO START

	// TODO END
	for(var/obj/effect/landmark/start/S in GLOB.landmarks_list)
		//Deleting Startpoints but we need the ai point to AI-ize people later
		if (S.name != "AI")
			qdel(S)

	if(CONFIG_GET(flag/sql_enabled))
		statistic_cycle() // Polls population totals regularly and stores them in an SQL DB -- TLE

//These callbacks will fire after roundstart key transfer
/datum/controller/subsystem/ticker/proc/OnRoundstart(datum/callback/cb)
	if(!HasRoundStarted())
		LAZYADD(round_start_events, cb)
	else
		cb.InvokeAsync()

//These callbacks will fire before roundend report
/datum/controller/subsystem/ticker/proc/OnRoundend(datum/callback/cb)
	if(current_state >= GAME_STATE_FINISHED)
		cb.InvokeAsync()
	else
		LAZYADD(round_end_events, cb)

// Formerly the first half of setup() - The part that chooses the game mode.
// Returns 0 if failed to pick a mode, otherwise 1
/datum/controller/subsystem/ticker/proc/setup_choose_gamemode()
	//Create and announce mode
	if(GLOB.master_mode == "secret")
		src.hide_mode = TRUE

	var/list/runnable_modes = config.get_runnable_modes()
	if((GLOB.master_mode == "random") || (GLOB.master_mode == "secret"))
		if(!runnable_modes.len)
			to_world(span_filter_system(span_bold("Unable to choose playable game mode.") + " Reverting to pregame lobby."))
			return 0
		if(GLOB.secret_force_mode != "secret")
			src.mode = config.pick_mode(GLOB.secret_force_mode)
		if(!src.mode)
			var/list/weighted_modes = list()
			for(var/datum/game_mode/GM in runnable_modes)
				weighted_modes[GM.config_tag] = CONFIG_GET(keyed_list/probabilities)[GM.config_tag]
			src.mode = config.gamemode_cache[pickweight(weighted_modes)]
	else
		src.mode = config.pick_mode(GLOB.master_mode)

	if(!src.mode)
		to_world(span_boldannounce("Serious error in mode setup! Reverting to pregame lobby.")) //Uses setup instead of set up due to computational context.
		return 0

	job_master.ResetOccupations()
	src.mode.create_antagonists()
	src.mode.pre_setup()
	job_master.DivideOccupations() // Apparently important for new antagonist system to register specific job antags properly.

	if(!src.mode.can_start())
		to_world(span_filter_system(span_bold("Unable to start [mode.name].") + " Not enough players readied, [CONFIG_GET(keyed_list/player_requirements)[mode.config_tag]] players needed. Reverting to pregame lobby."))
		mode.fail_setup()
		mode = null
		job_master.ResetOccupations()
		return 0

	if(hide_mode)
		to_world(span_world(span_notice("The current game mode is - Secret!")))
		if(runnable_modes.len)
			var/list/tmpmodes = new
			for (var/datum/game_mode/M in runnable_modes)
				tmpmodes+=M.name
			tmpmodes = sortList(tmpmodes)
			if(tmpmodes.len)
				to_world(span_filter_system(span_bold("Possibilities:") + " [english_list(tmpmodes, and_text= "; ", comma_text = "; ")]"))
	else
		src.mode.announce()
	return 1

<<<<<<< HEAD
// Formerly the second half of setup() - The part that actually initializes everything and starts the game.
/datum/controller/subsystem/ticker/proc/setup_startgame()
	setup_economy()
	create_characters() //Create player characters and transfer them.
	collect_minds()
	equip_characters()
//	data_core.manifest()

	callHook("roundstart")

	spawn(0)//Forking here so we dont have to wait for this to finish
		mode.post_setup()
		//Cleanup some stuff
		for(var/obj/effect/landmark/start/S in landmarks_list)
			//Deleting Startpoints but we need the ai point to AI-ize people later
			if (S.name != "AI")
				qdel(S)
		to_world(span_boldannounce(span_notice("<em>Enjoy the game!</em>")))
		world << sound('sound/AI/welcome.ogg') // Skie
		//Holiday Round-start stuff	~Carn
		Holiday_Game_Start()

	var/list/adm = get_admin_counts()
	if(adm["total"] == 0)
		send2adminirc("A round has started with no admins online.")

	current_state = GAME_STATE_PLAYING
	Master.SetRunLevel(RUNLEVEL_GAME)

	if(CONFIG_GET(flag/sql_enabled))
		statistic_cycle() // Polls population totals regularly and stores them in an SQL DB -- TLE

	return 1


// Called during GAME_STATE_PLAYING (RUNLEVEL_GAME)
/datum/controller/subsystem/ticker/proc/playing_tick(resumed = FALSE)
	mode.process() // So THIS is where we run mode.process() huh? Okay

	if(mode.explosion_in_progress)
		return // wait until explosion is done.

	// Calculate if game and/or mode are finished (Complicated by the continuous_rounds config option)
	var/game_finished = FALSE
	var/mode_finished = FALSE
	if (CONFIG_GET(flag/continuous_rounds)) // Game keeps going after mode ends.
		game_finished = (emergency_shuttle.returned() || mode.station_was_nuked)
		mode_finished = ((end_game_state >= END_GAME_MODE_FINISHED) || mode.check_finished()) // Short circuit if already finished.
	else // Game ends when mode does
		game_finished = (mode.check_finished() || (emergency_shuttle.returned() && emergency_shuttle.evac == 1)) || GLOB.universe_has_ended
		mode_finished = game_finished

	if(game_finished && mode_finished)
		end_game_state = END_GAME_READY_TO_END
		current_state = GAME_STATE_FINISHED
		Master.SetRunLevel(RUNLEVEL_POSTGAME)
		INVOKE_ASYNC(src, PROC_REF(declare_completion))
	else if (mode_finished && (end_game_state < END_GAME_MODE_FINISHED))
		end_game_state = END_GAME_MODE_FINISHED // Only do this cleanup once!
		mode.cleanup()
		//call a transfer shuttle vote
		to_world(span_boldannounce("The round has ended!"))
		SSvote.start_vote(new /datum/vote/crew_transfer)

=======
>>>>>>> 386c4f6756 ([MIRROR] Unit Test rework & Master/Ticker update (#11372))
// Called during GAME_STATE_FINISHED (RUNLEVEL_POSTGAME)
/datum/controller/subsystem/ticker/proc/post_game_tick()
	switch(end_game_state)
		if(END_GAME_READY_TO_END)
			callHook("roundend")

			if (mode.station_was_nuked)
				feedback_set_details("end_proper", "nuke")
				restart_timeleft = 1 MINUTE // No point waiting five minutes if everyone's dead.
				if(!delay_end)
					to_world(span_boldannounce("Rebooting due to destruction of [station_name()] in [round(restart_timeleft/600)] minute\s."))
					last_restart_notify = world.time
			else
				feedback_set_details("end_proper", "proper completion")
				restart_timeleft = restart_timeout

			if(blackbox)
				blackbox.save_all_data_to_sql()	// TODO - Blackbox or statistics subsystem

			end_game_state = END_GAME_ENDING
			return
<<<<<<< HEAD
		if(END_GAME_ENDING)
			restart_timeleft -= (world.time - last_fire)
			if(delay_end)
				to_world(span_boldannounce("An admin has delayed the round end."))
				end_game_state = END_GAME_DELAYED
			else if(restart_timeleft <= 0)
				to_world(span_boldannounce("Restarting world!"))
				sleep(5)
				world.Reboot()
			else if (world.time - last_restart_notify >= 1 MINUTE)
				to_world(span_boldannounce("Restarting in [round(restart_timeleft/600, 1)] minute\s."))
				last_restart_notify = world.time
			return
		if(END_GAME_DELAYED)
			restart_timeleft -= (world.time - last_fire)
			if(!delay_end)
				end_game_state = END_GAME_ENDING
		else
			log_error("Ticker arrived at round end in an unexpected endgame state '[end_game_state]'.")
			end_game_state = END_GAME_READY_TO_END


// ----------------------------------------------------------------------
// These two below are not used! But they could be

// Use these preferentially to directly examining ticker.current_state to help prepare for transition to ticker as subsystem!

/datum/controller/subsystem/ticker/proc/PreRoundStart()
	return (current_state < GAME_STATE_PLAYING)

/datum/controller/subsystem/ticker/proc/IsSettingUp()
	return (current_state == GAME_STATE_SETTING_UP)

/datum/controller/subsystem/ticker/proc/IsRoundInProgress()
	return (current_state == GAME_STATE_PLAYING)

/datum/controller/subsystem/ticker/proc/HasRoundStarted()
	return (current_state >= GAME_STATE_PLAYING)

// ------------------------------------------------------------------------
// HELPER PROCS!
// ------------------------------------------------------------------------

//Plus it provides an easy way to make cinematics for other events. Just use this as a template :)
/datum/controller/subsystem/ticker/proc/station_explosion_cinematic(var/station_missed=0, var/override = null)
	if( cinematic )	return	//already a cinematic in progress!

	//initialise our cinematic screen object
	cinematic = new(src)
	cinematic.icon = 'icons/effects/station_explosion.dmi'
	cinematic.icon_state = "station_intact"
	cinematic.layer = 100
	cinematic.plane = PLANE_PLAYER_HUD
	cinematic.mouse_opacity = 0
	cinematic.screen_loc = "1,0"

	var/obj/structure/bed/temp_buckle = new(src)
	//Incredibly hackish. It creates a bed within the gameticker (lol) to stop mobs running around
	if(station_missed)
		for(var/mob/living/M in living_mob_list)
			M.buckled = temp_buckle				//buckles the mob so it can't do anything
			if(M.client)
				M.client.screen += cinematic	//show every client the cinematic
	else	//nuke kills everyone on z-level 1 to prevent "hurr-durr I survived"
		for(var/mob/living/M in living_mob_list)
			M.buckled = temp_buckle
			if(M.client)
				M.client.screen += cinematic

			switch(M.z)
				if(0)	//inside a crate or something
					var/turf/T = get_turf(M)
					if(T && (T.z in using_map.station_levels))				//we don't use M.death(0) because it calls a for(/mob) loop and
						M.health = 0
						M.set_stat(DEAD)
				if(1)	//on a z-level 1 turf.
					M.health = 0
					M.set_stat(DEAD)

	//Now animate the cinematic
	switch(station_missed)
		if(1)	//nuke was nearby but (mostly) missed
			if( mode && !override )
				override = mode.name
			switch( override )
				if("mercenary") //Nuke wasn't on station when it blew up
					flick("intro_nuke",cinematic)
					sleep(35)
					world << sound('sound/effects/explosionfar.ogg')
					flick("station_intact_fade_red",cinematic)
					cinematic.icon_state = "summary_nukefail"
				else
					flick("intro_nuke",cinematic)
					sleep(35)
					world << sound('sound/effects/explosionfar.ogg')
					//flick("end",cinematic)


		if(2)	//nuke was nowhere nearby	//TODO: a really distant explosion animation
			sleep(50)
			world << sound('sound/effects/explosionfar.ogg')


		else	//station was destroyed
			if( mode && !override )
				override = mode.name
			switch( override )
				if("mercenary") //Nuke Ops successfully bombed the station
					flick("intro_nuke",cinematic)
					sleep(35)
					flick("station_explode_fade_red",cinematic)
					world << sound('sound/effects/explosionfar.ogg')
					cinematic.icon_state = "summary_nukewin"
				if("AI malfunction") //Malf (screen,explosion,summary)
					flick("intro_malf",cinematic)
					sleep(76)
					flick("station_explode_fade_red",cinematic)
					world << sound('sound/effects/explosionfar.ogg')
					cinematic.icon_state = "summary_malf"
				if("blob") //Station nuked (nuke,explosion,summary)
					flick("intro_nuke",cinematic)
					sleep(35)
					flick("station_explode_fade_red",cinematic)
					world << sound('sound/effects/explosionfar.ogg')
					cinematic.icon_state = "summary_selfdes"
				else //Station nuked (nuke,explosion,summary)
					flick("intro_nuke",cinematic)
					sleep(35)
					flick("station_explode_fade_red", cinematic)
					world << sound('sound/effects/explosionfar.ogg')
					cinematic.icon_state = "summary_selfdes"
			for(var/mob/living/M in living_mob_list)
				if(M.loc.z in using_map.station_levels)
					M.death()//No mercy
	//If its actually the end of the round, wait for it to end.
	//Otherwise if its a verb it will continue on afterwards.
	sleep(300)

	if(cinematic)	qdel(cinematic)		//end the cinematic
	if(temp_buckle)	qdel(temp_buckle)	//release everybody
	return

=======
>>>>>>> 386c4f6756 ([MIRROR] Unit Test rework & Master/Ticker update (#11372))

/datum/controller/subsystem/ticker/proc/create_characters()
	for(var/mob/new_player/player in player_list)
		if(player && player.ready && player.mind?.assigned_role)
			var/datum/job/J = SSjob.get_job(player.mind.assigned_role)

			// Ask their new_player mob to spawn them
			if(!player.spawn_checks_vr(player.mind.assigned_role))
				var/datum/job/job_datum = job_master.GetJob(J.title)
				job_datum.current_positions--
				player.mind.assigned_role = null
				continue //VOREStation Add

			// Snowflakey AI treatment
			if(J?.mob_type & JOB_SILICON_AI)
				player.close_spawn_windows()
				player.AIize(move = TRUE)
				continue

			var/mob/living/carbon/human/new_char = player.create_character()

			// Created their playable character, delete their /mob/new_player
			if(new_char)
				qdel(player)
				if(new_char.client)
					new_char.client.init_verbs()

			// If they're a carbon, they can get manifested
			if(J?.mob_type & JOB_CARBON)
				GLOB.data_core.manifest_inject(new_char)
		CHECK_TICK

/datum/controller/subsystem/ticker/proc/collect_minds()
	for(var/mob/living/player in player_list)
		if(player.mind)
			minds += player.mind
		CHECK_TICK

/datum/controller/subsystem/ticker/proc/equip_characters()
	var/captainless=1
	for(var/mob/living/carbon/human/player in player_list)
		if(player && player.mind && player.mind.assigned_role)
			if(player.mind.assigned_role == JOB_SITE_MANAGER)
				captainless=0
			if(!player_is_antag(player.mind, only_offstation_roles = 1))
				job_master.EquipRank(player, player.mind.assigned_role, 0)
				UpdateFactionList(player)
				//equip_custom_items(player)	//VOREStation Removal
				//player.apply_traits() //VOREStation Removal
		//VOREStation Addition Start
		if(player.client)
			if(player.client.prefs.auto_backup_implant)
				var/obj/item/implant/backup/imp = new(src)

				if(imp.handle_implant(player,player.zone_sel.selecting))
					imp.post_implant(player)
		//VOREStation Addition End
		CHECK_TICK
	if(captainless)
		for(var/mob/M in player_list)
			if(!isnewplayer(M))
				to_chat(M, span_notice("Site Management is not forced on anyone."))

///Whether the game has started, including roundend.
/datum/controller/subsystem/ticker/proc/HasRoundStarted()
	return current_state >= GAME_STATE_PLAYING

<<<<<<< HEAD
/datum/controller/subsystem/ticker/proc/declare_completion()
	to_world(span_filter_system("<br><br><br><H1>A round of [mode.name] has ended!</H1>"))
	for(var/mob/Player in player_list)
		if(Player.mind && !isnewplayer(Player))
			if(Player.stat != DEAD)
				var/turf/playerTurf = get_turf(Player)
				if(emergency_shuttle.departed && emergency_shuttle.evac)
					if(isNotAdminLevel(playerTurf.z))
						to_chat(Player, span_filter_system(span_blue(span_bold("You survived the round, but remained on [station_name()] as [Player.real_name]."))))
					else
						to_chat(Player, span_filter_system(span_green(span_bold("You managed to survive the events on [station_name()] as [Player.real_name]."))))
				else if(isAdminLevel(playerTurf.z))
					to_chat(Player, span_filter_system(span_green(span_bold("You successfully underwent crew transfer after events on [station_name()] as [Player.real_name]."))))
				else if(issilicon(Player))
					to_chat(Player, span_filter_system(span_green(span_bold("You remain operational after the events on [station_name()] as [Player.real_name]."))))
				else
					to_chat(Player, span_filter_system(span_blue(span_bold("You missed the crew transfer after the events on [station_name()] as [Player.real_name]."))))
			else
				if(isobserver(Player))
					var/mob/observer/dead/O = Player
					if(!O.started_as_observer)
						to_chat(Player, span_filter_system(span_red(span_bold("You did not survive the events on [station_name()]..."))))
				else
					to_chat(Player, span_filter_system(span_red(span_bold("You did not survive the events on [station_name()]..."))))
	to_world(span_filter_system("<br>"))

	for (var/mob/living/silicon/ai/aiPlayer in mob_list)
		if (aiPlayer.stat != 2)
			to_world(span_filter_system(span_bold("[aiPlayer.name]'s laws at the end of the round were:"))) // VOREStation edit
		else
			to_world(span_filter_system(span_bold("[aiPlayer.name]'s laws when it was deactivated were:"))) // VOREStation edit
		aiPlayer.show_laws(1)

		if (aiPlayer.connected_robots.len)
			var/robolist = span_bold("The AI's loyal minions were:") + " "
			for(var/mob/living/silicon/robot/robo in aiPlayer.connected_robots)
				robolist += "[robo.name][robo.stat?" (Deactivated), ":", "]"  // VOREStation edit
			to_world(span_filter_system("[robolist]"))

	var/dronecount = 0

	for (var/mob/living/silicon/robot/robo in mob_list)

		if(istype(robo, /mob/living/silicon/robot/platform))
			var/mob/living/silicon/robot/platform/tank = robo
			if(!tank.has_had_player)
				continue

		if(istype(robo,/mob/living/silicon/robot/drone) && !istype(robo,/mob/living/silicon/robot/drone/swarm))
			dronecount++
			continue

		if (!robo.connected_ai)
			if (robo.stat != 2)
				to_world(span_filter_system(span_bold("[robo.name] survived as an AI-less stationbound synthetic! Its laws were:"))) // VOREStation edit
			else
				to_world(span_filter_system(span_bold("[robo.name] was unable to survive the rigors of being a stationbound synthetic without an AI. Its laws were:"))) // VOREStation edit

			if(robo) //How the hell do we lose robo between here and the world messages directly above this?
				robo.laws.show_laws(world)

	if(dronecount)
		to_world(span_filter_system(span_bold("There [dronecount>1 ? "were" : "was"] [dronecount] industrious maintenance [dronecount>1 ? "drones" : "drone"] at the end of this round.")))

	mode.declare_completion()//To declare normal completion.

	//Ask the event manager to print round end information
	SSevents.RoundEnd()

	//Print a list of antagonists to the server log
	var/list/total_antagonists = list()
	//Look into all mobs in world, dead or alive
	for(var/datum/mind/Mind in minds)
		var/temprole = Mind.special_role
		if(temprole)							//if they are an antagonist of some sort.
			if(temprole in total_antagonists)	//If the role exists already, add the name to it
				total_antagonists[temprole] += ", [Mind.name]([Mind.key])"
			else
				total_antagonists.Add(temprole) //If the role doesnt exist in the list, create it and add the mob
				total_antagonists[temprole] += ": [Mind.name]([Mind.key])"

	//Now print them all into the log!
	log_game("Antagonists at round end were...")
	for(var/i in total_antagonists)
		log_game("[i]s[total_antagonists[i]].")

	SSdbcore.SetRoundEnd()

	return 1

/datum/controller/subsystem/ticker/stat_entry(msg)
	switch(current_state)
		if(GAME_STATE_INIT)
			..()
		if(GAME_STATE_PREGAME) // RUNLEVEL_LOBBY
			msg = "START [GLOB.round_progressing ? "[round(pregame_timeleft)]s" : "(PAUSED)"]"
		if(GAME_STATE_SETTING_UP) // RUNLEVEL_SETUP
			msg = "SETUP"
		if(GAME_STATE_PLAYING) // RUNLEVEL_GAME
			msg = "GAME"
		if(GAME_STATE_FINISHED) // RUNLEVEL_POSTGAME
			switch(end_game_state)
				if(END_GAME_MODE_FINISHED)
					msg = "MODE OVER, WAITING"
				if(END_GAME_READY_TO_END)
					msg = "ENDGAME PROCESSING"
				if(END_GAME_ENDING)
					msg = "END IN [round(restart_timeleft/10)]s"
				if(END_GAME_DELAYED)
					msg = "END PAUSED"
				else
					msg = "ENDGAME ERROR:[end_game_state]"
	return ..()
=======
///Whether the game is currently in progress, excluding roundend
/datum/controller/subsystem/ticker/proc/IsRoundInProgress()
	return current_state == GAME_STATE_PLAYING

///Whether the game is currently in progress, excluding roundend
/datum/controller/subsystem/ticker/proc/IsPostgame()
	return current_state == GAME_STATE_FINISHED
>>>>>>> 386c4f6756 ([MIRROR] Unit Test rework & Master/Ticker update (#11372))

/datum/controller/subsystem/ticker/Recover()
	current_state = SSticker.current_state
	force_ending = SSticker.force_ending

	login_music = SSticker.login_music
	round_end_sound = SSticker.round_end_sound

	minds = SSticker.minds

	delay_end = SSticker.delay_end

	tipped = SSticker.tipped
	selected_tip = SSticker.selected_tip

	timeLeft = SSticker.timeLeft

	totalPlayers = SSticker.totalPlayers
	totalPlayersReady = SSticker.totalPlayersReady
	total_admins_ready = SSticker.total_admins_ready

	queue_delay = SSticker.queue_delay
	queued_players = SSticker.queued_players
	round_start_time = SSticker.round_start_time
<<<<<<< HEAD
=======

	queue_delay = SSticker.queue_delay
	queued_players = SSticker.queued_players

	if (Master) //Set Masters run level if it exists
		switch (current_state)
			if(GAME_STATE_SETTING_UP)
				Master.SetRunLevel(RUNLEVEL_SETUP)
			if(GAME_STATE_PLAYING)
				Master.SetRunLevel(RUNLEVEL_GAME)
			if(GAME_STATE_FINISHED)
				Master.SetRunLevel(RUNLEVEL_POSTGAME)

/datum/controller/subsystem/ticker/proc/Reboot(reason, end_string, delay)
	set waitfor = FALSE
	if(usr && !check_rights(R_SERVER, TRUE))
		return

	if(!delay)
		delay = CONFIG_GET(number/round_end_countdown) * 10

	var/skip_delay = check_rights()
	if(delay_end && !skip_delay)
		to_chat(world, span_boldannounce("An admin has delayed the round end."))
		return

	to_chat(world, span_boldannounce("Rebooting World in [DisplayTimeText(delay)]. [reason]"))

	// We dont have those
	//var/statspage = CONFIG_GET(string/roundstatsurl)
	//var/gamelogloc = CONFIG_GET(string/gamelogurl)
	//if(statspage)
	//	to_chat(world, span_info("Round statistics and logs can be viewed <a href=\"[statspage][GLOB.round_id]\">at this website!</a>"))
	//else if(gamelogloc)
	//	to_chat(world, span_info("Round logs can be located <a href=\"[gamelogloc]\">at this website!</a>"))

	var/start_wait = world.time
	UNTIL(round_end_sound_sent || (world.time - start_wait) > (delay * 2)) //don't wait forever
	reboot_timer = addtimer(CALLBACK(src, PROC_REF(reboot_callback), reason, end_string), delay - (world.time - start_wait), TIMER_STOPPABLE)


/datum/controller/subsystem/ticker/proc/reboot_callback(reason, end_string)
	if(end_string)
		end_state = end_string

	log_game(span_boldannounce("Rebooting World. [reason]"))

	world.Reboot()

/**
 * Deletes the current reboot timer and nulls the var
 *
 * Arguments:
 * * user - the user that cancelled the reboot, may be null
 */
/datum/controller/subsystem/ticker/proc/cancel_reboot(mob/user)
	if(!reboot_timer)
		to_chat(user, span_warning("There is no pending reboot!"))
		return FALSE
	to_chat(world, span_boldannounce("An admin has delayed the round end."))
	deltimer(reboot_timer)
	reboot_timer = null
	return TRUE
>>>>>>> 386c4f6756 ([MIRROR] Unit Test rework & Master/Ticker update (#11372))
