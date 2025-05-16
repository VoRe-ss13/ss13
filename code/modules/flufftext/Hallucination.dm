/*
Ideas for the subtle effects of hallucination:

Light up oxygen/phoron indicators (done)
Cause health to look critical/dead, even when standing (done)
Characters silently watching you
Brief flashes of fire/space/bombs/c4/dangerous shit (done)
Items that are rare/traitorous/don't exist appearing in your inventory slots (done)
Strange audio (should be rare) (done)
Gunshots/explosions/opening doors/less rare audio (done)
*/

/datum/component/hallucinations
	dupe_mode = COMPONENT_DUPE_UNIQUE // First come first serve

	VAR_PRIVATE/mob/living/carbon/human/our_human = null
	VAR_PRIVATE/datum/weakref/halimage
	VAR_PRIVATE/datum/weakref/halbody
	VAR_PRIVATE/list/halitem = list() // weakref pair of obj-key, client-value

	VAR_PRIVATE/hal_crit = FALSE
	VAR_PRIVATE/hal_screwyhud = HUD_HALLUCINATION_NONE

/datum/component/hallucinations/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	our_human = parent
	make_timer()

<<<<<<< HEAD
						if(client) client.images += halimage
						spawn(rand(10,50)) //Only seen for a brief moment.
							if(client) client.images -= halimage
							halimage = null


			if(41 to 65)
				//Strange audio
				//to_chat(src, "Strange Audio")
				switch(rand(1,12))
					if(1) src << 'sound/machines/door/old_airlock.ogg'
					if(2)
						if(prob(50))src << 'sound/effects/Explosion1.ogg'
						else src << 'sound/effects/Explosion2.ogg'
					if(3) src << 'sound/effects/explosionfar.ogg'
					if(4) src << 'sound/effects/Glassbr1.ogg'
					if(5) src << 'sound/effects/Glassbr2.ogg'
					if(6) src << 'sound/effects/Glassbr3.ogg'
					if(7) src << 'sound/machines/twobeep.ogg'
					if(8) src << 'sound/machines/door/windowdoor.ogg'
					if(9)
						//To make it more realistic, I added two gunshots (enough to kill)
						src << 'sound/weapons/Gunshot1.ogg'
						spawn(rand(10,30))
							src << 'sound/weapons/Gunshot2.ogg'
					if(10) src << 'sound/weapons/smash.ogg'
					if(11)
						//Same as above, but with tasers.
						src << 'sound/weapons/Taser.ogg'
						spawn(rand(10,30))
							src << 'sound/weapons/Taser.ogg'
				//Rare audio
					if(12)
//These sounds are (mostly) taken from Hidden: Source
						var/list/creepyasssounds = list('sound/effects/ghost.ogg', 'sound/effects/ghost2.ogg', 'sound/effects/Heart Beat.ogg', 'sound/effects/screech.ogg',\
							'sound/hallucinations/behind_you1.ogg', 'sound/hallucinations/behind_you2.ogg', 'sound/hallucinations/far_noise.ogg', 'sound/hallucinations/growl1.ogg', 'sound/hallucinations/growl2.ogg',\
							'sound/hallucinations/growl3.ogg', 'sound/hallucinations/im_here1.ogg', 'sound/hallucinations/im_here2.ogg', 'sound/hallucinations/i_see_you1.ogg', 'sound/hallucinations/i_see_you2.ogg',\
							'sound/hallucinations/look_up1.ogg', 'sound/hallucinations/look_up2.ogg', 'sound/hallucinations/over_here1.ogg', 'sound/hallucinations/over_here2.ogg', 'sound/hallucinations/over_here3.ogg',\
							'sound/hallucinations/turn_around1.ogg', 'sound/hallucinations/turn_around2.ogg', 'sound/hallucinations/veryfar_noise.ogg', 'sound/hallucinations/wail.ogg')
						src << pick(creepyasssounds)
			if(66 to 70)
				//Flashes of danger
				//to_chat(src, "Danger Flash")
				if(!halbody)
					var/list/possible_points = list()
					for(var/turf/simulated/floor/F in view(src,world.view))
						possible_points += F
					if(possible_points.len)
						var/turf/simulated/floor/target = pick(possible_points)
						switch(rand(1,4))
							if(1)
								halbody = image('icons/mob/human.dmi',target,"husk_l",TURF_LAYER)
							if(2,3)
								halbody = image('icons/mob/human.dmi',target,"husk_s",TURF_LAYER)
							if(4)
								halbody = image('icons/mob/alien.dmi',target,"alienother",TURF_LAYER)
	//						if(5)
	//							halbody = image('xcomalien.dmi',target,"chryssalid",TURF_LAYER)

						if(client) client.images += halbody
						spawn(rand(50,80)) //Only seen for a brief moment.
							if(client) client.images -= halbody
							halbody = null
			if(71 to 72)
				//Fake death
