//Since it didn't really belong in any other category, I'm putting this here
//This is for procs to replace all the goddamn 'in world's that are chilling around the code

var/global/list/player_list = list()				//List of all mobs **with clients attached**. Excludes /mob/new_player
var/global/list/mob_list = list()					//List of all mobs, including clientless
var/global/list/human_mob_list = list()				//List of all human mobs and sub-types, including clientless
var/global/list/silicon_mob_list = list()			//List of all silicon mobs, including clientless
var/global/list/ai_list = list()					//List of all AIs, including clientless
var/global/list/living_mob_list = list()			//List of all alive mobs, including clientless. Excludes /mob/new_player
var/global/list/dead_mob_list = list()				//List of all dead mobs, including clientless. Excludes /mob/new_player
var/global/list/observer_mob_list = list()			//List of all /mob/observer/dead, including clientless.
var/global/list/listening_objects = list()			//List of all objects which care about receiving messages (communicators, radios, etc)
var/global/list/cleanbot_reserved_turfs = list()	//List of all turfs currently targeted by some cleanbot

var/global/list/cable_list = list()					//Index for all cables, so that powernets don't have to look through the entire world all the time
var/global/list/landmarks_list = list()				//list of all landmarks created
var/global/list/event_triggers = list()				//Associative list of creator_ckey:list(landmark references) for event triggers
var/global/list/surgery_steps = list()				//list of all surgery steps  |BS12
var/global/list/side_effects = list()				//list of all medical sideeffects types by thier names |BS12
var/global/list/mechas_list = list()				//list of all mechs. Used by hostile mobs target tracking.
var/global/list/joblist = list()					//list of all jobstypes, minus borg and AI

#define all_genders_define_list list(MALE,FEMALE,PLURAL,NEUTER,HERM) //VOREStaton Edit
#define all_genders_text_list list("Male","Female","Plural","Neuter","Herm") //VOREStation Edit
#define pronoun_set_to_genders list(\
			"He/Him" = MALE,\
			"She/Her" = FEMALE,\
			"It/Its" = NEUTER,\
			"They/Them" = PLURAL,\
			"Shi/Hir" = HERM\
			)
#define genders_to_pronoun_set list(\
			MALE = "He/Him",\
			FEMALE = "She/Her",\
			NEUTER = "It/Its",\
			PLURAL = "They/Them",\
			HERM = "Shi/Hir"\
			)

var/list/mannequins_

// Times that players are allowed to respawn ("ckey" = world.time)
GLOBAL_LIST_EMPTY(respawn_timers)

// Holomaps
var/global/list/holomap_markers = list()
var/global/list/mapping_units = list()
var/global/list/mapping_beacons = list()

//Preferences stuff
	//Hairstyles
var/global/list/hair_styles_list = list()			//stores /datum/sprite_accessory/hair indexed by name
var/global/list/hair_styles_male_list = list()
var/global/list/hair_styles_female_list = list()
var/global/list/facial_hair_styles_list = list()	//stores /datum/sprite_accessory/facial_hair indexed by name
var/global/list/facial_hair_styles_male_list = list()
var/global/list/facial_hair_styles_female_list = list()
var/global/list/skin_styles_female_list = list()		//unused
var/global/list/body_marking_styles_list = list()		//stores /datum/sprite_accessory/marking indexed by name
var/global/list/body_marking_nopersist_list = list()	// Body marking styles, minus non-genetic markings and augments
var/global/list/ear_styles_list = list()	// Stores /datum/sprite_accessory/ears indexed by type
var/global/list/tail_styles_list = list()	// Stores /datum/sprite_accessory/tail indexed by type
var/global/list/wing_styles_list = list()	// Stores /datum/sprite_accessory/wing indexed by type

GLOBAL_LIST_INIT(custom_species_bases, new) // Species that can be used for a Custom Species icon base
	//Underwear
var/datum/category_collection/underwear/global_underwear = new()

	//Customizables
GLOBAL_LIST_INIT(headsetlist, list("Standard","Bowman","Earbud"))
var/global/list/backbaglist = list("Nothing", "Backpack", "Satchel", "Satchel Alt", "Messenger Bag", "Sports Bag", "Strapless Satchel")
var/global/list/pdachoicelist = list("Default", "Slim", "Old", "Rugged", "Holographic", "Wrist-Bound","Slider", "Vintage")
var/global/list/exclude_jobs = list(/datum/job/ai,/datum/job/cyborg)

// Visual nets
var/list/datum/visualnet/visual_nets = list()
var/datum/visualnet/camera/cameranet = new()
var/datum/visualnet/cult/cultnet = new()
var/datum/visualnet/ghost/ghostnet = new()

// Runes
var/global/list/rune_list = new()
var/global/list/escape_list = list()
var/global/list/endgame_exits = list()
var/global/list/endgame_safespawns = list()

var/global/list/syndicate_access = list(access_maint_tunnels, access_syndicate, access_external_airlocks)

// Ores (for mining)
GLOBAL_LIST_EMPTY(ore_data)
GLOBAL_LIST_EMPTY(alloy_data)

// Strings which corraspond to bodypart covering flags, useful for outputting what something covers.
var/global/list/string_part_flags = list(
	"head" = HEAD,
	"face" = FACE,
	"eyes" = EYES,
	"upper body" = UPPER_TORSO,
	"lower body" = LOWER_TORSO,
	"legs" = LEGS,
	"feet" = FEET,
	"arms" = ARMS,
	"hands" = HANDS
)

// Strings which corraspond to slot flags, useful for outputting what slot something is.
var/global/list/string_slot_flags = list(
	"back" = SLOT_BACK,
	"face" = SLOT_MASK,
	"waist" = SLOT_BELT,
	"ID slot" = SLOT_ID,
	"ears" = SLOT_EARS,
	"eyes" = SLOT_EYES,
	"hands" = SLOT_GLOVES,
	"head" = SLOT_HEAD,
	"feet" = SLOT_FEET,
	"exo slot" = SLOT_OCLOTHING,
	"body" = SLOT_ICLOTHING,
	"uniform" = SLOT_TIE,
	"holster" = SLOT_HOLSTER
)

GLOBAL_LIST_EMPTY(mannequins)
/proc/get_mannequin(var/ckey = "NULL")
	var/mob/living/carbon/human/dummy/mannequin/M = GLOB.mannequins[ckey]
	if(!istype(M))
		GLOB.mannequins[ckey] = new /mob/living/carbon/human/dummy/mannequin(null)
		M = GLOB.mannequins[ckey]
	return M

/proc/del_mannequin(var/ckey = "NULL")
	GLOB.mannequins-= ckey

//////////////////////////
/////Initial Building/////
//////////////////////////

