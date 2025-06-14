/datum/species/sergal
	name = SPECIES_SERGAL
	name_plural = "Sergals"
	icobase = 'modular_chomp/icons/mob/human_races/r_sergal.dmi' //ChompEDIT - our icons
	deform = 'modular_chomp/icons/mob/human_races/r_def_sergal.dmi' //ChompEDIT - our icons
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	darksight = 8
	slowdown = -0.5
	//brute_mod = 1.15
	//burn_mod =  1.15
	//gluttonous = 1
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_SAGARU)
	name_language = LANGUAGE_SAGARU
	species_language = LANGUAGE_SAGARU
	color_mult = 1
	inherent_verbs = list(/mob/living/carbon/human/proc/tie_hair)
	digi_allowed = TRUE

	min_age = 18
	max_age = 110

	species_sounds = "Canine" // CHOMPEdit: Species sounds
	// male_scream_sound = null //CHOMPedit
	// female_scream_sound = null //CHOMPedit

	blurb = "There are two subspecies of Sergal; Southern and Northern. Northern sergals are a highly aggressive race \
	that lives in the plains and tundra of their homeworld. They are characterized by long, fluffy fur bodies with cold colors; \
	usually with white abdomens, somewhat short ears, and thick faces. Southern sergals are much more docile and live in the \
	Gold Ring City and are scattered around the outskirts in rural areas and small towns. They usually have short, brown or yellow \
	(or other 'earthy' colors) fur, long ears, and a long, thin face. They are smaller than their Northern relatives. Both have strong \
	racial tensions which has resulted in more than a number of wars and outright attempts at genocide. Sergals have an incredibly long \
	lifespan, but due to their lust for violence, only a handful have ever survived beyond the age of 80, such as the infamous and \
	legendary General Rain Silves who is claimed to have lived to 5000."

//CHOMPStation Removal
//	wikilink="https://www.yawn.ocry.com/Sergal"

	catalogue_data = list(/datum/category_item/catalogue/fauna/sergal)

	primitive_form = SPECIES_MONKEY_SERGAL

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	flesh_color = "#AFA59E"
	base_color = "#777777"

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	heat_discomfort_strings = list(
		"Your fur prickles in the heat.",
		"You feel uncomfortably warm.",
		"Your overheated skin itches."
		)

	has_limbs = list(
		BP_TORSO =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/sergal),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right)
		)

/datum/species/akula
	name = SPECIES_AKULA
	name_plural = "Akula"
	icobase = 'icons/mob/human_races/r_akula.dmi'
	deform = 'icons/mob/human_races/r_def_akula.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	//darksight = 8
	//slowdown = -0.5
	//brute_mod = 1.15
	//burn_mod =  1.15
	//gluttonous = 1
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_SPACER)
	name_language = LANGUAGE_SPACER
	species_language = LANGUAGE_SPACER
	color_mult = 1
	assisted_langs = list(LANGUAGE_EAL, LANGUAGE_ROOTLOCAL, LANGUAGE_ROOTGLOBAL, LANGUAGE_VOX, LANGUAGE_PROMETHEAN)
	inherent_verbs = list(/mob/living/carbon/human/proc/tie_hair, /mob/living/carbon/human/proc/water_stealth, /mob/living/carbon/human/proc/underwater_devour)
	min_age = 18
	//max_age = 80
	max_age = 110 //CHOMPedit
	digi_allowed = TRUE
	// male_scream_sound = null //CHOMPedit
	// female_scream_sound = null //CHOMPedit

	blurb = "The Akula are a species of amphibious humanoids like the Skrell, but have an appearance very similar to that of a shark. \
	They were first discovered as a primitive race of underwater dwelling tribal creatures by the Skrell. At first they were not believed \
	to be noteworthy, but the Akula proved to be such swift and clever learners that the Skrell reclassified them as sentients. Allegedly, \
	the Akula were also the first sentient life that the Skrell had ever encountered beside themselves, and thus the two species became swift \
	allies over the next few hundred years. With the help of Skrellean technology, the Akula had their genome modified to be capable of \
	surviving in open air for long periods of time. However, Akula even today still require a high humidity environment to avoid drying out \
	after a few days, which would make life on an arid world like Virgo-Prime nearly impossible if it were not for Skrellean technology to aid them."

