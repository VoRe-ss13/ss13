/obj/item/radio/headset
	name = "radio headset"
	desc = "An updated, modular intercom that fits over the head. Takes encryption keys"
	var/radio_desc = ""
	icon_state = "headset"
	item_state = null //To remove the radio's state
	matter = list(MAT_STEEL = 75)
	subspace_transmission = TRUE
	canhear_range = 0 // can't hear headsets from very far away
	slot_flags = SLOT_EARS
	sprite_sheets = list(SPECIES_TESHARI = 'icons/inventory/ears/mob_teshari.dmi',
						SPECIES_WEREBEAST = 'icons/inventory/ears/mob_vr_werebeast.dmi')

	var/translate_binary = FALSE
	var/translate_hive = FALSE
	var/obj/item/encryptionkey/keyslot1 = null
	var/obj/item/encryptionkey/keyslot2 = null
	var/ks1type = null
	var/ks2type = null

	drop_sound = 'sound/items/drop/component.ogg'
	pickup_sound = 'sound/items/pickup/component.ogg'

/obj/item/radio/headset/Initialize(mapload)
	. = ..()
	internal_channels.Cut()
	if(ks1type)
		keyslot1 = new ks1type(src)
	if(ks2type)
		keyslot2 = new ks2type(src)
	recalculateChannels(TRUE)

/obj/item/radio/headset/Destroy()
	qdel(keyslot1)
	qdel(keyslot2)
	keyslot1 = null
	keyslot2 = null
	return ..()

/obj/item/radio/headset/list_channels(var/mob/user)
	return list_secure_channels()

/obj/item/radio/headset/examine(mob/user)
	. = ..()

	if(radio_desc && Adjacent(user))
		. += "The following channels are available:"
		. += radio_desc

/obj/item/radio/headset/handle_message_mode(mob/living/M as mob, list/message_pieces, channel)
	if(channel == "special")
		if(translate_binary)
			var/datum/language/binary = GLOB.all_languages[LANGUAGE_ROBOT_TALK]
			binary.broadcast(M, M.strip_prefixes(multilingual_to_message(message_pieces)))
			return RADIO_CONNECTION_NON_SUBSPACE
		if(translate_hive)
			var/datum/language/hivemind = GLOB.all_languages[LANGUAGE_HIVEMIND]
			hivemind.broadcast(M, M.strip_prefixes(multilingual_to_message(message_pieces)))
			return RADIO_CONNECTION_NON_SUBSPACE
		return RADIO_CONNECTION_FAIL

	return ..()

/obj/item/radio/headset/receive_range(freq, level, aiOverride = 0)
	if(!ishuman(src.loc))				//CHOMP Addition, this IF block.
		return ..(freq, level)		//CHOMP Addition end
	if (aiOverride)
		playsound(loc, 'sound/effects/radio_common.ogg', 20, 1, 1, preference = /datum/preference/toggle/radio_sounds) //CHOMPAdd
		return ..(freq, level)
	if(ishuman(src.loc))
		var/mob/living/carbon/human/H = src.loc
		if(H.l_ear == src || H.r_ear == src)
			playsound(loc, 'sound/effects/radio_common.ogg', 20, 1, 1, preference = /datum/preference/toggle/radio_sounds) //CHOMPAdd
			return ..(freq, level)
	return -1

/obj/item/radio/headset/get_worn_icon_state(var/slot_name)
	var/append = ""
	if(icon_override)
		switch(slot_name)
			if(slot_l_ear_str)
				append = "_l"
			if(slot_r_ear_str)
				append = "_r"

	return "[..()][append]"

/obj/item/radio/headset/tgui_state(mob/user)
	return GLOB.tgui_inventory_state