/proc/makeDatumRefLists()
	var/list/paths

	//Hair - Initialise all /datum/sprite_accessory/hair into an list indexed by hair-style name
	paths = subtypesof(/datum/sprite_accessory/hair)
	for(var/path in paths)
		var/datum/sprite_accessory/hair/H = new path()
		hair_styles_list[H.name] = H
		switch(H.gender)
			if(MALE)	hair_styles_male_list += H.name
			if(FEMALE)	hair_styles_female_list += H.name
			else
				hair_styles_male_list += H.name
				hair_styles_female_list += H.name

	//Facial Hair - Initialise all /datum/sprite_accessory/facial_hair into an list indexed by facialhair-style name
	paths = subtypesof(/datum/sprite_accessory/facial_hair)
	for(var/path in paths)
		var/datum/sprite_accessory/facial_hair/H = new path()
		facial_hair_styles_list[H.name] = H
		switch(H.gender)
			if(MALE)	facial_hair_styles_male_list += H.name
			if(FEMALE)	facial_hair_styles_female_list += H.name
			else
				facial_hair_styles_male_list += H.name
				facial_hair_styles_female_list += H.name

	//Body markings - Initialise all /datum/sprite_accessory/marking into an list indexed by marking name
	paths = subtypesof(/datum/sprite_accessory/marking)
	for(var/path in paths)
		var/datum/sprite_accessory/marking/M = new path()
		body_marking_styles_list[M.name] = M
		if(!M.genetic)
			body_marking_nopersist_list[M.name] = M

	//Surgery Steps - Initialize all /datum/surgery_step into a list
	paths = subtypesof(/datum/surgery_step)
	for(var/T in paths)
		var/datum/surgery_step/S = new T
		surgery_steps += S
	sort_surgeries()

	//List of job. I can't believe this was calculated multiple times per tick!
	paths = subtypesof(/datum/job)
	paths -= exclude_jobs
	for(var/T in paths)
		var/datum/job/J = new T
		joblist[J.title] = J

	//Languages
	paths = subtypesof(/datum/language)
	for(var/T in paths)
		var/datum/language/L = new T
		if (isnull(GLOB.all_languages[L.name]))
			GLOB.all_languages[L.name] = L
		else
			log_debug("Language name conflict! [T] is named [L.name], but that is taken by [GLOB.all_languages[L.name].type]")
			if(isnull(GLOB.language_name_conflicts[L.name]))
				GLOB.language_name_conflicts[L.name] = list(GLOB.all_languages[L.name])
			GLOB.language_name_conflicts[L.name] += L

	for (var/language_name in GLOB.all_languages)
		var/datum/language/L = GLOB.all_languages[language_name]
		if(!(L.flags & NONGLOBAL))
			if(isnull(GLOB.language_keys[L.key]))
				GLOB.language_keys[L.key] = L
			else
				log_debug("Language key conflict! [L] has key [L.key], but that is taken by [(GLOB.language_keys[L.key])]")
				if(isnull(GLOB.language_key_conflicts[L.key]))
					GLOB.language_key_conflicts[L.key] = list(GLOB.language_keys[L.key])
				GLOB.language_key_conflicts[L.key] += L

	//Species
	var/rkey = 0
	paths = subtypesof(/datum/species)
	for(var/T in paths)

		rkey++

		var/datum/species/S = T
		if(!initial(S.name))
			continue

		S = new T
		S.race_key = rkey //Used in mob icon caching.
		GLOB.all_species[S.name] = S

	//Shakey shakey shake
	sortTim(GLOB.all_species, GLOBAL_PROC_REF(cmp_species), associative = TRUE)

	//Split up the rest
	for(var/speciesname in GLOB.all_species)
		var/datum/species/S = GLOB.all_species[speciesname]
		if(!(S.spawn_flags & SPECIES_IS_RESTRICTED))
			GLOB.playable_species += S.name
		if(S.spawn_flags & SPECIES_IS_WHITELISTED)
			GLOB.whitelisted_species += S.name

	// Suit cyclers
	paths = subtypesof(/datum/suit_cycler_choice/department)
	for(var/datum/suit_cycler_choice/SCC as anything in paths)
		if(!initial(SCC.name))
			continue
		GLOB.suit_cycler_departments += new SCC()
	paths = subtypesof(/datum/suit_cycler_choice/species)
	for(var/datum/suit_cycler_choice/SCC as anything in paths)
		if(!initial(SCC.name))
			continue
		GLOB.suit_cycler_species += new SCC()
	paths = subtypesof(/datum/suit_cycler_choice/department/emag)
	for(var/datum/suit_cycler_choice/SCC as anything in paths)
		if(!initial(SCC.name))
			continue
		GLOB.suit_cycler_emagged += new SCC()

	//Ores
	paths = subtypesof(/ore)
	for(var/oretype in paths)
		var/ore/OD = new oretype()
		GLOB.ore_data[OD.name] = OD

	paths = subtypesof(/datum/alloy)
	for(var/alloytype in paths)
		GLOB.alloy_data += new alloytype()

	//Closet appearances
	GLOB.closet_appearances = decls_repository.get_decls_of_type(/decl/closet_appearance)

	paths = subtypesof(/datum/sprite_accessory/ears)
	for(var/path in paths)
		var/obj/item/clothing/head/instance = new path()
		ear_styles_list[path] = instance

	// Custom Tails
	paths = subtypesof(/datum/sprite_accessory/tail) - /datum/sprite_accessory/tail/taur
	for(var/path in paths)
		var/datum/sprite_accessory/tail/instance = new path()
		tail_styles_list[path] = instance

	// Custom Wings
	paths = subtypesof(/datum/sprite_accessory/wing)
	for(var/path in paths)
		var/datum/sprite_accessory/wing/instance = new path()
		wing_styles_list[path] = instance

	// VOREStation Add - Vore Modes!
	paths = typesof(/datum/digest_mode)
	for(var/T in paths)
		var/datum/digest_mode/DM = new T
		GLOB.digest_modes[DM.id] = DM
	// VOREStation Add End
	init_crafting_recipes(GLOB.crafting_recipes)

/*
	// Custom species traits
	paths = subtypesof(/datum/trait)
	for(var/path in paths)
		var/datum/trait/instance = new path()
		if(!instance.name)
			continue //A prototype or something
		var/cost = instance.cost
		traits_costs[path] = cost
		all_traits[path] = instance
		switch(cost)
			if(-INFINITY to -0.1)
				negative_traits[path] = instance
			if(0)
				neutral_traits[path] = instance
			if(0.1 to INFINITY)
				positive_traits[path] = instance
*/

	// Custom species icon bases
	var/list/blacklisted_icons = list(SPECIES_CUSTOM,SPECIES_PROMETHEAN) //VOREStation Edit
	var/list/whitelisted_icons = list(SPECIES_FENNEC,SPECIES_XENOHYBRID,SPECIES_VOX,SPECIES_SHADEKIN) //CHOMPedit
	for(var/species_name in GLOB.playable_species)
		if(species_name in blacklisted_icons)
			continue
		var/datum/species/S = GLOB.all_species[species_name]
		if(S.spawn_flags & SPECIES_IS_WHITELISTED)
			continue
		GLOB.custom_species_bases += species_name
	for(var/species_name in whitelisted_icons)
		GLOB.custom_species_bases += species_name

	return 1 // Hooks must return 1


/// Inits the crafting recipe list, sorting crafting recipe requirements in the process.
/proc/init_crafting_recipes(list/crafting_recipes)
	for(var/path in subtypesof(/datum/crafting_recipe))
		var/datum/crafting_recipe/recipe = new path()
		recipe.reqs = sortList(recipe.reqs, GLOBAL_PROC_REF(cmp_crafting_req_priority))
		crafting_recipes += recipe
	return crafting_recipes
/* // Uncomment to debug chemical reaction list.
/client/verb/debug_chemical_list()

	for (var/reaction in chemical_reactions_list)
		. += "chemical_reactions_list\[\"[reaction]\"\] = \"[chemical_reactions_list[reaction]]\"\n"
		if(islist(chemical_reactions_list[reaction]))
			var/list/L = chemical_reactions_list[reaction]
			for(var/t in L)
				. += "    has: [t]\n"
	to_world(.)
*/
//Hexidecimal numbers
var/global/list/hexNums = list("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F")

/*
// Many global vars aren't GLOB type. This puts them there to be more easily inspected.
GLOBAL_LIST_EMPTY(legacy_globals)

/proc/populate_legacy_globals()
	//Note: these lists cannot be changed to a new list anywhere in code!
	//If they are, these will cause the old list to stay around!
	//Check by searching for "<GLOBAL_NAME> =" in the entire codebase
	GLOB.legacy_globals["player_list"] = player_list
	GLOB.legacy_globals["mob_list"] = mob_list
	GLOB.legacy_globals["human_mob_list"] = human_mob_list
	GLOB.legacy_globals["silicon_mob_list"] = silicon_mob_list
	GLOB.legacy_globals["ai_list"] = ai_list
	GLOB.legacy_globals["living_mob_list"] = living_mob_list
	GLOB.legacy_globals["dead_mob_list"] = dead_mob_list
	GLOB.legacy_globals["observer_mob_list"] = observer_mob_list
	GLOB.legacy_globals["listening_objects"] = listening_objects
	GLOB.legacy_globals["cleanbot_reserved_turfs"] = cleanbot_reserved_turfs
	GLOB.legacy_globals["cable_list"] = cable_list
	GLOB.legacy_globals["landmarks_list"] = landmarks_list
	GLOB.legacy_globals["event_triggers"] = event_triggers
	GLOB.legacy_globals["side_effects"] = side_effects
	GLOB.legacy_globals["mechas_list"] = mechas_list
	GLOB.legacy_globals["mannequins_"] = mannequins_
	//visual nets
	GLOB.legacy_globals["visual_nets"] = visual_nets
	GLOB.legacy_globals["cameranet"] = cameranet
	GLOB.legacy_globals["cultnet"] = cultnet
	GLOB.legacy_globals["item_tf_spawnpoints"] = item_tf_spawnpoints
	GLOB.legacy_globals["existing_solargrubs"] = GLOB.existing_solargrubs
	*/

var/global/list/selectable_footstep = list(
	"Default" = FOOTSTEP_MOB_HUMAN,
	"Claw" = FOOTSTEP_MOB_CLAW,
	"Light Claw" = FOOTSTEP_MOB_TESHARI,
	"Slither" = FOOTSTEP_MOB_SLITHER,
)

