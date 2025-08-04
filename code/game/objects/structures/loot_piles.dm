/*
Basically, each player key gets one chance per loot pile to get them phat lewt.
When they click the pile, after a delay, they 'roll' if they get anything, using chance_nothing.  If they're unlucky, they get nothing.
Otherwise, they roll up to two times, first a roll for rare things, using chance_rare.  If they succeed, they get something quite good.
If that roll fails, they do one final roll, using chance_uncommon.  If they succeed, they get something fairly useful.
If that fails again, they walk away with some common junk.

The same player cannot roll again, however other players can.  This has two benefits.  The first benefit is that someone raiding all of
maintenance will not deprive other people from a shot at loot, and that for the surface variants, it quietly encourages bringing along
buddies, to get more chances at getting cool things instead of someone going solo to hoard all the stuff.

Loot piles can be depleted, if loot_depleted is turned on.  Note that players who searched the pile already won't deplete the loot furthers when searching again.
*/

/obj/structure/loot_pile
	name = "base loot pile"
	desc = "If you can read me, this is bugged"
	description_info = "This can be searched by clicking on it and waiting a few seconds.  You might find valuable treasures or worthless junk. \
	These can only searched each once per player."
	icon = 'icons/obj/loot_piles.dmi'
	icon_state = "randompile"
	density = FALSE
	anchored = TRUE
	unacidable = TRUE
	var/list/icon_states_to_use = list() // List of icon states the pile can choose from on initialization. If empty or null, it will stay the initial icon_state.

	var/list/searchedby = list()	// Keys that have searched this loot pile, with values of searched time.
	var/busy = FALSE				// Used so you can't spamclick to loot.
	var/loot_element_path = null

/obj/structure/loot_pile/attack_ai(var/mob/user)
	if(isrobot(user) && Adjacent(user))
		return attack_hand(user)

/obj/structure/loot_pile/attack_hand(mob/user)
	//Human mob
	if(isliving(user))
		var/mob/living/L = user

		if(busy)
			to_chat(L, span_warning("\The [src] is already being searched."))
			return

		L.visible_message("[user] searches through \the [src].",span_notice("You search through \the [src]."))

		//Do the searching
		busy = TRUE
		if(do_after(user,rand(4 SECONDS,6 SECONDS),src))
			SEND_SIGNAL(src,COMSIG_LOOT_REWARD,L,searchedby)
		busy = FALSE
	else
		return ..()

/obj/structure/loot_pile/Initialize(mapload)
	if(icon_states_to_use && icon_states_to_use.len)
		icon_state = pick(icon_states_to_use)
	. = ..()
	if(loot_element_path)
		AddElement(loot_element_path)


// Maintenance junk piles with common to fun loot
/obj/structure/loot_pile/maint/junk
	name = "pile of junk"
	desc = "Lots of junk lying around.  They say one man's trash is another man's treasure."
	icon_states_to_use = list("junk_pile1", "junk_pile2", "junk_pile3", "junk_pile4", "junk_pile5")
	loot_element_path = /datum/element/lootable/maint/junk