//CHOMPStation Removal
//	wikilink="https://www.yawn.ocry.com/Akula"

	catalogue_data = list(/datum/category_item/catalogue/fauna/akula)

	primitive_form = SPECIES_MONKEY_AKULA

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	water_breather = TRUE
	water_movement = -4 //Negates shallow. Halves deep.
	swim_mult = 0.5

	flesh_color = "#AFA59E"
	base_color = "#777777"
	blood_color = "#1D2CBF"

/datum/species/nevrean
	name = SPECIES_NEVREAN
	name_plural = "Nevreans"
	icobase = 'icons/mob/human_races/r_nevrean.dmi'
	deform = 'icons/mob/human_races/r_def_nevrean.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	//darksight = 8
	//slowdown = -0.5
	//brute_mod = 1.15
	//burn_mod =  1.15
	//gluttonous = 1
	soft_landing = TRUE
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_BIRDSONG)
	name_language = LANGUAGE_BIRDSONG
	species_language = LANGUAGE_BIRDSONG
	color_mult = 1
	inherent_verbs = list(/mob/living/proc/flying_toggle,
		/mob/living/proc/flying_vore_toggle,
		/mob/living/proc/start_wings_hovering,
		/mob/living/carbon/human/proc/tie_hair)
	min_age = 18
	//max_age = 80
	max_age = 110 //CHOMPedit
	digi_allowed = TRUE
	// male_scream_sound = null //CHOMPedit
	// female_scream_sound = null //CHOMPedit
	// CHOMPEdit Start: Missing Sounds, so none for this race.

	blurb = "Nevreans are a race of avian and dinosaur-like creatures living on Tal. They belong to a group of races that hails from Eltus, \
	in the Vilous system. Unlike sergals whom they share a star system with, their species is a very peaceful one. They possess remarkable \
	intelligence and very skillful hands that are put use for constructing precision instruments, but tire-out fast when repeatedly working \
	over and over again. Consequently, they struggle to make copies of same things. Both genders have a voice that echoes a lot. Their natural \
	tone oscillates between tenor and soprano. They are excessively noisy when they quarrel in their native language."

//CHOMPStation Removal
//	wikilink="https://www.yawn.ocry.com/Nevrean"

	catalogue_data = list(/datum/category_item/catalogue/fauna/nevrean)

	primitive_form = SPECIES_MONKEY_NEVREAN

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	flesh_color = "#AFA59E"
	base_color = "#333333"

	heat_discomfort_strings = list(
		"Your fur prickles in the heat.",
		"You feel uncomfortably warm.",
		"Your overheated skin itches."
		)

/datum/species/hi_zoxxen
	name = SPECIES_ZORREN_HIGH
	name_plural = "Zorren"
	icobase = 'icons/mob/human_races/r_fox_vr.dmi'
	deform = 'icons/mob/human_races/r_def_fox.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_TERMINUS)
	name_language = LANGUAGE_TERMINUS
	species_language = LANGUAGE_TERMINUS
	inherent_verbs = list(/mob/living/carbon/human/proc/lick_wounds,
		/mob/living/proc/shred_limb,
		/mob/living/carbon/human/proc/tie_hair)
	assisted_langs = list(LANGUAGE_EAL, LANGUAGE_SKRELLIAN, LANGUAGE_ROOTLOCAL, LANGUAGE_ROOTGLOBAL, LANGUAGE_VOX)	//AEIOU edit: Zorren can speak Terminus unassisted.
	digi_allowed = TRUE

	min_age = 18
	max_age = 110

	// male_scream_sound = null //CHOMPedit
	// female_scream_sound = null //CHOMPedit
	species_sounds = "Vulpine" // CHOMPEdit: Species Sounds

	blurb = "The fennec-like, blue-blooded Zorren are native to Virgo 4/Menhir and are descendants of a precursor species \
			that is thought to be responsible for the near-collapse of the biosphere of the planet. \
			With societies organised around hierarchal caste systems (such as the Royal Zorren) or freedom and strength (such as the Free Tribe Zorren), \
			they now slowly recover from their previous hubris and aim to revitalize their planet. While many Zorren live in pre-industrial conditions by necessity, \
			they are an interstellar species known for their pride and stubbornness and doggedly hold out on a Deathworld of their own creation. \
			As local species, they hold moderate sway on local corporations and are hired by NT and other companies, although they find \"Outlander\" culture deeply weird."
	wikilink="https://wiki.torchstation13.net/index.php?title=Zorren" //CHOMPEdit: link to our wiki //TORCHEdit - Torch links

	catalogue_data = list(/datum/category_item/catalogue/fauna/zorren)

	//primitive_form = "" //We don't have fox-monkey sprites.

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR
	flesh_color = "#AFA59E"
	base_color = "#333333"
	blood_color = "#240bc4"
	blood_reagents = REAGENT_ID_COPPER
	reagent_tag = IS_ZORREN
	color_mult = 1

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	heat_discomfort_strings = list(
		"Your fur prickles in the heat.",
		"You feel uncomfortably warm.",
		"Your overheated skin itches."
		)

