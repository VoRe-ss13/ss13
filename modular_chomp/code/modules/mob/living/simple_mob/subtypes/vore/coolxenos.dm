// Chomp version of a xeno. Uses the thicc sprites for the queen - has a couple little custom abilities too.
// Thanks to BlackMajor for much guidance / stealing stuff from his bigdragon mob
// 06/07/2024: Sprite changes to TGMC/CM and more castes (experimental). Increased expected sprite size from 32x32 to 48x48 and 64x64 for larger castes. - Aroliacue
// If you are not sure what a variable does, please refer to "code\modules\mob\living\simple_mob\simple_mob.dm". Everything there is commented!

// Base type (Mostly initialises as an ability-less xeno hunter)
/mob/living/simple_mob/xeno_ch
	name = "badly spawned xenomorph"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. You probably shouldn't be seeing this, please contact an admin."

	icon = 'modular_chomp/icons/mob/48x48_xenos.dmi'
	vis_height = 48
	faction = "xeno"
	ui_icons = 'icons/mob/screen1_alien.dmi'
	hand_form = "claws"

//// This segment includes the intro blurb for players joining this mob and language settings. ////

	player_msg = ""
	has_langs = list(LANGUAGE_XENOLINGUA,LANGUAGE_HIVEMIND)// Text name of their language if they speak something other than galcom. They speak the first one by default.
	understands_common = 0 // Xenomorphs will not be able to understand Galcom without admin intervention.

//// This segment includes base health, damage and other special values for the Chompstation Xenomorph simplemobs. Different castes may have different values. ////

// HEALTH //
	maxHealth = 250
	health = 250
	armor = list(
				"melee" = 15,
				"bullet" = 10,
				"laser" = 5,
				"energy" = 10,
				"bomb" = 10,
				"bio" = 100,
				"rad" = 100
				)
	grab_resist = 50 // Probability check for a grab attempt to fail. 100 is full immunity.
	damage_fatigue_mult = 0 // No slowdown from low health values.

// ENVIRONMENTAL - These should stay at 0. //
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	heat_resist = 0.0
	cold_resist = 1.0
	shock_resist = 0.5
	water_resist = 1.0
	poison_resist = 1.0

// DAMAGE //
	melee_damage_lower = 15 // Keep the lower/upper values the same for consistent damage, easier to balance than RNG.
	melee_damage_upper = 15
	attack_sound = 'modular_chomp/sound/weapons/alien_claw_flesh1.ogg'
	attack_sharp = TRUE
	melee_miss_chance = 0 // Missing attacks is gay. NPC variants will have a miss chance to make them a little less punishing.

// OTHER //
	movement_cooldown = 0 // Determines movespeed. Negative values are faster.
	see_in_dark = 10 // Night vision. This value should never change.
	has_hands = TRUE // Lets Xenomorphs hold most items.

// VORE //
	vore_active = 0
	vore_capacity = 2
	vore_pounce_chance = 50
	vore_icons = null

//// This segment includes intent interactions. ////

	response_help = "pats"
	response_disarm = "tries to shove"
	response_harm = "hits"
	attacktext = list("slashed", "tailstabbed", "maimed", "bitten")
	friendly = list("nuzzles", "caresses", "headbumps against", "leans against", "nibbles affectionately on")
	speech_sounds = list(	'sound/voice/hiss1.ogg',
							'sound/voice/hiss2.ogg',
							'sound/voice/hiss3.ogg',
							'sound/voice/hiss4.ogg',
							'sound/voice/hiss5.ogg')

	can_enter_vent_with = list(	/obj/item/weapon/implant,
								/obj/item/device/radio/borg,
								/obj/item/weapon/holder,
								/obj/machinery/camera,
								/obj/belly,
								/obj/screen,
								/atom/movable/emissive_blocker,
								/obj/item/weapon/material,
								/obj/item/weapon/melee,
								/obj/item/stack/,
								/obj/item/weapon/tool,
								/obj/item/weapon/reagent_containers/food,
								/obj/item/weapon/coin,
								/obj/item/weapon/aliencoin,
								/obj/item/weapon/ore,
								/obj/item/weapon/disk/nuclear,
								/obj/item/toy,
								/obj/item/weapon/card,
								/obj/item/device/radio,
								/obj/item/device/perfect_tele_beacon,
								/obj/item/weapon/clipboard,
								/obj/item/weapon/paper,
								/obj/item/weapon/pen,
								/obj/item/canvas,
								/obj/item/paint_palette,
								/obj/item/paint_brush,
								/obj/item/device/camera,
								/obj/item/weapon/photo,
								/obj/item/device/camera_film,
								/obj/item/device/taperecorder,
								/obj/item/device/tape)

	var/xeno_build_time = 5 //time to build a structure

	//HUD
	var/datum/action/innate/xeno_ch/xeno_build/build_action = new
	var/datum/action/innate/xeno_ch/xeno_neuro/neurotox_action = new
	var/datum/action/innate/xeno_ch/xeno_acidspit/acidspit_action = new
	var/datum/action/innate/xeno_ch/xeno_corrode/corrode_action = new
	var/datum/action/innate/xeno_ch/xeno_pounce/pounce_action = new
	var/datum/action/innate/xeno_ch/xeno_spin/spin_action = new

	can_be_drop_prey = FALSE //CHOMP Add

