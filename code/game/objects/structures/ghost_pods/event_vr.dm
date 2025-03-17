/obj/structure/ghost_pod/proc/reset_ghostpod()	//Makes the ghost pod usable again and re-adds it to the active ghost pod list if it is not on it.
	active_ghost_pods |= src
	used = FALSE
	busy = FALSE

/obj/structure/ghost_pod/ghost_activated/maintpred
	name = "maintenance hole"
	desc = "Looks like some creature dug its way into station's maintenance..."
	icon = 'icons/effects/effects.dmi'
	icon_state = "tunnel_hole"
	icon_state_opened = "tunnel_hole"
	density = FALSE
	ghost_query_type = /datum/ghost_query/maints_pred
	anchored = TRUE
	invisibility = INVISIBILITY_OBSERVER
	spawn_active = TRUE
	var/announce_prob = 35
	// TORCHRemove - Porting "Join As Mob" verb and changes from Rogue Star. The possible_mobs list has been moved to ghost_simplemob_spawn.dm

/obj/structure/ghost_pod/ghost_activated/maintpred/create_occupant(var/mob/M)
	..()
	var/choice
	var/finalized = "No"
	var/mobtype		//RS EDIT // TORCHEdit - Update ghostpod to deal with updated mob list from RS

	if(jobban_isbanned(M, JOB_GHOSTROLES))
		to_chat(M, span_warning("You cannot inhabit this creature because you are banned from playing ghost roles."))
		reset_ghostpod()
		return

	//No OOC notes
	if (not_has_ooc_text(M))
		return

	while(finalized != "Yes" && M.client)
		choice = tgui_input_list(M, "What type of predator do you want to play as?", "Maintpred Choice", GLOB.ghost_spawnable_mobs)		//RS EDIT //TORCHEdit Start - Porting "Join As Mob" verb and changes from Rogue Star.
		if(choice)		//RS EDIT START
			if(islist(GLOB.ghost_spawnable_mobs[choice]))	//Allow for nested list for organization reasons
				var/list/ourlist = GLOB.ghost_spawnable_mobs[choice]
				var/newchoice = tgui_input_list(M, "Which one?", "[choice]", ourlist)
				if(!newchoice)
					to_chat(M, span_notice("No mob selected, cancelling."))
					reset_ghostpod()
					return
				choice = newchoice
				mobtype = ourlist[newchoice]
			else
				mobtype = GLOB.ghost_spawnable_mobs[choice]	//RS EDIT END // //TORCHEdit end

			finalized = tgui_alert(M, "Are you sure you want to play as [choice]?","Confirmation",list("No","Yes"))

	if(!choice)	//If somehow we ended up here and we don't have a choice, let's just reset things!
		reset_ghostpod()
		return

	var/mob/living/simple_mob/newPred = new mobtype(get_turf(src))
	qdel(newPred.ai_holder)
	newPred.ai_holder = null
	newPred.voremob_loaded = TRUE //CHOMPedit: On-demand belly loading.
	newPred.init_vore() //CHOMPedit: On-demand belly loading.
	//newPred.movement_cooldown = 0			// The "needless artificial speed cap" exists for a reason
	if(M.mind)
		M.mind.transfer_to(newPred)
	to_chat(M, span_notice("You are <b>[newPred]</b>, somehow having gotten aboard the station in search of food. \
	You are wary of environment around you, but you do feel rather peckish. Stick around dark, secluded places to avoid danger or, \
	if you are cute enough, try to make friends with this place's inhabitants."))
	to_chat(M, span_critical("Please be advised, this role is NOT AN ANTAGONIST."))
	to_chat(M, span_warning("You may be a spooky space monster, but your role is to facilitate spooky space monster roleplay, not to fight the station and kill people. You can of course eat and/or digest people as you like if OOC prefs align, but this should be done as part of roleplay. If you intend to fight the station and kill people and such, you need permission from the staff team. GENERALLY, this role should avoid well populated areas. You’re a weird spooky space monster, so the bar is probably not where you’d want to go if you intend to survive. Of course, you’re welcome to try to make friends and roleplay how you will in this regard, but something to keep in mind."))
	newPred.ckey = M.ckey
	newPred.visible_message(span_warning("[newPred] emerges from somewhere!"))
	log_and_message_admins("successfully entered \a [src] and became a [newPred].")
	newPred.mob_radio = new /obj/item/radio/headset/mob_headset(newPred)		//RS ADD // TORCHEdit Start - Porting "Join As Mob" verb and changes from Rogue Star.
	newPred.mob_radio.frequency = PUB_FREQ		//RS ADD
	newPred.sight |= SEE_SELF		//RS ADD
	newPred.sight |= SEE_MOBS		//RS ADD // TORCHEdit end

	qdel(src)

