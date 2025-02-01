/datum/sprite_accessory/tail
    var/vore_tail_sprite_variant = ""
    var/belly_variant_when_loaf = FALSE
    var/fullness_icons = 0
    var/struggle_anim = FALSE
    var/bellies_icon_path = 'modular_chomp/icons/mob/vore/Taur_Bellies.dmi' //CHOMPEdit

/datum/riding/taur
	keytype = /obj/item/material/twohanded/riding_crop // Crack!
	nonhuman_key_exemption = FALSE	// If true, nonhumans who can't hold keys don't need them, like borgs and simplemobs.
	key_name = "a riding crop"		// What the 'keys' for the thing being rided on would be called.
	only_one_driver = TRUE			// If true, only the person in 'front' (first on list of riding mobs) can drive.

/datum/riding/taur/handle_vehicle_layer()
	if(ridden.has_buckled_mobs())
		ridden.layer = initial(ridden.layer)
	else
		var/mob/living/L = ridden
		if(!(istype(L) && (L.status_flags & HIDING)))
			ridden.layer = initial(ridden.layer)

/datum/riding/taur/ride_check(mob/living/M)
	var/mob/living/L = ridden
	if(L.stat)
		force_dismount(M)
		return FALSE
	return TRUE

/datum/riding/taur/force_dismount(mob/M)
	. = ..()
	ridden.visible_message(span_notice("[M] stops riding [ridden]!"))

//Hoooo boy.
/datum/riding/taur/get_offsets(pass_index) // list(dir = x, y, layer)
	var/mob/living/L = ridden
	var/scale_x = L.icon_scale_x * L.size_multiplier //VOREStation Edit Start
	var/scale_y = L.icon_scale_y * L.size_multiplier
	var/scale_difference = (L.size_multiplier - rider_size) * 10

	var/list/values = list(
		"[NORTH]" = list(0, 8*scale_y + scale_difference, ABOVE_MOB_LAYER),
		"[SOUTH]" = list(0, 8*scale_y + scale_difference, BELOW_MOB_LAYER),
		"[EAST]" = list(-10*scale_x, 8*scale_y + scale_difference, ABOVE_MOB_LAYER),
		"[WEST]" = list(10*scale_x, 8*scale_y + scale_difference, ABOVE_MOB_LAYER)) //VOREStation Edit End

	return values

//Human overrides for taur riding
/mob/living/carbon/human
	max_buckled_mobs = 1 //Yeehaw
	can_buckle = TRUE
	buckle_movable = TRUE
	buckle_lying = FALSE

/mob/living/carbon/human/buckle_mob(mob/living/M, forced = FALSE, check_loc = TRUE)
	if(forced)
		return ..() // Skip our checks
	if(!istaurtail(tail_style))
		return FALSE
	else
		var/datum/sprite_accessory/tail/taur/taurtype = tail_style
		if(!taurtype.can_ride)
			return FALSE
	if(lying)
		return FALSE
	if(!ishuman(M))
		return FALSE
	if(M in buckled_mobs)
		return FALSE
//	if(M.size_multiplier > size_multiplier * 1.2)
//		to_chat(M,span_warning("This isn't a pony show! You need to be bigger for them to ride."))
//		return FALSE
	if(M.loc != src.loc)
		if(M.Adjacent(src))
			M.forceMove(get_turf(src))

	var/mob/living/carbon/human/H = M

	if(istaurtail(H.tail_style))
		to_chat(src,span_warning("Too many legs. TOO MANY LEGS!!"))
		return FALSE

	. = ..()
	if(.)
		riding_datum.rider_size = M.size_multiplier
		buckled_mobs[M] = "riding"

/mob/living/carbon/human/MouseDrop_T(mob/living/M, mob/living/user) //Prevention for forced relocation caused by can_buckle. Base proc has no other use.
	return