/obj/item/radio/headset/attackby(obj/item/W as obj, mob/user as mob)
//	..()
	user.set_machine(src)
	if(!(W.has_tool_quality(TOOL_SCREWDRIVER) || istype(W, /obj/item/encryptionkey)))
		return

	if(W.has_tool_quality(TOOL_SCREWDRIVER))
		if(keyslot1 || keyslot2)


			for(var/ch_name in channels)
				radio_controller.remove_object(src, radiochannels[ch_name])
				secure_radio_connections[ch_name] = null


			if(keyslot1)
				var/turf/T = get_turf(user)
				if(T)
					keyslot1.loc = T
					keyslot1 = null



			if(keyslot2)
				var/turf/T = get_turf(user)
				if(T)
					keyslot2.loc = T
					keyslot2 = null

			recalculateChannels()
			to_chat(user, span_notice("You pop out the encryption keys in the headset!"))
			playsound(src, W.usesound, 50, 1)

		else
			to_chat(user, span_notice("This headset doesn't have any encryption keys!  How useless..."))

	if(istype(W, /obj/item/encryptionkey/))
		if(keyslot1 && keyslot2)
			to_chat(user, span_notice("The headset can't hold another key!"))
			return

		if(!keyslot1)
			user.drop_item()
			W.loc = src
			keyslot1 = W

		else
			user.drop_item()
			W.loc = src
			keyslot2 = W


		recalculateChannels()

	return

/obj/item/radio/headset/recalculateChannels(var/setDescription = FALSE)
	src.channels = list()
	src.translate_binary = FALSE
	src.translate_hive = FALSE
	src.syndie = FALSE

	if(keyslot1)
		for(var/ch_name in keyslot1.channels)
			if(ch_name in src.channels)
				continue
			src.channels += ch_name
			src.channels[ch_name] = keyslot1.channels[ch_name]

		if(keyslot1.translate_binary)
			src.translate_binary = TRUE

		if(keyslot1.translate_hive)
			src.translate_hive = TRUE

		if(keyslot1.syndie)
			src.syndie = TRUE

	if(keyslot2)
		for(var/ch_name in keyslot2.channels)
			if(ch_name in src.channels)
				continue
			src.channels += ch_name
			src.channels[ch_name] = keyslot2.channels[ch_name]

		if(keyslot2.translate_binary)
			src.translate_binary = TRUE

		if(keyslot2.translate_hive)
			src.translate_hive = TRUE

		if(keyslot2.syndie)
			src.syndie = TRUE

	handle_finalize_recalculatechannels(setDescription, TRUE)

/obj/item/radio/headset/proc/handle_finalize_recalculatechannels(var/setDescription = FALSE, var/initial_run = FALSE)
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!radio_controller && initial_run)
		addtimer(CALLBACK(src,PROC_REF(handle_finalize_recalculatechannels),setDescription, FALSE),3 SECONDS)
		return
	if(!radio_controller && !initial_run)
		name = "broken radio headset"
		return

	for (var/ch_name in channels)
		secure_radio_connections[ch_name] = radio_controller.add_object(src, radiochannels[ch_name],  RADIO_CHAT)

	if(setDescription)
		setupRadioDescription()

/obj/item/radio/headset/proc/setupRadioDescription()
	var/radio_text = ""
	for(var/i = 1 to channels.len)
		var/channel = channels[i]
		var/key = get_radio_key_from_channel(channel)
		radio_text += "[key] - [channel]"
		if(i != channels.len)
			radio_text += ", "

	radio_desc = radio_text

/obj/item/radio/headset/mob_headset/handle_message_mode(mob/living/M, list/message_pieces, channel)	//RS ADD START // TORCHEdit Start - Porting "Join As Mob" verb and changes from Rogue Star.
	if(isanimal(M))
		if(!istype(M.default_language,/datum/language/common))
			to_chat(M,"<span class = 'warning'>You need to speak common to speak on the radio!</span>")
			return
	return ..()		//RS ADD END // TORCHEdit End - Porting "Join As Mob" verb and changes from Rogue Star.

/obj/item/radio/headset/mob_headset/receive_range(freq, level)
	if(ismob(src.loc))
		return ..(freq, level, 1)
	return -1

/obj/item/radio/headset/mob_headset/afterattack(var/atom/movable/target, mob/living/user, proximity)
	if(!proximity)
		return
	if(isanimal(target))
		var/mob/living/simple_mob/M = target
		if(!M.mob_radio)
			user.drop_item()
			forceMove(M)
			M.mob_radio = src
			return
		if(M.mob_radio)
			M.mob_radio.forceMove(M.loc)
			M.mob_radio = null
			return
	..()