/obj/structure/ghost_pod/ghost_activated/maintpred/no_announce
	announce_prob = 0

/obj/structure/ghost_pod/ghost_activated/morphspawn
	name = "weird goo"
	desc = "A pile of weird gunk... Wait, is it actually moving?"
	icon = 'icons/mob/animal_vr.dmi'
	icon_state = "morph"
	icon_state_opened = "morph_dead"
	density = FALSE
	ghost_query_type = /datum/ghost_query/morph
	anchored = TRUE
	invisibility = INVISIBILITY_OBSERVER
	spawn_active = TRUE
	var/announce_prob = 50

/obj/structure/ghost_pod/ghost_activated/morphspawn/create_occupant(var/mob/M)
	..()

	//No OOC notes
	if (not_has_ooc_text(M))
		return

	var/mob/living/simple_mob/vore/morph/newMorph = new /mob/living/simple_mob/vore/morph(get_turf(src))
	newMorph.voremob_loaded = TRUE //CHOMPedit: On-demand belly loading.
	newMorph.init_vore() //CHOMPedit: On-demand belly loading.
	if(M.mind)
		M.mind.transfer_to(newMorph)
	to_chat(M, span_notice("You are a <b>Morph</b>, somehow having gotten aboard the station in your wandering. \
	You are wary of environment around you, but your primal hunger still calls for you to find prey. Seek a convincing disguise, \
	using your amorphous form to traverse vents to find and consume weak prey."))
	to_chat(M, span_notice("You can use shift + click on objects to disguise yourself as them, but your strikes are nearly useless when you are disguised. \
	You can undisguise yourself by shift + clicking yourself, but disguise being switched, or turned on and off has a short cooldown. You can also ventcrawl, \
	by using alt + click on the vent or scrubber."))
	to_chat(M, span_critical("Please be advised, this role is NOT AN ANTAGONIST."))
	to_chat(M, span_warning("You may be a spooky space monster, but your role is to facilitate spooky space monster roleplay, not to fight the station and kill people. You can of course eat and/or digest people as you like if OOC prefs align, but this should be done as part of roleplay. If you intend to fight the station and kill people and such, you need permission from the staff team. GENERALLY, this role should avoid well populated areas. You’re a weird spooky space monster, so the bar is probably not where you’d want to go if you intend to survive. Of course, you’re welcome to try to make friends and roleplay how you will in this regard, but something to keep in mind."))

	newMorph.ckey = M.ckey
	newMorph.visible_message(span_warning("A morph appears to crawl out of somewhere."))
	log_and_message_admins("successfully entered \a [src] and became a Morph.")
	qdel(src)

/obj/structure/ghost_pod/ghost_activated/morphspawn/no_announce
	announce_prob = 0

/obj/structure/ghost_pod/ghost_activated/maintpred/redgate //For ghostpods placed in the redgate that aren't spawned via an event
	name = "creature hole"
	desc = "Looks like some creature dug is hiding in the redgate..."
	announce_prob = 0
	icon_state = "redgate_hole"
	icon_state_opened = "redgate_hole"

/obj/structure/ghost_pod/ghost_activated/maintpred/redgate/Initialize()
	..()
	if(!(src in active_ghost_pods))
		active_ghost_pods += src