/mob/living/carbon/human/proc/taur_mount(var/mob/living/M in living_mobs(1))
	set name = "Taur Mount/Dismount"
	set category = "Abilities.General"
	set desc = "Let people ride on you."

	if(LAZYLEN(buckled_mobs))
		var/datum/riding/R = riding_datum
		for(var/rider in buckled_mobs)
			R.force_dismount(rider)
		return
	if (stat != CONSCIOUS)
		return
	if(!can_buckle || !istype(M) || !M.Adjacent(src) || M.buckled)
		return
	if(buckle_mob(M))
		visible_message(span_notice("[M] starts riding [name]!"))

/mob/living/carbon/human/attack_hand(mob/user as mob)
	if(LAZYLEN(buckled_mobs) && riding_datum) //CHOMPEdit
		//We're getting off!
		if(user in buckled_mobs)
			riding_datum.force_dismount(user)
		//We're kicking everyone off!
		if(user == src)
			for(var/rider in buckled_mobs)
				riding_datum.force_dismount(rider)
	else
		. = ..()

/*
////////////////////////////
/  =--------------------=  /
/  == Taur Definitions ==  /
/  =--------------------=  /
////////////////////////////
*/

// Taur sprites are now a subtype of tail since they are mutually exclusive anyway.

/datum/sprite_accessory/tail/taur
	name = DEVELOPER_WARNING_NAME
	icon = 'icons/mob/human_races/sprite_accessories/taurs.dmi'
	do_colouration = 1 // Yes color, using tail color
	color_blend_mode = ICON_MULTIPLY  // The sprites for taurs are designed for ICON_MULTIPLY
	em_block = TRUE

	var/icon/suit_sprites = null //File for suit sprites, if any.
	var/icon/under_sprites = null

	var/icon_sprite_tag			// This is where we put stuff like _Horse, so we can assign icons easier.

	var/can_ride = FALSE			//whether we're real rideable taur or just in that category.

	hide_body_parts	= list(BP_L_LEG, BP_L_FOOT, BP_R_LEG, BP_R_FOOT) //Exclude pelvis just in case.
	clip_mask_icon = 'icons/mob/human_races/sprite_accessories/taurs.dmi'
	clip_mask_state = "taur_clip_mask_def" //Used to clip off the lower part of suits & uniforms.

// Species-unique long tails/taurhalves

// Tails/taurhalves for everyone

/datum/sprite_accessory/tail/taur/wolf
	name = "Wolf (Taur)"
	icon_state = "wolf_s"
	under_sprites = 'icons/mob/taursuits_wolf.dmi'
	suit_sprites = 'icons/mob/taursuits_wolf.dmi'
	icon_sprite_tag = "wolf"

/datum/sprite_accessory/tail/taur/fatwolf
	name = "Fat Wolf (Taur)"
	icon_state = "fatwolf_s"
	icon_sprite_tag = "wolf"	//This could be modified later.

/datum/sprite_accessory/tail/taur/wolf/wolf_2c
	name = "Wolf dual-color (Taur)"
	icon_state = "wolf_s"
	extra_overlay = "wolf_markings"
	//icon_sprite_tag = "wolf2c"

/datum/sprite_accessory/tail/taur/wolf/fatwolf_2c
	name = "Fat Wolf dual-color (Taur)"
	icon_state = "fatwolf_s"
	extra_overlay = "fatwolf_markings"
	//icon_sprite_tag = "fatwolf2c"

/datum/sprite_accessory/tail/taur/wolf/synthwolf
	name = "SynthWolf dual-color (Taur)"
	icon_state = "synthwolf_s"
	extra_overlay = "synthwolf_markings"
	//icon_sprite_tag = "synthwolf"

/datum/sprite_accessory/tail/taur/naga
	name = "Naga (Taur)"
	icon_state = "naga_s"
	suit_sprites = 'icons/mob/taursuits_naga.dmi'
	//icon_sprite_tag = "naga"