/obj/item/radio/headset/alt
	name = "bowman radio headset"
	desc = "A larger, sturdier radio headset. A bit bulky, but guaranteed to stay on no matter what."
	icon_state = "headset_alt"

/obj/item/radio/headset/earbud
	name = "radio earbud"
	desc = "A discreet radio earbud and low-profile mic. Simple and unobtrusive."
	icon_state = "headset_earbud"

/obj/item/radio/headset/headset_sec
	name = "security radio headset"
	desc = "This headset is used by your elite security force." // CHOMPAdd
	icon_state = "sec_headset"
	ks2type = /obj/item/encryptionkey/headset_sec

/obj/item/radio/headset/alt/headset_sec
	name = "security bowman headset"
	desc = "This bowman headset is used by your elite security force." // CHOMPAdd
	icon_state = "sec_headset_alt"
	ks2type = /obj/item/encryptionkey/headset_sec

/obj/item/radio/headset/earbud/headset_sec
	name = "security earbud"
	desc = "This tiny earbud is used by your elite security force." // CHOMPAdd
	icon_state = "sec_earbud"
	ks2type = /obj/item/encryptionkey/headset_sec

/obj/item/radio/headset/headset_eng
	name = "engineering radio headset"
	desc = "When the engineers wish to chat like girls." // CHOMPAdd
	icon_state = "eng_headset"
	ks2type = /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/alt/headset_eng
	name = "engineering bowman headset"
	desc = "When the engineers wish to chat like girls." // CHOMPAdd
	icon_state = "eng_headset_alt"
	ks2type = /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/earbud/headset_eng
	name = "engineering earbud"
	desc = "When the engineers wish to chat like girls." // CHOMPAdd
	icon_state = "eng_earbud"
	ks2type = /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/headset_med
	name = "medical radio headset"
	desc = "A headset for the trained staff of the medbay." // CHOMPAdd
	icon_state = "med_headset"
	ks2type = /obj/item/encryptionkey/headset_med

/obj/item/radio/headset/alt/headset_med
	name = "medical bowman headset"
	desc = "A bowman headset for the trained staff of the medbay." // CHOMPAdd
	icon_state = "med_headset_alt"
	ks2type = /obj/item/encryptionkey/headset_med

/obj/item/radio/headset/earbud/headset_med
	name = "medical earbud"
	desc = "A tiny earbud for the trained staff of the medbay." // CHOMPAdd
	icon_state = "med_earbud"
	ks2type = /obj/item/encryptionkey/headset_med

/obj/item/radio/headset/headset_sci
	name = "science radio headset"
	desc = "A sciency headset. Like usual." // CHOMPAdd
	icon_state = "com_headset"
	ks2type = /obj/item/encryptionkey/headset_sci

/obj/item/radio/headset/alt/headset_sci
	name = "science bowman headset"
	desc = "A sciency bowman headset. Like usual." // CHOMPAdd
	icon_state = "com_headset_alt"
	ks2type = /obj/item/encryptionkey/headset_sci

/obj/item/radio/headset/earbud/headset_sci
	name = "science earbud"
	desc = "A tiny sciency earbud. Like usual." // CHOMPAdd
	icon_state = "com_earbud"
	ks2type = /obj/item/encryptionkey/headset_sci

/obj/item/radio/headset/headset_com
	name = "command radio headset"
	desc = "A headset with a commanding channel." // CHOMPAdd
	icon_state = "com_headset"
	ks2type = /obj/item/encryptionkey/headset_com

/obj/item/radio/headset/alt/headset_com
	name = "command bowman headset"
	desc = "A bowman headset with a commanding channel." // CHOMPAdd
	icon_state = "com_headset_alt"
	ks2type = /obj/item/encryptionkey/headset_com

/obj/item/radio/headset/earbud/headset_com
	name = "command earbud"
	desc = "A tiny earbud with a commanding channel." // CHOMPAdd
	icon_state = "com_earbud"
	ks2type = /obj/item/encryptionkey/headset_com

