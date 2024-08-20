/mob/living/simple_mob/vore/otie/zorgoia //Yes im basing the goias on oties for now, sue me....please dont sue me - Jack
	name = "zorgoia"
	desc = "It's a a reptilian mammal hybrid, known for its voracious nature and love for fruits. By more popular terms its refered to as the furry slinky!"
	tt_desc = "Zorgoyuh slinkus"
	icon = 'modular_chomp/icons/mob/vore64x32_ch.dmi'
	icon_state = "zorgoia"
	icon_living = "zorgoia"
	icon_dead = "zorgoia-dead"
	faction = "zorgoia"
	maxHealth = 100
	health = 100
	melee_damage_lower = 5
	melee_damage_upper = 15 //Don't break my bones bro
	see_in_dark = 5
	attacktext = list("mauled")
	friendly = list("nuzzles", "noses softly at", "noseboops", "headbumps against", "nibbles affectionately on")
	meat_amount = 5

	color = null //color is selected when spawned

	max_buckled_mobs = 0 //No Yeehaw
	can_buckle = FALSE
	buckle_movable = FALSE

	say_list_type = /datum/say_list/zorgoia
	vore_active = 1
	vore_capacity = 3 //These bois can nom a bunch!
	vore_pounce_chance = 35	//More likely to nom
	vore_icons = SA_ICON_LIVING | SA_ICON_REST

	// CHOMPAdd: Don't think its checked, but just in case
	species_sounds = "Canine"
	pain_emote_1p = list("yelp", "whine", "bark", "growl")
	pain_emote_3p = list("yelps", "whines", "barks", "growls")

/mob/living/simple_mob/vore/otie/zorgoia/New()
	..()
	switch(rand(9))
		if(0)
			color = "#1a00ff"
		if(1)
			color = "#6c5bff"
		if(2)
			color = "#ff00fe"
		if(3)
			color = "#ff0000"
		if(4)
			color = "#00d3ff"
		if(5)
			color = "#00ff7c"
		if(6)
			color = "#00ff35"
		if(7)
			color = "#e1ff00"
		if(8)
			color = "#ff9f00"
		if(9)
			color = "#393939"

/mob/living/simple_mob/vore/otie/zorgoia/feral //gets the pet2tame feature. starts out hostile tho so get gamblin'
	name = "agressive zorgoia"
	desc = "It's a a reptilian mammal hybrid, known for its voracious nature and love for fruits. By more popular terms its refered to as the furry slinky! This one seems quite hungry and in a bad mood!"
	faction = "virgo3b"
	tame_chance = 10 // Only a 1 in 10 chance of success. It's feral. What do you expect?
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0

/mob/living/simple_mob/vore/otie/zorgoia/friendly //gets the pet2tame feature and doesn't kill you right away
	name = "friendly zorgoia"
	desc = "It's a a reptilian mammal hybrid, known for its voracious nature and love for fruits. By more popular terms its refered to as the furry slinky! This one seems harmless and friendly!"
	faction = "neutral"
	tamed = 1

<<<<<<< HEAD
/datum/say_list/zorgoia
	speak = list("Prurr.", "Murrr.")
	emote_hear = list("chuffs", "murrs", "churls", "hisses", "lets out a cougar like scream", "yawns")
	emote_see = list("licks their maw", "stretches", "yawns", "noodles")
	say_maybe_target = list("weh?")
	say_got_target = list("Rurrr!", "ROAR!", "RAH!")