/datum/sprite_accessory/tail/taur/naga/naga_2c
	name = "Naga dual-color (Taur)"
	icon_state = "naga_s"
	extra_overlay = "naga_markings"
	//icon_sprite_tag = "naga2c"

/datum/sprite_accessory/tail/taur/horse
	name = "Horse (Taur)"
	icon_state = "horse_s"
	under_sprites = 'icons/mob/taursuits_horse.dmi'
	suit_sprites = 'icons/mob/taursuits_horse.dmi'
	icon_sprite_tag = "horse"

/datum/sprite_accessory/tail/taur/horse/horse_2c
	name = "Horse & colorable tail (Taur)"
	extra_overlay = "horse_markings"
	//icon_sprite_tag = "wolf2c"

/datum/sprite_accessory/tail/taur/horse/synthhorse
	name = "SynthHorse dual-color (Taur)"
	icon_state = "synthhorse_s"
	extra_overlay = "synthhorse_markings"
	//icon_sprite_tag = "synthhorse"

/datum/sprite_accessory/tail/taur/cow
	name = "Cow (Taur)"
	icon_state = "cow_s"
	suit_sprites = 'icons/mob/taursuits_cow.dmi'
	icon_sprite_tag = "cow"

/datum/sprite_accessory/tail/taur/deer
	name = "Deer dual-color (Taur)"
	icon_state = "deer_s"
	extra_overlay = "deer_markings"
	suit_sprites = 'icons/mob/taursuits_deer.dmi'
	icon_sprite_tag = "deer"

/datum/sprite_accessory/tail/taur/lizard
	name = "Lizard (Taur)"
	icon_state = "lizard_s"
	suit_sprites = 'icons/mob/taursuits_lizard.dmi'
	icon_sprite_tag = "lizard"

/datum/sprite_accessory/tail/taur/lizard/lizard_2c
	name = "Lizard dual-color (Taur)"
	icon_state = "lizard_s"
	extra_overlay = "lizard_markings"
	//icon_sprite_tag = "lizard2c"

/datum/sprite_accessory/tail/taur/lizard/synthlizard
	name = "SynthLizard dual-color (Taur)"
	icon_state = "synthlizard_s"
	extra_overlay = "synthlizard_markings"
	//icon_sprite_tag = "synthlizard"

/datum/sprite_accessory/tail/taur/spider
	name = "Spider (Taur)"
	icon_state = "spider_s"
	suit_sprites = 'icons/mob/taursuits_spider.dmi'
	icon_sprite_tag = "spider"

/datum/sprite_accessory/tail/taur/tents
	name = "Tentacles (Taur)"
	icon_state = "tent_s"
	icon_sprite_tag = "tentacle"
	can_ride = 0

/datum/sprite_accessory/tail/taur/feline
	name = "Feline (Taur)"
	icon_state = "feline_s"
	suit_sprites = 'icons/mob/taursuits_feline.dmi'
	icon_sprite_tag = "feline"

/datum/sprite_accessory/tail/taur/fatfeline
	name = "Fat Feline (Taur)"
	icon_state = "fatfeline_s"
	//icon_sprite_tag = "fatfeline"

/datum/sprite_accessory/tail/taur/fatfeline_wag
	name = "Fat Feline (Taur) (vwag)"
	icon_state = "fatfeline_s"
	ani_state = "fatfeline_w"

/datum/sprite_accessory/tail/taur/feline/feline_2c
	name = "Feline dual-color (Taur)"
	icon_state = "feline_s"
	extra_overlay = "feline_markings"
	//icon_sprite_tag = "feline2c"

/datum/sprite_accessory/tail/taur/feline/fatfeline_2c
	name = "Fat Feline dual-color (Taur)"
	icon_state = "fatfeline_s"
	extra_overlay = "fatfeline_markings"
	//icon_sprite_tag = "fatfeline2c"

