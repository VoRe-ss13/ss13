/mob/living/simple_mob/mechanical/mecha/eclipse
	health = 875
	maxHealth = 875
	faction = FACTION_ECLIPSE
	icon = 'modular_chomp/icons/mob/eclipse.dmi'
	has_repair_droid = TRUE
	ai_holder_type = /datum/ai_holder/simple_mob/intentional/three_phases
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 100, rad = 100)
	armor_soak = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	special_attack_min_range = 1
	special_attack_max_range = 7
	special_attack_cooldown = 10 //This things attack soley via speical attacks hence basically no cooldown
	grab_resist = 100
	shock_resist = -0.2
	movement_cooldown = 10
	var/specialattackprojectile = /obj/item/projectile/energy/phase/bolt
	var/attackcycle = 1

/mob/living/simple_mob/mechanical/mecha/eclipse/do_special_attack(atom/A)
	bullet_heck(A, 3, 3)

/datum/ai_holder/simple_mob/intentional/three_phases
	use_astar = TRUE
	wander = FALSE
	respect_confusion = FALSE
	var/closest_desired_distance = 6

/datum/ai_holder/simple_mob/intentional/three_phases/on_engagement(atom/A)
	if(get_dist(holder, A) > closest_desired_distance)
		holder.IMove(get_step_towards(holder, A))

/datum/ai_holder/simple_mob/intentional/three_phases/pre_special_attack(atom/A)
	if(isliving(A))
		if((holder.health / holder.getMaxHealth()) <= 0.35) //Phase three!
			holder.a_intent = I_DISARM

		else if((holder.health / holder.getMaxHealth()) <= 0.7) //Phase two
			holder.a_intent = I_GRAB

		else
			holder.a_intent = I_HURT

//Most mechas have a strange defense mechanism
//This one however, is the simplest one, more meant as an intro
/mob/living/simple_mob/mechanical/mecha/eclipse/antipersonal_unit //Melts folks with lasers
	name = "Eclipse Expirmental Anti-Infantary Unit"
	specialattackprojectile = /obj/item/projectile/energy/eclipse/lorge
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 60, bomb = 90, bio = 100, rad = 100)
	icon_state = "orb"
	wreckage = /obj/structure/loot_pile/mecha/odd_gygax

/mob/living/simple_mob/mechanical/mecha/eclipse/antipersonal_unit/do_special_attack(atom/A)
	var/rng_cycle
	switch(a_intent)
		if(I_DISARM) //phase3
			if(attackcycle == 1)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 20, rng_cycle, 10), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(dual_spin), A, rng_cycle, 10), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				rng_cycle = rand(1,3)
				Beam(A, icon_state = "solar_beam", time = 2 SECONDS, maxdistance = INFINITY)
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, rng_cycle), 2 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0

		if(I_HURT) //phase1
			if(attackcycle == 1)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 8, rng_cycle, 15), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(cross_spin), A, rng_cycle, 15), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				rng_cycle = rand(1,3)
				Beam(A, icon_state = "solar_beam", time = 2 SECONDS, maxdistance = INFINITY)
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, rng_cycle), 2 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
		if(I_GRAB) // Phase 2
			if(attackcycle == 1)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 12, rng_cycle, 10), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(cross_spin), A, rng_cycle, 10), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				rng_cycle = rand(1,3)
				Beam(A, icon_state = "solar_beam", time = 1.5 SECONDS, maxdistance = INFINITY)
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, rng_cycle), 1 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0



//Nigh unbreakable defenses except during certian attack phases.
/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard //Explosive death
	name = "Eclipse Expirmental Mining Mecha"
	desc = "You mecha guarded by a powerful shield. Perhaps it will drop at some point."
	specialattackprojectile = /obj/item/projectile/energy/eclipse/lorgealien
	armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
	armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
	icon_state = "shielded_mining_mecha"
	shock_resist = 1
	wreckage = /obj/structure/loot_pile/mecha/odd_ripley
	attackcycle = 1

/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard/do_special_attack(atom/A)
	switch(a_intent)
		if(I_DISARM) //phase3
			if(attackcycle == 1)
<<<<<<< HEAD
				phasethree_cycleone(A)
			else if(attackcycle == 2)
				phasethree_cycletwo(A)
			else if(attackcycle == 3)
				phasethree_cyclethree(A)
		if(I_HURT) // Phase 1
			if(attackcycle == 1)
				phaseone_cycleone(A)
			else if(attackcycle == 2)
				phaseone_cycletwo(A)
			else if(attackcycle == 3)
				phaseone_cyclethree(A)
		if(I_GRAB) // Phase 2
			if(attackcycle == 1)
				phasetwo_cycleone(A)
			else if(attackcycle == 2)
				phasetwo_cycletwo(A)
			else if(attackcycle == 3)
				phasetwo_cyclethree(A)

//phase one. We begin the long drawn out endurance boute
/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard/proc/phaseone_cycleone(atom/target) //four seconds
	armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
	armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
	icon_state = "shielded_mining_mecha"
	addtimer(CALLBACK(src, PROC_REF(zone_control_one), target, 2), 0.5 SECONDS, TIMER_DELETE_ME)
	attackcycle = 0