// Put any artifact effects that are duplicates, unique, or otherwise unwated in here! This prevents them from spawning via RNG.
var/global/list/blacklisted_artifact_effects = list(
	/datum/artifact_effect/gas/sleeping,
	/datum/artifact_effect/gas/oxy,
	/datum/artifact_effect/gas/carbondiox,
	/datum/artifact_effect/gas/fuel,
	/datum/artifact_effect/gas/nitro,
	/datum/artifact_effect/gas/phoron,
	/datum/artifact_effect/extreme
)

//stuff that only synths can eat
var/global/list/edible_tech = list(/obj/item/cell,
				/obj/item/circuitboard,
				/obj/item/integrated_circuit,
				/obj/item/broken_device,
				/obj/item/brokenbug,
				)

var/global/list/item_digestion_blacklist = list(
		/obj/item/hand_tele,
		/obj/item/card/id,
		/obj/item/gun,
		/obj/item/pinpointer,
		/obj/item/clothing/shoes/magboots,
		/obj/item/areaeditor/blueprints,
		/obj/item/disk/nuclear,
		/obj/item/perfect_tele_beacon,
		/obj/item/organ/internal/brain/slime,
		/obj/item/mmi/digital/posibrain,
		/obj/item/mmi/digital/robot,
		/obj/item/rig/protean)

///A list of chemicals that are banned from being obtainable through means that generate chemicals. These chemicals are either lame, annoying, pref-breaking, or OP (This list does NOT include reactions)
GLOBAL_LIST_INIT(obtainable_chemical_blacklist, list(
	REAGENT_ID_ADMINORDRAZINE,
	REAGENT_ID_NUTRIMENT,
	REAGENT_ID_MACROCILLIN,
	REAGENT_ID_MICROCILLIN,
	REAGENT_ID_NORMALCILLIN,
	REAGENT_ID_MAGICDUST,
	REAGENT_ID_SUPERMATTER
	))

var/global/list/item_tf_spawnpoints = list() // Global variable tracking which items are item tf spawnpoints

// Options for transforming into a different mob in virtual reality.
var/global/list/vr_mob_tf_options = list(
	"Borg" = /mob/living/silicon/robot,
	"Cortical borer" = /mob/living/simple_mob/animal/borer/non_antag,
	"Hyena" = /mob/living/simple_mob/animal/hyena, //TODO: Port from Downstream //CHOMPStation Enable
	"Giant spider" = /mob/living/simple_mob/animal/giant_spider/thermic,
	"Armadillo" = /mob/living/simple_mob/animal/passive/armadillo, //TODO: Port from Downstream //CHOMPStation Enable
	"Parrot" = /mob/living/simple_mob/animal/passive/bird/parrot,
	"Cat" = /mob/living/simple_mob/animal/passive/cat,
	"Corgi" = /mob/living/simple_mob/animal/passive/dog/corgi,
	"Squirrel" = /mob/living/simple_mob/vore/squirrel,
	"Frog" = /mob/living/simple_mob/vore/aggressive/frog,
	"Seagull" =/mob/living/simple_mob/vore/seagull,
	"Fox" = /mob/living/simple_mob/animal/passive/fox,
	"Racoon" = /mob/living/simple_mob/animal/passive/raccoon_ch, //TODO: Port from Downstream //CHOMPStation Enable
	"Shantak" = /mob/living/simple_mob/animal/sif/shantak,
	"Goose" = /mob/living/simple_mob/animal/space/goose,
	"Space shark" = /mob/living/simple_mob/animal/space/shark,
	"Synx" = /mob/living/simple_mob/animal/synx, //TODO: Port from Downstream //CHOMPStation Enable
	"Dire wolf" = /mob/living/simple_mob/vore/wolf/direwolf,
	"Construct Artificer" = /mob/living/simple_mob/construct/artificer,
	"Tech golem" = /mob/living/simple_mob/mechanical/technomancer_golem,
	"Metroid" = /mob/living/simple_mob/metroid/juvenile/baby, //TODO: Port from Downstream //CHOMPStation Enable
	"Otie" = /mob/living/simple_mob/vore/otie/cotie/chubby,
	"Red-eyed Shadekin" = /mob/living/simple_mob/shadekin/red,
	"Blue-eyed Shadekin" = /mob/living/simple_mob/shadekin/blue,
	"Purple-eyed Shadekin" = /mob/living/simple_mob/shadekin/purple,
	"Green-eyed Shadekin" = /mob/living/simple_mob/shadekin/green,
	"Yellow-eyed Shadekin" = /mob/living/simple_mob/shadekin/yellow,
	"Slime" = /mob/living/simple_mob/slime/xenobio/metal,
	"Corrupt hound" = /mob/living/simple_mob/vore/aggressive/corrupthound,
	"Deathclaw" = /mob/living/simple_mob/vore/aggressive/deathclaw/den, //Downstream uses /den variant here. //CHOMPStation Enable
	"Weretiger" = /mob/living/simple_mob/vore/weretiger,
	"Mimic" = /mob/living/simple_mob/vore/aggressive/mimic/floor/plating, //Downstream uses /floor/plating variant here //CHOMPStation Enable
	"Giant rat" = /mob/living/simple_mob/vore/aggressive/rat,
	"Catslug" = /mob/living/simple_mob/vore/alienanimals/catslug,
	"Dust jumper" = /mob/living/simple_mob/vore/alienanimals/dustjumper,
	"Space ghost" = /mob/living/simple_mob/vore/alienanimals/spooky_ghost,
	"Teppi" = /mob/living/simple_mob/vore/alienanimals/teppi,
	"Bee" = /mob/living/simple_mob/vore/bee,
	"Dragon" = /mob/living/simple_mob/vore/bigdragon/friendly,
	"Riftwalker" = /mob/living/simple_mob/vore/demon/wendigo, //Downstream uses /wendigo variant here //CHOMPStation Enable
	"Horse" = /mob/living/simple_mob/vore/horse/big,
	"Morph" = /mob/living/simple_mob/vore/morph,
	"Leopardmander" = /mob/living/simple_mob/vore/leopardmander,
	"Rabbit" = /mob/living/simple_mob/vore/rabbit,
	"Red panda" = /mob/living/simple_mob/vore/redpanda,
	"Sect drone" = /mob/living/simple_mob/vore/sect_drone,
	"Armalis vox" = /mob/living/simple_mob/vox/armalis, //TODO: Port from Downstream //CHOMPStation Enable
	"Xeno hunter" = /mob/living/simple_mob/xeno_ch/hunter, //TODO: Port from Downstream //CHOMPStation Enable
	"Xeno queen" = /mob/living/simple_mob/xeno_ch/queen/maid, //TODO: Port from Downstream //CHOMPStation Enable
	"Xeno sentinel" = /mob/living/simple_mob/xeno_ch/sentinel, //TODO: Port from Downstream //CHOMPStation Enable
	"Space carp" = /mob/living/simple_mob/animal/space/carp,
	"Jelly blob" = /mob/living/simple_mob/vore/jelly,
	"SWOOPIE XL" = /mob/living/simple_mob/vore/aggressive/corrupthound/swoopie, //TODO: Port from Downstream //CHOMPStation Enable
	"Abyss lurker" = /mob/living/simple_mob/vore/vore_hostile/abyss_lurker,
	"Abyss leaper" = /mob/living/simple_mob/vore/vore_hostile/leaper,
	"Gelatinous cube" = /mob/living/simple_mob/vore/vore_hostile/gelatinous_cube,
	"Gryphon" = /mob/living/simple_mob/vore/gryphon //TODO: Port from Downstream //CHOMPStation Enable
	)