/datum/species/vulpkanin
	name = SPECIES_VULPKANIN
	name_plural = "Vulpkanin"
	blurb = "Vulpkanin are a species of sharp-witted canine-pideds residing on the planet Altam just barely within the \
	dual-star Vazzend system. Their politically de-centralized society and independent natures have led them to become a species and \
	culture both feared and respected for their scientific breakthroughs. Discovery, loyalty, and utilitarianism dominates their lifestyles \
	to the degree it can cause conflict with more rigorous and strict authorities. They speak a guttural language known as 'Canilunzt' \
	which has a heavy emphasis on utilizing tail positioning and ear twitches to communicate intent." //CHOMPedit
	icobase = 'icons/mob/human_races/r_vulpkanin.dmi'
	deform = 'icons/mob/human_races/r_vulpkanin.dmi'
//	path = /mob/living/carbon/human/vulpkanin
//	default_language = "Sol Common"
	secondary_langs = list(LANGUAGE_CANILUNZT)
	name_language = LANGUAGE_CANILUNZT
	species_language = LANGUAGE_CANILUNZT
	primitive_form = SPECIES_MONKEY_VULPKANIN
	tail = "vulptail"
	tail_animation = 'icons/mob/species/vulpkanin/tail.dmi' // probably need more than just one of each, but w/e
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	darksight = 5 //worse than cats, but better than lizards. -- Poojawa
//	gluttonous = 1
	num_alternate_languages = 3
	color_mult = 1
	inherent_verbs = list(/mob/living/carbon/human/proc/lick_wounds,
		/mob/living/carbon/human/proc/tie_hair)
	digi_allowed = TRUE

	// male_scream_sound = list('sound/voice/scream/canine/wolf_scream.ogg', 'sound/voice/scream/canine/wolf_scream2.ogg', 'sound/voice/scream/canine/wolf_scream3.ogg', 'sound/voice/scream/canine/wolf_scream4.ogg', 'sound/voice/scream/canine/wolf_scream5.ogg', 'sound/voice/scream/canine/wolf_scream6.ogg') //CHOMPedit: Scream sounds, finally, 3 years later.
	// female_scream_sound = list('sound/voice/scream/canine/wolf_scream.ogg', 'sound/voice/scream/canine/wolf_scream2.ogg', 'sound/voice/scream/canine/wolf_scream3.ogg', 'sound/voice/scream/canine/wolf_scream4.ogg', 'sound/voice/scream/canine/wolf_scream5.ogg', 'sound/voice/scream/canine/wolf_scream6.ogg') //CHOMPedit: Scream sounds, finally, 3 years later.
	// CHOMPEdit Start: Add Pain/Gasp/Death sounds
	pain_verb_1p = list("yelp", "growl")
	pain_verb_3p = list("yelps", "growls")

	species_sounds = "Canine"

	// CHOMPEdit End

//CHOMPStation Removal
//	wikilink="https://wiki.vore-station.net/Backstory#Vulpkanin"

	catalogue_data = list(/datum/category_item/catalogue/fauna/vulpkanin)

	//Furry fox-like animals shouldn't start freezing at 5 degrees celsius.
	//Minor cold is resisted, but not severe frost.
	cold_discomfort_level = 263 //Not as good at surviving the frost as tajara, but still better than humans.

	cold_level_1 = 243 //Default 260, other values remain at default. Starts taking damage at -30 celsius. Default tier 2 is -70 and tier 3 is -150


	breath_cold_level_1 = 220 // Default 240, lower is better.

	//While foxes can survive in deserts, that's handled by zorren. It's a good contrast that our vulp find heat a little uncomfortable.

	heat_discomfort_level = 295 //Just above standard 20 C to avoid heat message spam, same as Taj

	heat_level_1 = 345 //Default 360
	heat_level_2 = 390 //Default 400
	heat_level_3 = 900 //Default 1000

	breath_heat_level_1 = 370	//Default 380 - Higher is better
	breath_heat_level_2 = 445	//Default 450
	breath_heat_level_3 = 1125	//Default 1250

	primitive_form = SPECIES_MONKEY_VULPKANIN

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	flesh_color = "#966464"
	base_color = "#B43214"

	min_age = 18
	max_age = 110

	heat_discomfort_strings = list(
		"Your fur prickles in the heat.",
		"You feel uncomfortably warm.",
		"Your overheated skin itches."
		)