/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard/proc/phaseone_cycletwo(atom/target) //four seconds
	armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
	armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
	icon_state = "shielded_mining_mecha"
	addtimer(CALLBACK(src, PROC_REF(random_firing), target, 12, 3, 0.5 SECONDS), 0.5 SECONDS, TIMER_DELETE_ME)
	attackcycle = 0

/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard/proc/phaseone_cyclethree(atom/target) //eight seconds where it's vunerable
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 100, rad = 100)
	armor_soak = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	icon_state = "mining_mecha"
	addtimer(CALLBACK(src, PROC_REF(random_firing), target, 12, 1, 0.5 SECONDS), 0.5 SECONDS, TIMER_DELETE_ME)
	attackcycle = 0


/mob/living/simple_mob/mechanical/mecha/eclipse/proc/summon_drones(atom/target, var/amount, var/next_cycle, var/fire_delay)
	var/deathdir = rand(1,3)
	switch(deathdir)
		if(1)
			new /mob/living/simple_mob/mechanical/mining_drone/scavenger/eclipse (src.loc)
		if(2)
			new /mob/living/simple_mob/mechanical/hivebot/swarm/eclipse (src.loc)
		if(3)
			new /mob/living/simple_mob/mechanical/combat_drone/artillery
	amount--
	if(amount > 0)
		addtimer(CALLBACK(src, PROC_REF(summon_drones), target, amount, next_cycle, fire_delay), fire_delay, TIMER_DELETE_ME)
	else
		attackcycle = next_cycle

//phase two now we begin the bullet hell
/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard/proc/phasetwo_cycleone(atom/target) //Seven seconds
	armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
	armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
	icon_state = "shielded_mining_mecha"
	visible_message(span_danger("The [src] is preparing a deadly attack!"))
	addtimer(CALLBACK(src, PROC_REF(thewall), target), 2.5 SECONDS, TIMER_DELETE_ME)
	attackcycle = 0

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/thewall(atom/target)
	if(!target)
		return
	upfour_rightfour(target)
	upthree_rightfour(target)
	uptwo_rightfour(target)
	upone_rightfour(target)
	rightfour(target)
	downone_rightfour(target)
	downtwo_rightfour(target)
	downthree_rightfour(target)
	downfour_rightfour(target)
	upfour_leftfour(target)
	upthree_leftfour(target)
	uptwo_leftfour(target)
	upone_leftfour(target)
	leftfour(target)
	downone_leftfour(target)
	downtwo_leftfour(target)
	downthree_leftfour(target)
	downfour_leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(thehall), target), 2.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/thehall(atom/target)
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
	downfour_leftfour(target)
	downfour_leftthree(target)
	downfour_lefttwo(target)
	downfour_leftone(target)
	downfour(target)
	downfour_rightone(target)
	downfour_righttwo(target)
	downfour_rightthree(target)
	downfour_rightfour(target)
	attackcycle = 2

/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard/proc/phasetwo_cycletwo(atom/target) //Seven seconds
	armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
	armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
	icon_state = "shielded_mining_mecha"
	addtimer(CALLBACK(src, PROC_REF(beglaser), target, 3), 1 SECOND, TIMER_DELETE_ME)
	attackcycle = 0

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser(atom/target, var/next_cycle)
	upfour_leftone(target)
	upfour(target)
	upfour_rightone(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_1), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_1(atom/target, var/next_cycle)
	upfour_rightone(target)
	upfour_righttwo(target)
	upfour_rightthree(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_2), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_2(atom/target, var/next_cycle)
	upfour_rightfour(target)
	upthree_rightfour(target)
	uptwo_rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_3), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_3(atom/target, var/next_cycle)
	upone_rightfour(target)
	rightfour(target)
	downone_rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_4), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_4(atom/target, var/next_cycle)
	downone_rightfour(target)
	downtwo_rightfour(target)
	downthree_rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_5), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_5(atom/target, var/next_cycle)
	downthree_rightfour(target)
	downfour_rightfour(target)
	downfour_rightthree(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_6), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_6(atom/target, var/next_cycle)
	downfour_rightthree(target)
	downfour_righttwo(target)
	downfour_rightone(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_7), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_7(atom/target, var/next_cycle)
	downfour_rightone(target)
	downfour(target)
	downfour_leftone(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_8), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_8(atom/target, var/next_cycle)
	downfour_leftone(target)
	downfour_lefttwo(target)
	downfour_leftthree(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_9), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_9(atom/target, var/next_cycle)
	downfour_leftfour(target)
	downthree_leftfour(target)
	downtwo_leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_10), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_10(atom/target, var/next_cycle)
	downtwo_leftfour(target)
	downone_leftfour(target)
	leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_11), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_11(atom/target, var/next_cycle)
	leftfour(target)
	upone_leftfour(target)
	uptwo_leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_12), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_12(atom/target, var/next_cycle)
	uptwo_leftfour(target)
	upthree_leftfour(target)
	upfour_leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(beglaser_13), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/beglaser_13(atom/target, var/next_cycle)
	upfour_leftfour(target)
	upfour_leftthree(target)
	upfour_lefttwo(target)
	if(prob(20))
		addtimer(CALLBACK(src, PROC_REF(beglaser), target, next_cycle), 1 SECOND, TIMER_DELETE_ME)
	else
		attackcycle = next_cycle