/datum/sprite_accessory/tail/taur/feline/synthfeline
	name = "SynthFeline dual-color (Taur)"
	icon_state = "synthfeline_s"
	extra_overlay = "synthfeline_markings"
	//icon_sprite_tag = "synthfeline"

/datum/sprite_accessory/tail/taur/slug
	name = "Slug (Taur)"
	icon_state = "slug_s"
	suit_sprites = 'icons/mob/taursuits_slug.dmi'
	icon_sprite_tag = "slug"

/datum/sprite_accessory/tail/taur/slug/snail
	name = "Snail (Taur)"
	icon_state = "slug_s"
	extra_overlay = "snail_shell_marking"

/datum/sprite_accessory/tail/taur/frog
	name = "Frog (Taur)"
	icon_state = "frog_s"
	icon_sprite_tag = "frog"

/datum/sprite_accessory/tail/taur/thicktentacles
	name = "Thick Tentacles (Taur)"
	icon_state = "tentacle_s"
	can_ride = 0
	icon_sprite_tag = "thick_tentacles"

/datum/sprite_accessory/tail/taur/drake //Enabling on request, no suit compatibility but then again see 2 above.
	name = "Drake (Taur)"
	icon_state = "drake_s"
	extra_overlay = "drake_markings"
	suit_sprites = 'icons/mob/taursuits_drake.dmi'
	icon_sprite_tag = "drake"

/datum/sprite_accessory/tail/taur/otie
	name = "Otie (Taur)"
	icon_state = "otie_s"
	extra_overlay = "otie_markings"
	suit_sprites = 'icons/mob/taursuits_otie.dmi'
	icon_sprite_tag = "otie"

/datum/sprite_accessory/tail/taur/alraune/alraune_2c
	name = "Alraune (dual color)"
	icon_state = "alraunecolor_s"
	ani_state = "alraunecolor_closed_s"
	ckeys_allowed = null
	do_colouration = 1
	extra_overlay = "alraunecolor_markings"
	extra_overlay_w = "alraunecolor_closed_markings"
	clip_mask_state = "taur_clip_mask_alraune"
	icon_sprite_tag = "alraune"

/datum/sprite_accessory/tail/taur/wasp
	name = "Wasp (dual color)"
	icon_state = "wasp_s"
	extra_overlay = "wasp_markings"
	clip_mask_state = "taur_clip_mask_wasp"
	icon_sprite_tag = "wasp"

/datum/sprite_accessory/tail/taur/mermaid
	name = "Mermaid (Taur)"
	icon_state = "mermaid_s"
	can_ride = 0
	icon_sprite_tag = "mermaid"

/datum/sprite_accessory/tail/taur/noodle
	name = "Eastern Dragon (Taur)"
	icon_state = "noodle_s"
	extra_overlay = "noodle_markings"
	suit_sprites = 'icons/mob/taursuits_noodle.dmi'
	clip_mask_state = "taur_clip_mask_noodle"
	icon_sprite_tag = "noodle"

/datum/sprite_accessory/tail/taur/zorgoia
	name = "Zorgoia (Taur)"
	icon = 'icons/mob/human_races/sprite_accessories/taurs.dmi'
	icon_state = "zorgoia"
	extra_overlay = "zorgoia_fluff"

/datum/sprite_accessory/tail/taur/zorgoia/fat
	name = "Zorgoia (Fat Taur)"
<<<<<<< HEAD
	extra_overlay = "zorgoia_fat"
=======
	extra_overlay = "zorgoia_fat2"

/datum/sprite_accessory/tail/taur/rat
	name = "Rat (Taur)"
	icon_state = "rat_s"
	extra_overlay = "rat_markings"
	clip_mask_state = "taur_clip_mask_rat"
	icon_sprite_tag = "rat"

/datum/sprite_accessory/tail/taur/noodle
	name = "Eastern Dragon (Taur)"
	icon_state = "noodle_s"
	extra_overlay = "noodle_markings"
	extra_overlay2 = "noodle_markings_2"
	suit_sprites = 'icons/mob/taursuits_noodle.dmi'
	clip_mask_state = "taur_clip_mask_noodle"
	icon_sprite_tag = "noodle"