var/global/list/vr_mob_spawner_options = list(
	"Parrot" = /mob/living/simple_mob/animal/passive/bird/parrot,
	"Rabbit" = /mob/living/simple_mob/vore/rabbit,
	"Cat" = /mob/living/simple_mob/animal/passive/cat,
	"Fox" = /mob/living/simple_mob/animal/passive/fox,
	"Cow" = /mob/living/simple_mob/animal/passive/cow,
	"Dog" = /mob/living/simple_mob/vore/woof,
	"Horse" = /mob/living/simple_mob/vore/horse/big,
	"Hippo" = /mob/living/simple_mob/vore/hippo,
	"Sheep" = /mob/living/simple_mob/vore/sheep,
	"Squirrel" = /mob/living/simple_mob/vore/squirrel,
	"Red panda" = /mob/living/simple_mob/vore/redpanda,
	"Fennec" = /mob/living/simple_mob/vore/fennec,
	"Seagull" =/mob/living/simple_mob/vore/seagull,
	"Corgi" = /mob/living/simple_mob/animal/passive/dog/corgi,
	"Armadillo" = /mob/living/simple_mob/animal/passive/armadillo, //TODO: Port from Downstream //CHOMPStation Enable
	"Racoon" = /mob/living/simple_mob/animal/passive/raccoon_ch, //TODO: Port from Downstream //CHOMPStation Enable
	"Goose" = /mob/living/simple_mob/animal/space/goose,
	"Frog" = /mob/living/simple_mob/vore/aggressive/frog,
	"Dust jumper" = /mob/living/simple_mob/vore/alienanimals/dustjumper,
	"Dire wolf" = /mob/living/simple_mob/vore/wolf/direwolf,
	"Space bumblebee" = /mob/living/simple_mob/vore/bee,
	"Space bear" = /mob/living/simple_mob/animal/space/bear,
	"Otie" = /mob/living/simple_mob/vore/otie,
	"Mutated otie" =/mob/living/simple_mob/vore/otie/feral,
	"Red otie" = /mob/living/simple_mob/vore/otie/red,
	"Giant rat" = /mob/living/simple_mob/vore/aggressive/rat,
	"Giant snake" = /mob/living/simple_mob/vore/aggressive/giant_snake,
	"Hyena" = /mob/living/simple_mob/animal/hyena, //TODO: Port from Downstream //CHOMPStation Enable
	"Space shark" = /mob/living/simple_mob/animal/space/shark,
	"Shantak" = /mob/living/simple_mob/animal/sif/shantak,
	"Kururak" = /mob/living/simple_mob/animal/sif/kururak,
	"Teppi" = /mob/living/simple_mob/vore/alienanimals/teppi,
	"Slug" = /mob/living/simple_mob/vore/slug, //TODO: Port from Downstream //CHOMPStation Enable
	"Catslug" = /mob/living/simple_mob/vore/alienanimals/catslug,
	"Weretiger" = /mob/living/simple_mob/vore/weretiger,
	"Dust jumper" = /mob/living/simple_mob/vore/alienanimals/dustjumper,
	"Star treader" = /mob/living/simple_mob/vore/alienanimals/startreader,
	"Space ghost" = /mob/living/simple_mob/vore/alienanimals/spooky_ghost,
	"Space carp" = /mob/living/simple_mob/animal/space/carp,
	"Space jelly fish" = /mob/living/simple_mob/vore/alienanimals/space_jellyfish,
	"Abyss lurker" = /mob/living/simple_mob/vore/vore_hostile/abyss_lurker,
	"Abyss leaper" = /mob/living/simple_mob/vore/vore_hostile/leaper,
	"Gelatinous cube" = /mob/living/simple_mob/vore/vore_hostile/gelatinous_cube,
	"Panther" = /mob/living/simple_mob/vore/aggressive/panther,
	"Lizard man" = /mob/living/simple_mob/vore/aggressive/lizardman, //TODO: Port from Downstream //CHOMPStation Enable
	"Pakkun" = /mob/living/simple_mob/vore/pakkun,
	"Synx" = /mob/living/simple_mob/animal/synx, //TODO: Port from Downstream //CHOMPStation Enable
	"Jelly blob" = /mob/living/simple_mob/vore/jelly,
	"Voracious lizard" = /mob/living/simple_mob/vore/aggressive/dino,
	"Baby metroid" = /mob/living/simple_mob/metroid/juvenile/baby, //TODO: Port from Downstream //CHOMPStation Enable
	"Super metroid" = /mob/living/simple_mob/metroid/juvenile/super, //TODO: Port from Downstream //CHOMPStation Enable
	"Alpha metroid" = /mob/living/simple_mob/metroid/juvenile/alpha, //TODO: Port from Downstream //CHOMPStation Enable
	"Gamma metroid" = /mob/living/simple_mob/metroid/juvenile/gamma, //TODO: Port from Downstream //CHOMPStation Enable
	"Zeta metroid" = /mob/living/simple_mob/metroid/juvenile/zeta, //TODO: Port from Downstream //CHOMPStation Enable
	"Omega metroid" = /mob/living/simple_mob/metroid/juvenile/omega, //TODO: Port from Downstream //CHOMPStation Enable
	"Queen metroid" = /mob/living/simple_mob/metroid/juvenile/queen, //TODO: Port from Downstream //CHOMPStation Enable
	"Xeno hunter" = /mob/living/simple_mob/animal/space/alien,
	"Xeno sentinel" = /mob/living/simple_mob/animal/space/alien/sentinel,
	"Xeno Praetorian" = /mob/living/simple_mob/animal/space/alien/sentinel/praetorian,
	"Xeno queen" = /mob/living/simple_mob/animal/space/alien/queen,
	"Xeno Empress" = /mob/living/simple_mob/animal/space/alien/queen/empress,
	"Xeno Queen Mother" = /mob/living/simple_mob/animal/space/alien/queen/empress/mother,
	"Defanged xeno" = /mob/living/simple_mob/vore/xeno_defanged,
	"Sect drone" = /mob/living/simple_mob/vore/sect_drone,
	"Sect queen" = /mob/living/simple_mob/vore/sect_queen,
	"Deathclaw" = /mob/living/simple_mob/vore/aggressive/deathclaw,
	"Great White Wolf" = /mob/living/simple_mob/vore/greatwolf,
	"Great Black Wolf" = /mob/living/simple_mob/vore/greatwolf/black,
	"Solar grub" = /mob/living/simple_mob/vore/solargrub,
	"Pitcher plant" = /mob/living/simple_mob/vore/pitcher_plant, //TODO: Port from Downstream //CHOMPStation Enable
	"Red gummy kobold" = /mob/living/simple_mob/vore/candy/redcabold, //TODO: Port from Downstream //CHOMPStation Enable
	"Blue gummy kobold" = /mob/living/simple_mob/vore/candy/bluecabold, //TODO: Port from Downstream //CHOMPStation Enable
	"Yellow gummy kobold" = /mob/living/simple_mob/vore/candy/yellowcabold, //TODO: Port from Downstream //CHOMPStation Enable
	"Marshmellow serpent" = /mob/living/simple_mob/vore/candy/marshmellowserpent, //TODO: Port from Downstream //CHOMPStation Enable
	"Riftwalker" = /mob/living/simple_mob/vore/demon,
	"Wendigo" = /mob/living/simple_mob/vore/demon/wendigo, //TODO: Port from Downstream //CHOMPStation Enable
	"Shadekin" = /mob/living/simple_mob/shadekin,
	"Catgirl" = /mob/living/simple_mob/vore/catgirl,
	"Wolfgirl" = /mob/living/simple_mob/vore/wolfgirl,
	"Wolftaur" = /mob/living/simple_mob/vore/wolftaur,
	"Lamia" = /mob/living/simple_mob/vore/lamia,
	"Corrupt hound" = /mob/living/simple_mob/vore/aggressive/corrupthound,
	"Corrupt corrupt hound" = /mob/living/simple_mob/vore/aggressive/corrupthound/prettyboi,
	"SWOOPIE XL" = /mob/living/simple_mob/vore/aggressive/corrupthound/swoopie, //TODO: Port from Downstream //CHOMPStation Enable
	"Cultist Teshari" = /mob/living/simple_mob/humanoid/cultist/tesh, //TODO: Port from Downstream //CHOMPStation Enable
	"Burning Mage" = /mob/living/simple_mob/humanoid/cultist/human/bloodjaunt/fireball, //TODO: Port from Downstream //CHOMPStation Enable
	"Converted" = /mob/living/simple_mob/humanoid/cultist/noodle, //TODO: Port from Downstream //CHOMPStation Enable
	"Cultist Teshari Mage" = /mob/living/simple_mob/humanoid/cultist/castertesh, //TODO: Port from Downstream //CHOMPStation Enable
	"Monkey" = /mob/living/carbon/human/monkey,
	"Wolpin" = /mob/living/carbon/human/wolpin,
	"Sparra" = /mob/living/carbon/human/sparram,
	"Saru" = /mob/living/carbon/human/sergallingm,
	"Sobaka" = /mob/living/carbon/human/sharkm,
	"Farwa" = /mob/living/carbon/human/farwa,
	"Neaera" = /mob/living/carbon/human/neaera,
	"Stok" = /mob/living/carbon/human/stok,
	//"Gryphon" = /mob/living/simple_mob/vore/gryphon // Disabled until tested
	)
<<<<<<< HEAD
=======

/var/all_ui_styles_robot = list(
	"Midnight"     = 'icons/mob/screen1_robot.dmi',
	"Orange"       = 'icons/mob/screen1_robot.dmi',
	"old"          = 'icons/mob/screen1_robot.dmi',
	"White"        = 'icons/mob/screen1_robot.dmi',
	"old-noborder" = 'icons/mob/screen1_robot.dmi',
	"minimalist"   = 'icons/mob/screen1_robot_minimalist.dmi',
	"Hologram"     = 'icons/mob/screen1_robot_minimalist.dmi'
	)