/datum/species/unathi
	mob_size = MOB_MEDIUM //To allow normal mob swapping
	spawn_flags = SPECIES_CAN_JOIN //Species_can_join is the only spawn flag all the races get, so that none of them will be whitelist only if whitelist is enabled.
	icobase = 'icons/mob/human_races/r_lizard_vr.dmi'
	deform = 'icons/mob/human_races/r_def_lizard_vr.dmi'
	tail_animation = 'icons/mob/species/unathi/tail_vr.dmi'
	color_mult = 1
	min_age = 40 //ChompEDIT - Unathi lore minimal adult age.
	inherent_verbs = list(/mob/living/carbon/human/proc/tie_hair)
	gluttonous = 0
	inherent_verbs = list(/mob/living/proc/shred_limb)
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	descriptors = list()

//CHOMPSedit: link to our wiki
	wikilink="https://wiki.torchstation13.net/index.php?title=Unathi" //TORCHEdit - Torch links

/datum/species/tajaran
	spawn_flags = SPECIES_CAN_JOIN
	icobase = 'icons/mob/human_races/r_tajaran_vr.dmi'
	deform = 'icons/mob/human_races/r_def_tajaran_vr.dmi'
	tail_animation = 'icons/mob/species/tajaran/tail_vr.dmi'
	color_mult = 1
	min_age = 18
	inherent_verbs = list(/mob/living/carbon/human/proc/tie_hair)
	allergens = null
	gluttonous = 0 //Moving this here so I don't have to fix this conflict every time polaris glances at station.dm
	inherent_verbs = list(/mob/living/carbon/human/proc/lick_wounds)
	heat_discomfort_level = 295 //Prevents heat discomfort spam at 20c

//CHOMPSedit: links to our wiki
	wikilink="https://wiki.torchstation13.net/index.php?title=Tajaran" //TORCHEdit - Torch links
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	agility = 90
	can_climb = TRUE
	climbing_delay = 1.00 //Cats are good climbers.

/datum/species/skrell
	spawn_flags = SPECIES_CAN_JOIN
	icobase = 'icons/mob/human_races/r_skrell_vr.dmi'
	deform = 'icons/mob/human_races/r_def_skrell_vr.dmi'
	color_mult = 1
	min_age = 19 //ChompEDIT Lore-based adulthood age for this species is greater than 18.
	inherent_verbs = list(/mob/living/carbon/human/proc/tie_hair, /mob/living/carbon/human/proc/water_stealth, /mob/living/carbon/human/proc/underwater_devour)
	reagent_tag = null
	allergens = null
	assisted_langs = list(LANGUAGE_EAL, LANGUAGE_ROOTLOCAL, LANGUAGE_ROOTGLOBAL, LANGUAGE_VOX, LANGUAGE_PROMETHEAN)

//CHOMPedit: link to our wiki
	wikilink="https://wiki.torchstation13.net/index.php?title=Skrell" //TORCHEdit - Torch links
	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	water_breather = TRUE
	water_movement = -4 //Negates shallow. Halves deep.

/datum/species/zaddat
	spawn_flags = SPECIES_CAN_JOIN
	min_age = 18
	inherent_verbs = list(/mob/living/carbon/human/proc/tie_hair) //I don't even know if Zaddat can HAVE hair, but here we are, I suppose
	gluttonous = 0
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	descriptors = list()

//CHOMPedit: link to our wiki
	wikilink="https://wiki.torchstation13.net/index.php?title=Zaddat" //TORCHEdit - Torch links