/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard/proc/phasetwo_cyclethree(atom/target) //seven seconds
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 100, rad = 100)
	armor_soak = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	icon_state = "mining_mecha"
	addtimer(CALLBACK(src, PROC_REF(spin_to_win), target, 1), 2 SECONDS, TIMER_DELETE_ME)
	attackcycle = 0

//phase three
/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard/proc/phasethree_cycleone(atom/target) //seven seconds
	armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
	armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
	icon_state = "shielded_mining_mecha"
	addtimer(CALLBACK(src, PROC_REF(spin_to_win), target, 2), 2 SECONDS, TIMER_DELETE_ME)
	attackcycle = 0

/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard/proc/phasethree_cycletwo(atom/target) //seven seconds
	armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
	armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
	icon_state = "shielded_mining_mecha"
	addtimer(CALLBACK(src, PROC_REF(beglaser), target, 3), 1 SECOND, TIMER_DELETE_ME)
	attackcycle = 0

/mob/living/simple_mob/mechanical/mecha/eclipse/mining_guard/proc/phasethree_cyclethree(atom/target) //two seconds
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 100, rad = 100)
	armor_soak = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	icon_state = "mining_mecha"
	addtimer(CALLBACK(src, PROC_REF(random_firing), target, 20, 1, 0.2 SECONDS), 0.5 SECONDS, TIMER_DELETE_ME)
	attackcycle = 0

//High overall defense, swaps between Burn and brute defense based off what was just used.
/mob/living/simple_mob/mechanical/mecha/eclipse/darkmatter_assualt //The final boss
	name = "Eclipse Expirmental Janus"
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 60, bomb = 80, bio = 100, rad = 100)
	specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
	pilot_type = /mob/living/simple_mob/humanoid/eclipse/head/tyrlead
	icon_state = "eclipse_janus"
	attackcycle = 1


/mob/living/simple_mob/mechanical/mecha/eclipse/darkmatter_assualt/bullet_act(obj/item/projectile/P)
	.= ..()
	if(istype(P, /obj/item/projectile/bullet))
		armor = list(melee = 80, bullet = 80, laser = 40, energy = 40, bomb = 80, bio = 100, rad = 100)
		armor_soak = list(melee = 10, bullet = 10, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
		icon_state = "eclipse_janus_red"
	else
		armor = list(melee = 40, bullet = 40, laser = 80, energy = 80, bomb = 80, bio = 100, rad = 100)
		armor_soak = list(melee = 0, bullet = 0, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
		icon_state = "eclipse_janus_orange"

/mob/living/simple_mob/mechanical/mecha/eclipse/darkmatter_assualt/do_special_attack(atom/A)
	. = TRUE // So we don't fire a bolt as well.
	switch(a_intent)
		if(I_DISARM) // Phase 3
			if(attackcycle == 1)
				specialattackprojectile = /obj/item/projectile/arc/explosive_rocket
				attackcycle = 0
				if(prob(50))
					addtimer(CALLBACK(src, PROC_REF(miniburst_a), A, 1), 0.5 SECONDS, TIMER_DELETE_ME)
				else
					addtimer(CALLBACK(src, PROC_REF(miniburst_b), A, 1), 0.5 SECONDS, TIMER_DELETE_ME)
			else if(attackcycle == 2)
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 10, 2, 0.75 SECONDS), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				say("Hypercharge laser burst!")
				specialattackprojectile = /obj/item/projectile/beam/heavylaser
				addtimer(CALLBACK(src, PROC_REF(burst), A, 3), 6 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 4)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 10, 1, 0.75 SECONDS), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
		if(I_HURT) // Phase 1
			specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
			if(attackcycle == 1)
				addtimer(CALLBACK(src, PROC_REF(spin_to_win), A, 2), 2 SECONDS, TIMER_DELETE_ME)
=======
				specialattackprojectile = /obj/item/projectile/energy/eclipse/lorgealien
				addtimer(CALLBACK(src, PROC_REF(quad_random_firing), A, 12, 2, 10), 1 SECOND, TIMER_DELETE_ME)
				armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 100, rad = 100)
				armor_soak = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
				icon_state = "mining_mecha"