/mob/living/simple_mob/xeno_ch/Initialize()
	..()
	src.adjust_nutrition(src.max_nutrition)
	sight |= SEE_MOBS

/mob/living/simple_mob/xeno_ch/Initialize(mapload)
    .=..()
    LoadComponent(/datum/component/squeak, list('modular_chomp/sound/effects/footstep/hardclaw1.ogg'), 50)

/mob/living/simple_mob/xeno_ch/Login()
	. = ..()
	faction = "neutral"
	add_verb(src,/mob/living/simple_mob/verb/toggle_speech_sounds) //CHOMPEdit TGPanel

////// TIER ONE XENOMORPH CASTES //////

/// XENOMORPH LARVA /// - WIP

/mob/living/simple_mob/xeno_ch/larva
	name = "xenomorph larva"
	desc = "A xenomorph larva."

	movement_cooldown = -1
	icon = 'modular_chomp/icons/mob/1x1_xenos.dmi'
	icon_dead = "Larva Dead"
	icon_living = "Larva Moving"
	icon_rest = "Larva Sleeping"
	icon_state = "Larva Moving"
	pixel_x = 0
	default_pixel_x = 0
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Larva Running"
	icon_pounce = 'modular_chomp/icons/mob/1x1_xenos.dmi'
	icon_state_pounce = "Larva Running"

	ai_holder_type = /datum/ai_holder/simple_mob/xenolarva

	melee_damage_lower = 5
	melee_damage_upper = 5
	maxHealth = 15
	health = 15
	armor = list(
				"melee" = 0,
				"bullet" = 0,
				"laser" = 0,
				"energy" = 0,
				"bomb" = 0,
				"bio" = 100,
				"rad" = 100
				)

/datum/ai_holder/simple_mob/xenolarva
	hostile = TRUE
	retaliate = TRUE
	can_flee = TRUE
	dying_threshold = 1
	flee_when_outmatched = TRUE
	outmatched_threshold = 25

/// XENOMORPH DRONE /// - Basic xenomorph caste.

/mob/living/simple_mob/xeno_ch/drone
	name = "xenomorph drone"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle."

	movement_cooldown = -0.5
	icon = 'modular_chomp/icons/mob/48x48_xenos.dmi'
	icon_dead = "Drone Dead"
	icon_living = "Drone Walking"
	icon_rest = "Drone Sleeping"
	icon_state = "Drone Walking"
	pixel_x = -12
	default_pixel_x = -12
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Drone Running"
	icon_pounce = 'modular_chomp/icons/mob/48x48_xenos.dmi'
	icon_state_pounce = "Drone Running"

	ai_holder_type = /datum/ai_holder/simple_mob/melee

	melee_damage_lower = 15
	melee_damage_upper = 15
	maxHealth = 125
	health = 125
	armor = list(
				"melee" = 5,
				"bullet" = 0,
				"laser" = 0,
				"energy" = 0,
				"bomb" = 0,
				"bio" = 100,
				"rad" = 100
				)

/// XEMOMORPH RUNNER /// - Rouny & Pamfer

/mob/living/simple_mob/xeno_ch/runner
	name = "xenomorph runner"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. This one appears to be dog-like, and especially fast."

	movement_cooldown = -3
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Runner Dead"
	icon_living = "Runner Walking"
	icon_rest = "Runner Sleeping"
	icon_state = "Runner Walking"

	icon_state_prepounce = "Runner Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Runner Running"

	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0

	ai_holder_type = /datum/ai_holder/simple_mob/melee/evasive

	melee_damage_lower = 15
	melee_damage_upper = 15
	melee_attack_delay = 0
	maxHealth = 125
	health = 125
	armor = list(
				"melee" = 15,
				"bullet" = 10,
				"laser" = 5,
				"energy" = 10,
				"bomb" = 10,
				"bio" = 100,
				"rad" = 100
				)

	special_attack_min_range = 1
	special_attack_max_range = 7
	special_attack_cooldown = 5 SECONDS

	var/leap_warmup = 0.2 SECOND // How long the leap telegraphing is.
	var/leap_sound = 'sound/weapons/spiderlunge.ogg' //Temporary. -- Serdy

