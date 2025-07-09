/datum/species/shadekin
	name = SPECIES_SHADEKIN
	name_plural = "Shadekin"
	icobase = 'icons/mob/human_races/r_shadekin_vr.dmi'
	deform = 'icons/mob/human_races/r_shadekin_vr.dmi'
	tail = "tail"
	icobase_tail = 1
	blurb = "Very little is known about these creatures. They appear to be largely mammalian in appearance. \
	Seemingly very rare to encounter, there have been widespread myths of these creatures the galaxy over, \
	but next to no verifiable evidence to their existence. However, they have recently been more verifiably \
	documented in the Virgo system, following a mining bombardment of Virgo 3. The crew of NSB Adephagia have \
	taken to calling these creatures 'Shadekin', and the name has generally stuck and spread. "		//TODO: Something that's not wiki copypaste
	wikilink = "https://wiki.vore-station.net/Shadekin"
	catalogue_data = list(/datum/category_item/catalogue/fauna/shadekin)

	language = LANGUAGE_SHADEKIN
	name_language = LANGUAGE_SHADEKIN
	species_language = LANGUAGE_SHADEKIN
	secondary_langs = list(LANGUAGE_SHADEKIN)
	num_alternate_languages = 3
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws/shadekin, /datum/unarmed_attack/bite/sharp/shadekin)
	rarity_value = 15	//INTERDIMENSIONAL FLUFFERS

	inherent_verbs = list(/mob/proc/adjust_hive_range)

	siemens_coefficient = 1
	darksight = 10

	slowdown = -0.5
	item_slowdown_mod = 0.5

	brute_mod = 0.7	// Naturally sturdy.
	burn_mod = 1.2	// Furry

	warning_low_pressure = 50
	hazard_low_pressure = -1

	warning_high_pressure = 300
	hazard_high_pressure = INFINITY

	cold_level_1 = -1	//Immune to cold
	cold_level_2 = -1
	cold_level_3 = -1

	heat_level_1 = 850	//Resistant to heat
	heat_level_2 = 1000
	heat_level_3 = 1150

	flags =  NO_DNA | NO_SLEEVE | NO_MINOR_CUT | NO_INFECT
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_WHITELIST_SELECTABLE

	reagent_tag = IS_SHADEKIN		// for shadekin-unqiue chem interactions

	flesh_color = "#FFC896"
	blood_color = "#A10808"
	base_color = "#f0f0f0"
	color_mult = 1

	// has_glowing_eyes = TRUE			//Applicable through neutral taits.

	death_message = "phases to somewhere far away!"
	speech_bubble_appearance = "ghost"

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	virus_immune = 1

	breath_type = null
	poison_type = null
	water_breather = TRUE	//They don't quite breathe

	vision_flags = SEE_SELF|SEE_MOBS
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_SKIN_COLOR | HAS_EYE_COLOR | HAS_UNDERWEAR

	move_trail = /obj/effect/decal/cleanable/blood/tracks/paw

	has_organ = list(
		O_HEART =		/obj/item/organ/internal/heart,
		O_VOICE = 		/obj/item/organ/internal/voicebox,
		O_LIVER =		/obj/item/organ/internal/liver,
		O_KIDNEYS =		/obj/item/organ/internal/kidneys,
		O_BRAIN =		/obj/item/organ/internal/brain/shadekin,
		O_EYES =		/obj/item/organ/internal/eyes,
		O_STOMACH =		/obj/item/organ/internal/stomach,
		O_INTESTINE =	/obj/item/organ/internal/intestine
		)

	has_limbs = list(
		BP_TORSO =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/shadekin),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right)
		)

	species_component = /datum/component/shadekin/full //CHOMPEdit: Enabling full shadekin.
	component_requires_late_recalc = TRUE