/obj/item/radio/headset/heads/captain
	name = "site manager's headset"
	desc = "The headset of the boss." // CHOMPAdd
	icon_state = "com_headset"
	ks2type = /obj/item/encryptionkey/heads/captain

/obj/item/radio/headset/heads/captain/sfr
	name = "SFR headset"
	desc = "A headset belonging to a Sif Free Radio DJ. SFR, best tunes in the wilderness."
	icon_state = "com_headset_alt"

/obj/item/radio/headset/alt/heads/captain
	name = "site manager's bowman headset"
	desc = "The bowman headset of the boss." // CHOMPAdd
	icon_state = "com_headset_alt"
	ks2type = /obj/item/encryptionkey/heads/captain

/obj/item/radio/headset/earbud/heads/captain
	name = "site manager's earbud"
	desc = "The tiny earbud of the boss." // CHOMPAdd
	icon_state = "com_earbud"
	ks2type = /obj/item/encryptionkey/heads/captain

/obj/item/radio/headset/heads/rd
	name = "research director's headset"
	desc = "The headset of the eccentric-in-chief." // CHOMPAdd
	icon_state = "com_headset"
	ks2type = /obj/item/encryptionkey/heads/rd

/obj/item/radio/headset/alt/heads/rd
	name = "research director's bowman headset"
	desc = "The bowman headset of the eccentric-in-chief." // CHOMPAdd
	icon_state = "com_headset_alt"
	ks2type = /obj/item/encryptionkey/heads/rd

/obj/item/radio/headset/earbud/heads/rd
	name = "research director's earbud"
	desc = "The tiny earbud of the eccentric-in-chief." // CHOMPAdd
	icon_state = "com_earbud"
	ks2type = /obj/item/encryptionkey/heads/rd

/obj/item/radio/headset/heads/hos
	name = "head of security's headset"
	desc = "The headset of the hardass who protects your worthless lives." // CHOMPAdd
	icon_state = "com_headset"
	ks2type = /obj/item/encryptionkey/heads/hos

/obj/item/radio/headset/alt/heads/hos
	name = "head of security's bowman headset"
	desc = "The bowman headset of the hardass who protects your worthless lives." // CHOMPAdd
	icon_state = "com_headset_alt"
	ks2type = /obj/item/encryptionkey/heads/hos

/obj/item/radio/headset/earbud/heads/hos
	name = "head of security's earbud"
	desc = "The tiny earbud of the hardass who protects your worthless lives." // CHOMPAdd
	icon_state = "com_earbud"
	ks2type = /obj/item/encryptionkey/heads/hos

/obj/item/radio/headset/heads/ce
	name = "chief engineer's headset"
	desc = "The headset of the clown who is in charge of the circus." // CHOMPAdd
	icon_state = "com_headset"
	ks2type = /obj/item/encryptionkey/heads/ce

/obj/item/radio/headset/alt/heads/ce
	name = "chief engineer's bowman headset"
	desc = "The bowman headset of the clown who is in charge of the circus." // CHOMPAdd
	icon_state = "com_headset_alt"
	ks2type = /obj/item/encryptionkey/heads/ce

/obj/item/radio/headset/earbud/heads/ce
	name = "chief engineer's earbud"
	desc = "The tiny earbud of the clown who is in charge of the circus." // CHOMPAdd
	icon_state = "com_earbud"
	ks2type = /obj/item/encryptionkey/heads/ce

/obj/item/radio/headset/heads/cmo
	name = "chief medical officer's headset"
	desc = "The headset of the highly trained medical chief." // CHOMPAdd
	icon_state = "com_headset"
	ks2type = /obj/item/encryptionkey/heads/cmo

/obj/item/radio/headset/alt/heads/cmo
	name = "chief medical officer's bowman headset"
	desc = "The bowman headset of the highly trained medical chief." // CHOMPAdd
	icon_state = "com_headset_alt"
	ks2type = /obj/item/encryptionkey/heads/cmo

/obj/item/radio/headset/earbud/heads/cmo
	name = "chief medical officer's earbud"
	desc = "The tiny earbud of the highly trained medical chief." // CHOMPAdd
	icon_state = "com_earbud"
	ks2type = /obj/item/encryptionkey/heads/cmo