/datum/species/zaddat/equip_survival_gear(var/mob/living/carbon/human/H)
	.=..()
	var/obj/item/storage/toolbox/lunchbox/survival/zaddat/L = new(get_turf(H))
	if(H.backbag == 1)
		H.equip_to_slot_or_del(L, slot_r_hand)
	else
		H.equip_to_slot_or_del(L, slot_in_backpack)

/datum/species/diona
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_WHITELIST_SELECTABLE	//CHOMPStation Edit: restore whitelist requirement
	min_age = 18
	wikilink="https://wiki.torchstation13.net/index.php?title=Diona" //CHOMPedit //TORCHEdit - Torch links
	genders = list(MALE, FEMALE, PLURAL, NEUTER)

//CHOMPedit start
/datum/species/shapeshifter/promethean
	spawn_flags = SPECIES_CAN_JOIN
	wikilink="https://wiki.torchstation13.net/index.php?title=Promethean" //TORCHEdit - Torch links
//CHOMPedit end

/datum/species/human
	blurb = "Humanity originated in the Sol system, and over the last five centuries has spread \
	colonies across a wide swathe of space. They hold a wide range of forms and creeds.<br/><br/> \
	While the central Sol government maintains control of its far-flung people, powerful corporate \
	interests, rampant cyber and bio-augmentation and secretive factions make life on most human \
	worlds tumultous at best." //CHOMPedit: blurb variable
	color_mult = 1
	icobase = 'icons/mob/human_races/r_human_vr.dmi'
	deform = 'icons/mob/human_races/r_def_human_vr.dmi'
	appearance_flags = HAS_HAIR_COLOR | HAS_SKIN_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_EYE_COLOR
	min_age = 18
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	base_color = "#EECEB3"

//CHOMPedit: link to our wiki
	wikilink="https://wiki.torchstation13.net/index.php?title=Humans" //TORCHEdit - Torch links

/datum/species/human/vatgrown
	spawn_flags = SPECIES_IS_RESTRICTED

/datum/species/vox
	gluttonous = 0
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_WHITELIST_SELECTABLE
	min_age = 18
	inherent_verbs = list(/mob/living/carbon/human/proc/tie_hair) //Get ya quills done did
	icobase = 'icons/mob/human_races/r_vox_old.dmi'
	tail = "voxtail"
	tail_animation = 'icons/mob/species/vox/tail.dmi'
	deform = 'icons/mob/human_races/r_def_vox_old.dmi'
	color_mult = 1

	descriptors = list(
		/datum/mob_descriptor/vox_markings = 0
		)

//CHOMPedit: link to our wiki
	wikilink="https://wiki.torchstation13.net/index.php?title=Vox" //TORCHEdit - Torch links

/datum/species/harpy
	name = SPECIES_RAPALA
	name_plural = "Rapalans"
	icobase = 'icons/mob/human_races/r_harpy_vr.dmi'
	deform = 'icons/mob/human_races/r_def_harpy_vr.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/punch, /datum/unarmed_attack/bite)
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_BIRDSONG, LANGUAGE_UNATHI)
	species_language = LANGUAGE_UNATHI
	name_language = null
	color_mult = 1
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	inherent_verbs = list(/mob/living/proc/flying_toggle,/mob/living/proc/flying_vore_toggle,/mob/living/proc/start_wings_hovering,/mob/living/carbon/human/proc/tie_hair)
	digi_allowed = TRUE

	min_age = 18
	max_age = 80

	soft_landing = TRUE

	base_color = "#EECEB3"


	blurb = "An Avian species, coming from a distant planet, the Rapalas are the very proud race.\
	Sol researchers have commented on them having a very close resemblance to the mythical race called 'Harpies',\
	who are known for having massive winged arms and talons as feet. They've been clocked at speeds of over 35 miler per hour chasing the planet's many fish-like fauna.\
	The Rapalan's home-world 'Verita' is a strangely habitable gas giant, while no physical earth exists, there are fertile floating islands orbiting around the planet from past asteroid activity."

//CHOMPStation Removal
//	wikilink="https://www.yawn.ocry.com/Rapala"

	catalogue_data = list(/datum/category_item/catalogue/fauna/rapala)

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR


	heat_discomfort_strings = list(
		"Your feathers prickle in the heat.",
		"You feel uncomfortably warm.",
		"Your overheated skin itches."
		)