/mob/living/simple_mob/xeno_ch/runner/apply_bonus_melee_damage(atom/A, damage_amount)
	if(isliving(A))
		var/mob/living/L = A
		if(L.incapacitated(INCAPACITATION_DISABLED))
			return damage_amount * 1.5
	return ..()

/mob/living/simple_mob/xeno_ch/runner/do_special_attack(atom/A) //Yoinked from the spiders originally. Could probably be implemented better. -- Serdy
	set waitfor = FALSE
	set_AI_busy(TRUE)

	do_windup_animation(A, leap_warmup)
	sleep(leap_warmup) // For the telegraphing.

	status_flags |= LEAPING
	visible_message(span("danger","\The [src] leaps at \the [A]!"))
	throw_at(get_step(get_turf(A), get_turf(src)), special_attack_max_range+1, 1, src)
	playsound(src, leap_sound, 75, 1)

	sleep(5)

	if(status_flags & LEAPING)
		status_flags &= ~LEAPING

	var/turf/T = get_turf(src)

	. = FALSE

	// Now for the stun.
	var/mob/living/victim = null
	for(var/mob/living/L in T)
		if(L == src)
			continue

		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			if(H.check_shields(damage = 0, damage_source = src, attacker = src, def_zone = null, attack_text = "the leap"))
				continue // We were blocked.

		victim = L
		break

	if(victim)
		victim.Weaken(2)
		victim.visible_message(span("danger","\The [src] knocks down \the [victim]!"))
		to_chat(victim, span("critical", "\The [src] jumps on you!"))
		. = TRUE

	set_AI_busy(FALSE)


/mob/living/simple_mob/xeno_ch/runner/panther
	name = "xenomorph panther"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. This one appears to be cat-like, and especially fast."
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Panther Dead"
	icon_living = "Panther Walking"
	icon_rest = "Panther Sleeping"
	icon_state = "Panther Walking"
	icon_state_prepounce = "Panther Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Panther Running"
	melee_attack_delay = 0.5
	var/poison_type = "spidertoxin"	// The reagent that gets injected when it attacks.
	var/poison_chance = 100			// Chance for injection to occur.
	var/poison_per_bite = 5			// Amount added per injection.

/mob/living/simple_mob/xeno_ch/runner/panther/apply_melee_effects(var/atom/A)
	if(isliving(A))
		var/mob/living/L = A
		if(L.reagents)
			var/target_zone = pick(BP_TORSO,BP_TORSO,BP_TORSO,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_HEAD)
			if(L.can_inject(src, null, target_zone))
				inject_poison(L, target_zone)

/mob/living/simple_mob/xeno_ch/runner/panther/proc/inject_poison(mob/living/L, target_zone)
	if(prob(poison_chance))
		to_chat(L, "<span class='warning'>You feel a sharp burning pain as the panther claws you!</span>")
		L.reagents.add_reagent(poison_type, poison_per_bite)



/// XENOMORPH DEFENDER /// - WIP

/mob/living/simple_mob/xeno_ch/defender
	name = "xenomorph defender"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. This one is quite heavily armored."

	movement_cooldown = 0
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Defender Dead"
	icon_living = "Defender Walking"
	icon_rest = "Defender Sleeping"
	icon_state = "Defender Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Defender Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Defender Running"

	ai_holder_type = /datum/ai_holder/simple_mob/melee

	melee_damage_lower = 15
	melee_damage_upper = 15
	maxHealth = 300
	health = 300
	armor = list(			// Values for normal getarmor() checks
				"melee" = 30,
				"bullet" = 25,
				"laser" = 10, //Weak to lasers
				"energy" = 10,
				"bomb" = 50,
				"bio" = 100,
				"rad" = 100
				)
	armor_soak = list(		// Values for getsoak() checks.
				"melee" = 5,
				"bullet" = 5,
				"laser" = 0,
				"energy" = 5,
				"bomb" = 5,
				"bio" = 0,
				"rad" = 0
				)

/// XENOMORPH HUNTER /// - The Hunter's role in the hive is as the name suggests: They aggressively and stealthily hunt down targets, usually lone crewmembers.