/datum/sprite_accessory/tail/taur/sect_drone
	name = "Sect Drone (Taur)"
	icon_state = "sect_drone"
	extra_overlay = "sect_drone_markings"
	icon_sprite_tag = "sect_drone"

	msg_owner_disarm_run = "You quickly push %prey to the ground with your leg!"
	msg_prey_disarm_run = "%owner pushes you down to the ground with their leg!"

	msg_owner_disarm_walk = "You firmly push your leg down on %prey, painfully but harmlessly pinning them to the ground!"
	msg_prey_disarm_walk = "%owner firmly pushes their leg down on you, quite painfully but harmlessly pinning you to the ground!"

	msg_owner_harm_walk = "You methodically place your leg down upon %prey's body, slowly applying pressure, crushing them against the floor!"
	msg_prey_harm_walk = "%owner methodically places their leg upon your body, slowly applying pressure, crushing you against the floor!"

	msg_owner_grab_success = "You pin %prey down on the ground with your front leg before using your other leg to pick them up, trapping them between two of your front legs!"
	msg_prey_grab_success = "%owner pins you down on the ground with their front leg before using their other leg to pick you up, trapping you between two of their front legs!"

	msg_owner_grab_fail = "You step down onto %prey, squishing them and forcing them down to the ground!"
	msg_prey_grab_fail = "%owner steps down and squishes you with their leg, forcing you down to the ground!"

/datum/sprite_accessory/tail/taur/sect_drone/fat
	name = "Fat Sect Drone (Taur)"
	icon_state = "fat_sect_drone"
	extra_overlay = "fat_sect_drone_markings"
	icon_sprite_tag = "sect_drone" //Ported from Chomp

/datum/sprite_accessory/tail/taur/sect_drone/drone_wag
	name = "Sect Drone (Taur, Fat vwag)"
	icon_state = "sect_drone"
	extra_overlay = "sect_drone_markings"
	ani_state = "fat_sect_drone"
	extra_overlay_w = "fat_sect_drone_markings"
	icon_sprite_tag = "sect_drone" //Ported from Chomp

/datum/sprite_accessory/tail/taur/giantspider
	name = "Giant Spider (Taur)"
	icon_state = "giantspidertaur"
	extra_overlay = null
	icon_sprite_tag = "giantspidertaur"

	msg_owner_disarm_run = "You quickly push %prey to the ground with your leg!"
	msg_prey_disarm_run = "%owner pushes you down to the ground with their leg!"

	msg_owner_disarm_walk = "You firmly push your leg down on %prey, painfully but harmlessly pinning them to the ground!"
	msg_prey_disarm_walk = "%owner firmly pushes their leg down on you, quite painfully but harmlessly pinning you to the ground!"

	msg_owner_harm_walk = "You methodically place your leg down upon %prey's body, slowly applying pressure, crushing them against the floor!"
	msg_prey_harm_walk = "%owner methodically places their leg upon your body, slowly applying pressure, crushing you against the floor!"

	msg_owner_grab_success = "You pin %prey down on the ground with your front leg before using your other leg to pick them up, trapping them between two of your front legs!"
	msg_prey_grab_success = "%owner pins you down on the ground with their front leg before using their other leg to pick you up, trapping you between two of their front legs!"

	msg_owner_grab_fail = "You step down onto %prey, squishing them and forcing them down to the ground!"
	msg_prey_grab_fail = "%owner steps down and squishes you with their leg, forcing you down to the ground!"

/datum/sprite_accessory/tail/taur/giantspider/colorable
	name = "Giant Spider dual-color (Taur)"
	icon_state = "giantspidertaur-colorable"
	extra_overlay = "giantspidertaur-colorable-markings"
	icon_sprite_tag = "giantspidertaur-colorable"