/datum/species/crew_shadekin
	name = SPECIES_SHADEKIN_CREW
	name_plural = "Black-Eyed Shadekin"
	icobase = 'icons/mob/human_races/r_shadekin_vr.dmi'
	deform = 'icons/mob/human_races/r_shadekin_vr.dmi'
	tail = "tail"
	icobase_tail = 1
	// male_scream_sound = null //CHOMPedit
	// female_scream_sound = null //CHOMPedit
	blurb = "Very little is known about these creatures. They appear to be largely mammalian in appearance. \
	Seemingly very rare to encounter, there have been widespread myths of these creatures the galaxy over, \
	but next to no verifiable evidence to their existence. However, they have recently been more verifiably \
	documented in the Virgo system, following a mining bombardment of Virgo 3. The crew of NSB Adephagia have \
	taken to calling these creatures 'Shadekin', and the name has generally stuck and spread. "		//TODO: Something more fitting for black-eyes

//CHOMPStation Removal
//	wikilink = "https://wiki.vore-station.net/Shadekin"
	catalogue_data = list(/datum/category_item/catalogue/fauna/shadekin)
	digi_allowed = TRUE

	language = LANGUAGE_SHADEKIN
	name_language = LANGUAGE_SHADEKIN
	species_language = LANGUAGE_SHADEKIN
	secondary_langs = list(LANGUAGE_SHADEKIN)
	num_alternate_languages = 3
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	rarity_value = 5	//INTERDIMENSIONAL FLUFFERS

	inherent_verbs = list(/mob/proc/adjust_hive_range)

	siemens_coefficient = 0
	darksight = 10

	slowdown = 0.5
	item_slowdown_mod = 1.5

	total_health = 75
	brute_mod = 1.25 // Frail
	burn_mod = 1.25	// Furry
	blood_volume = 500
	hunger_factor = 0.2

	warning_low_pressure = 50
	hazard_low_pressure = -1

	warning_high_pressure = 300
	hazard_high_pressure = INFINITY

	cold_level_1 = -1	//Immune to cold
	cold_level_2 = -1
	cold_level_3 = -1

	heat_level_1 = 850	//Resistant to heat
	heat_level_2 = 1000
	heat_level_3 = 1150

	flags =  NO_DNA | NO_SLEEVE
	spawn_flags = SPECIES_IS_RESTRICTED //SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_WHITELIST_SELECTABLE CHOMPedit: disabled maybe forever

	reagent_tag = IS_SHADEKIN		// for shadekin-unqiue chem interactions

	flesh_color = "#FFC896"
	blood_color = "#A10808"
	base_color = "#f0f0f0"
	color_mult = 1

	//has_glowing_eyes = TRUE			// Applicable through traits.

	/* // CHOMPEdit: Not defined
	male_cough_sounds = null
	female_cough_sounds = null
	male_sneeze_sound = null
	female_sneeze_sound = null
	*/

	speech_bubble_appearance = "ghost"

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	breath_type = null
	poison_type = null
	water_breather = TRUE //They do not quite breathe...

	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_SKIN_COLOR | HAS_UNDERWEAR

	move_trail = /obj/effect/decal/cleanable/blood/tracks/paw

	has_organ = list(
		O_HEART =		/obj/item/organ/internal/heart,
		O_VOICE = 		/obj/item/organ/internal/voicebox,
		O_LIVER =		/obj/item/organ/internal/liver,
		O_KIDNEYS =		/obj/item/organ/internal/kidneys,
		O_BRAIN =		/obj/item/organ/internal/brain,
		O_EYES =		/obj/item/organ/internal/eyes,
		O_STOMACH =		/obj/item/organ/internal/stomach,
		O_INTESTINE =	/obj/item/organ/internal/intestine
		)

	has_limbs = list(
		BP_TORSO =  list("path" = /obj/item/organ/external/chest/crewkin),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin/crewkin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/crewkin),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm/crewkin),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/crewkin),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg/crewkin),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/crewkin),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/crewkin),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/crewkin),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/crewkin),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/crewkin)
		)

/datum/species/crew_shadekin/get_bodytype()
	return SPECIES_SHADEKIN

//These species are not really species but are just there for custom species selection