/obj/item/radio/headset/heads/hop
	name = "head of personnel's headset"
	desc = "The headset of the poor fool who will one day be " + JOB_SITE_MANAGER + "." // CHOMPAdd
	icon_state = "com_headset"
	ks2type = /obj/item/encryptionkey/heads/hop

/obj/item/radio/headset/alt/heads/hop
	name = "head of personnel's bowman headset"
	desc = "The bowman headset of the poor fool who will one day be " + JOB_SITE_MANAGER + "." // CHOMPAdd
	icon_state = "com_headset_alt"
	ks2type = /obj/item/encryptionkey/heads/hop

/obj/item/radio/headset/earbud/heads/hop
	name = "head of personnel's earbud"
	desc = "The tiny earbud of the poor fool who will one day be " + JOB_SITE_MANAGER + "." // CHOMPAdd
	icon_state = "com_earbud"
	ks2type = /obj/item/encryptionkey/heads/hop

/obj/item/radio/headset/miner
	name = "mining radio headset"
	desc = "Headset used by miners. Has inbuilt short-band radio for when comms are down."
	icon_state = "mine_headset"
	adhoc_fallback = TRUE
	ks2type = /obj/item/encryptionkey/headset_cargo

/obj/item/radio/headset/cargo
	name = "supply radio headset"
	desc = "A headset used by the QM's slaves." // CHOMPAdd
	icon_state = "cargo_headset"
	ks2type = /obj/item/encryptionkey/headset_cargo

/obj/item/radio/headset/alt/cargo
	name = "supply bowman headset"
	desc = "A bowman headset used by the QM's slaves." // CHOMPAdd
	icon_state = "cargo_headset_alt"
	ks2type = /obj/item/encryptionkey/headset_cargo

/obj/item/radio/headset/earbud/cargo
	name = "supply earbud"
	desc = "A tiny earbud used by the QM's slaves." // CHOMPAdd
	icon_state = "cargo_earbud"
	ks2type = /obj/item/encryptionkey/headset_cargo

/obj/item/radio/headset/qm
	name = "qm radio headset"
	desc = "A headset used by the QM." // CHOMPAdd
	icon_state = "cargo_headset"
	ks2type = /obj/item/encryptionkey/qm

/obj/item/radio/headset/alt/qm
	name = "qm bowman headset"
	desc = "A bowman headset used by the QM." // CHOMPAdd
	icon_state = "cargo_headset_alt"
	ks2type = /obj/item/encryptionkey/qm

/obj/item/radio/headset/earbud/qm
	name = "qm earbud"
	desc = "A tiny earbud used by the QM." // CHOMPAdd
	icon_state = "cargo_earbud"
	ks2type = /obj/item/encryptionkey/qm

/obj/item/radio/headset/service
	name = "service radio headset"
	desc = "Headset used by the service staff, tasked with keeping the station full, happy and clean." // CHOMPAdd
	icon_state = "srv_headset"
	ks2type = /obj/item/encryptionkey/headset_service

/obj/item/radio/headset/alt/service
	name = "service bowman headset"
	desc = "Bowman headset used by the service staff, tasked with keeping the station full, happy and clean." // CHOMPAdd
	icon_state = "srv_headset_alt"
	ks2type = /obj/item/encryptionkey/headset_service

/obj/item/radio/headset/earbud/service
	name = "service earbud"
	desc = "A tiny earbud used by the service staff, tasked with keeping the station full, happy and clean." // CHOMPAdd
	icon_state = "srv_earbud"
	ks2type = /obj/item/encryptionkey/headset_service

/obj/item/radio/headset/ert
	name = "emergency response team radio headset"
	desc = "The headset of the boss's boss." // CHOMPAdd
	icon_state = "com_headset"
	centComm = 1
	ks2type = /obj/item/encryptionkey/ert

/obj/item/radio/headset/alt/ert
	name = "emergency response team bowman headset"
	desc = "The bowman headset of the boss's boss." // CHOMPAdd
	icon_state = "com_headset_alt"
	centComm = 1
	ks2type = /obj/item/encryptionkey/ert