/datum/sprite_accessory/tail/taur/giantspider/carrier
	name = "Carrier Spider (Taur)"
	icon_state = "carrierspidertaur"
	extra_overlay = null
	icon_sprite_tag = "carrierspidertaur"

/datum/sprite_accessory/tail/taur/giantspider/phoron
	name = "Phorogenic Spider (Taur)"
	icon_state = "phoronspidertaur"
	extra_overlay = null
	icon_sprite_tag = "phoronspidertaur"

/datum/sprite_accessory/tail/taur/giantspider/spark
	name = "Voltaic Spider (Taur)"
	icon_state = "sparkspidertaur"
	extra_overlay = null
	icon_sprite_tag = "sparkspidertaur"

/datum/sprite_accessory/tail/taur/giantspider/frost
	name = "Frost Spider (Taur)"
	icon_state = "frostspidertaur"
	extra_overlay = null
	icon_sprite_tag = "frostspidertaur"

/datum/sprite_accessory/tail/taur/giantspider/ant	//technically not a spider, but it inherits the same messages
	name = "Ant (dual color)"
	icon_state = "ant_s"
	extra_overlay = "ant_markings"
	clip_mask_state = "taur_clip_mask_wasp"
	icon_sprite_tag = "wasp"

/datum/sprite_accessory/tail/taur/fox
	name = "Fox (Taur, 3-color)"
	icon_state = "fox"
	extra_overlay = "fox_markings"
	extra_overlay2 = "fox_markings2"
	can_loaf = TRUE
	icon_loaf = 'icons/mob/vore/taurs_vr_loaf.dmi'
	loaf_offset = 4

/datum/sprite_accessory/tail/taur/kitsune
	name = "Kitsune (Taur)"
	icon_state = "kitsune"

/*
/datum/sprite_accessory/tail/taur/teppi			// Mostly used as example/template/test subject as to how you use the 'big' taur sprites. Pls give it better icons before uncommenting...
	name = "Teppi (Taur)"
	icon_state = "teppi_s"
	clip_mask_icon = 'icons/mob/vore/taurs128x64.dmi'
	icon = 'icons/mob/vore/taurs128x64.dmi'
	clip_mask_state = "taur_clip_mask_teppi"
	icon_sprite_tag = "teppi"
	offset_x = -32
	offset_y = -11
	mob_offset_y = 11
*/

/datum/sprite_accessory/tail/taur/bunny
	name = "Bunny (Taur, Fat vwag)"
	icon = 'icons/rogue-star/tails_64x32_rs.dmi'
	icon_state = "bnytr"
	extra_overlay = "bnytr-m1"
	extra_overlay2 = "bnytr-m2"
	ani_state = "bnytr-f"
	extra_overlay_w = "bnytr-m1"
	extra_overlay2_w = "bnytr-f-m2"

	can_loaf = TRUE
	icon_loaf = 'icons/rogue-star/loafs_64x32.dmi'
	loaf_offset = 4