/datum/species/shadekin/handle_death(var/mob/living/carbon/human/H)
	var/special_handling = TRUE //varswitch for downstream //CHOMPEdit - Enable.
	H.clear_dark_maws() //clear dark maws on death or similar
	if(!special_handling)
		spawn(1)
			for(var/obj/item/W in H)
				H.drop_from_inventory(W)
			qdel(H)
	else
		var/datum/component/shadekin/SK = H.get_shadekin_component()
		if(!SK)
			return
		if(SK.respite_activating)
			return TRUE
		var/area/current_area = get_area(H)
		if((SK.in_dark_respite) || H.has_modifier_of_type(/datum/modifier/dark_respite) || current_area.flag_check(AREA_LIMIT_DARK_RESPITE))
			return
		if(!LAZYLEN(GLOB.latejoin_thedark))
			log_and_message_admins("[H] died outside of the dark but there were no valid floors to warp to")
			return

		H.visible_message("<b>\The [H.name]</b> phases to somewhere far away!")
		var/obj/effect/temp_visual/shadekin/phase_out/phaseanimout = new /obj/effect/temp_visual/shadekin/phase_out(H.loc)
		phaseanimout.dir = H.dir
		SK.respite_activating = TRUE

		H.drop_l_hand()
		H.drop_r_hand()

		SK.shadekin_set_energy(0)
		SK.in_dark_respite = TRUE
		H.invisibility = INVISIBILITY_SHADEKIN

		H.adjustFireLoss(-(H.getFireLoss() * 0.75))
		H.adjustBruteLoss(-(H.getBruteLoss() * 0.75))
		H.adjustToxLoss(-(H.getToxLoss() * 0.75))
		H.adjustCloneLoss(-(H.getCloneLoss() * 0.75))
		H.germ_level = 0 //Take away the germs, or we'll die AGAIN
		H.vessel.add_reagent(REAGENT_ID_BLOOD,blood_volume-H.vessel.total_volume)
		for(var/obj/item/organ/external/bp in H.organs)
			bp.bandage()
			bp.disinfect()
		for(var/obj/item/organ/internal/I in H.internal_organs) //other wise their organs stay mush
			I.damage = 0
			I.status = 0
			if(I.organ_tag == O_EYES)
				H.sdisabilities &= ~BLIND
			if(I.organ_tag == O_LUNGS)
				H.SetLosebreath(0)
		H.nutrition = 0
		H.invisibility = INVISIBILITY_SHADEKIN
		BITRESET(H.hud_updateflag, HEALTH_HUD)
		BITRESET(H.hud_updateflag, STATUS_HUD)
		BITRESET(H.hud_updateflag, LIFE_HUD)

		if(istype(H.loc, /obj/belly))
			//Yay digestion... presumably...
			var/obj/belly/belly = H.loc
			add_attack_logs(belly.owner, H, "Digested in [lowertext(belly.name)]")
			to_chat(belly.owner, span_notice("\The [H.name] suddenly vanishes within your [belly.name]"))
			H.forceMove(pick(GLOB.latejoin_thedark))
			if(SK.in_phase)
				H.phase_shift()
			else
				var/obj/effect/temp_visual/shadekin/phase_in/phaseanim = new /obj/effect/temp_visual/shadekin/phase_in(H.loc)
				phaseanim.dir = H.dir
			H.invisibility = initial(H.invisibility)
			SK.respite_activating = FALSE
			belly.owner.handle_belly_update()
			H.clear_fullscreen("belly")
			if(H.hud_used)
				if(!H.hud_used.hud_shown)
					H.toggle_hud_vis()
			H.stop_sound_channel(CHANNEL_PREYLOOP)
			H.add_modifier(/datum/modifier/dark_respite, 10 MINUTES)
			H.muffled = FALSE
			H.forced_psay = FALSE


			addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living, can_leave_dark)), 5 MINUTES, TIMER_DELETE_ME)
		else
			H.add_modifier(/datum/modifier/dark_respite, 25 MINUTES)

			addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living, enter_the_dark)), 1 SECOND, TIMER_DELETE_ME)

			addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living, can_leave_dark)), 15 MINUTES, TIMER_DELETE_ME)

		return TRUE


/mob/living/proc/enter_the_dark()
	var/datum/component/shadekin/SK = get_shadekin_component()
	if(!SK)
		return
	SK.respite_activating = FALSE
	SK.in_dark_respite = TRUE

	forceMove(pick(GLOB.latejoin_thedark))
	invisibility = initial(invisibility)
	SK.respite_activating = FALSE

/mob/living/proc/can_leave_dark()
	var/datum/component/shadekin/SK = get_shadekin_component()
	if(!SK)
		return
	SK.in_dark_respite = FALSE
	to_chat(src, span_notice("You feel like you can leave the Dark again"))

/datum/species/shadekin/get_bodytype()
	return SPECIES_SHADEKIN

/datum/species/shadekin/get_random_name()
	return "shadekin"

<<<<<<< HEAD
/datum/species/shadekin/handle_environment_special(var/mob/living/carbon/human/H)
	handle_shade(H)

/datum/species/shadekin/add_inherent_verbs(var/mob/living/carbon/human/H)
	..()
	add_shadekin_abilities(H)