/obj/item/radio/headset/ia
	name = "internal affairs headset"
	desc = "The headset of your worst enemy." // CHOMPAdd
	icon_state = "com_headset"
	ks2type = /obj/item/encryptionkey/heads/hos

/obj/item/radio/headset/alt/ia
	name = "internal affairs bowman headset"
	desc = "The bowman headset of your worst enemy." // CHOMPAdd
	icon_state = "com_headset_alt"
	ks2type = /obj/item/encryptionkey/heads/hos

/obj/item/radio/headset/earbud/ia
	name = "internal affairs earbud"
	desc = "The tiny earbud of your worst enemy." // CHOMPAdd
	icon_state = "com_earbud"
	ks2type = /obj/item/encryptionkey/heads/hos

/obj/item/radio/headset/centcom
	name = "centcom radio headset"
	desc = "The headset of the boss's boss." // CHOMPAdd
	icon_state = "cent_headset"
	item_state = "headset"
	centComm = 1
	ks2type = /obj/item/encryptionkey/ert

/obj/item/radio/headset/alt/centcom
	name = "centcom bowman headset"
	desc = "The bowman headset of the boss's boss." // CHOMPAdd
	icon_state = "com_headset_alt"
	centComm = 1
	ks2type = /obj/item/encryptionkey/ert

/obj/item/radio/headset/nanotrasen
	name = "\improper NT radio headset"
	desc = "The headset of a Nanotrasen corporate employee." // CHOMPAdd
	icon_state = "nt_headset"
	centComm = 1
	ks2type = /obj/item/encryptionkey/ert

/obj/item/radio/headset/alt/nanotrasen
	name = "\improper NT bowman headset"
	desc = "The bowman headset of a Nanotrasen corporate employee." // CHOMPAdd
	icon_state = "nt_headset_alt"
	centComm = 1
	ks2type = /obj/item/encryptionkey/ert

/obj/item/radio/headset/pathfinder
	name = "pathfinder's headset"
	desc = "Headset used by pathfinders for exploring. Access to the explorer and command channels." // CHOMPAdd
	icon_state = "exp_headset"
	adhoc_fallback = TRUE
	ks2type = /obj/item/encryptionkey/pathfinder

/obj/item/radio/headset/alt/pathfinder
	name = "pathfinder's bowman headset"
	desc = "Bowman headset used by pathfinders for exploring. Access to the explorer and command channels." // CHOMPAdd
	icon_state = "exp_headset_alt"
	adhoc_fallback = TRUE
	ks2type = /obj/item/encryptionkey/pathfinder

/obj/item/radio/headset/pilot
	name = "pilot's headset"
	desc = "A headset used by pilots." // CHOMPAdd
	icon_state = "pilot_headset"
	adhoc_fallback = TRUE

/obj/item/radio/headset/alt/pilot
	name = "pilot's bowman headset"
	desc = "A bowman headset used by pilots." // CHOMPAdd
	icon_state = "pilot_headset_alt"
	adhoc_fallback = TRUE

/obj/item/radio/headset/explorer
	name = "away team member's headset"
	desc = "Headset used by the away team for exploring. Access to the away team channel." // CHOMPAdd
	icon_state = "exp_headset"
	adhoc_fallback = TRUE
	ks2type = /obj/item/encryptionkey/explorer

/obj/item/radio/headset/alt/explorer
	name = "away team's bowman headset"
	desc = "Bowman headset used by the away team for exploring. Access to the away team channel." // CHOMPAdd
	icon_state = "exp_headset_alt"
	adhoc_fallback = TRUE
	ks2type = /obj/item/encryptionkey/explorer

/obj/item/radio/headset/sar
	name = "search and rescue headset"
	desc = "A headset for field medics." // CHOMPAdd
	icon_state = "sar_headset"
	adhoc_fallback = TRUE
	ks2type = /obj/item/encryptionkey/sar

/obj/item/radio/headset/alt/sar
	name = "search and rescue bowman headset"
	desc = "A bowman headset for field medics." // CHOMPAdd
	icon_state = "sar_headset_alt"
	adhoc_fallback = TRUE
	ks2type = /obj/item/encryptionkey/sar

