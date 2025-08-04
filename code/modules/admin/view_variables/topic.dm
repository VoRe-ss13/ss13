//DO NOT ADD MORE TO THIS FILE.
//Use vv_do_topic() for datums!
/client/proc/view_var_Topic(href, href_list, hsrc)
<<<<<<< HEAD
	if((usr.client != src) || !src.holder)
=======
	if(!check_rights_for(src, R_VAREDIT) || !holder.CheckAdminHref(href, href_list))
>>>>>>> 76310c6448 ([MIRROR] View Variables Update (2) (#11149))
		return
	var/target = GET_VV_TARGET
	vv_do_basic(target, href_list, href)
	if(isdatum(target))
		var/datum/D = target
		D.vv_do_topic(href_list)
	else if(islist(target))
		vv_do_list(target, href_list)
	if(href_list["Vars"])
		var/datum/vars_target = locate(href_list["Vars"])
		if(href_list["special_varname"]) // Some special vars can't be located even if you have their ref, you have to use this instead
			vars_target = vars_target.vars[href_list["special_varname"]]
		debug_variables(vars_target)

//~CARN: for renaming mobs (updates their name, real_name, mind.name, their ID/PDA and datacore records).
	if(href_list["rename"])

		var/mob/M = locate(href_list["rename"]) in mob_list
		if(!istype(M))
<<<<<<< HEAD
			to_chat(usr, "This can only be used on instances of type /mob")
			return

		var/new_name = sanitize(tgui_input_text(usr,"What would you like to name this mob?","Input a name",M.real_name,MAX_NAME_LEN), MAX_NAME_LEN)
		if( !new_name || !M )	return

		message_admins("Admin [key_name_admin(usr)] renamed [key_name_admin(M)] to [new_name].")
		M.fully_replace_character_name(M.real_name,new_name)
		href_list["datumrefresh"] = href_list["rename"]

	else if(href_list["varnameedit"] && href_list["datumedit"])
		if(!check_rights(R_VAREDIT))	return

		var/D = locate(href_list["datumedit"])
		if(!istype(D,/datum) && !istype(D,/client))
			to_chat(usr, "This can only be used on instances of types /client or /datum")
			return

		modify_variables(D, href_list["varnameedit"], 1)

	else if(href_list["varnamechange"] && href_list["datumchange"])
		if(!check_rights(R_VAREDIT))	return

		var/D = locate(href_list["datumchange"])
		if(!istype(D,/datum) && !istype(D,/client))
			to_chat(usr, "This can only be used on instances of types /client or /datum")
			return

		modify_variables(D, href_list["varnamechange"], 0)

	else if(href_list["varnamemass"] && href_list["datummass"])
		if(!check_rights(R_VAREDIT))	return

		var/atom/A = locate(href_list["datummass"])
		if(!istype(A))
			to_chat(usr, "This can only be used on instances of type /atom")
			return

		cmd_mass_modify_object_variables(A, href_list["varnamemass"])

	else if(href_list["mob_player_panel"])
		if(!check_rights(0))	return

		var/mob/M = locate(href_list["mob_player_panel"])
		if(!istype(M))
			to_chat(usr, "This can only be used on instances of type /mob")
			return

		src.holder.show_player_panel(M)
		href_list["datumrefresh"] = href_list["mob_player_panel"]

	else if(href_list["give_spell"])
		if(!check_rights(R_ADMIN|R_FUN|R_EVENT))	return

		var/mob/M = locate(href_list["give_spell"])
		if(!istype(M))
			to_chat(usr, "This can only be used on instances of type /mob")
			return

		src.give_spell(M)
		href_list["datumrefresh"] = href_list["give_spell"]

	else if(href_list["give_modifier"])
		if(!check_rights(R_ADMIN|R_FUN|R_DEBUG|R_EVENT))
			return

		var/mob/living/M = locate(href_list["give_modifier"])
		if(!istype(M))
			to_chat(usr, "This can only be used on instances of type /mob/living")
			return

		src.admin_give_modifier(M)
		href_list["datumrefresh"] = href_list["give_modifier"]

	else if(href_list["give_wound_internal"])
		if(!check_rights(R_ADMIN|R_FUN|R_DEBUG|R_EVENT))
			return

		var/mob/living/carbon/human/H = locate(href_list["give_wound_internal"])
		if(!istype(H))
			to_chat(usr, span_notice("This can only be used on instances of type /mob/living/carbon/human"))
			return

		var/severity = tgui_input_number(usr, "How much damage should the bleeding internal wound cause? \
		Bleed timer directly correlates with this. 0 cancels. Input is rounded to nearest integer.",
		"Wound Severity", 0)
		if(!severity) return

		var/obj/item/organ/external/chosen_organ = tgui_input_list(usr, "Choose an external organ to inflict IB on!", "Organ Choice", H.organs)
		if(!chosen_organ || !istype(chosen_organ))
			to_chat(usr, span_notice("The chosen organ is of inappropriate type or no longer exists."))
			return

		var/datum/wound/internal_bleeding/I = new /datum/wound/internal_bleeding(severity)
		if(!I || !istype(I))
			to_chat(usr, span_notice("Could not initialize internal wound"))
			log_debug("[usr] attempted to create an internal bleeding wound on [H]'s [chosen_organ] of [severity] damage \
			and wound initialization failed")

		chosen_organ.wounds += I
		chosen_organ.update_wounds()
		chosen_organ.update_damages()
		H.bad_external_organs += chosen_organ
		H.handle_organs()

		if(H.client)
			H.custom_pain("You feel a throbbing pain inside your [chosen_organ]", severity, force=TRUE)
			log_and_message_admins("created an Internal Bleeding wound on [H.ckey]'s mob [H] on [chosen_organ] of [severity] damage", usr)

		href_list["datumrefresh"] = href_list["give_wound_internal"]

	else if(href_list["godmode"])
		if(!check_rights(R_REJUVINATE))	return

		var/mob/M = locate(href_list["godmode"])
		if(!istype(M))
			to_chat(usr, "This can only be used on instances of type /mob")
			return

		src.cmd_admin_godmode(M)
		href_list["datumrefresh"] = href_list["godmode"]

	else if(href_list["gib"])
		if(!check_rights(0))	return

		var/mob/M = locate(href_list["gib"])
		if(!istype(M))
			to_chat(usr, "This can only be used on instances of type /mob")
			return

		src.cmd_admin_gib(M)

	else if(href_list["build_mode"])
		if(!check_rights(R_BUILDMODE))	return

		var/mob/M = locate(href_list["build_mode"])
		if(!istype(M))
			to_chat(usr, "This can only be used on instances of type /mob")
			return

		togglebuildmode(M)
		href_list["datumrefresh"] = href_list["build_mode"]

	else if(href_list["drop_everything"])
		if(!check_rights(R_DEBUG|R_ADMIN|R_EVENT))	return

		var/mob/M = locate(href_list["drop_everything"])
		if(!istype(M))
			to_chat(usr, "This can only be used on instances of type /mob")
			return

		if(usr.client)
			usr.client.cmd_admin_drop_everything(M)

	else if(href_list["direct_control"])
		if(!check_rights(0))	return

		var/mob/M = locate(href_list["direct_control"])
		if(!istype(M))
			to_chat(usr, "This can only be used on instances of type /mob")
			return

		if(usr.client)
			usr.client.cmd_assume_direct_control(M)

	else if(href_list["give_ai"])
		if(!check_rights(0))	return

		var/mob/M = locate(href_list["give_ai"])
		if(!isliving(M))
			to_chat(usr, span_notice("This can only be used on instances of type /mob/living"))
			return
		var/mob/living/L = M
		if(L.client || L.teleop)
			to_chat(usr, span_warning("This cannot be used on player mobs!"))
			return

		if(L.ai_holder)	//Cleaning up the original ai
			var/ai_holder_old = L.ai_holder
			L.ai_holder = null
			qdel(ai_holder_old)	//Only way I could make #TESTING - Unable to be GC'd to stop. del() logs show it works.
		L.ai_holder_type = tgui_input_list(usr, "Choose AI holder", "AI Type", typesof(/datum/ai_holder/))
		L.initialize_ai_holder()
		L.faction = sanitize(tgui_input_text(usr, "Please input AI faction", "AI faction", "neutral"))
		L.a_intent = tgui_input_list(usr, "Please choose AI intent", "AI intent", list(I_HURT, I_HELP))
		if(tgui_alert(usr, "Make mob wake up? This is needed for carbon mobs.", "Wake mob?", list("Yes", "No")) == "Yes")
			L.AdjustSleeping(-100)

	else if(href_list["make_skeleton"])
		if(!check_rights(R_FUN))	return

		var/mob/living/carbon/human/H = locate(href_list["make_skeleton"])
		if(!istype(H))
			to_chat(usr, "This can only be used on instances of type /mob/living/carbon/human")
			return

		H.ChangeToSkeleton()
		href_list["datumrefresh"] = href_list["make_skeleton"]

	else if(href_list["delall"])
		if(!check_rights(R_DEBUG|R_SERVER))
			return

		var/obj/O = locate(href_list["delall"])
		if(!isobj(O))
			to_chat(usr, "This can only be used on instances of type /obj")
			return

		var/action_type = tgui_alert(usr, "Strict type ([O.type]) or type and all subtypes?","Type Selection",list("Strict type","Type and subtypes","Cancel"))
		if(action_type == "Cancel" || !action_type)
			return

		if(tgui_alert(usr, "Are you really sure you want to delete all objects of type [O.type]?","Delete All?",list("Yes","No")) != "Yes")
			return

		if(tgui_alert(usr, "Second confirmation required. Delete?","REALLY?",list("Yes","No")) != "Yes")
			return

		var/O_type = O.type
		switch(action_type)
			if("Strict type")
				var/i = 0
				for(var/obj/Obj in world)
					if(Obj.type == O_type)
						i++
						qdel(Obj)
					CHECK_TICK
				if(!i)
					to_chat(usr, "No objects of this type exist")
					return
				log_admin("[key_name(usr)] deleted all objects of type [O_type] ([i] objects deleted) ")
				message_admins(span_notice("[key_name(usr)] deleted all objects of type [O_type] ([i] objects deleted) "))
			if("Type and subtypes")
				var/i = 0
				for(var/obj/Obj in world)
					if(istype(Obj,O_type))
						i++
						qdel(Obj)
					CHECK_TICK
				if(!i)
					to_chat(usr, "No objects of this type exist")
					return
				log_admin("[key_name(usr)] deleted all objects of type or subtype of [O_type] ([i] objects deleted) ")
				message_admins(span_notice("[key_name(usr)] deleted all objects of type or subtype of [O_type] ([i] objects deleted) "))
	else if(href_list["fakepdapropconvo"])
		if(!check_rights(R_FUN)) return

		var/obj/item/pda/P = locate(href_list["fakepdapropconvo"])
		if(!istype(P))
			to_chat(usr, span_warning("This can only be done to instances of type /pda"))
			return

		P.createPropFakeConversation_admin(usr)
=======
			to_chat(usr, "This can only be used on instances of type /mob", confidential = TRUE)
			return

		var/new_name = stripped_input(usr,"What would you like to name this mob?","Input a name",M.real_name,MAX_NAME_LEN)

		// If the new name is something that would be restricted by IC chat filters,
		// give the admin a warning but allow them to do it anyway if they want.
		//if(is_ic_filtered(new_name) || is_soft_ic_filtered(new_name) && tgui_alert(usr, "Your selected name contains words restricted by IC chat filters. Confirm this new name?", "IC Chat Filter Conflict", list("Confirm", "Cancel")) == "Cancel")
		//	return

		if( !new_name || !M )
			return

		message_admins("Admin [key_name_admin(usr)] renamed [key_name_admin(M)] to [new_name].")
		M.fully_replace_character_name(M.real_name,new_name)
		vv_update_display(M, "name", new_name)
		vv_update_display(M, "real_name", M.real_name || "No real name")
>>>>>>> 76310c6448 ([MIRROR] View Variables Update (2) (#11149))

	else if(href_list["rotatedatum"])

		var/atom/A = locate(href_list["rotatedatum"])
		if(!istype(A))
<<<<<<< HEAD
			to_chat(usr, "This can only be done to instances of type /atom")
=======
			to_chat(usr, "This can only be done to instances of type /atom", confidential = TRUE)
>>>>>>> 76310c6448 ([MIRROR] View Variables Update (2) (#11149))
			return

		switch(href_list["rotatedir"])
			if("right")
				A.set_dir(turn(A.dir, -45))
			if("left")
				A.set_dir(turn(A.dir, 45))
		vv_update_display(A, "dir", dir2text(A.dir))

<<<<<<< HEAD
	else if(href_list["makemonkey"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/human/H = locate(href_list["makemonkey"])
		if(!istype(H))
			to_chat(usr, "This can only be done to instances of type /mob/living/carbon/human")
			return

		if(tgui_alert(usr, "Confirm mob type change?","Confirm",list("Transform","Cancel")) != "Transform")	return
		if(!H)
			to_chat(usr, "Mob doesn't exist anymore")
			return
		holder.Topic(href, list("monkeyone"=href_list["makemonkey"]))

	else if(href_list["makerobot"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/human/H = locate(href_list["makerobot"])
		if(!istype(H))
			to_chat(usr, "This can only be done to instances of type /mob/living/carbon/human")
			return

		if(tgui_alert(usr, "Confirm mob type change?","Confirm",list("Transform","Cancel")) != "Transform")	return
		if(!H)
			to_chat(usr, "Mob doesn't exist anymore")
			return
		holder.Topic(href, list("makerobot"=href_list["makerobot"]))

	else if(href_list["makealien"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/human/H = locate(href_list["makealien"])
		if(!istype(H))
			to_chat(usr, "This can only be done to instances of type /mob/living/carbon/human")
			return

		if(tgui_alert(usr, "Confirm mob type change?","Confirm",list("Transform","Cancel")) != "Transform")	return
		if(!H)
			to_chat(usr, "Mob doesn't exist anymore")
			return
		holder.Topic(href, list("makealien"=href_list["makealien"]))

	else if(href_list["makeai"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/human/H = locate(href_list["makeai"])
		if(!istype(H))
			to_chat(usr, "This can only be done to instances of type /mob/living/carbon/human")
			return

		if(tgui_alert(usr, "Confirm mob type change?","Confirm",list("Transform","Cancel")) != "Transform")	return
		if(!H)
			to_chat(usr, "Mob doesn't exist anymore")
			return
		holder.Topic(href, list("makeai"=href_list["makeai"]))

	else if(href_list["setspecies"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/human/H = locate(href_list["setspecies"])
		if(!istype(H))
			to_chat(usr, "This can only be done to instances of type /mob/living/carbon/human")
			return

		var/new_species = tgui_input_list(usr, "Please choose a new species.","Species", GLOB.all_species)

		if(!H)
			to_chat(usr, "Mob doesn't exist anymore")
			return

		if(H.set_species(new_species))
			to_chat(usr, "Set species of [H] to [H.species].")
		else
			to_chat(usr, "Failed! Something went wrong.")

	else if(href_list["addlanguage"])
		if(!check_rights(R_SPAWN))	return

		var/mob/H = locate(href_list["addlanguage"])
		if(!istype(H))
			to_chat(usr, "This can only be done to instances of type /mob")
			return

		var/new_language = tgui_input_list(usr, "Please choose a language to add.","Language", GLOB.all_languages)

		if(!new_language)
			return

		if(!H)
			to_chat(usr, "Mob doesn't exist anymore")
			return

		if(H.add_language(new_language))
			to_chat(usr, "Added [new_language] to [H].")
		else
			to_chat(usr, "Mob already knows that language.")

	else if(href_list["remlanguage"])
		if(!check_rights(R_SPAWN))	return

		var/mob/H = locate(href_list["remlanguage"])
		if(!istype(H))
			to_chat(usr, "This can only be done to instances of type /mob")
			return

		if(!H.languages.len)
			to_chat(usr, "This mob knows no languages.")
			return

		var/datum/language/rem_language = tgui_input_list(usr, "Please choose a language to remove.","Language", H.languages)

		if(!rem_language)
			return

		if(!H)
			to_chat(usr, "Mob doesn't exist anymore")
			return

		if(H.remove_language(rem_language.name))
			to_chat(usr, "Removed [rem_language] from [H].")
		else
			to_chat(usr, "Mob doesn't know that language.")

	else if(href_list["addverb"])
		if(!check_rights(R_DEBUG))      return

		var/mob/H = locate(href_list["addverb"])

		if(!ismob(H))
			to_chat(usr, "This can only be done to instances of type /mob")
			return
		var/list/possibleverbs = list()
		possibleverbs += "Cancel" 								// One for the top...
		possibleverbs += typesof(/mob/proc, /mob/verb)
		if(isobserver(H))
			possibleverbs += typesof(/mob/observer/dead/proc,/mob/observer/dead/verb)
		if(isliving(H))
			possibleverbs += typesof(/mob/living/proc,/mob/living/verb)
		if(ishuman(H))
			possibleverbs += typesof(/mob/living/carbon/proc,/mob/living/carbon/verb,/mob/living/carbon/human/verb,/mob/living/carbon/human/proc)
		if(isrobot(H))
			possibleverbs += typesof(/mob/living/silicon/proc,/mob/living/silicon/robot/proc,/mob/living/silicon/robot/verb)
		if(isAI(H))
			possibleverbs += typesof(/mob/living/silicon/proc,/mob/living/silicon/ai/proc,/mob/living/silicon/ai/verb)
		if(isanimal(H))
			possibleverbs += typesof(/mob/living/simple_mob/proc)
		possibleverbs -= H.verbs
		possibleverbs += "Cancel" 								// ...And one for the bottom

		var/verb = tgui_input_list(usr, "Select a verb!", "Verbs", possibleverbs)
		if(!H)
			to_chat(usr, "Mob doesn't exist anymore")
			return
		if(!verb || verb == "Cancel")
			return
		else
			add_verb(H, verb)

	else if(href_list["remverb"])
		if(!check_rights(R_DEBUG))      return

		var/mob/H = locate(href_list["remverb"])

		if(!istype(H))
			to_chat(usr, "This can only be done to instances of type /mob")
			return
		var/verb = tgui_input_list(usr, "Please choose a verb to remove.","Verbs", H.verbs)
		if(!H)
			to_chat(usr, "Mob doesn't exist anymore")
			return
		if(!verb)
			return
		else
			remove_verb(H, verb)

	else if(href_list["addorgan"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/M = locate(href_list["addorgan"])
		if(!istype(M))
			to_chat(usr, "This can only be done to instances of type /mob/living/carbon")
			return

		var/new_organ = tgui_input_list(usr, "Please choose an organ to add.","Organ", subtypesof(/obj/item/organ))
		if(!new_organ) return

		if(!M)
			to_chat(usr, "Mob doesn't exist anymore")
			return

		if(locate(new_organ) in M.internal_organs)
			to_chat(usr, "Mob already has that organ.")
			return

		new new_organ(M)


	else if(href_list["remorgan"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/M = locate(href_list["remorgan"])
		if(!istype(M))
			to_chat(usr, "This can only be done to instances of type /mob/living/carbon")
			return

		var/obj/item/organ/rem_organ = tgui_input_list(usr, "Please choose an organ to remove.","Organ", M.internal_organs)

		if(!M)
			to_chat(usr, "Mob doesn't exist anymore")
			return

		if(!(locate(rem_organ) in M.internal_organs))
			to_chat(usr, "Mob does not have that organ.")
			return

		to_chat(usr, "Removed [rem_organ] from [M].")
		rem_organ.removed()
		qdel(rem_organ)

	else if(href_list["fix_nano"])
		if(!check_rights(R_DEBUG)) return

		var/mob/H = locate(href_list["fix_nano"])

		if(!istype(H) || !H.client)
			to_chat(usr, "This can only be done on mobs with clients")
			return

		H.client.send_resources()

		to_chat(usr, "Resource files sent")
		to_chat(H, "Your NanoUI Resource files have been refreshed")

		log_admin("[key_name(usr)] resent the NanoUI resource files to [key_name(H)] ")

	else if(href_list["regenerateicons"])
		if(!check_rights(0))	return

		var/mob/M = locate(href_list["regenerateicons"])
		if(!ismob(M))
			to_chat(usr, "This can only be done to instances of type /mob")
			return
		M.regenerate_icons()
=======
>>>>>>> 76310c6448 ([MIRROR] View Variables Update (2) (#11149))

	else if(href_list["adjustDamage"] && href_list["mobToDamage"])

		var/mob/living/L = locate(href_list["mobToDamage"]) in mob_list
		if(!istype(L))
			return

		var/Text = href_list["adjustDamage"]

<<<<<<< HEAD
		var/amount =  tgui_input_number(usr, "Deal how much damage to mob? (Negative values here heal)","Adjust [Text]loss",0, min_value=-INFINITY, round_value=FALSE)

		if(!L)
			to_chat(usr, "Mob doesn't exist anymore")
=======
		var/amount = tgui_input_number(src, "Deal how much damage to mob? (Negative values here heal)", "Adjust [Text]loss", 0, min_value=-INFINITY, round_value=FALSE)

		if (isnull(amount))
>>>>>>> 76310c6448 ([MIRROR] View Variables Update (2) (#11149))
			return

		if(!L)
			to_chat(usr, "Mob doesn't exist anymore", confidential = TRUE)
			return

		var/newamt
		switch(Text)
			if("brute")
				L.adjustBruteLoss(amount)
				newamt = L.getBruteLoss()
			if("fire")
				L.adjustFireLoss(amount)
				newamt = L.getFireLoss()
			if("toxin")
				L.adjustToxLoss(amount)
				newamt = L.getToxLoss()
			if("oxygen")
				L.adjustOxyLoss(amount)
				newamt = L.getOxyLoss()
			if("brain")
				L.adjustBrainLoss(amount)
				newamt = L.getBrainLoss()
			if("clone")
				L.adjustCloneLoss(amount)
				newamt = L.getCloneLoss()
			//if("brain")
			//	L.adjustOrganLoss(ORGAN_SLOT_BRAIN, amount)
			//	newamt = L.get_organ_loss(ORGAN_SLOT_BRAIN)
			//if("stamina")
			//	L.adjustStaminaLoss(amount, forced = TRUE)
			//	newamt = L.getStaminaLoss()
			else
<<<<<<< HEAD
				to_chat(usr, "You caused an error. DEBUG: Text:[Text] Mob:[L]")
				return

		if(amount != 0)
			log_admin("[key_name(usr)] dealt [amount] amount of [Text] damage to [L]")
			message_admins(span_notice("[key_name(usr)] dealt [amount] amount of [Text] damage to [L]"))
			href_list["datumrefresh"] = href_list["mobToDamage"]
	else if(href_list["expose"])
		if(!check_rights(R_ADMIN, FALSE))
			return
		var/thing = locate(href_list["expose"])
		if(!thing)		//Do NOT QDELETED check!
			return
		var/value = vv_get_value(VV_CLIENT)
		if (value["class"] != VV_CLIENT)
			return
		var/client/C = value["value"]
		if (!C)
			return
		var/prompt = tgui_alert(usr, "Do you want to grant [C] access to view this VV window? (they will not be able to edit or change anysrc nor open nested vv windows unless they themselves are an admin)", "Confirm", list("Yes", "No"))
		if (prompt != "Yes")
			return
		if(!thing)
			to_chat(usr, span_warning("The object you tried to expose to [C] no longer exists (GC'd)"))
			return
		message_admins("[key_name_admin(usr)] Showed [key_name_admin(C)] a <a href='byond://?_src_=vars;[HrefToken(TRUE)];datumrefresh=\ref[thing]'>VV window</a>")
		log_admin("Admin [key_name(usr)] Showed [key_name(C)] a VV window of a [src]")
		to_chat(C, "[holder.fakekey ? "an Administrator" : "[usr.client.key]"] has granted you access to view a View Variables window")
		C.debug_variables(thing)
=======
				to_chat(usr, "You caused an error. DEBUG: Text:[Text] Mob:[L]", confidential = TRUE)
				return

		if(amount != 0)
			var/log_msg = "[key_name(usr)] dealt [amount] amount of [Text] damage to [key_name(L)]"
			message_admins("[key_name(usr)] dealt [amount] amount of [Text] damage to [ADMIN_LOOKUPFLW(L)]")
			log_admin(log_msg)
			admin_ticket_log(L, "<font color='blue'>[log_msg]</font>")
			vv_update_display(L, Text, "[newamt]")
>>>>>>> 76310c6448 ([MIRROR] View Variables Update (2) (#11149))

	else if(href_list["item_to_tweak"] && href_list["var_tweak"])

		var/obj/item/editing = locate(href_list["item_to_tweak"])
		if(!istype(editing) || QDELING(editing))
			return

		var/existing_val = -1
		switch(href_list["var_tweak"])
			if("damtype")
				existing_val = editing.damtype
			if("force")
				existing_val = editing.force
			//if("wound")
			//	existing_val = editing.wound_bonus
			//if("bare wound")
			//	existing_val = editing.exposed_wound_bonus
			else
				CRASH("Invalid var_tweak passed to item vv set var: [href_list["var_tweak"]]")

		var/new_val
		if(href_list["var_tweak"] == "damtype")
			//new_val = tgui_input_list(usr, "Enter the new damage type for [editing]", "Set Damtype", list(BRUTE, BURN, TOX, OXY, STAMINA, BRAIN), existing_val)
			new_val = tgui_input_list(usr, "Enter the new damage type for [editing]","Set Damtype", list(BRUTE, BURN, TOX, OXY, CLONE, HALLOSS, ELECTROCUTE, BIOACID, SEARING, ELECTROMAG), existing_val)
		else
			new_val = tgui_input_number(usr, "Enter the new value for [editing]'s [href_list["var_tweak"]]","Set [href_list["var_tweak"]]", existing_val)
		if(isnull(new_val) || new_val == existing_val || QDELETED(editing) || !check_rights(R_VAREDIT))
			return

		switch(href_list["var_tweak"])
			if("damtype")
				editing.damtype = new_val
			if("force")
				editing.force = new_val
			//if("wound")
			//	editing.wound_bonus = new_val
			//if("bare wound")
			//	editing.exposed_wound_bonus = new_val

		message_admins("[key_name(usr)] set [editing]'s [href_list["var_tweak"]] to [new_val] (was [existing_val])")
		log_admin("[key_name(usr)] set [editing]'s [href_list["var_tweak"]] to [new_val] (was [existing_val])")
		vv_update_display(editing, href_list["var_tweak"], istext(new_val) ? uppertext(new_val) : new_val)

	//Finally, refresh if something modified the list.
	if(href_list["datumrefresh"])
		var/datum/DAT = locate(href_list["datumrefresh"])
		if(isdatum(DAT) || istype(DAT, /client) || islist(DAT))
			debug_variables(DAT)