/mob/living/simple_mob/xeno_ch/hunter
	name = "xenomorph hunter"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. This one appears to be smaller and more agile than the rest."

	movement_cooldown = -1
	icon = 'modular_chomp/icons/mob/48x48_xenos.dmi'
	icon_dead = "Hunter Dead"
	icon_living = "Hunter Walking"
	icon_rest = "Hunter Sleeping"
	icon_state = "Hunter Walking"
	pixel_x = 0
	default_pixel_x = 0
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Hunter Running"
	icon_pounce = 'modular_chomp/icons/mob/48x48_xenos.dmi'
	icon_state_pounce = "Hunter Running"
	icon_overlay_spit = "alienspit"
	icon_overlay_spit_pounce = "alienspit_leap"

	ai_holder_type = /datum/ai_holder/simple_mob/melee

	melee_damage_lower = 25
	melee_damage_upper = 25
	maxHealth = 200
	health = 200
	armor = list(
				"melee" = 15,
				"bullet" = 10,
				"laser" = 5,
				"energy" = 10,
				"bomb" = 10,
				"bio" = 100,
				"rad" = 100
				)

	special_attack_min_range = 1
	special_attack_max_range = 7
	special_attack_cooldown = 5 SECONDS

	var/leap_warmup = 0.5 SECOND // How long the leap telegraphing is.
	var/leap_sound = 'sound/weapons/spiderlunge.ogg' //Temporary. -- Serdy

/mob/living/simple_mob/xeno_ch/hunter/apply_bonus_melee_damage(atom/A, damage_amount)
	if(isliving(A))
		var/mob/living/L = A
		if(L.incapacitated(INCAPACITATION_DISABLED))
			return damage_amount * 1.5
	return ..()

/mob/living/simple_mob/xeno_ch/hunter/do_special_attack(atom/A) //Yoinked from the spiders originally. Could probably be implemented better. -- Serdy
	set waitfor = FALSE
	set_AI_busy(TRUE)

	do_windup_animation(A, leap_warmup)
	sleep(leap_warmup) // For the telegraphing.

	status_flags |= LEAPING
	visible_message(span("danger","\The [src] leaps at \the [A]!"))
	throw_at(get_step(get_turf(A), get_turf(src)), special_attack_max_range+1, 1, src)
	playsound(src, leap_sound, 75, 1)

	sleep(5)

	if(status_flags & LEAPING)
		status_flags &= ~LEAPING

	var/turf/T = get_turf(src)

	. = FALSE

	// Now for the stun.
	var/mob/living/victim = null
	for(var/mob/living/L in T)
		if(L == src)
			continue

		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			if(H.check_shields(damage = 0, damage_source = src, attacker = src, def_zone = null, attack_text = "the leap"))
				continue // We were blocked.

		victim = L
		break

	if(victim)
		victim.Weaken(2)
		victim.visible_message(span("danger","\The [src] knocks down \the [victim]!"))
		to_chat(victim, span("critical", "\The [src] jumps on you!"))
		. = TRUE

	set_AI_busy(FALSE)

/mob/living/simple_mob/xeno_ch/hunter/Login()
	. = ..()
	add_verb(src,/mob/living/simple_mob/proc/pounce_toggle) //CHOMPEdit TGPanel
	add_verb(src,/mob/living/proc/ventcrawl) //CHOMPEdit TGPanel
	add_verb(src,/mob/living/proc/hide) //CHOMPEdit TGPanel
	pounce_action.Grant(src)

/// XENOMORPH SENTINEL /// - The Sentinel serves as a flexible, ranged offensive/defensive caste.

/mob/living/simple_mob/xeno_ch/sentinel
	name = "xenomorph spitter"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. A small, spitting sort of xenomorph."

	movement_cooldown = 0
	icon = 'modular_chomp/icons/mob/48x48_xenos.dmi'
	icon_dead = "Sentinel Dead"
	icon_living = "Sentinel Walking"
	icon_rest = "Sentinel Sleeping"
	icon_state = "Sentinel Walking"
	pixel_x = -12
	default_pixel_x = -12
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Sentinel Running"
	icon_pounce = 'modular_chomp/icons/mob/48x48_xenos.dmi'
	icon_state_pounce = "Sentinel Running"

	ai_holder_type = /datum/ai_holder/simple_mob/ranged

	base_attack_cooldown = 10
	projectilesound = 'modular_chomp/sound/voice/alien_spitacid.ogg'
	projectiletype = /obj/item/projectile/energy/acid/ch/weak

	melee_damage_lower = 15
	melee_damage_upper = 15
	maxHealth = 100
	health = 100
	armor = list(			// Values for normal getarmor() checks
				"melee" = 10,
				"bullet" = 10,
				"laser" = 0, //Weak to lasers
				"energy" = 10,
				"bomb" = 20,
				"bio" = 100,
				"rad" = 100
				)