<<<<<<< HEAD
	common_loot = list(
		/obj/item/flashlight/flare,
		/obj/item/flashlight/glowstick,
		/obj/item/flashlight/glowstick/blue,
		/obj/item/flashlight/glowstick/orange,
		/obj/item/flashlight/glowstick/red,
		/obj/item/flashlight/glowstick/yellow,
		/obj/item/flashlight/pen,
		/obj/item/cell,
		/obj/item/cell/device,
		/obj/item/clothing/mask/gas,
		/obj/item/clothing/mask/gas/clear, //Chompadd: Proper Implementation of clear gasmasks
		/obj/item/clothing/mask/gas/half,
		/obj/item/clothing/mask/breath,
		/obj/item/reagent_containers/glass/rag,
		/obj/item/reagent_containers/food/snacks/liquidfood,
		/obj/item/storage/secure/briefcase,
		/obj/item/storage/briefcase,
		/obj/item/storage/backpack,
		/obj/item/storage/backpack/satchel/norm,
		/obj/item/storage/backpack/satchel,
		/obj/item/storage/backpack/dufflebag,
		/obj/item/storage/box,
		/obj/item/storage/wallet,
		/obj/item/clothing/shoes/galoshes,
		/obj/item/clothing/shoes/black,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/shoes/laceup/grey,
		/obj/item/clothing/shoes/laceup/brown,
		/obj/item/clothing/gloves/botanic_leather,
		/obj/item/clothing/gloves/sterile/latex,
		/obj/item/clothing/gloves/white,
		/obj/item/clothing/gloves/rainbow,
		/obj/item/clothing/gloves/fyellow,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/clothing/glasses/meson,
		/obj/item/clothing/glasses/meson/prescription,
		/obj/item/clothing/glasses/welding,
		/obj/item/clothing/head/bio_hood/general,
		/obj/item/clothing/head/hardhat,
		/obj/item/clothing/head/hardhat/red,
		/obj/item/clothing/head/ushanka,
		/obj/item/clothing/head/welding,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/suit/space/emergency,
		/obj/item/clothing/suit/storage/toggle/bomber,
		/obj/item/clothing/suit/bio_suit/general,
		/obj/item/clothing/suit/storage/toggle/hoodie/black,
		/obj/item/clothing/suit/storage/toggle/hoodie/blue,
		/obj/item/clothing/suit/storage/toggle/hoodie/red,
		/obj/item/clothing/suit/storage/toggle/hoodie/yellow,
		/obj/item/clothing/suit/storage/toggle/brown_jacket,
		/obj/item/clothing/suit/storage/toggle/leather_jacket,
		/obj/item/clothing/suit/storage/apron,
		/obj/item/clothing/under/color/grey,
		/obj/item/clothing/under/syndicate/tacticool,
		/obj/item/clothing/under/pants/camo,
		/obj/item/clothing/under/harness,
		/obj/item/clothing/accessory/storage/webbing,
		/obj/item/spacecash/c1,
		/obj/item/spacecash/c5,
		/obj/item/spacecash/c10,
		/obj/item/spacecash/c20,
		/obj/item/camera_assembly,
		/obj/item/clothing/suit/caution,
		/obj/item/clothing/head/cone,
		/obj/item/card/emag_broken,
		/obj/item/camera,
		/obj/item/pda,
		/obj/item/radio/headset,
		/obj/item/paicard,
		/obj/item/reagent_containers/hypospray/autoinjector/biginjector/glucose
	)

	uncommon_loot = list(
		/obj/item/clothing/shoes/syndigaloshes,
		/obj/item/clothing/gloves/yellow,
		/obj/item/clothing/under/tactical,
		/obj/item/beartrap,
		/obj/item/clothing/suit/storage/vest/press,
		/obj/item/material/knife/tacknife,
		/obj/item/material/butterfly/switchblade
	)

	rare_loot = list(
		/obj/item/clothing/suit/storage/vest/heavy/merc,
		/obj/item/clothing/shoes/boots/combat,
	)