GLOBAL_LIST_INIT(all_tooltip_styles, list(
	"Midnight",		//Default for everyone is the first one,
	"Plasmafire",
	"Retro",
	"Slimecore",
	"Operative",
	"Clockwork"
	))

//Global Datums
var/global/datum/pipe_icon_manager/icon_manager
var/global/datum/emergency_shuttle_controller/emergency_shuttle = new

// We manually initialize the alarm handlers instead of looping over all existing types
// to make it possible to write: camera_alarm.triggerAlarm() rather than SSalarm.managers[datum/alarm_handler/camera].triggerAlarm() or a variant thereof.
/var/global/datum/alarm_handler/atmosphere/atmosphere_alarm	= new()
/var/global/datum/alarm_handler/camera/camera_alarm			= new()
/var/global/datum/alarm_handler/fire/fire_alarm				= new()
/var/global/datum/alarm_handler/motion/motion_alarm			= new()
/var/global/datum/alarm_handler/power/power_alarm			= new()

GLOBAL_LIST_EMPTY(gun_choices)

GLOBAL_LIST_INIT(severity_to_string, list(
	EVENT_LEVEL_MUNDANE = "Mundane",
	EVENT_LEVEL_MODERATE = "Moderate",
	EVENT_LEVEL_MAJOR = "Major"
	))

//Some global icons for the examine tab to use to display some item properties.
GLOBAL_LIST_INIT(description_icons, list(
	"melee_armor" = image(icon='icons/mob/screen1_stats.dmi',icon_state="melee_protection"),
	"bullet_armor" = image(icon='icons/mob/screen1_stats.dmi',icon_state="bullet_protection"),
	"laser_armor" = image(icon='icons/mob/screen1_stats.dmi',icon_state="laser_protection"),
	"energy_armor" = image(icon='icons/mob/screen1_stats.dmi',icon_state="energy_protection"),
	"bomb_armor" = image(icon='icons/mob/screen1_stats.dmi',icon_state="bomb_protection"),
	"radiation_armor" = image(icon='icons/mob/screen1_stats.dmi',icon_state="radiation_protection"),
	"biohazard_armor" = image(icon='icons/mob/screen1_stats.dmi',icon_state="biohazard_protection"),

	"offhand" = image(icon='icons/mob/screen1_stats.dmi',icon_state="offhand"),

	"welder" = image(icon='icons/obj/tools.dmi',icon_state="welder"),
	"wirecutters" = image(icon='icons/obj/tools.dmi',icon_state="cutters"),
	"screwdriver" = image(icon='icons/obj/tools.dmi',icon_state="screwdriver"),
	"wrench" = image(icon='icons/obj/tools.dmi',icon_state="wrench"),
	"crowbar" = image(icon='icons/obj/tools.dmi',icon_state="crowbar"),
	"multitool" = image(icon='icons/obj/device.dmi',icon_state="multitool"),
	"cable coil" = image(icon='icons/obj/power.dmi',icon_state="coil"), // VOREStation Edit

	"metal sheet" = image(icon='icons/obj/items.dmi',icon_state="sheet-metal"),
	"plasteel sheet" = image(icon='icons/obj/items.dmi',icon_state="sheet-plasteel"),

	"air tank" = image(icon='icons/obj/tank.dmi',icon_state="oxygen"),
	"connector" = image(icon='icons/obj/pipes.dmi',icon_state="connector"),

	"stunbaton" = image(icon='icons/obj/weapons.dmi',icon_state="stunbaton_active"),
	"slimebaton" = image(icon='icons/obj/weapons.dmi',icon_state="slimebaton_active"),

	"power cell" = image(icon='icons/obj/power.dmi',icon_state="hcell"),
	"device cell" = image(icon='icons/obj/power.dmi',icon_state="dcell"),
	"weapon cell" = image(icon='icons/obj/power.dmi',icon_state="wcell"),

	"hatchet" = image(icon='icons/obj/weapons.dmi',icon_state="hatchet"),
	))

// TODO - Optimize this into numerics if this ends up working out
GLOBAL_LIST_INIT(MOVE_KEY_MAPPINGS, list(
	"North" = NORTH_KEY,
	"South" = SOUTH_KEY,
	"East" = EAST_KEY,
	"West" = WEST_KEY,
	"W" = W_KEY,
	"A" = A_KEY,
	"S" = S_KEY,
	"D" = D_KEY,
	"Shift" = SHIFT_KEY,
	"Ctrl" = CTRL_KEY,
	"Alt" = ALT_KEY,
))

GLOBAL_LIST_EMPTY(total_extraction_beacons)

GLOBAL_LIST_INIT(possible_ghost_sprites, list(
	"Clear" = "blank",
	"Green Blob" = "otherthing",
	"Bland" = "ghost",
	"Robed-B" = "ghost1",
	"Robed-BAlt" = "ghost2",
	"King" = "ghostking",
	"Shade" = "shade",
	"Hecate" = "ghost-narsie",
	"Glowing Statue" = "armour",
	"Artificer" = "artificer",
	"Behemoth" = "behemoth",
	"Harvester" = "harvester",
	"Wraith" = "wraith",
	"Viscerator" = "viscerator",
	"Corgi" = "corgi",
	"Tamaskan" = "tamaskan",
	"Black Cat" = "blackcat",
	"Lizard" = "lizard",
	"Goat" = "goat",
	"Space Bear" = "bear",
	"Bats" = "bat",
	"Chicken" = "chicken_white",
	"Parrot"= "parrot_fly",
	"Goose" = "goose",
	"Penguin" = "penguin",
	"Brown Crab" = "crab",
	"Gray Crab" = "evilcrab",
	"Trout" = "trout-swim",
	"Salmon" = "salmon-swim",
	"Pike" = "pike-swim",
	"Koi" = "koi-swim",
	"Carp" = "carp",
	"Red Robes" = "robe_red",
	"Faithless" = "faithless",
	"Shadowform" = "forgotten",
	"Dark Ethereal" = "bloodguardian",
	"Holy Ethereal" = "lightguardian",
	"Red Elemental" = "magicRed",
	"Blue Elemental" = "magicBlue",
	"Pink Elemental" = "magicPink",
	"Orange Elemental" = "magicOrange",
	"Green Elemental" = "magicGreen",
	"Daemon" = "daemon",
	"Guard Spider" = "guard",
	"Hunter Spider" = "hunter",
	"Nurse Spider" = "nurse",
	"Rogue Drone" = "drone",
	"ED-209" = "ed209",
	"Beepsky" = "secbot"
	))

GLOBAL_LIST_EMPTY(sparring_attack_cache)

GLOBAL_LIST_EMPTY(protean_abilities)

//PAI stuff
GLOBAL_LIST_INIT(possible_chassis, list(
	"Drone" = "pai-repairbot",
	"Cat" = "pai-cat",
	"Mouse" = "pai-mouse",
	"Monkey" = "pai-monkey",
	"Borgi" = "pai-borgi",
	"Fox" = "pai-fox",
	"Parrot" = "pai-parrot",
	"Rabbit" = "pai-rabbit",
	"Dire wolf" = "pai-diredog",
	"Horse (Lune)" = "pai-horse_lune",
	"Horse (Soleil)" = "pai-horse_soleil",
	"Dragon" = "pai-pdragon",
	"Bear" = "pai-bear",
	"Fennec" = "pai-fen",
	"Type Zero" = "pai-typezero",
	"Raccoon" = "pai-raccoon",
	"Raptor" = "pai-raptor",
	"Corgi" = "pai-corgi",
	"Bat" = "pai-bat",
	"Butterfly" = "pai-butterfly",
	"Hawk" = "pai-hawk",
	"Duffel" = "pai-duffel",
	"Rat" = "rat",
	"Panther" = "panther",
	"Cyber Elf" = "cyberelf",
	"Teppi" = "teppi",
	"Catslug" = "catslug",
	"Car" = "car",
	"Type One" = "typeone",
	"Type Thirteen" = "13",
	"Protogen Dog" = "pai-protodog"
	))

//PAI stuff
GLOBAL_LIST_INIT(possible_say_verbs, list(
	"Robotic" = list("states","declares","queries"),
	"Natural" = list("says","yells","asks"),
	"Beep" = list("beeps","beeps loudly","boops"),
	"Chirp" = list("chirps","chirrups","cheeps"),
	"Feline" = list("purrs","yowls","meows"),
	"Canine" = list("yaps","barks","woofs"),
	"Rodent" = list("squeaks", "SQUEAKS", "sqiks")
	))

