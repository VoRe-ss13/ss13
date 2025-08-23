<<<<<<< HEAD
=======
/obj/structure/loot_pile/mecha/ripley/pirate
	icon = 'icons/mob/pirates.dmi'
	icon_state = "pirate-broken"

/obj/structure/loot_pile/maint/technical
	density = FALSE

/obj/structure/loot_pile/maint/boxfort
	density = FALSE

//Eclipse mecha
/obj/structure/loot_pile/mecha/odd_gygax
	name = "\improper mecha wreckage"
	icon = 'modular_chomp/icons/mob/eclipse.dmi'
	icon_state = "orb-broken"
	density = TRUE
	anchored = FALSE

	loot_element_path = /datum/element/lootable/mecha/odd_gygax

/obj/structure/loot_pile/mecha/odd_ripley
	name = "\improper mecha wreckage"
	icon = 'modular_chomp/icons/mob/eclipse.dmi'
	icon_state = "mine-broken"
	density = TRUE
	anchored = FALSE

	loot_element_path = /datum/element/lootable/mecha/odd_riplay

>>>>>>> 4febf95738 ([MIRROR] Simple mob port [IDB IGNORE] (#11492))
/obj/structure/loot_pile/christmas_tree
	name = "festive tree"
	desc = "Happy Holidays!"
	icon = 'modular_chomp/icons/obj/loot_piles.dmi'
	icon_state = "festivetree"
	plane = ABOVE_MOB_PLANE
	chance_uncommon = 0
	chance_rare = 0
	common_loot = list(/obj/item/a_gift/advanced)
	pixel_x = -32
	bound_width = 96
	bound_height = 64
	density = 1
