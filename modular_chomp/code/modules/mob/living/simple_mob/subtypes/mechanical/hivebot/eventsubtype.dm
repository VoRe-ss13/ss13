/mob/living/simple_mob/mechanical/hivebot/nanoevent
	name = "strange hivebot"
	maxHealth = 0.5 LASERS_TO_KILL // 20 hp
	health = 0.5 LASERS_TO_KILL
	icon = 'modular_chomp/icons/mob/hivebot.dmi'
	icon_state = "precursorhive"
	icon_living = "precursorhive"
	movement_cooldown = 0
	melee_damage_lower = 13
	melee_damage_upper = 13
	attack_armor_pen = 40
	water_resist = 1
	melee_miss_chance = 0

/mob/living/simple_mob/mechanical/hivebot/nanoevent/bright_green //swarm melee creature
	icon_state = "bright_green"
	icon_living = "bright_green"
	pass_flags = PASSTABLE

/mob/living/simple_mob/mechanical/hivebot/nanoevent/cyan //cracks the shell
	icon_state = "cyan"
	icon_living = "cyan"
	projectiletype = /obj/item/projectile/energy/wallbreaker

/mob/living/simple_mob/mechanical/hivebot/nanoevent/pink //firing squad
	icon_state = "pink"
	icon_living = "pink"
	projectiletype = /obj/item/projectile/bullet/alterhivebot

/mob/living/simple_mob/mechanical/hivebot/nanoevent/yellow
	icon_state = "yellow"
	icon_living = "yellow"
	projectiletype = /obj/item/projectile/energy/electrode

/mob/living/simple_mob/mechanical/hivebot/nanoevent/orange //Need to siege the dungeon otherwise this get involved
	icon_state = "orange"
	icon_living = "orange"
	maxHealth = 1.5 LASERS_TO_KILL // 60 hp
	health = 1.5 LASERS_TO_KILL
	projectiletype = /obj/item/projectile/bullet/incendiary/dragonflame

/mob/living/simple_mob/mechanical/hivebot/nanoevent/orange/up
	maxHealth = 3 LASERS_TO_KILL // 120
	health = 3 LASERS_TO_KILL

/mob/living/simple_mob/mechanical/hivebot/nanoevent/orange/upper
	maxHealth = 3 LASERS_TO_KILL // 120
	health = 3 LASERS_TO_KILL
	projectiletype = /obj/item/projectile/bullet/dragon

/mob/living/simple_mob/mechanical/hivebot/nanoevent/orange/max //if the station gets pushed to this then wins, I will be impressed
	maxHealth = 5 LASERS_TO_KILL //200
	health = 5 LASERS_TO_KILL
	projectiletype = /obj/item/projectile/bullet/dragon
	projectiletype = /datum/ai_holder/hostile/ranged/robust

/obj/item/projectile/energy/wallbreaker
	name = "energy bolt"
	icon_state = "chronobolt"
	damage = 13
	armor_penetration = 40
	range = 16
	penetrating = 5

/obj/item/projectile/energy/wallbreaker/boss
	damage = 30
	speed = 10

/obj/item/projectile/bullet/alterhivebot
	damage = 20
	armor_penetration = 40
	icon_state = "bullet_alt"

/obj/item/projectile/bullet/alterhivebot/boss
	damage = 30
	speed = 10

/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard/corehivebot
	name = "command tower hivebot"
	desc = "A large, very important looking robot."
	icon = 'modular_chomp/icons/mob/hivebot.dmi'

/obj/item/projectile/beam/midlaser/shortrange
	range = 3

/obj/item/projectile/knockback
	name = "sonic blast"
	icon_state = "sound"
	damage = 0 //No
	damage_type = BRUTE
	check_armour = "melee"
	embed_chance = 0
	range = 12

/obj/item/projectile/pummel/on_hit(var/atom/movable/target, var/blocked = 0)
	if(isliving(target))
		var/mob/living/L = target
		var/throwdir = get_dir(firer,L)
		L.throw_at(get_edge_target_turf(L, throwdir), rand(3,6), 10)


/obj/item/projectile/metalball
	name = "ball of metal"
	icon_state = "bolter"
	speed = 0.5 //we need this to hit for the follow up, the sooner the better
	damage = 0 //but hey no real harm
	embed_chance = 0
	damage_type = BRUTE
	muzzle_type = null
	combustion = FALSE