>>>>>>> e5c574285d (Tyr Update 9000 (#11107))
				attackcycle = 0
			else if(attackcycle == 2)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/lorgealien
				addtimer(CALLBACK(src, PROC_REF(hole_in_wall), A, 3, 15), 0.5 SECONDS, TIMER_DELETE_ME)
				armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
				armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
				icon_state = "shielded_mining_mecha"
				attackcycle = 0
			else if(attackcycle == 3)
				specialattackprojectile = /obj/item/projectile/arc/blue_energy/precusor
				addtimer(CALLBACK(src, PROC_REF(chain_burst), A, 1, 15), 0.5 SECONDS, TIMER_DELETE_ME)
				armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
				armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
				icon_state = "shielded_mining_mecha"
				attackcycle = 0
		if(I_HURT) //phase1
			if(attackcycle == 1)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/lorgealien
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 6, 2, 10), 1 SECOND, TIMER_DELETE_ME)
				armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 100, rad = 100)
				armor_soak = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
				icon_state = "mining_mecha"
				attackcycle = 0
			else if(attackcycle == 2)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/lorgealien
				addtimer(CALLBACK(src, PROC_REF(hole_in_wall), A, 3, 20), 0.5 SECONDS, TIMER_DELETE_ME)
				armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
				armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
				icon_state = "shielded_mining_mecha"
				attackcycle = 0
			else if(attackcycle == 3)
				specialattackprojectile = /obj/item/projectile/arc/blue_energy/precusor
				addtimer(CALLBACK(src, PROC_REF(chain_burst), A, 1, 20), 0.5 SECONDS, TIMER_DELETE_ME)
				armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
				armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
				icon_state = "shielded_mining_mecha"
				attackcycle = 0
		if(I_GRAB) // Phase 2
			if(attackcycle == 1)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/lorgealien
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 8, 2, 10), 1 SECOND, TIMER_DELETE_ME)
				armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 100, rad = 100)
				armor_soak = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
				icon_state = "mining_mecha"
				attackcycle = 0
			else if(attackcycle == 2)
<<<<<<< HEAD
				say("Activating laser surge")
				specialattackprojectile = /obj/item/projectile/energy/burninglaser/boss
				addtimer(CALLBACK(src, PROC_REF(miniburst_a), A, 2), 3 SECONDS, TIMER_DELETE_ME)
			else if(attackcycle == 3)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 10, 4, 0.75 SECONDS), 0.5 SECONDS, TIMER_DELETE_ME)
=======
				specialattackprojectile = /obj/item/projectile/energy/eclipse/lorgealien
				addtimer(CALLBACK(src, PROC_REF(hole_in_wall), A, 3, 15), 0.5 SECONDS, TIMER_DELETE_ME)
				armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
				armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
				icon_state = "shielded_mining_mecha"