/*// Special snowflake tails/taurhalves // CHOMPRemove Start

//spoopylizz: Roiz Lizden
/datum/sprite_accessory/tail/taur/roiz_long_lizard // Not ACTUALLY a taur, but it uses 32x64 so it wouldn't fit in tails.dmi, and having it as a tail bugs up the sprite.
	name = "Long Lizard Tail (Roiz Lizden)"
	icon_state = "roiz_tail_s"
	do_colouration = 0
	ckeys_allowed = list("spoopylizz")
	hide_body_parts = null
	clip_mask_icon = null
	clip_mask_state = null

//grallstonefist: Ranihrönn Skrolk
/datum/sprite_accessory/tail/taur/altmermaid/orcamermaid
	name = "Mermaid Orca (Taur)"
	icon_state = "orcamermaid_s"
	can_ride = 1
	do_colouration = 0
	ckeys_allowed = list("grallstonefist")

//wickedtemp: Chakat Tempest
/datum/sprite_accessory/tail/taur/feline/tempest
	name = "Feline (wickedtemp) (Taur)"
	icon_state = "tempest_s"
	ckeys_allowed = list("wickedtemp")
	can_loaf = FALSE

//silencedmp5a5: Serdykov Antoz
/datum/sprite_accessory/tail/taur/wolf/serdy
	name = "CyberSerdy (silencedmp5a5) (Taur)"
	icon_state = "serdy_s"
	ckeys_allowed = list("silencedmp5a5")
	can_loaf = FALSE

//liquidfirefly: Ariana Scol
/datum/sprite_accessory/tail/taur/centipede
	name = "Centipede (liquidfirefly) (Taur)"
	icon_state = "ariana_s"
	ckeys_allowed = list("liquidfirefly")
	do_colouration = 0

	msg_owner_disarm_run = "You quickly push %prey to the ground with your leg!"
	msg_prey_disarm_run = "%owner pushes you down to the ground with their leg!"

	msg_owner_disarm_walk = "You firmly push your leg down on %prey, painfully but harmlessly pinning them to the ground!"
	msg_prey_disarm_walk = "%owner firmly pushes their leg down on you, quite painfully but harmlessly pinning you to the ground!"

	msg_owner_harm_walk = "You methodically place your leg down upon %prey's body, slowly applying pressure, crushing them against the floor below!"
	msg_prey_harm_walk = "%owner methodically places their leg upon your body, slowly applying pressure, crushing you against the floor below!"

	msg_owner_grab_success = "You pin %prey down on the ground with your front leg before using your other leg to pick them up, trapping them between two of your front legs!"
	msg_prey_grab_success = "%owner pins you down on the ground with their front leg before using their other leg to pick you up, trapping you between two of their front legs!"

	msg_owner_grab_fail = "You step down onto %prey, squishing them and forcing them down to the ground!"
	msg_prey_grab_fail = "%owner steps down and squishes you with their leg, forcing you down to the ground!"

//natje:
/datum/sprite_accessory/tail/taur/alraune
	name = "Alraune (natje) (Taur)"
	icon_state = "alraune_s"
	ani_state = "alraune_closed_s"
	ckeys_allowed = list("natje")
	do_colouration = 0
	can_ride = 0
	clip_mask_state = "taur_clip_mask_alraune"


	msg_prey_stepunder = "You run between %prey's vines."
	msg_owner_stepunder = "%owner runs between your vines."

	msg_owner_disarm_run = "You quickly push %prey to the ground with some of your vines!"
	msg_prey_disarm_run = "%owner pushes you down to the ground with some of their vines!"

	msg_owner_disarm_walk = "You push down on %prey with some of your vines, pinning them down firmly under you!"
	msg_prey_disarm_walk = "%owner pushes down on you with some of their vines, pinning you down firmly below them!"

	msg_owner_harm_run = "Your vines carelessly slide past %prey, crushing them!"
	msg_prey_harm_run = "%owner quickly goes over your body, carelessly crushing you with their vines!"

	msg_owner_harm_walk = "Your vines methodically apply pressure on %prey's body, crushing them against the floor below!"
	msg_prey_harm_walk = "%owner's thick vines methodically apply pressure on your body, crushing you into the floor below!"

	msg_owner_grab_success = "You slide over %prey with your vines, smushing them against the ground before wrapping one up around them, trapping them within the tight confines of your vines!"
	msg_prey_grab_success = "%owner slides over you with their vines, smushing you against the ground before wrapping one up around you, trapping you within the tight confines of their vines!"

	msg_owner_grab_fail = "You step down onto %prey with one of your vines, forcing them onto the ground!"
	msg_prey_grab_fail = "%owner steps down onto you with one of their vines, squishing you and forcing you onto the ground!"
*/// CHOMPRemove End
>>>>>>> f4755bd3bf (follow up (#10026))