/datum/species/shadekin/proc/add_shadekin_abilities(var/mob/living/carbon/human/H)
	if(!H.ability_master || !istype(H.ability_master, /obj/screen/movable/ability_master/shadekin))
		H.ability_master = null
		H.ability_master = new /obj/screen/movable/ability_master/shadekin(H)
	for(var/datum/power/shadekin/P in shadekin_ability_datums)
		if(!(P.verbpath in H.verbs))
			add_verb(H, P.verbpath)
			H.ability_master.add_shadekin_ability(
					object_given = H,
					verb_given = P.verbpath,
					name_given = P.name,
					ability_icon_given = P.ability_icon_state,
					arguments = list()
					)
	add_verb(H,/mob/living/carbon/human/proc/phase_strength_toggle ) //CHOMPEdit - Add gentle phasing //CHOMPEdit
	add_verb(H,/mob/living/carbon/human/proc/nutrition_conversion_toggle ) //CHOMPEdit - Add nutrition conversion toggle //CHOMPEdit
	add_verb(H,/mob/living/carbon/human/proc/clear_dark_maws ) //CHOMPEdit - Add Dark maw clearing //CHOMPEdit

/datum/species/shadekin/proc/handle_shade(var/mob/living/carbon/human/H)
	//CHOMPEdit begin - No energy during dark respite
	if(H.has_modifier_of_type(/datum/modifier/dark_respite))
		set_energy(H, 0)
		update_shadekin_hud(H)
		return
	//CHOMPEdit End

	//Shifted kin don't gain/lose energy (and save time if we're at the cap)
	var/darkness = 1
	var/dark_gains = 0

	var/turf/T = get_turf(H)
	if(!T)
		dark_gains = 0
		return

	var/brightness = T.get_lumcount() //Brightness in 0.0 to 1.0
	//CHOMPEdit begin - dark in bellies
	if(isbelly(H.loc))
		brightness = 0
	//CHOMPEdit end
	darkness = 1-brightness //Invert
	var/is_dark = (darkness >= 0.5) || istype(get_area(H), /area/shadekin) //CHOMPEdit - Dark provides health

	if(H.ability_flags & AB_PHASE_SHIFTED)
		dark_gains = 0
	else
		//Heal (very) slowly in good darkness
		if(is_dark)
			H.adjustFireLoss((-0.10)*darkness)
			H.adjustBruteLoss((-0.10)*darkness)
			H.adjustToxLoss((-0.10)*darkness)
			//energy_dark and energy_light are set by the shadekin eye traits.
			//These are balanced around their playstyles and 2 planned new aggressive abilities
			dark_gains = energy_dark
		else
			dark_gains = energy_light
		//CHOMPEdit begin - Energy <-> nutrition conversion
		if(nutrition_energy_conversion && get_energy(H) == 100 && dark_gains > 0)
			H.nutrition += dark_gains * 5 * nutrition_conversion_scaling
		else if(nutrition_energy_conversion && get_energy(H) < 50 && H.nutrition > 500)
			H.nutrition -= nutrition_conversion_scaling * 50
			dark_gains += nutrition_conversion_scaling
		//CHOMPEdit end

	set_energy(H, get_energy(H) + dark_gains)

	//Update huds
	update_shadekin_hud(H)

/datum/species/shadekin/proc/get_energy(var/mob/living/carbon/human/H)
	var/datum/component/shadekin/comp = H.GetComponent(/datum/component/shadekin)
	if(!comp)
		return FALSE //No component, no energy to be had.
	//CHOMPEdit - Dark Respite
	if(H.ability_flags & AB_DARK_RESPITE || H.has_modifier_of_type(/datum/modifier/dark_respite))
		return FALSE
	//CHOMPEdit - Dark Respite
	if(comp.dark_energy_infinite)
		return comp.max_dark_energy

	return comp.dark_energy

/datum/species/shadekin/proc/get_max_energy(var/mob/living/carbon/human/H)
	var/datum/component/shadekin/comp = H.GetComponent(/datum/component/shadekin)
	if(!comp)
		return FALSE //No component, no energy to be had.
	return comp.max_dark_energy

/datum/species/shadekin/proc/set_energy(var/mob/living/carbon/human/H, var/new_energy)
	var/datum/component/shadekin/comp = H.GetComponent(/datum/component/shadekin)
	if(!comp)
		return FALSE //No component, no energy to be had.

	comp.dark_energy = CLAMP(new_energy, 0, get_max_energy(H))