/obj/item/radio/headset/talon
	name = "talon headset"
	desc = "A headset for communication between the crew of the ITV Talon." // CHOMPAdd
	adhoc_fallback = TRUE
	icon_state = "pilot_headset"
	ks2type = /obj/item/encryptionkey/talon

/obj/item/radio/headset/alt/talon
	name = "talon bowman headset"
	desc = "A bowman headset for communication between the crew of the ITV Talon." // CHOMPAdd
	adhoc_fallback = TRUE
	icon_state = "pilot_headset"
	ks2type = /obj/item/encryptionkey/talon

/obj/item/radio/headset/earbud/talon
	name = "talon earbud"
	desc = "A tiny earbud for communication between the crew of the ITV Talon." // CHOMPAdd
	adhoc_fallback = TRUE
	icon_state = "pilot_headset"
	ks2type = /obj/item/encryptionkey/talon

/obj/item/radio/headset/headset_rob
	name = "robotics radio headset"
	desc = "Made specifically for the roboticists who cannot decide between departments." // CHOMPAdd
	icon_state = "rob_headset"
	ks2type = /obj/item/encryptionkey/headset_rob

// Special Antag/Admin/Event/Other headsets

/obj/item/radio/headset/syndicate
	origin_tech = list(TECH_ILLEGAL = 3)
	icon_state = "syndie_headset"
	syndie = 1
	ks1type = /obj/item/encryptionkey/syndicate

/obj/item/radio/headset/alt/syndicate
	origin_tech = list(TECH_ILLEGAL = 3)
	icon_state = "syndie_headset_alt"
	syndie = 1
	ks1type = /obj/item/encryptionkey/syndicate

/obj/item/radio/headset/earbud/syndicate
	origin_tech = list(TECH_ILLEGAL = 3)
	icon_state = "syndie_earbud"
	syndie = 1
	ks1type = /obj/item/encryptionkey/syndicate

/obj/item/radio/headset/raider
	origin_tech = list(TECH_ILLEGAL = 2)
	icon_state = "syndie_headset"
	syndie = 1
	ks1type = /obj/item/encryptionkey/raider

/obj/item/radio/headset/raider/Initialize(mapload)
	. = ..()
	set_frequency(RAID_FREQ)

/obj/item/radio/headset/binary
	origin_tech = list(TECH_ILLEGAL = 3)
	ks1type = /obj/item/encryptionkey/binary

/obj/item/radio/headset/omni		//Only for the admin intercoms
	ks2type = /obj/item/encryptionkey/omni

/obj/item/radio/headset/mmi_radio
	name = "brain-integrated radio"
	desc = "MMIs and synthetic brains are often equipped with these." // CHOMPAdd
	icon = 'icons/obj/robot_component.dmi'
	icon_state = "radio"
	item_state = "headset"
	var/mmiowner = null
	var/radio_enabled = 1

/obj/item/radio/headset/mmi_radio/receive_range(freq, level)
	if (!radio_enabled || istype(src.loc.loc, /mob/living/silicon) || istype(src.loc.loc, /obj/item/organ/internal))
		return -1 //Transciever Disabled.
	return ..(freq, level, 1)

/obj/item/radio/headset/mob_headset	//Adminbus headset for simplemob shenanigans.
	name = "nonhuman radio receiver"
	desc = "An updated, self-adhesive modular intercom that requires no hands to operate or ears to hold, just stick it on. Takes encryption keys"

/obj/item/radio/headset/heads/ai_integrated //No need to care about icons, it should be hidden inside the AI anyway.
	name = "\improper AI subspace transceiver"
	desc = "Integrated AI radio transceiver."
	icon = 'icons/obj/robot_component.dmi'
	icon_state = "radio"
	item_state = "headset"
	ks2type = /obj/item/encryptionkey/heads/ai_integrated
	var/myAi = null    // Atlantis: Reference back to the AI which has this radio.
	var/disabledAi = 0 // Atlantis: Used to manually disable AI's integrated radio via intellicard menu.

/obj/item/radio/headset/heads/ai_integrated/receive_range(freq, level)
	if (disabledAi)
		return -1 //Transciever Disabled.
	return ..(freq, level, 1)