//Borg modules
GLOBAL_LIST_INIT(robot_modules, list(
	"Standard"		= /obj/item/robot_module/robot/standard,
	"Service" 		= /obj/item/robot_module/robot/clerical/butler,
	"Clerical" 		= /obj/item/robot_module/robot/clerical/general,
	"Clown"			= /obj/item/robot_module/robot/clerical/honkborg,
	"Command"		= /obj/item/robot_module/robot/chound,
	"Research" 		= /obj/item/robot_module/robot/research,
	"Miner" 		= /obj/item/robot_module/robot/miner,
	"Crisis" 		= /obj/item/robot_module/robot/medical/crisis,
	"Surgeon" 		= /obj/item/robot_module/robot/medical/surgeon,
	"Security" 		= /obj/item/robot_module/robot/security/general,
	"Combat" 		= /obj/item/robot_module/robot/security/combat,
	"Exploration"	= /obj/item/robot_module/robot/exploration,
	"Engineering"	= /obj/item/robot_module/robot/engineering,
	"Janitor" 		= /obj/item/robot_module/robot/janitor,
	"Gravekeeper"	= /obj/item/robot_module/robot/gravekeeper,
	"Lost"			= /obj/item/robot_module/robot/lost,
	"Protector" 	= /obj/item/robot_module/robot/syndicate/protector,
	"Mechanist" 	= /obj/item/robot_module/robot/syndicate/mechanist,
	"Combat Medic"	= /obj/item/robot_module/robot/syndicate/combat_medic,
	"Ninja" 		= /obj/item/robot_module/robot/syndicate/ninja,
	))


//Xenoarch stuff
/// <summary>
/// This is a list of what the depth_scanner can show, depending on what get_responsive_reagent returns below.
/// </summary>
GLOBAL_LIST_INIT(responsive_carriers, list(
	REAGENT_ID_CARBON,
	REAGENT_ID_POTASSIUM,
	REAGENT_ID_HYDROGEN,
	REAGENT_ID_NITROGEN,
	REAGENT_BLOOD,
	REAGENT_ID_MERCURY,
	REAGENT_ID_IRON,
	REAGENT_ID_PHORON))

/// <summary>
/// This is a list of what the depth_scanner shows the user. In order with the above list.
/// </summary>
/// <example>
/// If the get_responsive_reagent returns 'REAGENT_ID_CARBON' it will show up to the user as "Trace organic cells"
/// If the get_responsive_reagent returns "REAGENT_ID_CHLORINE" it will show up to the user as "Metamorphic/igneous rock composite"
/// </example>
GLOBAL_LIST_INIT(finds_as_strings, list(
	"Trace organic cells", 							//Carbon
	"Long exposure particles", 						//Potassium
	"Trace water particles", 						//Hydrogen
	"Crystalline structures", 						//Nitrogen
	"Abnormal energy signatures",					//Occult
	"Metallic derivative", 							//Mercury
	"Metallic composite", 							//Iron
	"Anomalous material")) 							//Phoron


//tgui law manager
var/global/list/datum/ai_laws/admin_laws
var/global/list/datum/ai_laws/player_laws

//shield_gen/external
GLOBAL_LIST_INIT(external_shield_gen_blockedturfs,  list(
	/turf/space,
	/turf/simulated/floor/outdoors,
))

//machinery/shieldgen
GLOBAL_LIST_INIT(shieldgen_blockedturfs,  list(
	/turf/space,
	/turf/simulated/floor/outdoors,
))

//Reagent Grinders
// Don't need a new list for every grinder in the game
GLOBAL_LIST_INIT(sheet_reagents, list( //have a number of reagents divisible by REAGENTS_PER_SHEET (default 20) unless you like decimals.
	/obj/item/stack/material/plastic = list(REAGENT_ID_CARBON,REAGENT_ID_CARBON,REAGENT_ID_OXYGEN,REAGENT_ID_CHLORINE,REAGENT_ID_SULFUR),
	/obj/item/stack/material/copper = list(REAGENT_ID_COPPER),
	/obj/item/stack/material/graphite = list(REAGENT_ID_CARBON),
	/obj/item/stack/material/aluminium = list(REAGENT_ID_ALUMINIUM),
	/obj/item/stack/material/diamond = list(REAGENT_ID_CARBON),
	/obj/item/stack/material/durasteel = list(REAGENT_ID_IRON,REAGENT_ID_IRON,REAGENT_ID_CARBON,REAGENT_ID_CARBON,REAGENT_ID_PLATINUM),
	/obj/item/stack/material/wax = list(REAGENT_ID_ETHANOL,REAGENT_ID_TRIGLYCERIDE),
	/obj/item/stack/material/iron = list(REAGENT_ID_IRON),
	/obj/item/stack/material/phoron = list(REAGENT_ID_PHORON),
	/obj/item/stack/material/gold = list(REAGENT_ID_GOLD),
	/obj/item/stack/material/silver = list(REAGENT_ID_SILVER),
	/obj/item/stack/material/platinum = list(REAGENT_ID_PLATINUM),
	/obj/item/stack/material/osmium = list(REAGENT_ID_PLATINUM), // This should be fixed someday
	/obj/item/stack/material/steel = list(REAGENT_ID_IRON, REAGENT_ID_CARBON),
	/obj/item/stack/material/plasteel = list(REAGENT_ID_IRON, REAGENT_ID_IRON, REAGENT_ID_CARBON, REAGENT_ID_CARBON, REAGENT_ID_PLATINUM), //8 iron, 8 carbon, 4 platinum,
	/obj/item/stack/material/sandstone = list(REAGENT_ID_SILICON, REAGENT_ID_OXYGEN),
	/obj/item/stack/material/marble = list(REAGENT_ID_CALCIUM),
	/obj/item/stack/material/titanium = list(REAGENT_ID_ALUMINIUM),
	// Nuclear
	/obj/item/stack/material/mhydrogen = list(REAGENT_ID_HYDROGEN),
	/obj/item/stack/material/deuterium = list(REAGENT_ID_HYDROGEN),
	/obj/item/stack/material/tritium = list(REAGENT_ID_HYDROGEN),
	/obj/item/stack/material/uranium = list(REAGENT_ID_URANIUM),
	/obj/item/stack/material/supermatter = list(REAGENT_ID_SUPERMATTER),
	// Misc
	/obj/item/stack/material/snow = list(REAGENT_ID_WATER,REAGENT_ID_ICE),
	/obj/item/stack/tile/grass = list(REAGENT_ID_CARBON,REAGENT_ID_NITROGEN,REAGENT_ID_NITROGEN,REAGENT_ID_PHOSPHORUS,REAGENT_ID_PHOSPHORUS),
	/obj/item/stack/material/leather = list(REAGENT_ID_CARBON,REAGENT_ID_CARBON,REAGENT_ID_PROTEIN,REAGENT_ID_PROTEIN,REAGENT_ID_TRIGLYCERIDE),
	/obj/item/stack/material/cloth = list(REAGENT_ID_CARBON,REAGENT_ID_CARBON,REAGENT_ID_CARBON,REAGENT_ID_PROTEIN,REAGENT_ID_SODIUM),
	/obj/item/stack/material/fiber = list(REAGENT_ID_CARBON,REAGENT_ID_CARBON,REAGENT_ID_CARBON,REAGENT_ID_PROTEIN,REAGENT_ID_SODIUM),
	/obj/item/stack/material/fur = list(REAGENT_ID_CARBON,REAGENT_ID_CARBON,REAGENT_ID_CARBON,REAGENT_ID_SULFUR,REAGENT_ID_SODIUM),
	/obj/item/stack/material/algae = list(REAGENT_ID_CARBON,REAGENT_ID_NITROGEN,REAGENT_ID_NITROGEN,REAGENT_ID_PHOSPHORUS,REAGENT_ID_PHOSPHORUS),
	/obj/item/stack/material/algae/ten = list(REAGENT_ID_CARBON,REAGENT_ID_NITROGEN,REAGENT_ID_NITROGEN,REAGENT_ID_PHOSPHORUS,REAGENT_ID_PHOSPHORUS), // Just spawns with 10, is the same as normal one
	/obj/item/stack/material/concrete = list(REAGENT_ID_SILICATE, REAGENT_ID_CALCIUM),
	/obj/item/stack/material/cardboard = list(REAGENT_ID_WOODPULP),
	// Woods
	/obj/item/stack/material/wood = list(REAGENT_ID_CARBON,REAGENT_ID_WOODPULP,REAGENT_ID_NITROGEN,REAGENT_ID_POTASSIUM,REAGENT_ID_SODIUM),
	/obj/item/stack/material/wood/sif = list(REAGENT_ID_CARBON,REAGENT_ID_WOODPULP,REAGENT_ID_NITROGEN,REAGENT_ID_POTASSIUM,REAGENT_ID_SODIUM),
	/obj/item/stack/material/wood/hard = list(REAGENT_ID_CARBON,REAGENT_ID_WOODPULP,REAGENT_ID_NITROGEN,REAGENT_ID_POTASSIUM,REAGENT_ID_SODIUM),
	// Hull
	/obj/item/stack/material/steel/hull = list(REAGENT_ID_IRON, REAGENT_ID_CARBON),
	/obj/item/stack/material/plasteel/hull = list(REAGENT_ID_IRON, REAGENT_ID_IRON, REAGENT_ID_CARBON, REAGENT_ID_CARBON, REAGENT_ID_PLATINUM),
	/obj/item/stack/material/plastitanium/hull = list(REAGENT_ID_TITANIUM, REAGENT_ID_SILICON, REAGENT_ID_IRON, REAGENT_ID_CARBON, REAGENT_ID_PLATINUM),
	/obj/item/stack/material/durasteel/hull = list(REAGENT_ID_IRON,REAGENT_ID_IRON,REAGENT_ID_CARBON,REAGENT_ID_CARBON,REAGENT_ID_PLATINUM),
	// Glass
	/obj/item/stack/material/glass = list(REAGENT_ID_SILICON),
	/obj/item/stack/material/glass/reinforced = list(REAGENT_ID_SILICON,REAGENT_ID_SILICON,REAGENT_ID_SILICON,REAGENT_ID_IRON,REAGENT_ID_CARBON),
	/obj/item/stack/material/glass/phoronglass = list(REAGENT_ID_PLATINUM, REAGENT_ID_SILICON, REAGENT_ID_SILICON, REAGENT_ID_SILICON), //5 platinum, 15 silicon,
	/obj/item/stack/material/glass/phoronrglass = list(REAGENT_ID_SILICON,REAGENT_ID_SILICON,REAGENT_ID_SILICON,REAGENT_ID_PHORON,REAGENT_ID_PHORON),
	/obj/item/stack/material/glass/titanium = list(REAGENT_ID_TITANIUM, REAGENT_ID_SILICON),
	/obj/item/stack/material/glass/plastitanium = list(REAGENT_ID_TITANIUM, REAGENT_ID_SILICON, REAGENT_ID_IRON, REAGENT_ID_CARBON, REAGENT_ID_PLATINUM),
	// Rods
	/obj/item/stack/rods = list(REAGENT_ID_IRON, REAGENT_ID_CARBON), // 2 per sheet of steel
	/obj/item/stack/material/plasteel/rebar = list(REAGENT_ID_IRON, REAGENT_ID_IRON, REAGENT_ID_CARBON, REAGENT_ID_CARBON, REAGENT_ID_PLATINUM), // Only makes 1 per sheet of plasteel!
	// Logs
	/obj/item/stack/material/stick = list(REAGENT_ID_CARBON,REAGENT_ID_WOODPULP,REAGENT_ID_NITROGEN,REAGENT_ID_POTASSIUM,REAGENT_ID_SODIUM),
	/obj/item/stack/material/stick/fivestack = list(REAGENT_ID_CARBON,REAGENT_ID_WOODPULP,REAGENT_ID_NITROGEN,REAGENT_ID_POTASSIUM,REAGENT_ID_SODIUM), // Just spawns with 5, same as normal one
	/obj/item/stack/material/log = list(REAGENT_ID_CARBON,REAGENT_ID_WOODPULP,REAGENT_ID_NITROGEN,REAGENT_ID_POTASSIUM,REAGENT_ID_SODIUM),
	/obj/item/stack/material/log/hard = list(REAGENT_ID_CARBON,REAGENT_ID_WOODPULP,REAGENT_ID_NITROGEN,REAGENT_ID_POTASSIUM,REAGENT_ID_SODIUM),
	/obj/item/stack/material/log/sif = list(REAGENT_ID_CARBON,REAGENT_ID_WOODPULP,REAGENT_ID_NITROGEN,REAGENT_ID_POTASSIUM,REAGENT_ID_SODIUM),
	))