/datum/species/fl_zorren
	name = SPECIES_FENNEC
	name_plural = "Fennec"
	icobase = 'icons/mob/human_races/r_fennec_vr.dmi'
	deform = 'icons/mob/human_races/r_def_fennec.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_TERMINUS)
	name_language = LANGUAGE_TERMINUS
	species_language = LANGUAGE_TERMINUS
	inherent_verbs = list(/mob/living/carbon/human/proc/lick_wounds,/mob/living/proc/shred_limb,/mob/living/carbon/human/proc/tie_hair)
	digi_allowed = TRUE

	min_age = 18
	max_age = 80

	// male_scream_sound = null //CHOMPedit
	// female_scream_sound = null //CHOMPedit
	species_sounds = "Vulpine" // CHOMPEdit: Species Sounds

	//primitive_form = "" //We don't have fennec-monkey sprites.
	spawn_flags = SPECIES_IS_RESTRICTED
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR
	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	flesh_color = "#AFA59E"
	base_color = "#333333"
	blood_color = "#240bc4"
	color_mult = 1

	heat_discomfort_strings = list(
		"Your fur prickles in the heat.",
		"You feel uncomfortably warm.",
		"Your overheated skin itches."
		)

/datum/species/xenohybrid
	name = SPECIES_XENOHYBRID
	name_plural = "Xenomorphs"
	icobase = 'icons/mob/human_races/r_xenomorph.dmi'
	deform = 'icons/mob/human_races/r_def_xenomorph.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	darksight = 4 //Better hunters in the dark.
	hunger_factor = 0.1 //In exchange, they get hungry a tad faster.
	num_alternate_languages = 3
	digi_allowed = TRUE

	min_age = 18
	max_age = 80

	species_sounds = "Xeno"
	// male_scream_sound = list('sound/effects/mob_effects/x_scream1.ogg','sound/effects/mob_effects/x_scream2.ogg','sound/effects/mob_effects/x_scream3.ogg') //CHOMPedit Scree
	// female_scream_sound = list('sound/effects/mob_effects/x_scream1.ogg','sound/effects/mob_effects/x_scream2.ogg','sound/effects/mob_effects/x_scream3.ogg') //CHOMPedit

	blurb = "Xenomorphs hybrids are a mixture of xenomorph DNA and some other humanoid species. \
	Xenomorph hyrids mostly have had had their natural aggression removed due to the gene modification process \
	although there are some exceptions, such as when they are harmed. Most xenomorph hybrids are female, due to their natural xenomorph genes, \
	but there are multiple exceptions. All xenomorph hybrids have had their ability to lay eggs containing facehuggers \
	removed if they had the ability to, although hybrids that previously contained this ability is extremely rare."
	// No wiki page for xenohybrids at present

	//primitive_form = "" //None for these guys

	spawn_flags = SPECIES_IS_RESTRICTED
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR
	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	blood_color = "#12ff12"
	flesh_color = "#201730"
	base_color = "#201730"

	heat_discomfort_strings = list(
		"Your chitin feels extremely warm.",
		"You feel uncomfortably warm.",
		"Your chitin feels hot."
		)

/datum/species/altevian
	name = SPECIES_ALTEVIAN
	name_plural = "Altevians"
	icobase = 'icons/mob/human_races/r_altevian.dmi'
	deform = 'icons/mob/human_races/r_def_altevian.dmi'
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_TAVAN)
	species_language = LANGUAGE_TAVAN
	name_language = null
	color_mult = 1
	inherent_verbs = list(/mob/living/carbon/human/proc/tie_hair)
	digi_allowed = TRUE

	min_age = 18
	max_age = 80

	blurb = "The Altevian are a species of tall, rodent humanoids that are akin to rats for their features. \
	The Altevian, unlike most species, do not have a home planet, nor system, adopting a fully nomadic lifestyle \
	for their survival across the stars. Instead, they have opted to live in massive super capital-class colony-ships \
	with a flagship as their place they would call home."

	// wikilink="https://wiki.vore-station.net/Altevian" //CHOMPedit

	catalogue_data = list(/datum/category_item/catalogue/fauna/altevian)

	species_sounds = "Mouse" // CHOMPEdit: Species Sounds

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	flesh_color = "#AFA59E"
	base_color = "#777777"

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	burn_mod =  1.15
	hunger_factor = 0.04
	can_zero_g_move = TRUE

	heat_discomfort_strings = list(
		"Your fur prickles in the heat.",
		"You feel uncomfortably warm.",
		"Your overheated skin itches."
		)

	has_limbs = list(
		BP_TORSO =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right)
		)