/obj/item/projectile/metalball/on_hit(var/atom/target, var/blocked = 0)
	if(isturf(target.loc))
		var/obj/structure/foamedmetal/W = locate() in get_turf(target)
		if(!W)
			visible_message(span_danger("\The [src] splatters a lump of metal on \the [target]!"))
			new /obj/structure/foamedmetal(target.loc)
	..()

/mob/living/simple_mob/mechanical/mecha/eclipse/hivebotboss
	name = "central command tower hivebot"
	desc = "A large, very important looking robot."
	icon = 'modular_chomp/icons/mob/hivebot.dmi'
	icon_state = "mining_mecha"
	movement_cooldown = 7
	size_multiplier = 2
	maxHealth = 3000
	health = 3000
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 100, rad = 100)

/mob/living/simple_mob/mechanical/mecha/eclipse/hivebotboss/sane //Use this one in mapping, above has horribly inflated health vaules for event
	maxHealth = 900
	health = 900

/mob/living/simple_mob/mechanical/mecha/eclipse/hivebotboss/do_special_attack(atom/A)
	. = TRUE // So we don't fire a bolt as well.
	switch(a_intent)
		if(I_DISARM) // Phase 3
			if(attackcycle == 1)
				say("PROTOCOL: RESTRAIN.")
				Beam(A, icon_state = "solar_beam", time = 2.5 SECONDS, maxdistance = INFINITY)
				specialattackprojectile = /obj/item/projectile/metalball
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, 2), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				say("PROTOCOL: DESTORY.")
				Beam(A, icon_state = "solar_beam", time = 2.5 SECONDS, maxdistance = INFINITY)
				specialattackprojectile = /obj/item/projectile/beam/midlaser
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, 3), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				say("PROTOCOL: BARRIER WIPE")
				specialattackprojectile = /obj/item/projectile/energy/wallbreaker/boss
				addtimer(CALLBACK(src, PROC_REF(spin_to_win), A, 4), 1 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 4)
				say("PROTOCOL: SPRAY FIRE")
				specialattackprojectile = /obj/item/projectile/bullet/alterhivebot/boss
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 12, 5, 0.5 SECONDS), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 5)
				say("PROTOCOL: SHOCKWAVE.")
				specialattackprojectile = /obj/item/projectile/knockback
				addtimer(CALLBACK(src, PROC_REF(burst), A, 6), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 6)
				say("PROTOCOL: MICROWAVE.")
				Beam(A, icon_state = "solar_beam", time = 2.5 SECONDS, maxdistance = INFINITY)
				specialattackprojectile = /obj/item/projectile/temp/hot
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, 7), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 7)
				say("PROTOCOL: MACROWAVE.")
				specialattackprojectile = /obj/item/projectile/temp/hot
				addtimer(CALLBACK(src, PROC_REF(beglaser), A, 8), 2 SECOND, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 8)
				say("PROTOCOL: LASERBLADE.")
				specialattackprojectile = /obj/item/projectile/beam/midlaser/shortrange
				addtimer(CALLBACK(src, PROC_REF(burst), A, 9), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 9)
				say("PROTOCOL: WORMHOLE.")
				specialattackprojectile = /obj/item/projectile/arc/microsingulo
				attackcycle = 0
				if(prob(50))
					addtimer(CALLBACK(src, PROC_REF(miniburst_a), A, 10), 2 SECONDS, TIMER_DELETE_ME)
				else
					addtimer(CALLBACK(src, PROC_REF(miniburst_b), A, 10), 2 SECONDS, TIMER_DELETE_ME)
			else if(attackcycle == 10)
				say("PROTOCOL: FIREWALL.")
				specialattackprojectile = /obj/item/projectile/energy/infernosphere
				attackcycle = 0
				if(prob(50))
					addtimer(CALLBACK(src, PROC_REF(miniburst_a), A, 1), 2 SECONDS, TIMER_DELETE_ME)
				else
					addtimer(CALLBACK(src, PROC_REF(miniburst_b), A, 1), 2 SECONDS, TIMER_DELETE_ME)

		if(I_HURT) // Phase 1. Teaching the player the three funny attacks
			if(attackcycle == 1) //metal ball
				say("PROTOCOL: RESTRAIN.")
				Beam(A, icon_state = "solar_beam", time = 2.5 SECONDS, maxdistance = INFINITY)
				specialattackprojectile = /obj/item/projectile/metalball
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, 2), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2) //laser to be blocked by the foam we set up.
				say("PROTOCOL: DESTORY.")
				Beam(A, icon_state = "solar_beam", time = 2.5 SECONDS, maxdistance = INFINITY)
				specialattackprojectile = /obj/item/projectile/beam/midlaser
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, 3), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3) //The knock back AoE.
				say("PROTOCOL: SHOCKWAVE.")
				specialattackprojectile = /obj/item/projectile/knockback
				addtimer(CALLBACK(src, PROC_REF(burst), A, 4), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 4) //The Get away from me AoE.
				say("PROTOCOL: LASERBLADE.")
				specialattackprojectile = /obj/item/projectile/beam/midlaser/shortrange
				addtimer(CALLBACK(src, PROC_REF(burst), A, 1), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
		if(I_GRAB) // Phase 2
			if(attackcycle == 1)
				say("PROTOCOL: RESTRAIN.")
				Beam(A, icon_state = "solar_beam", time = 2.5 SECONDS, maxdistance = INFINITY)
				specialattackprojectile = /obj/item/projectile/metalball
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, 2), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				say("PROTOCOL: DESTORY.")
				Beam(A, icon_state = "solar_beam", time = 2.5 SECONDS, maxdistance = INFINITY)
				specialattackprojectile = /obj/item/projectile/beam/midlaser
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, 3), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				say("PROTOCOL: BARRIER WIPE")
				specialattackprojectile = /obj/item/projectile/energy/wallbreaker/boss
				addtimer(CALLBACK(src, PROC_REF(spin_to_win), A, 4), 1 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 4)
				say("PROTOCOL: SHOCKWAVE.")
				specialattackprojectile = /obj/item/projectile/knockback
				addtimer(CALLBACK(src, PROC_REF(burst), A, 5), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 5)
				say("PROTOCOL: MICROWAVE.")
				Beam(A, icon_state = "solar_beam", time = 2.5 SECONDS, maxdistance = INFINITY)
				specialattackprojectile = /obj/item/projectile/temp/hot
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, 6), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 6)
				say("PROTOCOL: LASERBLADE.")
				specialattackprojectile = /obj/item/projectile/beam/midlaser/shortrange
				addtimer(CALLBACK(src, PROC_REF(burst), A, 7), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 7)
				say("PROTOCOL: FIREWALL.")
				specialattackprojectile = /obj/item/projectile/energy/infernosphere
				attackcycle = 0
				if(prob(50))
					addtimer(CALLBACK(src, PROC_REF(miniburst_a), A, 1), 3 SECONDS, TIMER_DELETE_ME)
				else
					addtimer(CALLBACK(src, PROC_REF(miniburst_b), A, 1), 3 SECONDS, TIMER_DELETE_ME)