//				src.sleeping_willingly = 1
				SetSleeping(20)
				hal_crit = 1
				hal_screwyhud = 1
				spawn(rand(50,100))
//					src.sleeping_willingly = 0
					SetSleeping(0)
					hal_crit = 0
					hal_screwyhud = 0
	handling_hal = 0




/*obj/machinery/proc/mockpanel(list/buttons,start_txt,end_txt,list/mid_txts)

	if(!mocktxt)

		mocktxt = ""

		var/possible_txt = list("Launch Escape Pods","Self-Destruct Sequence","\[Swipe ID\]","De-Monkify",\
		"Reticulate Splines","Plasma","Open Valve","Lockdown","Nerf Airflow","Kill Traitor","Nihilism",\
		"OBJECTION!","Arrest Stephen Bowman","Engage Anti-Trenna Defenses","Increase Site Manager IQ","Retrieve Arms",\
		"Play Charades","Oxygen","Inject BeAcOs","Ninja Lizards","Limit Break","Build Sentry")

		if(mid_txts)
			while(mid_txts.len)
				var/mid_txt = pick(mid_txts)
				mocktxt += mid_txt
				mid_txts -= mid_txt

		while(buttons.len)

			var/button = pick(buttons)

			var/button_txt = pick(possible_txt)

			mocktxt += "<a href='byond://?src=\ref[src];[button]'>[button_txt]</a><br>"

			buttons -= button
			possible_txt -= button_txt

	return start_txt + mocktxt + end_txt + "</TT></BODY></HTML>"

/proc/check_panel(mob/M)
	if (ishuman(M) || isAI(M))
		if(M.hallucination < 15)
			return 1
	return 0*/

