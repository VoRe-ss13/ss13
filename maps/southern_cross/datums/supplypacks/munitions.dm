/*
*	Here is where any supply packs
*	related to sc weapons live.
*/

/datum/supply_pack/munitions/bolt_rifles_explorer
 	name = "Weapons - Surplus Hunting Rifles"
 	contains = list(
 			/obj/item/gun/projectile/shotgun/pump/rifle = 2,
 			/obj/item/ammo_magazine/clip/c762/hunter = 6
 			)
 	cost = 50
 	containertype = /obj/structure/closet/crate/secure/hedberg
 	containername = "Hunting Rifle crate"
<<<<<<< HEAD
 	access = access_explorer //CHOMP keep explo
=======
 	access = access_brig
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))

/datum/supply_pack/munitions/phase_carbines_explorer
 	name = "Weapons - Surplus Phase Carbines"
 	contains = list(
<<<<<<< HEAD
 			/obj/item/gun/energy/locked/phasegun = 2,
=======
 			/obj/item/gun/energy/phasegun = 2,
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
 			)
 	cost = 25
 	containertype = /obj/structure/closet/crate/secure/ward
 	containername = "Phase Carbine crate"
<<<<<<< HEAD
 	access = access_explorer //CHOMP keep explo
=======
 	access = access_brig
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))

/datum/supply_pack/munitions/phase_rifles_explorer
 	name = "Weapons - Phase Rifles"
 	contains = list(
<<<<<<< HEAD
 			/obj/item/gun/energy/locked/phasegun/rifle = 2,
=======
 			/obj/item/gun/energy/phasegun/rifle = 2,
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
 			)
 	cost = 50
 	containertype = /obj/structure/closet/crate/secure/ward
 	containername = "Phase Rifle crate"
<<<<<<< HEAD
 	access = access_explorer //CHOMP keep explo
=======
 	access = access_brig
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