//phase 1, the tutortial
/mob/living/simple_mob/mechanical/mecha/eclipse/proc/singleproj/(atom/target, var/next_cycle)
	if(!target)
		return
	var/obj/item/projectile/P = new specialattackprojectile(get_turf(src))
	P.launch_projectile(target, BP_TORSO, src)
	attackcycle = next_cycle

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/burst(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_leftfour(target)
	upfour_leftthree(target)
	upfour_lefttwo(target)
	upfour_leftone(target)
	upfour(target)
	upfour_rightone(target)
	upfour_righttwo(target)
	upfour_rightthree(target)
	upfour_rightfour(target)
	upthree_rightfour(target)
	uptwo_rightfour(target)
	upone_rightfour(target)
	rightfour(target)
	downone_rightfour(target)
	downtwo_rightfour(target)
	downthree_rightfour(target)
	downfour_rightfour(target)
	downfour_rightthree(target)
	downfour_righttwo(target)
	downfour_rightone(target)
	downfour(target)
	downfour_leftone(target)
	downfour_lefttwo(target)
	downfour_leftthree(target)
	downfour_leftfour(target)
	downthree_leftfour(target)
	downtwo_leftfour(target)
	downone_leftfour(target)
	leftfour(target)
	upone_leftfour(target)
	uptwo_leftfour(target)
	upthree_leftfour(target)
	attackcycle = next_cycle

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/miniburst_a(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_leftfour(target)
	upfour_rightfour(target)
	downfour_rightfour(target)
	downfour_leftfour(target)
	attackcycle = next_cycle

<<<<<<< HEAD
/mob/living/simple_mob/mechanical/mecha/eclipse/proc/miniburst_b(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_leftfour(target)
	upfour_rightfour(target)
	downfour_rightfour(target)
	downfour_leftfour(target)
	attackcycle = next_cycle
=======
/mob/living/simple_mob/mechanical/mecha/eclipse/hivebot/green/event
	maxHealth = 3000
	health = 3000

/mob/living/simple_mob/mechanical/mecha/eclipse/hivebot/green/do_special_attack(atom/A)
	. = TRUE // So we don't fire a bolt as well.
	switch(a_intent)
		if(I_DISARM) // Phase 3
			if(attackcycle == 1)
				say("PROTOCOL: LASERBLADE.")
				specialattackprojectile = /obj/item/projectile/beam/midlaser/shortrange
				addtimer(CALLBACK(src, PROC_REF(burst), A, 2), 2 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				say("PROTOCOL: TELEPORT.")
				addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, 1), 1 SECOND, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle > 2)
				attackcycle = 1

		if(I_HURT) //phase 1
			if(attackcycle == 1)
				say("PROTOCOL: SWEEP. FIGURATION: A.")
				specialattackprojectile = /obj/item/projectile/energy/burninglaser/boss
				addtimer(CALLBACK(src, PROC_REF(dualsweep_one), A, 2), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				say("PROTOCOL: SWEEP. FIGURATION: B.")
				specialattackprojectile = /obj/item/projectile/energy/burninglaser/boss
				addtimer(CALLBACK(src, PROC_REF(dualsweep_one_r), A, 3), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				say("PROTOCOL: LASERBLADE.")
				specialattackprojectile = /obj/item/projectile/beam/midlaser/shortrange
				addtimer(CALLBACK(src, PROC_REF(burst), A, 1), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0

		if(I_GRAB) // Phase 2
			if(attackcycle == 1)
				say("PROTOCOL: SWEEP. FIGURATION: A.")
				specialattackprojectile = /obj/item/projectile/energy/burninglaser/boss
				addtimer(CALLBACK(src, PROC_REF(dualsweep_one), A, 2), 3 SECOND, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				say("PROTOCOL: TELEPORT.")
				addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, 3), 1 SECOND, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				say("PROTOCOL: SWEEP. FIGURATION: B.")
				specialattackprojectile = /obj/item/projectile/energy/burninglaser/boss
				addtimer(CALLBACK(src, PROC_REF(dualsweep_one), A, 4), 3 SECOND, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 4)
				say("PROTOCOL: TELEPORT.")
				addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, 5), 1 SECOND, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 5)
				say("PROTOCOL: LASERBLADE.")
				specialattackprojectile = /obj/item/projectile/beam/midlaser/shortrange
				addtimer(CALLBACK(src, PROC_REF(burst), A, 6), 3 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 6)
				say("PROTOCOL: TELEPORT.")
				addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, 1), 1 SECOND, TIMER_DELETE_ME)
				attackcycle = 0




//lore things
/obj/item/prop/nanoweave
	name = "alien disc"
	desc = "A disc for storing data."
	icon = 'modular_chomp/icons/mob/hivebot.dmi'
	w_class = ITEMSIZE_SMALL

/obj/item/prop/nanoweave/lime
	catalogue_data = list(/datum/category_item/catalogue/anomalous/limedisc)
	icon_state = "limedisc"

/obj/item/prop/nanoweave/cyan
	catalogue_data = list(/datum/category_item/catalogue/anomalous/cyandisc)
	icon_state = "cyandisc"

/obj/item/prop/nanoweave/orange
	catalogue_data = list(/datum/category_item/catalogue/anomalous/orangedisc)
	icon_state = "orangedisc"

/obj/item/prop/nanoweave/terraformers
	catalogue_data = list(/datum/category_item/catalogue/anomalous/orangedisc)
	icon_state = "orangedisc"


/datum/category_item/catalogue/anomalous/cyandisc
	name = "Precursor Object - Data Disc Cyan"
	desc = "End of time measures are now to be taken. Aimming several survial pods. \
	amongst our lands, and allies. \
	They shall burrow deep beneath the earth and overseen by the Overlord program. \
	Survival outlook likly.\
	<br><br>\
	Error file corruption.\
	<br><br>\
	T3e cr7at1re dv8s n07 4pp5ar to f000o5 3ur 1u228nt 3n0w1e1ge of 3c4e2ce. \
	6v3n 15e 01h5rs e5pe12m3nta1 t02h501ogy d0es n0t m1m73 1t's c8rr3n1 m0vem3nt.. \
	1t's 94th 6s u7pr3di21abl3."
	value = CATALOGUER_REWARD_HARD

/datum/category_item/catalogue/anomalous/orangedisc
	name = "Precursor Object - Data Disc Orange"
	desc = "The voidwalkers are launching themselves into the void. \
	The beast callers venture into the unknown. \
	The abyss divers never plan to surface. \
	The terraformers are following a similiar plan to us, burrowing beneath the surface.\
	<br><br>\
	Error file corruption.\
	<br><br>\
	Ew ahev rna teh acclsuaotiln. Uor rpooptytse rae sceduer... \
	Spyretonlia csroe vaeh ebne eplemmidnet fi we rae ot lalf... \
	Oru ofmsr erbrno in a enw dtiiag; oybd if oru eral nose dei.."
	value = CATALOGUER_REWARD_HARD

/datum/category_item/catalogue/anomalous/limedisc
	name = "Precursor Object - Data Disc Lime"
	desc = "We have secured our technoly within the vaults. Settled upon the core. \
	of the planet. It should be safe from tampering..\
	Our pods should land a few hundred meters above them. \
	Survival outlook likly.\
	<br><br>\
	Error file corruption.\
	<br><br>\
	W3 h4v3 s3t 07r c0mp7t3rs t0 b71lt c07nt3r m34sur3s 1n c4s3 th3 0th3rs s7rv1v3 th3 p7rg3.. \
	B7t the 0th3rs s7rv1val s33ms 7nl1k3ly... \
	Th3 t3rr4f0rm3rs ar3 4lr3ady 4ffl1ct3d by 4 pl4g73.."
	value = CATALOGUER_REWARD_HARD

/datum/category_item/catalogue/anomalous/terraformers
	name = "Precursor Object - Data Disc Styx"
	desc = "We have secured our technoly within the vaults. Settled upon the core. \
	of the planet. It should be safe from tampering..\
	Our pods should land a few hundred meters above them. \
	Survival outlook likly.\
	<br><br>\
	Error file corruption.\
	<br><br>\
	W3 h4v3 s3t 07r c0mp7t3rs t0 b71lt c07nt3r m34sur3s 1n c4s3 th3 0th3rs s7rv1v3 th3 p7rg3.. \
	B7t the 0th3rs s7rv1val s33ms 7nl1k3ly... \
	Th3 t3rr4f0rm3rs ar3 4lr3ady 4ffl1ct3d by 4 pl4g73.."
	value = CATALOGUER_REWARD_HARD



/*
/mob/living/simple_mob/mechanical/mecha/eclipse/hivebot/green/do_special_attack(atom/A)
	. = TRUE // So we don't fire a bolt as well.
	switch(a_intent)
		if(I_DISARM) // Phase 3 1 safe zone
			if(attackcycle == 1)
				say("PROTOCOL: LASERBLADE.")
				specialattackprojectile = /obj/item/projectile/beam/midlaser/shortrange
				addtimer(CALLBACK(src, PROC_REF(burst), A, 2), 2 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				say("PROTOCOL: TELEPORT.")
				addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, 1), 1 SECOND, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				say("PROTOCOL: TELEPORT.")
				addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, 1), 1 SECOND, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				say("PROTOCOL: TELEPORT.")
				addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, 1), 1 SECOND, TIMER_DELETE_ME)
				attackcycle = 0

		if(I_HURT) //phase 1 3 safe zones
			if(attackcycle == 1)
				say("PROTOCOL: SWEEP. FIGURATION: A.")

				attackcycle = 0
			else if(attackcycle == 2)
				say("PROTOCOL: SWEEP. FIGURATION: B.")

				attackcycle = 0
			else if(attackcycle == 3)
				say("PROTOCOL: LASERBLADE.")

				attackcycle = 0

		if(I_GRAB) // Phase 2 2 safe zones
			if(attackcycle == 1)
				say("PROTOCOL: SWEEP. FIGURATION: A.")

				attackcycle = 0
			else if(attackcycle == 2)

*/
>>>>>>> 4f90d2f057 (Tyr Update (#10780))