// Contains mostly useless garbage.
=======
>>>>>>> 7d9ac8e760 ([MIRROR] Looting element for trash piles and more (#11207))
/obj/structure/loot_pile/maint/trash
	name = "pile of trash"
	desc = "Lots of garbage in one place.  Might be able to find something if you're in the mood for dumpster diving."
	icon_states_to_use = list("trash_pile1", "trash_pile2")
	loot_element_path = /datum/element/lootable/maint/trash

<<<<<<< HEAD
	common_loot = list(
		/obj/item/trash/candle,
		/obj/item/trash/candy,
		/obj/item/trash/candy/proteinbar,
		/obj/item/trash/candy/gums,
		/obj/item/trash/cheesie,
		/obj/item/trash/chips,
		/obj/item/trash/chips/bbq,
		/obj/item/trash/liquidfood,
		/obj/item/trash/pistachios,
		/obj/item/trash/plate,
		/obj/item/trash/popcorn,
		/obj/item/trash/raisins,
		/obj/item/trash/semki,
		/obj/item/trash/snack_bowl,
		/obj/item/trash/sosjerky,
		/obj/item/trash/syndi_cakes,
		/obj/item/trash/tastybread,
		/obj/item/trash/coffee,
		/obj/item/trash/tray,
		/obj/item/trash/unajerky,
		/obj/item/trash/waffles,
		/obj/item/reagent_containers/food/snacks/xenomeat/spidermeat,
		/obj/item/reagent_containers/food/snacks/mysterysoup,
		/obj/item/reagent_containers/food/snacks/old/hotdog,
		/obj/item/pizzabox/old,
		/obj/item/ammo_casing/spent,
		/obj/item/stack/rods{amount = 5},
		/obj/item/stack/material/steel{amount = 5},
		/obj/item/stack/material/cardboard{amount = 5},
		/obj/item/poster,
		/obj/item/poster/custom,
		/obj/item/newspaper,
		/obj/item/paper/crumpled,
		/obj/item/paper/crumpled/bloody
	)

	uncommon_loot = list(
		/obj/item/reagent_containers/syringe/steroid,
		/obj/item/storage/pill_bottle/zoom,
		/obj/item/storage/pill_bottle/happy,
		/obj/item/storage/pill_bottle/paracetamol //VOREStation Edit
	)

// Contains loads of different types of boxes, which may have items inside!
=======
>>>>>>> 7d9ac8e760 ([MIRROR] Looting element for trash piles and more (#11207))
/obj/structure/loot_pile/maint/boxfort
	name = "pile of boxes"
	desc = "A large pile of boxes sits here."
	density = TRUE
	icon_states_to_use = list("boxfort")
	loot_element_path = /datum/element/lootable/boxes

<<<<<<< HEAD
	common_loot = list(
		/obj/item/storage/box,
		/obj/item/storage/box/beakers,
		/obj/item/storage/box/botanydisk,
		/obj/item/storage/box/cups,
		/obj/item/storage/box/disks,
		/obj/item/storage/box/donkpockets,
		/obj/item/storage/box/donut,
		/obj/item/storage/box/donut/empty,
		/obj/item/storage/box/evidence,
		/obj/item/storage/box/lights/mixed,
		/obj/item/storage/box/lights/tubes,
		/obj/item/storage/box/lights/bulbs,
		/obj/item/storage/box/injectors,
		/obj/item/storage/box/masks,
		/obj/item/storage/box/ids,
		/obj/item/storage/box/mousetraps,
		/obj/item/storage/box/syringes,
		/obj/item/storage/box/survival,
		/obj/item/storage/box/gloves,
		/obj/item/storage/box/PDAs
	)

	uncommon_loot = list(
		/obj/item/storage/box/sinpockets,
		/obj/item/ammo_magazine/ammo_box/b12g/practice,
		/obj/item/ammo_magazine/ammo_box/b12g/blank,
		/obj/item/storage/box/smokes,
		/obj/item/storage/box/metalfoam,
		/obj/item/storage/box/handcuffs,
		/obj/item/storage/box/seccarts
	)

	rare_loot = list(
		/obj/item/storage/box/flashbangs,
		/obj/item/storage/box/empslite,
		/obj/item/ammo_magazine/ammo_box/b12g/flash,
		/obj/item/ammo_magazine/ammo_box/b12g/stunshell,
		/obj/item/storage/box/teargas
	)

// One of the more useful maint piles, contains electrical components.
=======
>>>>>>> 7d9ac8e760 ([MIRROR] Looting element for trash piles and more (#11207))
/obj/structure/loot_pile/maint/technical
	name = "broken machine"
	desc = "A destroyed machine with unknown purpose, and doesn't look like it can be fixed.  It might still have some functional components?"
	density = TRUE
	icon_states_to_use = list("technical_pile1", "technical_pile2", "technical_pile3")
<<<<<<< HEAD

	common_loot = list(
		/obj/item/stock_parts/gear,
		/obj/item/stock_parts/console_screen,
		/obj/item/stock_parts/spring,
		/obj/item/stock_parts/capacitor,
		/obj/item/stock_parts/capacitor/adv,
		/obj/item/stock_parts/capacitor/super,
		/obj/item/stock_parts/manipulator,
		/obj/item/stock_parts/manipulator/nano,
		/obj/item/stock_parts/manipulator/pico,
		/obj/item/stock_parts/matter_bin,
		/obj/item/stock_parts/matter_bin/adv,
		/obj/item/stock_parts/matter_bin/super,
		/obj/item/stock_parts/scanning_module,
		/obj/item/stock_parts/scanning_module/adv,
		/obj/item/stock_parts/scanning_module/phasic,
		/obj/item/stock_parts/subspace/amplifier,
		/obj/item/stock_parts/subspace/analyzer,
		/obj/item/stock_parts/subspace/ansible,
		/obj/item/stock_parts/subspace/crystal,
		/obj/item/stock_parts/subspace/sub_filter,
		/obj/item/stock_parts/subspace/transmitter,
		/obj/item/stock_parts/subspace/treatment,
		/obj/item/frame,
		/obj/item/broken_device/random,
		/obj/item/borg/upgrade/utility/restart,
		/obj/item/cell,
		/obj/item/cell/high,
		/obj/item/cell/device,
		/obj/item/circuitboard/broken,
		/obj/item/circuitboard/arcade,
		/obj/item/circuitboard/autolathe,
		/obj/item/circuitboard/atmos_alert,
		/obj/item/circuitboard/airalarm,
		/obj/item/circuitboard/fax,
		/obj/item/circuitboard/jukebox,
		/obj/item/circuitboard/batteryrack,
		/obj/item/circuitboard/message_monitor,
		/obj/item/circuitboard/rcon_console,
		/obj/item/smes_coil,
		/obj/item/cartridge/engineering,
		/obj/item/analyzer,
		/obj/item/healthanalyzer,
		/obj/item/robotanalyzer,
		/obj/item/lightreplacer,
		/obj/item/radio,
		/obj/item/hailer,
		/obj/item/gps,
		/obj/item/geiger,
		/obj/item/mass_spectrometer,
		/obj/item/tool/wrench,
		/obj/item/tool/screwdriver,
		/obj/item/tool/wirecutters,
		/obj/item/mining_scanner/advanced,
		/obj/item/multitool,
		/obj/item/mecha_parts/mecha_equipment/generator,
		/obj/item/mecha_parts/mecha_equipment/tool/cable_layer,
		/obj/item/mecha_parts/mecha_equipment/tool/drill,
		/obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp,
		/obj/item/mecha_parts/mecha_equipment/tool/passenger,
		/obj/item/mecha_parts/mecha_equipment/tool/sleeper,
		/obj/item/mecha_parts/mecha_equipment/tool/syringe_gun,
		/obj/item/robot_parts/robot_component/binary_communication_device,
		/obj/item/robot_parts/robot_component/armour,
		/obj/item/robot_parts/robot_component/actuator,
		/obj/item/robot_parts/robot_component/camera,
		/obj/item/robot_parts/robot_component/diagnosis_unit,
		/obj/item/robot_parts/robot_component/radio
	)

	uncommon_loot = list(
		/obj/item/cell/super,
		/obj/item/cell/device/weapon,
		/obj/item/circuitboard/security,
		/obj/item/circuitboard/crew,
		/obj/item/aiModule/reset,
		/obj/item/smes_coil/super_capacity,
		/obj/item/smes_coil/super_io,
		/obj/item/cartridge/captain,
		/obj/item/disk/integrated_circuit/upgrade/advanced,
		/obj/item/tvcamera,
		/obj/item/universal_translator,
		/obj/item/aicard,
		/obj/item/borg/upgrade/advanced/jetpack,
		/obj/item/borg/upgrade/advanced/advhealth,
		/obj/item/borg/upgrade/basic/vtec,
		/obj/item/borg/upgrade/restricted/tasercooler,
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/riggedlaser,
		/obj/item/mecha_parts/mecha_equipment/tool/drill/diamonddrill,
		/obj/item/rig_module/device/drill,
		/obj/item/rig_module/device/plasmacutter,
		/obj/item/rig_module/device/healthscanner,
		/obj/item/rig_module/device/orescanner,
		/obj/item/rig_module/device/anomaly_scanner,
		/obj/item/rig_module/datajack,
		/obj/item/rig_module/vision/medhud,
		/obj/item/rig_module/vision/meson,
		/obj/item/rig_module/vision/sechud,
		/obj/item/rig_module/sprinter
	)

	rare_loot = list(
		/obj/item/cell/hyper,
		/obj/item/aiModule/freeform,
		/obj/item/aiModule/asimov,
		/obj/item/aiModule/paladin,
		/obj/item/aiModule/safeguard,
		/obj/item/disposable_teleporter,
		/obj/item/mecha_parts/mecha_equipment/tesla_energy_relay
	)
=======
	loot_element_path = /datum/element/lootable/maint/technical
>>>>>>> 7d9ac8e760 ([MIRROR] Looting element for trash piles and more (#11207))


// Surface piles for POIs, most have rarer loot
/obj/structure/loot_pile/surface/alien
	name = "alien pod"
	desc = "A pod which looks bigger on the inside. Something quite shiny might be inside?"
	icon_state = "alien_pile1"
	loot_element_path = /datum/element/lootable/surface/alien
/obj/structure/loot_pile/surface/alien/engineering
	loot_element_path = /datum/element/lootable/surface/alien/engineering
/obj/structure/loot_pile/surface/alien/medical
	loot_element_path = /datum/element/lootable/surface/alien/medical
/obj/structure/loot_pile/surface/alien/security
	loot_element_path = /datum/element/lootable/surface/alien/security
/obj/structure/loot_pile/surface/alien/end
	loot_element_path = /datum/element/lootable/surface/alien/end

/obj/structure/loot_pile/surface/bones
	name = "bone pile"
	desc = "A pile of various dusty bones. Your graverobbing instincts tell you there might be valuables here."
	icon = 'icons/obj/bones.dmi'
	icon_state = "bonepile"
	loot_element_path = /datum/element/lootable/surface/bones

/obj/structure/loot_pile/surface/drone
	name = "drone wreckage"
	desc = "The ruins of some unfortunate drone. Perhaps something is salvageable."
	icon = 'icons/mob/animal.dmi'
	icon_state = "drone_dead"
	loot_element_path = /datum/element/lootable/surface/drone

// Mechaparts loot piles
/obj/structure/loot_pile/mecha
	name = "pod wreckage"
	desc = "The ruins of some unfortunate pod. Perhaps something is salvageable."
	icon = 'icons/mecha/mecha.dmi'
	icon_state = "engineering_pod-broken"
	loot_element_path = /datum/element/lootable/mecha
	density = TRUE
	anchored = FALSE // In case a dead mecha-mob dies in a bad spot.

/obj/structure/loot_pile/mecha/ripley
	name = "ripley wreckage"
	desc = "The ruins of some unfortunate ripley. Perhaps something is salvageable."
	icon_state = "ripley-broken"
	loot_element_path = /datum/element/lootable/mecha/ripley
/obj/structure/loot_pile/mecha/ripley/firefighter
	icon_state = "firefighter-broken"
/obj/structure/loot_pile/mecha/ripley/random_sprite
	icon_states_to_use = list("ripley-broken", "firefighter-broken", "ripley-broken-old")

/obj/structure/loot_pile/mecha/deathripley
	name = "strange ripley wreckage"
	icon_state = "deathripley-broken"
	loot_element_path = /datum/element/lootable/mecha/deathripley

/obj/structure/loot_pile/mecha/odysseus
	name = "odysseus wreckage"
	desc = "The ruins of some unfortunate odysseus. Perhaps something is salvageable."
	icon_state = "odysseus-broken"
	loot_element_path = /datum/element/lootable/mecha/odysseus
/obj/structure/loot_pile/mecha/odysseus/murdysseus
	icon_state = "murdysseus-broken"

/obj/structure/loot_pile/mecha/hoverpod
	name = "hoverpod wreckage"
	desc = "The ruins of some unfortunate hoverpod. Perhaps something is salvageable."
	icon_state = "engineering_pod"

/obj/structure/loot_pile/mecha/gygax
	name = "gygax wreckage"
	desc = "The ruins of some unfortunate gygax. Perhaps something is salvageable."
	icon_state = "gygax-broken"
	loot_element_path = /datum/element/lootable/mecha/gygax
/obj/structure/loot_pile/mecha/gygax/dark
	icon_state = "darkgygax-broken"
/obj/structure/loot_pile/mecha/gygax/dark/adv
	icon_state = "darkgygax_adv-broken"
	icon_scale_x = 1.5
	icon_scale_y = 1.5
	pixel_y = 8
/obj/structure/loot_pile/mecha/gygax/medgax
	icon_state = "medgax-broken"

/obj/structure/loot_pile/mecha/durand
	name = "durand wreckage"
	desc = "The ruins of some unfortunate durand. Perhaps something is salvageable."
	icon_state = "durand-broken"
	loot_element_path = /datum/element/lootable/mecha/durand

/obj/structure/loot_pile/mecha/marauder // Todo: Better loot.
	name = "marauder wreckage"
	desc = "The ruins of some unfortunate marauder. Perhaps something is salvagable."
	icon_state = "marauder-broken"

/obj/structure/loot_pile/mecha/marauder/seraph
	name = "seraph wreckage"
	desc = "The ruins of some unfortunate seraph. Perhaps something is salvagable."
	icon_state = "seraph-broken"
/obj/structure/loot_pile/mecha/marauder/mauler
	name = "mauler wreckage"
	desc = "The ruins of some unfortunate mauler. Perhaps something is salvagable."
	icon_state = "mauler-broken"

/obj/structure/loot_pile/mecha/phazon
	name = "phazon wreckage"
	desc = "The ruins of some unfortunate phazon. Perhaps something is salvageable."
	icon_state = "phazon-broken"
	loot_element_path = /datum/element/lootable/mecha/phazon


/obj/structure/loot_pile/surface/medicine_cabinet
	name = "abandoned medicine cabinet"
	desc = "An old cabinet, it might still have something of use inside."
	icon_state = "medicine_cabinet"
	density = FALSE
	loot_element_path = /datum/element/lootable/expired_medicine

/obj/structure/loot_pile/surface/medicine_cabinet/fresh
	name = "medicine cabinet"
	desc = "A cabinet designed to hold medicine, it might still have something of use inside."
	icon_state = "medicine_cabinet"
	density = FALSE
	loot_element_path = /datum/element/lootable/fresh_medicine