/mob/living/simple_mob/xeno_ch/sentinel/Login()
	. = ..()
	add_verb(src,/mob/living/simple_mob/proc/neurotoxin) //CHOMPEdit TGPanel
	add_verb(src,/mob/living/simple_mob/proc/acidspit) //CHOMPEdit TGPanel
	add_verb(src,/mob/living/simple_mob/proc/corrosive_acid) //CHOMPEdit TGPanel
	neurotox_action.Grant(src)
	acidspit_action.Grant(src)
	corrode_action.Grant(src)

////// TIER TWO XENOMORPH CASTES //////

/// XENOMORPH WARRIOR /// - The GOAT.

/mob/living/simple_mob/xeno_ch/warrior
	name = "xenomorph warrior"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. This one is clearly a lean, agile, powerful fighter."

	movement_cooldown = -0.5
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Warrior Dead"
	icon_living = "Warrior Walking"
	icon_rest = "Warrior Sleeping"
	icon_state = "Warrior Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Warrior Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Warrior Running"

	ai_holder_type = /datum/ai_holder/simple_mob/melee

	melee_damage_lower = 25
	melee_damage_upper = 25
	maxHealth = 400
	health = 400
	armor = list(			// Values for normal getarmor() checks
				"melee" = 10,
				"bullet" = 10,
				"laser" = 0, //Weak to lasers
				"energy" = 10,
				"bomb" = 20,
				"bio" = 100,
				"rad" = 100
				)

/// XENOMORPH SPITTER /// - WIP

/mob/living/simple_mob/xeno_ch/spitter
	name = "xenomorph spitter"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. A small, spitting sort of xenomorph."

	movement_cooldown = 0
	icon = 'modular_chomp/icons/mob/48x48_xenos.dmi'
	icon_dead = "Spitter Dead"
	icon_living = "Spitter Walking"
	icon_rest = "Spitter Sleeping"
	icon_state = "Spitter Walking"
	pixel_x = -12
	default_pixel_x = -12
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Spitter Running"
	icon_pounce = 'modular_chomp/icons/mob/48x48_xenos.dmi'
	icon_state_pounce = "Spitter Running"

	ai_holder_type = /datum/ai_holder/simple_mob/ranged

	base_attack_cooldown = 10
	projectilesound = 'modular_chomp/sound/voice/alien_spitacid.ogg'
	projectiletype = /obj/item/projectile/energy/acid/ch

	melee_damage_lower = 15
	melee_damage_upper = 15
	maxHealth = 150
	health = 150
	armor = list(			// Values for normal getarmor() checks
				"melee" = 10,
				"bullet" = 10,
				"laser" = 0, //Weak to lasers
				"energy" = 10,
				"bomb" = 20,
				"bio" = 100,
				"rad" = 100
				)

/mob/living/simple_mob/xeno_ch/wraith
	name = "xenomorph wraith"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. This one seems to shift unnaturally, as if between realms at all times..."

	movement_cooldown = -0.5
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Wraith Dead"
	icon_living = "Wraith Walking"
	icon_rest = "Wraith Sleeping"
	icon_state = "Wraith Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Wraith Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Wraith Running"

	ai_holder_type = /datum/ai_holder/simple_mob/melee/evasive

	melee_damage_lower = 25
	melee_damage_upper = 25
	maxHealth = 200
	health = 200
	armor = list(			// Values for normal getarmor() checks
				"melee" = 10,
				"bullet" = 10,
				"laser" = 0, //Weak to lasers
				"energy" = 10,
				"bomb" = 20,
				"bio" = 100,
				"rad" = 100
				)


/mob/living/simple_mob/xeno_ch/wraith
	ai_holder_type = /datum/ai_holder/simple_mob/melee/evasive
	var/jaunt_warning = 0.5 SECONDS	// How long the jaunt telegraphing is.
	var/jaunt_tile_speed = 20		// How long to wait between each tile. Higher numbers result in an easier to dodge tunnel attack.
	special_attack_min_range = 2
	special_attack_max_range = 6
	special_attack_cooldown = 10 SECONDS

/mob/living/simple_mob/xeno_ch/wraith/jaunt_spam
	special_attack_cooldown = 5 SECONDS

/mob/living/simple_mob/xeno_ch/wraith/fast_jaunt //Teleports behind you
	jaunt_tile_speed = 2