/* //ChompREMOVE fake_attacker - EXTREME image qdel usage. Look at the attack_loop and updateimage procs and weep.
/obj/effect/fake_attacker
	icon = null
	icon_state = null
	name = ""
	desc = ""
	density = FALSE
	anchored = TRUE
	opacity = 0
	var/mob/living/carbon/human/my_target = null
	var/weapon_name = null
	var/obj/item/weap = null
	var/image/stand_icon = null
	var/image/currentimage = null
	var/icon/base = null
	var/s_tone
	var/mob/living/clone = null
	var/image/left
	var/image/right
	var/image/up
	var/collapse
	var/image/down

	var/health = 100

/obj/effect/fake_attacker/attackby(var/obj/item/P as obj, mob/user as mob)
	step_away(src,my_target,2)
	for(var/mob/M in oviewers(world.view,my_target))
		to_chat(M, span_bolddanger("[my_target] flails around wildly."))
	my_target.show_message(span_bolddanger("[src] has been attacked by [my_target] "), 1) //Lazy.

	src.health -= P.force


	return

/obj/effect/fake_attacker/Crossed(var/mob/M, somenumber)
	if(M == my_target)
		step_away(src,my_target,2)
		if(prob(30))
			for(var/mob/O in oviewers(world.view , my_target))
				to_chat(O, span_bolddanger("[my_target] stumbles around."))

/obj/effect/fake_attacker/New()
	..()
	QDEL_IN(src, 30 SECONDS)
	step_away(src,my_target,2)
	spawn attack_loop()
=======
/datum/component/hallucinations/Destroy(force)
	if(halitem.len)
		remove_hallucination_item()
	our_human = null
	. = ..()
>>>>>>> 2f4ae557ee ([MIRROR] Hallucination Refactor (#10879))

/datum/component/hallucinations/proc/make_timer()
	PROTECTED_PROC(TRUE)
	addtimer(CALLBACK(src, PROC_REF(trigger)), ((rand(20,50) SECONDS) / (min(our_human.hallucination,100)/25)), TIMER_DELETE_ME)

/datum/component/hallucinations/proc/get_fakecrit()
	SHOULD_NOT_OVERRIDE(TRUE)
	return hal_crit

/datum/component/hallucinations/proc/get_hud_state()
	SHOULD_NOT_OVERRIDE(TRUE)
	return hal_screwyhud

<<<<<<< HEAD

	if(src.dir == NORTH)
		qdel(src.currentimage)
		src.currentimage = new /image(up,src)
	else if(src.dir == SOUTH)
		qdel(src.currentimage)
		src.currentimage = new /image(down,src)
	else if(src.dir == EAST)
		qdel(src.currentimage)
		src.currentimage = new /image(right,src)
	else if(src.dir == WEST)
		qdel(src.currentimage)
		src.currentimage = new /image(left,src)
	my_target << currentimage


/obj/effect/fake_attacker/proc/attack_loop()
	while(1)
		sleep(rand(5,10))
		if(src.health < 0)
			collapse()
			continue
		if(get_dist(src,my_target) > 1)
			src.set_dir(get_dir(src,my_target))
			step_towards(src,my_target)
			updateimage()
		else
			if(prob(15))
				if(weapon_name)
					my_target << sound(pick('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit3.ogg'))
					my_target.show_message(span_bolddanger("[my_target] has been attacked with [weapon_name] by [src.name]!"), 1)
					my_target.halloss += 8
					if(prob(20)) my_target.eye_blurry += 3
					if(prob(33))
						if(!locate(/obj/effect/overlay) in my_target.loc)
							fake_blood(my_target)
				else
					my_target << sound(pick('sound/weapons/punch1.ogg','sound/weapons/punch2.ogg','sound/weapons/punch3.ogg','sound/weapons/punch4.ogg'))
					my_target.show_message(span_bolddanger("[src.name] has punched [my_target]!"), 1)
					my_target.halloss += 4
					if(prob(33))
						if(!locate(/obj/effect/overlay) in my_target.loc)
							fake_blood(my_target)

		if(prob(15))
			step_away(src,my_target,2)

/obj/effect/fake_attacker/proc/collapse()
	collapse = 1
	updateimage()

/proc/fake_blood(var/mob/target)
	var/obj/effect/overlay/O = new/obj/effect/overlay(target.loc)
	O.name = "blood"
	var/image/I = image('icons/effects/blood.dmi',O,"floor[rand(1,7)]",O.dir,1)
	target << I
	spawn(300)
		qdel(O)
	return

var/list/non_fakeattack_weapons = list(/obj/item/gun/projectile, /obj/item/ammo_magazine/s357,\
	/obj/item/gun/energy/crossbow, /obj/item/melee/energy/sword,\
	/obj/item/storage/box/syndicate, /obj/item/storage/box/emps,\
	/obj/item/cartridge/syndicate, /obj/item/clothing/under/chameleon,\
	/obj/item/clothing/shoes/syndigaloshes, /obj/item/card/id/syndicate,\
	/obj/item/clothing/mask/gas/voice, /obj/item/clothing/glasses/thermal,\
	/obj/item/chameleon, /obj/item/card/emag,\
	/obj/item/storage/toolbox/syndicate, /obj/item/aiModule,\
	/obj/item/radio/headset/syndicate,	/obj/item/plastique,\
	/obj/item/powersink, /obj/item/storage/box/syndie_kit,\
	/obj/item/toy/syndicateballoon, /obj/item/gun/energy/captain,\
	/obj/item/hand_tele, /obj/item/rcd, /obj/item/tank/jetpack,\
	/obj/item/clothing/under/rank/captain, /obj/item/aicard,\
	/obj/item/clothing/shoes/magboots, /obj/item/areaeditor/blueprints, /obj/item/disk/nuclear,\
	/obj/item/clothing/suit/space/void, /obj/item/tank)

/proc/fake_attack(var/mob/living/target)
	var/list/possible_clones = new/list()
	var/mob/living/carbon/human/clone = null
	var/clone_weapon = null

	for(var/mob/living/carbon/human/H in living_mob_list)
		if(H.stat || H.lying)
			continue
		possible_clones += H
//		clone = H
//		break	//changed the code a bit. Less randomised, but less work to do. Should be ok, world.contents aren't stored in any particular order.

	if(!possible_clones.len)
=======
/////////////////////////////////////////////////////////////////////////////////////////////////////
// Traditional hallucinations
/////////////////////////////////////////////////////////////////////////////////////////////////////
/mob/living/carbon/proc/handle_hallucinations()
	if(get_hallucination_component() || !client)
		return
	LoadComponent(/datum/component/hallucinations)

/mob/living/carbon/proc/get_hallucination_component()
	RETURN_TYPE(/datum/component/hallucinations)
	return GetComponent(/datum/component/hallucinations)

/datum/component/hallucinations/proc/trigger()
	PROTECTED_PROC(TRUE)
	if(QDELETED(our_human))
		qdel(src)
		return
	if(!our_human.client)
		qdel(src)
		return
	if(our_human.hallucination < HALLUCINATION_THRESHOLD)
		qdel(src)
		return
	handle_hallucinating()
	make_timer()

/datum/component/hallucinations/proc/handle_hallucinating()
	PROTECTED_PROC(TRUE)
	var/halpick = rand(1,100)
	switch(halpick)
		if(0 to 15)
			event_hudscrew()
		if(16 to 25)
			event_fake_item()
		if(26 to 40)
			event_flash_environmental_threats()
		if(41 to 65)
			event_strange_sound()
		if(66 to 70)
			if(prob(20) && our_human.nutrition < 100)
				event_hunger() // Hungi, meant for xenochi but this is too funny to pass up
			else
				event_flash_monsters()
		if(71 to 72)
			event_sleeping()
		if(73 to 75) // If you don't want hallucination beatdowns, comment this out
			event_attacker()
		if(76 to 80)
			event_painmessage()

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Xenochimera hallucinations
// Unlike normal hallucinations this one is triggered from handle_feral randomly.
// So it destroys itself after it triggers, freeing up space for the next run of it.
/////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/component/hallucinations/xenochimera/make_timer()
	var/datum/component/xenochimera/XC = our_human.GetComponent(/datum/component/xenochimera)
	var/F = XC ? (XC.feral / 10) : 1
	addtimer(CALLBACK(src, PROC_REF(trigger)), ((rand(20,50) SECONDS) / F), TIMER_DELETE_ME)

/datum/component/hallucinations/xenochimera/trigger()
	if(QDELETED(our_human))
		qdel(src)
>>>>>>> 2f4ae557ee ([MIRROR] Hallucination Refactor (#10879))
		return
	if(!our_human.client)
		qdel(src)
		return
	var/datum/component/xenochimera/XC = our_human.GetComponent(/datum/component/xenochimera)
	if(!XC || XC.feral < XENOCHIFERAL_THRESHOLD)
		qdel(src)
		return
	handle_hallucinating()
	QDEL_IN(src,rand(3,9)SECONDS)

/datum/component/hallucinations/xenochimera/handle_hallucinating()
	var/halpick = rand(1,100)
	switch(halpick)
		if(0 to 15) //15% chance
			//Screwy HUD
			event_hudscrew()
		if(16 to 25) //10% chance
			event_fake_item()
		if(26 to 35) //10% chance
			event_flash_environmental_threats()
		if(36 to 55) //20% chance
			event_strange_sound()
		if(56 to 60) //5% chance
			event_flash_monsters()
		if(61 to 85) //25% chance
			event_hunger()
		if(86 to 100) //15% chance
			event_hear_voices()