>>>>>>> e5c574285d (Tyr Update 9000 (#11107))
				attackcycle = 0
			else if(attackcycle == 3)
				specialattackprojectile = /obj/item/projectile/arc/blue_energy/precusor
				addtimer(CALLBACK(src, PROC_REF(chain_burst), A, 1, 15), 0.5 SECONDS, TIMER_DELETE_ME)
				armor = list(melee = 90, bullet = 90, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
				armor_soak = list(melee = 25, bullet = 25, laser = 25, energy = 25, bomb = 0, bio = 0, rad = 0)
				icon_state = "shielded_mining_mecha"
				attackcycle = 0


//radidation gimmick go brrrr
/mob/living/simple_mob/mechanical/mecha/eclipse/engimecha
	name = "Eclipse Expirmental Enginering Mecha"
	health = 300
	maxHealth = 300
	desc = "A mecha made for enginering purposes, with several alterations to be an odd ball combat unit."
	specialattackprojectile = /obj/item/projectile/energy/excavate/weak
	armor = list(melee = 30, bullet = 30, laser = 30, energy = 40, bomb = 90, bio = 100, rad = 100)
	armor_soak = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	icon_state = "engi_spider"
	shock_resist = 1
	projectiletype = /obj/item/projectile/beam/chain_lightning
	reload_max = 1
	reload_time = 0.5 SECONDS
	ranged_attack_delay = 2 SECONDS

	glow_color = "#14ff20"
	light_color = "#14ff20"
	glow_range = 5
	glow_intensity = 3

	special_attack_cooldown = 60

	pilot_type = /mob/living/simple_mob/humanoid/eclipse/head/engineer

	var/rads = 5

/mob/living/simple_mob/mechanical/mecha/eclipse/engimecha/do_special_attack(atom/A)
	rads += 15

/mob/living/simple_mob/mechanical/mecha/eclipse/engimecha/handle_special()
	if(stat != DEAD)
		irradiate()
	..()

/mob/living/simple_mob/mechanical/mecha/eclipse/engimecha/proc/irradiate()
	SSradiation.radiate(src, rads)

/mob/living/simple_mob/mechanical/mecha/eclipse/engimecha/ranged_pre_animation(atom/A)
	Beam(get_turf(A), icon_state = "sniper_beam", time = 2 SECONDS, maxdistance = 15)
	. = ..()

/mob/living/simple_mob/mechanical/mecha/eclipse/engimecha/shoot_target(atom/A)
	set waitfor = FALSE

	if(!istype(A) || QDELETED(A))
		return

	setClickCooldown(get_attack_speed())

	face_atom(A)

	var/atom/orig_targ = A

	if(ranged_attack_delay)
		A = get_turf(orig_targ)
		ranged_pre_animation(A)
		handle_attack_delay(A, ranged_attack_delay) // This will sleep this proc for a bit, which is why waitfor is false.

	if(needs_reload)
		if(reload_count >= reload_max)
			try_reload()
			return FALSE

	/*
	 * CHOMP Addition: This section here is (duplicated) special snowflake code because sniper does not call parent. Basically, this is a non-stupid version of the above intended for ranged mobs.
	 * ranged_attack_delay is stupid because it sleeps the entire mob.
	 * This new ranged_cooldown_time is smarter in the sense that it is an internalized timer. Try not to confuse the names.
	*/
	if(ranged_cooldown_time) //If you have a non-zero number in a mob's variables, this pattern begins.
		if(ranged_cooldown <= world.time) //Further down, a timer keeps adding to the ranged_cooldown variable automatically.
			visible_message(span_bolddanger("\The [src]") + " fires at \the [A]!") //Leave notice of shooting.
			shoot(A) //Perform the shoot action
			if(casingtype) //If the mob is designated to leave casings...
				new casingtype(loc) //... leave the casing.
			ranged_cooldown = world.time + ranged_cooldown_time + ((injury_level / 2) SECONDS) //Special addition here. This is a timer. Keeping updating the time after shooting. Add that ranged cooldown time specified in the mob to the world time.
		return TRUE	//End these commands here.
	// CHOMPAddition End

	visible_message(span_bolddanger("\The [src]") + " fires at \the [orig_targ]!")
	shoot(A)
	if(casingtype)
		new casingtype(loc)

	if(ranged_attack_delay)
		ranged_post_animation(A)

	return TRUE

//High overall defense, swaps between Burn and brute defense based off what was just used.
/mob/living/simple_mob/mechanical/mecha/eclipse/darkmatter_assualt/armored //The final boss
	name = "Eclipse Expirmental Janus"
	desc = "A powerful looking mecha, it's shield appears to swap to protect itself against the most rescent damage type."
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 60, bomb = 80, bio = 100, rad = 100)
	specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
	pilot_type =/mob/living/simple_mob/mechanical/mecha/eclipse/darkmatter_assualt/phasetwo
	wreckage = /obj/item/prop/tyrlore/monodisc
	icon_state = "eclipse_janus"
	attackcycle = 1


/mob/living/simple_mob/mechanical/mecha/eclipse/darkmatter_assualt/armored/bullet_act(obj/item/projectile/P)
	.= ..()
	if(istype(P, /obj/item/projectile/bullet))
		armor = list(melee = 80, bullet = 80, laser = 30, energy = 30, bomb = 80, bio = 100, rad = 100)
		armor_soak = list(melee = 10, bullet = 10, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
		icon_state = "eclipse_janus_red"
		visible_message(span_cult("[P] has been adapted too!."))
	else
		armor = list(melee = 30, bullet = 30, laser = 80, energy = 80, bomb = 80, bio = 100, rad = 100)
		armor_soak = list(melee = 0, bullet = 0, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
		icon_state = "eclipse_janus_orange"
		visible_message(span_cult("[P] has been adapted too!."))

/mob/living/simple_mob/mechanical/mecha/eclipse/darkmatter_assualt/armored/do_special_attack(atom/A)
	var/rng_cycle
	switch(a_intent)
		if(I_DISARM) //phase3
			if(attackcycle == 1)
				rng_cycle = rand(1,4)
				addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, rng_cycle, 2), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				rng_cycle = rand(1,4)
				specialattackprojectile = /obj/item/projectile/arc/blue_energy/precusor
				addtimer(CALLBACK(src, PROC_REF(dual_burst), A, rng_cycle), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				rng_cycle = rand(1,4)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
				addtimer(CALLBACK(src, PROC_REF(quad_random_firing), A, 8, rng_cycle, 5), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 4)
				rng_cycle = rand(1,4)
				specialattackprojectile = /obj/item/projectile/arc/blue_energy/precusor
				addtimer(CALLBACK(src, PROC_REF(chain_burst), A, rng_cycle), 1 SECOND, TIMER_DELETE_ME)
				attackcycle = 0
		if(I_HURT) //phase1 simple projectiles
			if(attackcycle == 1)
				rng_cycle = rand(1,4)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 8, rng_cycle, 5), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				rng_cycle = rand(1,4)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
				addtimer(CALLBACK(src, PROC_REF(cross_spin), A, rng_cycle, 5), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				rng_cycle = rand(1,4)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
				Beam(A, icon_state = "solar_beam", time = 2 SECONDS, maxdistance = INFINITY)
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, rng_cycle), 2 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 4)
				rng_cycle = rand(1,4)
				addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, rng_cycle, 3), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
		if(I_GRAB) // Phase 2
			if(attackcycle == 1)
				rng_cycle = rand(1,4)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
				addtimer(CALLBACK(src, PROC_REF(quad_random_firing), A, 8, rng_cycle, 5), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				rng_cycle = rand(1,4)
				specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
				addtimer(CALLBACK(src, PROC_REF(dual_spin), A, rng_cycle, 5), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				rng_cycle = rand(1,4)
				addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, rng_cycle, 2), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 4)
				rng_cycle = rand(1,4)
				specialattackprojectile = /obj/item/projectile/arc/blue_energy/precusor
				addtimer(CALLBACK(src, PROC_REF(checker_board), A, rng_cycle), 1 SECOND, TIMER_DELETE_ME)
				attackcycle = 0

/mob/living/simple_mob/mechanical/mecha/eclipse/darkmatter_assualt/phasetwo //we ain't done yet
	name = "Collapsing Janus"
	armor = list(melee = 30, bullet = 30, laser = 30, energy = 30, bomb = 80, bio = 100, rad = 100) //our shielding is gone
	health = 425
	maxHealth = 425
	desc = "The mecha is smoking, it's drone and shield is broken, but it's pilot is pushing it further."
	specialattackprojectile = /obj/item/projectile/energy/eclipse/janusjavelin
	wreckage = /obj/item/prop/tyrlore/neonjanus
	pilot_type = /mob/living/simple_mob/mechanical/mecha/eclipse/sniper
	has_repair_droid = FALSE //broken mecha
	icon_state = "eclipse_janus"

/mob/living/simple_mob/mechanical/mecha/eclipse/darkmatter_assualt/phasetwo/do_special_attack(atom/A)
	var/rng_cycle
	if(attackcycle == 1)
		attackcycle = rand(4,6)
		addtimer(CALLBACK(src, PROC_REF(random_firing), A, 14, attackcycle, 5), 0.5 SECONDS, TIMER_DELETE_ME)
	else if(attackcycle == 2)
		addtimer(CALLBACK(src, PROC_REF(cross_spin), A, attackcycle, 5), 0.5 SECONDS, TIMER_DELETE_ME)
		attackcycle = rand(4,6)
	else if(attackcycle == 3)
		addtimer(CALLBACK(src, PROC_REF(hole_in_wall), A, attackcycle, 15), 0.5 SECONDS, TIMER_DELETE_ME)
		attackcycle = rand(4,6)
	else if(attackcycle == 4)
		rng_cycle = rand(1,3)
		addtimer(CALLBACK(src, PROC_REF(dual_spin), A, rng_cycle, 5), 0.5 SECONDS, TIMER_DELETE_ME)
		attackcycle = 0
	else if(attackcycle == 5)
		rng_cycle = rand(1,3)
		addtimer(CALLBACK(src, PROC_REF(quad_random_firing), A, 7, rng_cycle, 15), 0.5 SECONDS, TIMER_DELETE_ME)
		attackcycle = 0
	else if(attackcycle == 6)
		rng_cycle = rand(1,3)
		addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, rng_cycle, 5), 3 SECONDS, TIMER_DELETE_ME)
		attackcycle = 0