/mob/living/simple_mob/xeno_ch/wraith/do_special_attack(atom/A)
	set waitfor = FALSE
	set_AI_busy(TRUE)

	// Save where we're gonna go soon.
	var/turf/destination = get_turf(A)
	var/turf/starting_turf = get_turf(src)

	// Telegraph to give a small window to dodge if really close.
	flick("phase_shift",A)
	icon_state = "Wraith Running"
	sleep(jaunt_warning) // For the telegraphing.

	// Do the dig!
	visible_message(span("danger","\The [src] vanishes into thin air towards [A]!"))
	flick("phase_shift",A)
	icon_state = "Wraith Running"

	if(handle_jaunt(destination) == FALSE)
		set_AI_busy(FALSE)
		flick("phase_shift2",A)
		icon_state = "Wraith Running"
		return FALSE

	// Did we make it?
	if(!(src in destination))
		set_AI_busy(FALSE)
		icon_state = "Wraith Running"
		flick("phase_shift2",A)
		return FALSE

	var/overshoot = TRUE

	// Test if something is at destination.
	for(var/mob/living/L in destination)
		if(L == src)
			continue

		visible_message(span("danger","\The [src] appears in a flurry of slashes at [L]!"))
		playsound(L, 'sound/weapons/heavysmash.ogg', 75, 1)
		L.add_modifier(/datum/modifier/entangled, 1 SECONDS) //L.Weaken(3) CHOMPedit: Trying to remove hardstuns
		overshoot = FALSE

	if(!overshoot) // We hit the target, or something, at destination, so we're done.
		set_AI_busy(FALSE)
		icon_state = "Wraith Running"
		flick("phase_shift2",A)
		return TRUE

	// Otherwise we need to keep going.
	to_chat(src, span("warning", "You overshoot your target!"))
	playsound(src, 'sound/weapons/punchmiss.ogg', 75, 1)
	var/dir_to_go = get_dir(starting_turf, destination)
	for(var/i = 1 to rand(2, 4))
		destination = get_step(destination, dir_to_go)

	if(handle_jaunt(destination) == FALSE)
		set_AI_busy(FALSE)
		icon_state = "Wraith Running"
		flick("phase_shift2",A)
		return FALSE

	set_AI_busy(FALSE)
	icon_state = "Wraith Running"
	flick("phase_shift2",A)
	return FALSE

// Does the jaunt movement
/mob/living/simple_mob/xeno_ch/wraith/proc/handle_jaunt(turf/destination)
	var/turf/T = get_turf(src) // Hold our current tile.

	// Regular tunnel loop.
	for(var/i = 1 to get_dist(src, destination))
		if(stat)
			return FALSE // We died or got knocked out on the way.
		if(loc == destination)
			break // We somehow got there early.

		// Update T.
		T = get_step(src, get_dir(src, destination))
		if(T.check_density(ignore_mobs = TRUE))
			to_chat(src, span("critical", "You hit something really solid!"))
			playsound(src, "punch", 75, 1)
			Weaken(5)
			add_modifier(/datum/modifier/tunneler_vulnerable, 10 SECONDS)
			return FALSE // Hit a wall.

		// Get into the tile.
		forceMove(T)


/mob/living/simple_mob/xeno_ch/wraith/should_special_attack(atom/A)
	// Make sure its possible for the wraith to reach the target so it doesn't try to go through a window.
	var/turf/destination = get_turf(A)
	var/turf/starting_turf = get_turf(src)
	var/turf/T = starting_turf
	for(var/i = 1 to get_dist(starting_turf, destination))
		if(T == destination)
			break

		T = get_step(T, get_dir(T, destination))
		if(T.check_density(ignore_mobs = TRUE))
			return FALSE
	return T == destination

/// XENOMORPH HIVELORD /// - Drone 2

/mob/living/simple_mob/xeno_ch/hivelord
	name = "xenomorph hivelord"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. The next step in a drone's life. Master of building hives."

	movement_cooldown = 0
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Hivelord Dead"
	icon_living = "Hivelord Walking"
	icon_rest = "Hivelord Sleeping"
	icon_state = "Hivelord Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Hivelord Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Hivelord Running"

	ai_holder_type = /datum/ai_holder/simple_mob/melee

	melee_damage_lower = 15
	melee_damage_upper = 15
	maxHealth = 300
	health = 300
	armor = list(			// Values for normal getarmor() checks
				"melee" = 10,
				"bullet" = 10,
				"laser" = 0, //Weak to lasers
				"energy" = 10,
				"bomb" = 20,
				"bio" = 100,
				"rad" = 100
				)

////// TIER THREE XENOMORPH CASTES //////

/// XENOMORPH CHARGER /// - WIP