/datum/species/shadekin/proc/set_max_energy(var/mob/living/carbon/human/H, var/new_max_energy)
	var/datum/component/shadekin/comp = H.GetComponent(/datum/component/shadekin)
	if(!comp)
		return FALSE //No component, no energy to be had.

	comp.max_dark_energy = new_max_energy

/datum/species/shadekin/proc/update_shadekin_hud(var/mob/living/carbon/human/H)
	var/turf/T = get_turf(H)
	if(H.shadekin_display)
		var/l_icon = 0
		var/e_icon = 0

		H.shadekin_display.invisibility = INVISIBILITY_NONE
		if(T)
			var/brightness = T.get_lumcount() //Brightness in 0.0 to 1.0
			var/darkness = 1-brightness //Invert
			switch(darkness)
				if(0.80 to 1.00)
					l_icon = 0
				if(0.60 to 0.80)
					l_icon = 1
				if(0.40 to 0.60)
					l_icon = 2
				if(0.20 to 0.40)
					l_icon = 3
				if(0.00 to 0.20)
					l_icon = 4

		switch(get_energy(H))
			if(0 to 24)
				e_icon = 0
			if(25 to 49)
				e_icon = 1
			if(50 to 74)
				e_icon = 2
			if(75 to 99)
				e_icon = 3
			if(100 to INFINITY)
				e_icon = 4

		H.shadekin_display.icon_state = "shadekin-[l_icon]-[e_icon]"
	return

/datum/species/shadekin/proc/get_shadekin_eyecolor(var/mob/living/carbon/human/H)
	var/eyecolor_rgb = rgb(H.r_eyes, H.g_eyes, H.b_eyes)

	var/eyecolor_hue = rgb2num(eyecolor_rgb, COLORSPACE_HSV)[1]
	var/eyecolor_sat = rgb2num(eyecolor_rgb, COLORSPACE_HSV)[2]
	var/eyecolor_val = rgb2num(eyecolor_rgb, COLORSPACE_HSV)[3]

	//First, clamp the saturation/value to prevent black/grey/white eyes
	if(eyecolor_sat < 10)
		eyecolor_sat = 10
	if(eyecolor_val < 40)
		eyecolor_val = 40

	eyecolor_rgb = rgb(eyecolor_hue, eyecolor_sat, eyecolor_val, space=COLORSPACE_HSV)

	H.r_eyes = rgb2num(eyecolor_rgb)[1]
	H.g_eyes = rgb2num(eyecolor_rgb)[2]
	H.b_eyes = rgb2num(eyecolor_rgb)[3]

	//Now determine what color we fall into.
	var/eyecolor_type = BLUE_EYES
	switch(eyecolor_hue)
		if(0 to 20)
			eyecolor_type = RED_EYES
		if(21 to 50)
			eyecolor_type = ORANGE_EYES
		if(51 to 70)
			eyecolor_type = YELLOW_EYES
		if(71 to 160)
			eyecolor_type = GREEN_EYES
		if(161 to 260)
			eyecolor_type = BLUE_EYES
		if(261 to 340)
			eyecolor_type = PURPLE_EYES
		if(341 to 360)
			eyecolor_type = RED_EYES

	return eyecolor_type

=======
>>>>>>> 3e095bf5db ([MIRROR] Completes the /datum/component/shadekin work (#11148))
/datum/species/shadekin/post_spawn_special(var/mob/living/carbon/human/H)
	.=..()

	var/datum/component/shadekin/SK = H.get_shadekin_component()
	if(!SK)
		CRASH("A shadekin [H] somehow is missing their shadekin component post-spawn!")

	switch(SK.eye_color)
		if(BLUE_EYES)
			total_health = 75 //CHOMPEdit
		if(RED_EYES)
			total_health = 150 //CHOMPEdit
		if(PURPLE_EYES)
			total_health = 150
		if(YELLOW_EYES)
			total_health = 50 //CHOMPEdit
		if(GREEN_EYES)
			total_health = 100
		if(ORANGE_EYES)
			total_health = 125 //CHOMPEdit

	H.maxHealth = total_health

	H.health = H.getMaxHealth()

/datum/species/shadekin/produceCopy(var/list/traits, var/mob/living/carbon/human/H, var/custom_base, var/reset_dna = TRUE) // Traitgenes reset_dna flag required, or genes get reset on resleeve
	var/datum/species/shadekin/new_copy = ..()
	new_copy.total_health = total_health

	return new_copy