GLOBAL_LIST_INIT(ore_reagents, list( //have a number of reageents divisible by REAGENTS_PER_ORE (default 20) unless you like decimals.
	/obj/item/ore/glass = list(REAGENT_ID_SILICON),
	/obj/item/ore/iron = list(REAGENT_ID_IRON),
	/obj/item/ore/coal = list(REAGENT_ID_CARBON),
	/obj/item/ore/phoron = list(REAGENT_ID_PHORON),
	/obj/item/ore/silver = list(REAGENT_ID_SILVER),
	/obj/item/ore/gold = list(REAGENT_ID_GOLD),
	/obj/item/ore/marble = list(REAGENT_ID_SILICON,REAGENT_ID_ALUMINIUM,REAGENT_ID_ALUMINIUM,REAGENT_ID_SODIUM,REAGENT_ID_CALCIUM), // Some nice variety here
	/obj/item/ore/uranium = list(REAGENT_ID_URANIUM),
	/obj/item/ore/diamond = list(REAGENT_ID_CARBON),
	/obj/item/ore/osmium = list(REAGENT_ID_PLATINUM), // should contain osmium
	/obj/item/ore/lead = list(REAGENT_ID_LEAD),
	/obj/item/ore/hydrogen = list(REAGENT_ID_HYDROGEN),
	/obj/item/ore/verdantium = list(REAGENT_ID_RADIUM,REAGENT_ID_PHORON,REAGENT_ID_NITROGEN,REAGENT_ID_PHOSPHORUS,REAGENT_ID_SODIUM), // Some fun stuff to be useful with
	/obj/item/ore/rutile = list(REAGENT_ID_TITANIUMDIOX,REAGENT_ID_OXYGEN),
	/obj/item/ore/copper = list(REAGENT_ID_COPPER),
	/obj/item/ore/tin = list(REAGENT_ID_TIN),
	/obj/item/ore/void_opal = list(REAGENT_ID_SILICON,REAGENT_ID_SILICON,REAGENT_ID_OXYGEN,REAGENT_ID_WATER),
	/obj/item/ore/painite = list(REAGENT_ID_CALCIUM,REAGENT_ID_ALUMINIUM,REAGENT_ID_OXYGEN,REAGENT_ID_OXYGEN),
	/obj/item/ore/quartz = list(REAGENT_ID_SILICON,REAGENT_ID_OXYGEN),
	/obj/item/ore/bauxite = list(REAGENT_ID_ALUMINIUM,REAGENT_ID_ALUMINIUM),
	))

// Don't need a new list for every grinder in the game
GLOBAL_LIST_INIT(reagent_sheets,list( // Recompressing reagents back into sheets
	REAGENT_ID_COPPER 			= MAT_COPPER,
	REAGENT_ID_TIN 				= MAT_TIN,
	REAGENT_ID_WOODPULP 		= MAT_CARDBOARD,
	REAGENT_ID_CARBON 			= MAT_GRAPHITE,
	REAGENT_ID_ALUMINIUM 		= MAT_ALUMINIUM,
	REAGENT_ID_TITANIUM 		= MAT_TITANIUM,
	REAGENT_ID_IRON 			= MAT_IRON,
	REAGENT_ID_LEAD				= MAT_LEAD,
	REAGENT_ID_URANIUM			= MAT_URANIUM,
	REAGENT_ID_GOLD 			= MAT_GOLD,
	REAGENT_ID_SILVER 			= MAT_SILVER,
	REAGENT_ID_PLATINUM			= MAT_PLATINUM,
	REAGENT_ID_SILICON 			= MAT_GLASS,
	// Mostly harmless
	REAGENT_ID_PROTEIN			= REFINERY_SINTERING_SMOKE,
	REAGENT_ID_TRIGLYCERIDE 	= REFINERY_SINTERING_SMOKE,
	REAGENT_ID_SODIUM	 		= REFINERY_SINTERING_SMOKE,
	REAGENT_ID_PHOSPHORUS 		= REFINERY_SINTERING_SMOKE,
	REAGENT_ID_ETHANOL 			= REFINERY_SINTERING_SMOKE,
	// Extremely stupid ones
	REAGENT_ID_OXYGEN 			= REFINERY_SINTERING_EXPLODE,
	REAGENT_ID_HYDROGEN 		= REFINERY_SINTERING_EXPLODE,
	REAGENT_ID_PHORON 			= REFINERY_SINTERING_EXPLODE,
	REAGENT_ID_SUPERMATTER 		= REFINERY_SINTERING_EXPLODE,
	// Nothing is funnier to me
	REAGENT_ID_SPIDEREGG 		= REFINERY_SINTERING_SPIDERS,
	))