<<<<<<< HEAD
//Revamped special attacks
/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_one(atom/target, var/next_cycle)
	if(!target)
		return
	upfour(target)
	downfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_two), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_two(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_leftone(target)
	downfour_rightone(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_three), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_three(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_lefttwo(target)
	downfour_righttwo(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_four), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_four(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_leftthree(target)
	downfour_rightthree(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_five), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_five(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_leftfour(target)
	downfour_rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_six), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_six(atom/target, var/next_cycle)
	if(!target)
		return
	upthree_leftfour(target)
	downthree_rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_seven), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_seven(atom/target, var/next_cycle)
	if(!target)
		return
	uptwo_leftfour(target)
	downtwo_rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_eight), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_eight(atom/target, var/next_cycle)
	if(!target)
		return
	upone_leftfour(target)
	downone_rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_nine), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_nine(atom/target, var/next_cycle)
	if(!target)
		return
	leftfour(target)
	rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_ten), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_ten(atom/target, var/next_cycle)
	if(!target)
		return
	downone_leftfour(target)
	upone_rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_eleven), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_eleven(atom/target, var/next_cycle)
	if(!target)
		return
	downtwo_leftfour(target)
	uptwo_rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_twelve), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_twelve(atom/target, var/next_cycle)
	if(!target)
		return
	downthree_leftfour(target)
	upthree_rightfour(target)
	attackcycle = next_cycle

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_one_r(atom/target, var/next_cycle)
	if(!target)
		return
	upfour(target)
	downfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_two_r), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_two_r(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_rightone(target)
	downfour_leftone(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_three_r), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_three_r(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_righttwo(target)
	downfour_lefttwo(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_four_r), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_four_r(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_rightthree(target)
	downfour_leftthree(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_five_r), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_five_r(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_rightfour(target)
	downfour_leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_six_r), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_six_r(atom/target, var/next_cycle)
	if(!target)
		return
	upthree_rightfour(target)
	downthree_leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_seven_r), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_seven_r(atom/target, var/next_cycle)
	if(!target)
		return
	uptwo_rightfour(target)
	downtwo_leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_eight_r), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_eight_r(atom/target, var/next_cycle)
	if(!target)
		return
	upone_rightfour(target)
	downone_leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_nine_r), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_nine_r(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_ten_r), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_ten_r(atom/target, var/next_cycle)
	if(!target)
		return
	downone_rightfour(target)
	upone_leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_eleven_r), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_eleven_r(atom/target, var/next_cycle)
	if(!target)
		return
	downtwo_rightfour(target)
	uptwo_leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(dualsweep_twelve_r), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/dualsweep_twelve_r(atom/target, var/next_cycle)
	if(!target)
		return
	downthree_rightfour(target)
	upthree_leftfour(target)
	attackcycle = next_cycle

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_one(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_two), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_two(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	upfour(target)
	downfour(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_three), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_three(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_four), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_four(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	upfour_leftone(target)
	upfour_rightone(target)
	downfour_leftone(target)
	downfour_rightone(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_five), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_five(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_six), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_six(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	upfour_lefttwo(target)
	upfour_righttwo(target)
	downfour_lefttwo(target)
	downfour_righttwo(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_seven), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_seven(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_eight), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_eight(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	upfour_leftthree(target)
	upfour_rightthree(target)
	downfour_leftthree(target)
	downfour_rightthree(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_nine), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_nine(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_ten), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_ten(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	upfour_leftthree(target)
	upfour_rightthree(target)
	downfour_leftthree(target)
	downfour_rightthree(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_eleven), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_eleven(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_twelve), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_twelve(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	upfour_leftfour(target)
	upfour_rightfour(target)
	downfour_leftfour(target)
	downfour_rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_thirteen), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_thirteen(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_fourteen), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_fourteen(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	upthree_leftfour(target)
	upthree_rightfour(target)
	downthree_leftfour(target)
	downthree_rightfour(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_fifteen), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_fifteen(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	addtimer(CALLBACK(src, PROC_REF(zone_control_sixteen), target, next_cycle), 0.5 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/zone_control_sixteen(atom/target, var/next_cycle)
	if(!target)
		return
	rightfour(target)
	leftfour(target)
	uptwo_leftfour(target)
	uptwo_rightfour(target)
	downtwo_leftfour(target)
	downtwo_rightfour(target)
	attackcycle = next_cycle


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

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/miniburst_b(atom/target, var/next_cycle)
	if(!target)
		return
	upfour_leftfour(target)
	upfour_rightfour(target)
	downfour_rightfour(target)
	downfour_leftfour(target)
	attackcycle = next_cycle

/mob/living/simple_mob/mechanical/mecha/eclipse/proc/teleport_attack(atom/target, var/next_cycle)
	// Teleport attack.
	if(!target)
		to_chat(src, span_warning("There's nothing to teleport to."))
		return FALSE

	var/list/nearby_things = range(4, target)
	var/list/valid_turfs = list()

	// All this work to just go to a non-dense tile.
	for(var/turf/potential_turf in nearby_things)
		var/valid_turf = TRUE
		if(potential_turf.density)
			continue
		for(var/atom/movable/AM in potential_turf)
			if(AM.density)
				valid_turf = FALSE
		if(valid_turf)
			valid_turfs.Add(potential_turf)

	if(!(valid_turfs.len))
		to_chat(src, span_warning("There wasn't an unoccupied spot to teleport to."))
		return FALSE

	var/turf/target_turf = pick(valid_turfs)
	var/turf/T = get_turf(src)

	var/datum/effect/effect/system/spark_spread/s1 = new /datum/effect/effect/system/spark_spread
	s1.set_up(5, 1, T)
	var/datum/effect/effect/system/spark_spread/s2 = new /datum/effect/effect/system/spark_spread
	s2.set_up(5, 1, target_turf)


	T.visible_message(span_warning("\The [src] vanishes!"))
	s1.start()

	forceMove(target_turf)
	playsound(target_turf, 'sound/effects/phasein.ogg', 50, 1)
	to_chat(src, span_notice("You teleport to \the [target_turf]."))

	target_turf.visible_message(span_warning("\The [src] appears!"))
	s2.start()
	attackcycle = next_cycle

/mob/living/simple_mob/mechanical/mecha/eclipse/sniper
=======
/mob/living/simple_mob/mechanical/mecha/eclipse/sniper //one last stand
>>>>>>> e5c574285d (Tyr Update 9000 (#11107))
	name = "Eclipse Lead Pilot"
	icon_state = "captian"
	icon_living = "captian"
	health = 200
	maxHealth = 200
	ai_holder_type = /datum/ai_holder/simple_mob/intentional/three_phases
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 50, bio = 100, rad = 100)
	specialattackprojectile = /obj/item/projectile/arc/explosive_rocket
	wreckage = /obj/item/prop/tyrlore/truegoal
	has_repair_droid = FALSE

/mob/living/simple_mob/mechanical/mecha/eclipse/sniper/do_special_attack(atom/A)
	. = TRUE
	if(attackcycle == 1)
		addtimer(CALLBACK(src, PROC_REF(teleport_attack), A, 2, 4), 0.5 SECONDS, TIMER_DELETE_ME)
		attackcycle = 0
	else if(attackcycle == 2)
		specialattackprojectile = /obj/item/projectile/beam/heavylaser/cannon
		Beam(A, icon_state = "solar_beam", time = 0.75 SECONDS, maxdistance = INFINITY)
		addtimer(CALLBACK(src, PROC_REF(singleproj), A, 1), 1 SECOND, TIMER_DELETE_ME)
		attackcycle = 0

/mob/living/simple_mob/mechanical/mecha/eclipse/battle_top
	name = "eclipse cryo top"
	icon_state = "mecha_top"
	icon_living = "mecha_top"
	armor = list(melee = 20, bullet = 20, laser = 20, energy = 20, bomb = 80, bio = 100, rad = 100) //Smol armor to compensate for the gimmick
	deflect_chance = 100 //yes, this looks absurd
	wreckage = /obj/item/melee/energy/sword/top_shield
	specialattackprojectile = /obj/item/projectile/energy/eclipse/chillingwind
	desc = "It appears to be spinning at rapid speeds; enough to deflect projectiles. The air around it feels frigid.."

/mob/living/simple_mob/mechanical/mecha/eclipse/battle_top/do_special_attack(atom/A)
	var/rng_cycle
	if(attackcycle == 1)
		rng_cycle = rand(1,2)
		addtimer(CALLBACK(src, PROC_REF(quad_random_firing), A, 20, rng_cycle, 25), 0.5 SECONDS, TIMER_DELETE_ME)
		attackcycle = 0
	else if(attackcycle == 2)
		rng_cycle = rand(1,2)
		addtimer(CALLBACK(src, PROC_REF(dual_spin), A, rng_cycle, 15), 0.5 SECONDS, TIMER_DELETE_ME)
		attackcycle = 0

/mob/living/simple_mob/mechanical/mecha/eclipse/battle_top/bullet_act(obj/item/projectile/P)
	..()
	if(deflect_chance > 30)
		visible_message(span_cult("The mecha is deflecting most projectiles!."))

/mob/living/simple_mob/mechanical/mecha/eclipse/battle_top/attackby(var/obj/item/O as obj, var/mob/user as mob) //but melees lowers the deflect chance
	.=..()
	if(deflect_chance > 10)
		to_chat(user, span_cult("The strike slows down the mecha!."))
		deflect_chance -= 10

/mob/living/simple_mob/mechanical/mecha/eclipse/excavate_head
	name = "Xenoarch Lead"
	desc = "A unathi wearing what appears to be a modified breacher suit. Something seems off though"
	icon_state = "cursor_guard"
	icon_living = "cursor_guard"
	armor = list(melee = 80, bullet = 80, laser = 80, energy = 80, bomb = 80, bio = 100, rad = 100)
	pilot_type = /obj/item/prop/tyrlore/stolenbreacher
	wreckage = /obj/item/pickaxe/diamonddrill/alien
	specialattackprojectile = /obj/item/projectile/energy/eclipse/mining
	desc = "A being wearing what appears to be a modified breacher outfit."
	projectiletype = /obj/item/projectile/arc/explosive_rocket
	ranged_cooldown = 50


/mob/living/simple_mob/mechanical/mecha/eclipse/excavate_head/updatehealth()
	. = ..()
	if(health < maxHealth*0.3)
		armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 100, rad = 100)
	else if(health < maxHealth*0.6)
		armor = list(melee = 30, bullet = 30, laser = 30, energy = 30, bomb = 30, bio = 100, rad = 100)
	else if (health < maxHealth*0.9)
		armor = list(melee = 60, bullet = 60, laser = 60, energy = 50, bomb = 60, bio = 100, rad = 100)


/mob/living/simple_mob/mechanical/mecha/eclipse/excavate_head/do_special_attack(atom/A)
	var/rng_cycle
	switch(a_intent)
		if(I_DISARM) //phase3
			if(attackcycle == 1)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 20, rng_cycle, 10), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(dual_spin), A, rng_cycle, 10), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				rng_cycle = rand(1,3)
				Beam(A, icon_state = "solar_beam", time = 2 SECONDS, maxdistance = INFINITY)
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, rng_cycle), 2 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0

		if(I_HURT) //phase1
			if(attackcycle == 1)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 8, rng_cycle, 15), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(cross_spin), A, rng_cycle, 15), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				rng_cycle = rand(1,3)
				Beam(A, icon_state = "solar_beam", time = 2 SECONDS, maxdistance = INFINITY)
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, rng_cycle), 2 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
		if(I_GRAB) // Phase 2
			if(attackcycle == 1)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(random_firing), A, 12, rng_cycle, 10), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 2)
				rng_cycle = rand(1,3)
				addtimer(CALLBACK(src, PROC_REF(cross_spin), A, rng_cycle, 10), 0.5 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0
			else if(attackcycle == 3)
				rng_cycle = rand(1,3)
				Beam(A, icon_state = "solar_beam", time = 1.5 SECONDS, maxdistance = INFINITY)
				addtimer(CALLBACK(src, PROC_REF(singleproj), A, rng_cycle), 1 SECONDS, TIMER_DELETE_ME)
				attackcycle = 0