=======
	I = image(icon, "[goia_overlays[3]][resting? "-rest" : null]", pixel_x = -16)
	I.color = goia_overlays[goia_overlays[3]]
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	I.plane = MOB_PLANE
	I.layer = MOB_LAYER
	add_overlay(I)
	qdel(I)

	I = image(icon, "[goia_overlays[4]][resting? "-rest" : null]", pixel_x = -16)
	I.color = goia_overlays[goia_overlays[4]]
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	I.plane = MOB_PLANE
	I.layer = MOB_LAYER
	add_overlay(I)
	qdel(I)

	I = image(icon, "[goia_overlays[5]][resting? "-rest" : null]", pixel_x = -16)
	I.color = goia_overlays[goia_overlays[5]]
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	I.plane = MOB_PLANE
	I.layer = MOB_LAYER
	add_overlay(I)
	qdel(I)

	I = image(icon, "[goia_overlays[6]][resting? "-rest" : null]", pixel_x = -16)
	I.color = goia_overlays[goia_overlays[6]]
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	I.plane = MOB_PLANE
	I.layer = MOB_LAYER
	add_overlay(I)
	qdel(I)

	I = image(icon, "[goia_overlays[7]][resting? "-rest" : null]", pixel_x = -16)
	I.color = goia_overlays[goia_overlays[7]]
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	I.plane = MOB_PLANE
	I.layer = MOB_LAYER
	add_overlay(I)
	qdel(I)

	I = image(icon, "[goia_overlays[8]][resting? "-rest" : null]", pixel_x = -16)
	I.color = goia_overlays[goia_overlays[8]]
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	I.plane = MOB_PLANE
	I.layer = MOB_LAYER
	add_overlay(I)
	qdel(I)

	I = image(icon, "[goia_overlays[9]][resting? "-rest" : null]", pixel_x = -16)
	I.color = goia_overlays[goia_overlays[9]]
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	I.plane = PLANE_LIGHTING_ABOVE
	add_overlay(I)
	qdel(I)

	I = image(icon, "[goia_overlays[10]][resting? "-rest" : null]", pixel_x = -16)
	I.color = goia_overlays[goia_overlays[10]]
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	I.plane = MOB_PLANE
	I.layer = MOB_LAYER
	add_overlay(I)
	qdel(I)

	I = image(icon, "[goia_overlays[1]][resting? "-rest" : (vore_fullness? "-[vore_fullness]" : null)]", pixel_x = -16) //todo, check kasscs resting sprite
	I.color = goia_overlays[goia_overlays[1]]
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	I.plane = MOB_PLANE
	I.layer = MOB_LAYER
	add_overlay(I)
	qdel(I)

/mob/living/simple_mob/vore/zorgoia/attack_hand(mob/living/carbon/human/M as mob)
	switch(M.a_intent)
		if(I_HELP)
			if(health > 0)
				if(M.zone_sel.selecting == BP_GROIN)
					if(M.vore_bellyrub(src))
						return
				M.visible_message("<span class='notice'>[M] [response_help] \the [src].</span>")
				if(has_AI())
					var/datum/ai_holder/AI = ai_holder
					AI.set_stance(STANCE_IDLE)
					if(prob(tame_chance))
						AI.violent_breakthrough = FALSE
						AI.hostile = FALSE
						friend = M
						AI.set_follow(friend)
						if(tamed != 1)
							tamed = 1
							faction = M.faction
					sleep(1 SECOND)

		if(I_GRAB)
			if(health > 0)
				if(has_AI())
					var/datum/ai_holder/AI = ai_holder
					audible_emote("growls disapprovingly at [M].")
					if(M == friend)
						AI.lose_follow()
						friend = null
					return
			..()
		else
			..()

/mob/living/simple_mob/vore/zorgoia/Login()
	. = ..()
	if(!riding_datum)
		riding_datum = new /datum/riding/simple_mob(src)
	add_verb(src,/mob/living/simple_mob/proc/animal_mount)
	add_verb(src,/mob/living/proc/toggle_rider_reins)
	movement_cooldown = 0

/mob/living/simple_mob/vore/zorgoia/MouseDrop_T(mob/living/M, mob/living/user)
	return

/mob/living/simple_mob/vore/zorgoia/death() //are they going to be ok?
	. = ..()
	cut_overlays()

/mob/living/simple_mob/vore/zorgoia/tamed
	tamed = TRUE

/datum/ai_holder/simple_mob/melee/evasive/zorgoia

/datum/ai_holder/simple_mob/melee/evasive/zorgoia/New(var/mob/living/simple_mob/vore/zorgoia/new_holder)
	.=..()
	if(new_holder.tamed)
		hostile = FALSE
>>>>>>> 1cdbf715ca (fixes goia grabs (#8806))