/mob/living/simple_mob/xeno_ch/crusher
	name = "xenomorph crusher"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. A tank with four legs."

	movement_cooldown = 1
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Crusher Dead"
	icon_living = "Crusher Walking"
	icon_rest = "Crusher Sleeping"
	icon_state = "Crusher Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Crusher Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Crusher Running"

	ai_holder_type = /datum/ai_holder/simple_mob/melee

	melee_damage_lower = 15
	melee_damage_upper = 15
	maxHealth = 900
	health = 900
	armor = list(			// Values for normal getarmor() checks
				"melee" = 30,
				"bullet" = 25,
				"laser" = 10, //Weak to lasers
				"energy" = 10,
				"bomb" = 50,
				"bio" = 100,
				"rad" = 100
				)
	armor_soak = list(		// Values for getsoak() checks.
				"melee" = 5,
				"bullet" = 5,
				"laser" = 0,
				"energy" = 5,
				"bomb" = 5,
				"bio" = 0,
				"rad" = 0
				)


/// XENOMORPH PRAETORIAN /// - WIP


/mob/living/simple_mob/xeno_ch/praetorian
	name = "xenomorph praetorian"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. A huge spitting sort of xenomorph. Very imposing, usually only spotted in the presence of the queen."

	movement_cooldown = 0
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Praetorian Dead"
	icon_living = "Praetorian Walking"
	icon_rest = "Praetorian Sleeping"
	icon_state = "Praetorian Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Praetorian Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Praetorian Running"

	ai_holder_type = /datum/ai_holder/simple_mob/ranged

	base_attack_cooldown = 10
	projectilesound = 'modular_chomp/sound/voice/alien_spitacid.ogg'
	projectiletype = /obj/item/projectile/energy/acid/ch

	melee_damage_lower = 15
	melee_damage_upper = 15
	maxHealth = 300
	health = 300
	armor = list(			// Values for normal getarmor() checks
				"melee" = 10,
				"bullet" = 10,
				"laser" = 0, //Weak to lasers
				"energy" = 10,
				"bomb" = 20,
				"bio" = 100,
				"rad" = 100
				)

/// XENOMORPH RAVAGER /// - Will rip you to shreds.

/mob/living/simple_mob/xeno_ch/ravager
	name = "xenomorph ravager"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. This one is big, red, and has hands like giant scythes."

	movement_cooldown = 0
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Ravager Dead"
	icon_living = "Ravager Walking"
	icon_rest = "Ravager Sleeping"
	icon_state = "Ravager Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Ravager Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Ravager Running"

	ai_holder_type = /datum/ai_holder/simple_mob/melee

	melee_damage_lower = 50
	melee_damage_upper = 50
	maxHealth = 600
	health = 600
	armor = list(			// Values for normal getarmor() checks
				"melee" = 10,
				"bullet" = 10,
				"laser" = 0, //Weak to lasers
				"energy" = 10,
				"bomb" = 20,
				"bio" = 100,
				"rad" = 100
				)
/*
/mob/living/simple_mob/xeno_ch/dragon
	name = "xenomorph dragon"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. This is what you get when a xenomorph embryo infects a firebreathing dragon."

	movement_cooldown = 1
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Dragon Dead"
	icon_living = "Dragon Walking"
	icon_rest = "Dragon Sleeping"
	icon_state = "Dragon Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Dragon Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Dragon Running"
	ai_holder_type = /datum/ai_holder/simple_mob/intentional/dragon
	melee_damage_lower = 60
	melee_damage_upper = 60
	maxHealth = 2000
	health = 2000
	armor = list(			// Values for normal getarmor() checks
				"melee" = 20,
				"bullet" = 20,
				"laser" = 30, //NOT weak to lasers
				"energy" = 10,
				"bomb" = 20,
				"bio" = 100,
				"rad" = 100
				)

*/ /// - Commented out till i can figure out how to get em to use firebreath and stuff. - Serdy

////// HIVE LEADER CASTES //////

/// XENOMORPH QUEEN /// - The Queen leads and expands the hive.

/mob/living/simple_mob/xeno_ch/queen
	name = "xenomorph queen"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. In hive society, this is the queen."

	movement_cooldown = 1
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Queen Dead"
	icon_living = "Queen Walking"
	icon_rest = "Queen Sleeping"
	icon_state = "Queen Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Queen Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Queen Running"

	ai_holder_type = /datum/ai_holder/simple_mob/melee

	melee_damage_lower = 45
	melee_damage_upper = 45
	maxHealth = 900
	health = 900
	armor = list(			// Values for normal getarmor() checks
				"melee" = 30,
				"bullet" = 25,
				"laser" = 10, //Weak to lasers
				"energy" = 10,
				"bomb" = 50,
				"bio" = 100,
				"rad" = 100
				)
	armor_soak = list(		// Values for getsoak() checks.
				"melee" = 5,
				"bullet" = 5,
				"laser" = 0,
				"energy" = 5,
				"bomb" = 5,
				"bio" = 0,
				"rad" = 0
				)