GLOBAL_LIST_INIT(deepore_fracking_reagents,list( // Fracking results for fluid pump
	ORE_HEMATITE = list(REAGENT_ID_SILICATE,REAGENT_ID_IRON,REAGENT_ID_CARBON),
	ORE_URANIUM = list(REAGENT_ID_RADIUM,REAGENT_ID_RADIUM,REAGENT_ID_CALCIUM,REAGENT_ID_PHOSPHORUS), // Doesn't produce uranium due to low use in reagents, and emp reaction
	ORE_COPPER = list(REAGENT_ID_GOLD,REAGENT_ID_COPPER,REAGENT_ID_LEAD), // Commonly
	ORE_GOLD = list(REAGENT_ID_GOLD,REAGENT_ID_COPPER,REAGENT_ID_LEAD), // Found
	ORE_TIN = list(REAGENT_ID_GOLD,REAGENT_ID_COPPER,REAGENT_ID_LEAD), // Together
	ORE_SILVER = list(REAGENT_ID_SILVER,REAGENT_ID_LEAD,REAGENT_ID_COPPER), // lead loves this one too
	ORE_DIAMOND = list(REAGENT_ID_TITANIUMDIOX,REAGENT_ID_PHOSPHORUS,REAGENT_ID_SULFUR,REAGENT_ID_CARBON), // Ignius process
	ORE_PHORON = list(REAGENT_ID_PHORON,REAGENT_ID_RADIUM,REAGENT_ID_PHOSPHORUS,REAGENT_ID_SULFUR), // Ignius heavymetals?
	ORE_PLATINUM = list(REAGENT_ID_PLATINUM,REAGENT_ID_COPPER), // Don't have much to group it with
	ORE_MHYDROGEN = list(REAGENT_ID_SILICATE,REAGENT_ID_HYDROGEN),
	ORE_SAND = list(REAGENT_ID_SILICATE,REAGENT_ID_SILICON,REAGENT_ID_LITHIUM,REAGENT_ID_PHOSPHORUS,REAGENT_ID_CALCIUM,REAGENT_ID_SODIUMCHLORIDE,REAGENT_ID_CARBON), // Catch all sedimentry
	ORE_CARBON = list(REAGENT_ID_SILICATE,REAGENT_ID_CARBON,REAGENT_ID_SODIUMCHLORIDE), // Salty coal
	ORE_BAUXITE = list(REAGENT_ID_TITANIUMDIOX,REAGENT_ID_ALUMINIUM,REAGENT_ID_SODIUMCHLORIDE), // ore's general components and neighbours
	ORE_RUTILE = list(REAGENT_ID_TITANIUMDIOX,REAGENT_ID_SILICATE,REAGENT_ID_SILICON,REAGENT_ID_SODIUMCHLORIDE) // ore's general components and neighbours
	))

//List of the ammo types that can be used in game.
GLOBAL_LIST_INIT(global_ammo_types, list(
	/obj/item/ammo_casing/a357              = ".357",
	/obj/item/ammo_casing/a9mm		        = "9mm",
	/obj/item/ammo_casing/a45				= ".45",
	/obj/item/ammo_casing/a10mm             = "10mm",
	/obj/item/ammo_casing/a12g              = "12g",
	/obj/item/ammo_casing/a12g              = "12g",
	/obj/item/ammo_casing/a12g/pellet       = "12g",
	/obj/item/ammo_casing/a12g/pellet       = "12g",
	/obj/item/ammo_casing/a12g/pellet       = "12g",
	/obj/item/ammo_casing/a12g/beanbag      = "12g",
	/obj/item/ammo_casing/a12g/stunshell    = "12g",
	/obj/item/ammo_casing/a12g/flash        = "12g",
	/obj/item/ammo_casing/a762              = "7.62mm",
	/obj/item/ammo_casing/a545              = "5.45mm"
	))

//Rad collectors in the world
GLOBAL_LIST_EMPTY(rad_collectors)

//NIF
GLOBAL_LIST_INIT(nif_look_messages, list(
			"flicks their eyes around",
			"looks at something unseen",
			"reads some invisible text",
			"seems to be daydreaming",
			"focuses elsewhere for a moment"))

GLOBAL_LIST(starting_legal_nifsoft)
GLOBAL_LIST(starting_illegal_nifsoft)

// By default they can be in any water turf.  Subtypes might restrict to deep/shallow etc
GLOBAL_LIST_INIT(suitable_fish_turf_types,  list(
	/turf/simulated/floor/beach/water,
	/turf/simulated/floor/beach/coastline,
	/turf/simulated/floor/holofloor/beach/water,
	/turf/simulated/floor/holofloor/beach/coastline,
	/turf/simulated/floor/water
))


//Chamelion clothing was all stupid so it's done here instead.
//Jumpsuit
GLOBAL_LIST(chamelion_jumpsuit_choices)
//Hat
GLOBAL_LIST(chamelion_head_choices)
//Suit
GLOBAL_LIST(chamelion_suit_choices)
//Shoes
GLOBAL_LIST(chamelion_shoe_choices)
//Backpack
GLOBAL_LIST(chamelion_back_choices)
//Gloves
GLOBAL_LIST(chamelion_glove_choices)
//Mask
GLOBAL_LIST(chamelion_mask_choices)
//Belt
GLOBAL_LIST(chamelion_belt_choices)
//Accessory
GLOBAL_LIST(chamelion_accessory_choices)

GLOBAL_LIST_INIT(tail_layer_options, list("Lower layer" = TAIL_UPPER_LAYER_LOW , "Default layer" = TAIL_UPPER_LAYER , "Upper layer" = TAIL_UPPER_LAYER_HIGH ))

//Spritesheet stuff. Used by /obj/item/clothing/proc/refit_for_species(var/target_species)
#define SPECIES_HUMANOID_CAN_WEAR list(SPECIES_HUMAN, SPECIES_SKRELL, SPECIES_RAPALA, SPECIES_VASILISSAN, SPECIES_ALRAUNE, SPECIES_PROMETHEAN)
#define SPECIES_UNATHI_CAN_WEAR list(SPECIES_UNATHI, SPECIES_XENOHYBRID)
#define SPECIES_TAJARAN_CAN_WEAR list(SPECIES_TAJARAN, SPECIES_XENOCHIMERA)
#define SPECIES_VULPKANIN_CAN_WEAR list(SPECIES_VULPKANIN, SPECIES_ZORREN_HIGH, SPECIES_FENNEC)
#define SPECIES_SERGAL_CAN_WEAR list(SPECIES_SERGAL, SPECIES_NEVREAN)
#define SPECIES_TESHARI_CAN_WEAR list(SPECIES_TESHARI)
#define SPECIES_VOX_CAN_WEAR list(SPECIES_VOX)
#define SPECIES_ALL_BUT_TESHARI_CAN_WEAR list(SPECIES_HUMAN, SPECIES_SKRELL, SPECIES_RAPALA, SPECIES_VASILISSAN, SPECIES_ALRAUNE, SPECIES_PROMETHEAN, SPECIES_UNATHI, SPECIES_XENOHYBRID, SPECIES_TAJARAN, SPECIES_XENOCHIMERA, SPECIES_VULPKANIN, SPECIES_ZORREN_HIGH, SPECIES_FENNEC, SPECIES_SERGAL, SPECIES_NEVREAN, SPECIES_VOX, SPECIES_SHADEKIN)
#define SPECIES_ALL_BUT_TESHARI_AND_VOX_CAN_WEAR list(SPECIES_HUMAN, SPECIES_SKRELL, SPECIES_RAPALA, SPECIES_VASILISSAN, SPECIES_ALRAUNE, SPECIES_PROMETHEAN, SPECIES_UNATHI, SPECIES_XENOHYBRID, SPECIES_TAJARAN, SPECIES_XENOCHIMERA, SPECIES_VULPKANIN, SPECIES_ZORREN_HIGH, SPECIES_FENNEC, SPECIES_SERGAL, SPECIES_NEVREAN, SPECIES_SHADEKIN)
#define SPECIES_ALL_CAN_WEAR list(SPECIES_HUMAN, SPECIES_SKRELL, SPECIES_RAPALA, SPECIES_VASILISSAN, SPECIES_ALRAUNE, SPECIES_PROMETHEAN, SPECIES_UNATHI, SPECIES_XENOHYBRID, SPECIES_TAJARAN, SPECIES_XENOCHIMERA, SPECIES_VULPKANIN, SPECIES_ZORREN_HIGH, SPECIES_FENNEC, SPECIES_SERGAL, SPECIES_NEVREAN, SPECIES_TESHARI, SPECIES_VOX, SPECIES_SHADEKIN)
>>>>>>> 75e6f29853 ([MIRROR] Metamorphic suits [IDB IGNORE] (#11471))
