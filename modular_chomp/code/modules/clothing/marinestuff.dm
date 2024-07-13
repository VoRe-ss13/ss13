
///Temporary storage for all this/// -- Serdy


/obj/item/clothing/suit/storage/vest/marine_exoarmor
	name = "MX-04 modular armor"
	desc = "A modular exoskeletal armor originally developed for the Solarian Marine corps during the first war against the xenomorph, XX-121. This model is cutting edge."
	slowdown = 0
	icon = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_override = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_state = "suit_bw"
	armor = list(melee = 65, bullet = 55, laser = 55, energy = 55, bomb = 25, bio = 70, rad = 100)
	flags = THICKMATERIAL
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	body_parts_covered = HEAD|UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	w_class = ITEMSIZE_NORMAL

/obj/item/clothing/head/helmet/marine_exohelm
	name = "MX-04 helmet"
	desc = "A modular helmet for the MX-04 exoskeleton, originally developed for the Solarian Marine corps during the first war against the xenomorph, XX-121. This model is cutting edge."
	icon = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_override = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_state = "helm_bw"
	valid_accessory_slots = (ACCESSORY_SLOT_HELM_C)
	restricted_accessory_slots = (ACCESSORY_SLOT_HELM_C)
	flags = THICKMATERIAL
	armor = list(melee = 60, bullet = 50, laser = 50, energy = 50, bomb = 10, bio = 70, rad = 100)
	flags_inv = null
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.7
	w_class = ITEMSIZE_NORMAL
	ear_protection = 1
	drop_sound = 'sound/items/drop/helm.ogg'
	pickup_sound = 'sound/items/pickup/helm.ogg'

/obj/item/clothing/suit/storage/vest/marine_armor
	name = "PAS-11 armor vest"
	desc = "A legacy armor system for the Solarian Marines, effective against most threats."
	slowdown = 0
	icon = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_override = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_state = "pasvest"
	armor = list(melee = 45, bullet = 65, laser = 35, energy = 35, bomb = 0, bio = 50, rad = 0)
	flags = THICKMATERIAL
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	w_class = ITEMSIZE_NORMAL

/obj/item/clothing/head/helmet/marine_helm
	name = "M-10 helmet"
	desc = "A legacy helmet for the Solarian Marines, effective against most threats."
	icon = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_override = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_state = "pashelm"
	valid_accessory_slots = (ACCESSORY_SLOT_HELM_C)
	restricted_accessory_slots = (ACCESSORY_SLOT_HELM_C)
	flags = THICKMATERIAL
	armor = list(melee = 40, bullet = 50, laser = 20, energy = 20, bomb = 10, bio = 40, rad = 0)
	flags_inv = null
	cold_protection = HEAD
	heat_protection = HEAD
	siemens_coefficient = 0.7
	w_class = ITEMSIZE_NORMAL
	ear_protection = 1
	drop_sound = 'sound/items/drop/helm.ogg'
	pickup_sound = 'sound/items/pickup/helm.ogg'

/obj/item/clothing/head/marine_beret
	name = "marine beret"
	desc = "A Solarian Marines service beret, with a red flash."
	icon = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_override = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_state = "beret_mar"

/obj/item/clothing/suit/storage/vest/marine_jacket
	name = "marine jacket"
	desc = "A lightly armored marine service jacket."
	slowdown = 0
	icon = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_override = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_state = "jacket_mar"
	armor = list(melee = 25, bullet = 25, laser = 25, energy = 20, bomb = 0, bio = 20, rad = 0)
	flags = THICKMATERIAL
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	w_class = ITEMSIZE_NORMAL

/obj/item/clothing/under/syndicate/marine_uni //Merc Tactleneck
	name = "marine jumpsuit"
	desc = "A black, lightly reinforced jumpsuit, worn by Solarian Marines."
	icon = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_override = 'modular_chomp/icons/inventory/suit/marinearmor.dmi'
	icon_state = "marine_uni"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	has_sensor = 0
	armor = list(melee = 5, bullet = 5, laser = 5,energy = 5, bomb = 5, bio = 5, rad = 0)
	siemens_coefficient = 0.9