/mob/living/simple_mob/xeno_ch/queen/maid

/// XENOMORPH SHRIKE /// - WIP

/mob/living/simple_mob/xeno_ch/shrike
	name = "xenomorph shrike"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. A huge psychic repository of a xeno-- Very dangerous."

	movement_cooldown = 0
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Shrike Dead"
	icon_living = "Shrike Walking"
	icon_rest = "Shrike Sleeping"
	icon_state = "Shrike Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Shrike Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Shrike Running"

	ai_holder_type = /datum/ai_holder/simple_mob/ranged

	base_attack_cooldown = 10
	projectiletype = /obj/item/projectile/sonic/strong

	melee_damage_lower = 15
	melee_damage_upper = 15
	maxHealth = 500
	health = 500
	armor = list(			// Values for normal getarmor() checks
				"melee" = 10,
				"bullet" = 10,
				"laser" = 0, //Weak to lasers
				"energy" = 10,
				"bomb" = 20,
				"bio" = 100,
				"rad" = 100
				)

/// XENOMORPH KING /// - The King assists the Queen in leading the hive, and is a very powerful combatant in its own right.

/mob/living/simple_mob/xeno_ch/king
	name = "xenomorph king"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. In hive society, this is the king."

	movement_cooldown = 1
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "King Dead"
	icon_living = "King Walking"
	icon_rest = "King Sleeping"
	icon_state = "King Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "King Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "King Running"

	ai_holder_type = /datum/ai_holder/simple_mob/melee

	melee_damage_lower = 45
	melee_damage_upper = 45
	maxHealth = 1200
	health = 1200
	armor = list(			// Values for normal getarmor() checks
				"melee" = 30,
				"bullet" = 25,
				"laser" = 10, //Weak to lasers
				"energy" = 10,
				"bomb" = 50,
				"bio" = 100,
				"rad" = 100
				)
	armor_soak = list(		// Values for getsoak() checks.
				"melee" = 5,
				"bullet" = 5,
				"laser" = 0,
				"energy" = 5,
				"bomb" = 5,
				"bio" = 0,
				"rad" = 0
				)

/// XENOMORPH DESTROYER & RED KING /// - Adminbus WIP

/mob/living/simple_mob/xeno_ch/destroyer
	name = "xenomorph destroyer"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. If you're seeing this, you're probably doomed."

	movement_cooldown = 1
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Destroyer Dead"
	icon_living = "Destroyer Walking"
	icon_rest = "Destroyer Sleeping"
	icon_state = "Destroyer Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Destroyer Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Destroyer Running"

	ai_holder_type = /datum/ai_holder/simple_mob/melee

	melee_damage_lower = 85
	melee_damage_upper = 85
	maxHealth = 3000
	health = 3000
	armor = list(			// Values for normal getarmor() checks
				"melee" = 30,
				"bullet" = 25,
				"laser" = 10, //Weak to lasers
				"energy" = 10,
				"bomb" = 50,
				"bio" = 100,
				"rad" = 100
				)
	armor_soak = list(		// Values for getsoak() checks.
				"melee" = 5,
				"bullet" = 5,
				"laser" = 0,
				"energy" = 5,
				"bomb" = 5,
				"bio" = 0,
				"rad" = 0
				)

/mob/living/simple_mob/xeno_ch/emperor
	name = "xenomorph emperor"
	desc = "An extraterrestrial hive-based endoparasitoid with a multi-staged life cycle. If you're seeing this, you're probably doomed."

	movement_cooldown = 1
	icon = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_dead = "Red King Dead"
	icon_living = "Red King Walking"
	icon_rest = "Red King Sleeping"
	icon_state = "Red King Walking"
	pixel_x = -16
	default_pixel_x = -16
	pixel_y = 0
	default_pixel_y = 0
	icon_state_prepounce = "Red King Running"
	icon_pounce = 'modular_chomp/icons/mob/2x2_xenos.dmi'
	icon_state_pounce = "Red King Running"

	ai_holder_type = /datum/ai_holder/simple_mob/melee

	melee_damage_lower = 85
	melee_damage_upper = 85
	maxHealth = 3000
	health = 3000
	armor = list(			// Values for normal getarmor() checks
				"melee" = 30,
				"bullet" = 25,
				"laser" = 10, //Weak to lasers
				"energy" = 10,
				"bomb" = 50,
				"bio" = 100,
				"rad" = 100
				)
	armor_soak = list(		// Values for getsoak() checks.
				"melee" = 5,
				"bullet" = 5,
				"laser" = 0,
				"energy" = 5,
				"bomb" = 5,
				"bio" = 0,
				"rad" = 0
				)