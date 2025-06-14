//Procedures in this file: Gneric surgery steps
//////////////////////////////////////////////////////////////////
//						COMMON STEPS							//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/
	surgery_name = "Robotic Surgery"
	can_infect = 0

/datum/surgery_step/robotics/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (isslime(target))
		return 0
	if (target_zone == O_EYES)	//there are specific steps for eye surgery
		return 0
	if (!hasorgans(target))
		return 0
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if (affected == null)
		return 0
	if (affected.status & ORGAN_DESTROYED)
		return 0
	if (!(affected.robotic == ORGAN_ROBOT || affected.robotic == ORGAN_LIFELIKE)) //VOREStation Edit - No good on ORGAN_NANOFORM
		return 0
	if(coverage_check(user, target, affected, tool))
		return 0
	return 1

///////////////////////////////////////////////////////////////
// Unscrew Hatch Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/unscrew_hatch
	surgery_name = "Unscrew Hatch"
	allowed_tools = list(
		/obj/item/coin = 50,
		/obj/item/material/knife = 50
	)

	allowed_procs = list(IS_SCREWDRIVER = 100)

	req_open = 0

	min_duration = 90
	max_duration = 110

/datum/surgery_step/robotics/unscrew_hatch/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(..())
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return affected && affected.open == 0 && target_zone != O_MOUTH

/datum/surgery_step/robotics/unscrew_hatch/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_filter_notice("[user] starts to unscrew the maintenance hatch on [target]'s [affected.name] with \the [tool]."), \
	span_filter_notice("You start to unscrew the maintenance hatch on [target]'s [affected.name] with \the [tool]."))
	user.balloon_alert_visible("starts to unscrew the maintenance hatch on [target]'s [affected.name]", "unscrewing the maintenance hatch on \the [affected.name]")
	..()

/datum/surgery_step/robotics/unscrew_hatch/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_notice("[user] has opened the maintenance hatch on [target]'s [affected.name] with \the [tool]."), \
	span_notice("You have opened the maintenance hatch on [target]'s [affected.name] with \the [tool]."),)
	user.balloon_alert_visible("opens the maintenance hatch on [target]'s [affected.name]", "maintenance hatch opened on \the [affected.name]")
	affected.open = 1

/datum/surgery_step/robotics/unscrew_hatch/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_warning("[user]'s [tool.name] slips, failing to unscrew [target]'s [affected.name]."), \
	span_warning("Your [tool] slips, failing to unscrew [target]'s [affected.name]."))
	user.balloon_alert_visible("slips, failing to unscrew [target]'s [affected.name]", "your [tool] slips, failing to unscrew \the [affected.name]")

///////////////////////////////////////////////////////////////
// Open Hatch Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/insertion_preparation
	surgery_name = "Rewire Internals"
	allowed_tools = list(
		/obj/item/multitool = 100
	)

	min_duration = 30
	max_duration = 40

/datum/surgery_step/robotics/insertion_preparation/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(..())
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return affected && affected.open == 1

/datum/surgery_step/robotics/insertion_preparation/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_filter_notice("[user] starts to modify the wiring in [target]'s [affected.name] with \the [tool]."),
		span_filter_notice("You start to modify the wiring in [target]'s [affected.name] with \the [tool]."))
	..()

/datum/surgery_step/robotics/insertion_preparation/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_notice("[user] modifies the wiring in [target]'s [affected.name] with \the [tool]."), \
		span_notice("You modify the wiring in [target]'s [affected.name] with \the [tool]."))
	affected.open = 2

/datum/surgery_step/robotics/insertion_preparation/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_warning("[user]'s [tool.name] slips, failing to modify the wiring in [target]'s [affected.name]."),
		span_warning("Your [tool] slips, failing to modify the wiring in [target]'s [affected.name]."))

///////////////////////////////////////////////////////////////
// Open Hatch Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/insertion_preparation
	surgery_name = "Rewire Internals"
	allowed_tools = list(
		/obj/item/multitool = 100
	)

	min_duration = 30
	max_duration = 40

/datum/surgery_step/robotics/insertion_preparation/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(..())
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return affected && affected.open == 1

/datum/surgery_step/robotics/insertion_preparation/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_filter_notice("[user] starts to modify the wiring in [target]'s [affected.name] with \the [tool]."),
	span_filter_notice("You start to modify the wiring in [target]'s [affected.name] with \the [tool]."))
	..()

/datum/surgery_step/robotics/insertion_preparation/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_notice("[user] modifies the wiring in [target]'s [affected.name] with \the [tool]."), \
		span_notice("You modify the wiring in [target]'s [affected.name] with \the [tool]."))
	affected.open = 2

/datum/surgery_step/robotics/insertion_preparation/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_warning("[user]'s [tool.name] slips, failing to modify the wiring in [target]'s [affected.name]."),
	span_warning("Your [tool] slips, failing to modify the wiring in [target]'s [affected.name]."))

///////////////////////////////////////////////////////////////
// Open Hatch Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/open_hatch
	surgery_name = "Open Hatch"
	allowed_tools = list(
		/obj/item/surgical/retractor = 100,
		/obj/item/material/kitchen/utensil = 50
	)

	allowed_procs = list(IS_CROWBAR = 100)

	min_duration = 30
	max_duration = 40

/datum/surgery_step/robotics/open_hatch/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(..())
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return affected && affected.open == 1

/datum/surgery_step/robotics/open_hatch/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_filter_notice("[user] starts to pry open the maintenance hatch on [target]'s [affected.name] with \the [tool]."),
												span_filter_notice("You start to pry open the maintenance hatch on [target]'s [affected.name] with \the [tool]."))
	user.balloon_alert_visible("starts to pry open the maintenance hatch on [target]'s [affected.name]", "prying open the maintenance hatch on \the [affected.name]")
	..()

/datum/surgery_step/robotics/open_hatch/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_notice("[user] opens the maintenance hatch on [target]'s [affected.name] with \the [tool]."), \
										span_notice("You open the maintenance hatch on [target]'s [affected.name] with \the [tool]."))
	user.balloon_alert_visible("opens the maintenance hatch on [target]'s [affected.name]", "maintenance hatch on \the [affected.name] open")
	affected.open = 3

/datum/surgery_step/robotics/open_hatch/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_warning("[user]'s [tool.name] slips, failing to open the hatch on [target]'s [affected.name]."),
										span_warning("Your [tool] slips, failing to open the hatch on [target]'s [affected.name]."))
	user.balloon_alert_visible("slips, failing to open the hatch on [target]'s [affected.name]", "your [tool] slips, fialing to open the hatch on \the [affected.name]")

///////////////////////////////////////////////////////////////
// Close Hatch Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/close_hatch
	surgery_name = "Close Hatch"
	allowed_tools = list(
		/obj/item/surgical/retractor = 100,
		/obj/item/material/kitchen/utensil = 50
	)

	allowed_procs = list(IS_CROWBAR = 100)

	min_duration = 70
	max_duration = 100

/datum/surgery_step/robotics/close_hatch/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(..())
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return affected && affected.open && target_zone != O_MOUTH

/datum/surgery_step/robotics/close_hatch/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_filter_notice("[user] begins to close and secure the hatch on [target]'s [affected.name] with \the [tool].") , \
	span_filter_notice("You begin to close and secure the hatch on [target]'s [affected.name] with \the [tool]."))
	user.balloon_alert_visible("begins closing and securing the hatch on [target]'s [affected.name]", "closing and securing the hatch on \the [affected.name]")
	..()

/datum/surgery_step/robotics/close_hatch/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_notice("[user] closes and secures the hatch on [target]'s [affected.name] with \the [tool]."), \
	span_notice("You close and secure the hatch on [target]'s [affected.name] with \the [tool]."))
	user.balloon_alert_visible("closes and secures the hatch on [target]'s [affected.name]", "closed and secured the hatch on \the [affected.name]")
	affected.open = 0
	affected.germ_level = 0

/datum/surgery_step/robotics/close_hatch/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_warning("[user]'s [tool.name] slips, failing to close the hatch on [target]'s [affected.name]."),
	span_warning("Your [tool.name] slips, failing to close the hatch on [target]'s [affected.name]."))
	user.balloon_alert_visible("[tool.name] slips, failing to close the htach on [target]'s [affected.name]", "[tool.name] slips, failing to close the htach on [target]'s [affected.name]")

///////////////////////////////////////////////////////////////
// Brute Repair Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/repair_brute
	surgery_name = "Repair Robotic Brute"
	allowed_tools = list(
		/obj/item/weldingtool = 100,
		/obj/item/pickaxe/plasmacutter = 50
	)

	min_duration = 50
	max_duration = 60

/datum/surgery_step/robotics/repair_brute/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(..()) //CHOMPEdit begin. Added damage check.
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		if(istype(tool, /obj/item/weldingtool))
			var/obj/item/weldingtool/welder = tool
			if(affected.brute_dam == 0)
				to_chat(user, span_notice("There is no damage to the internal structure here!"))
				return SURGERY_FAILURE
			else
				if(!welder.isOn() || !welder.remove_fuel(1,user))
					return 0
		return affected && affected.open == 3 && (affected.disfigured || affected.brute_dam > 0) && target_zone != O_MOUTH // CHOMPEdit End.

/datum/surgery_step/robotics/repair_brute/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_filter_notice("[user] begins to patch damage to [target]'s [affected.name]'s support structure with \the [tool].") , \
	span_filter_notice("You begin to patch damage to [target]'s [affected.name]'s support structure with \the [tool]."))
	user.balloon_alert_visible("begins patching damage to [target]'s [affected.name]'s support structure", "beggining to patch damage to \the [affected.name] support structure")
	..()

/datum/surgery_step/robotics/repair_brute/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_notice("[user] finishes patching damage to [target]'s [affected.name] with \the [tool]."), \
	span_notice("You finish patching damage to [target]'s [affected.name] with \the [tool]."))
	user.balloon_alert_visible("finishes patching damage to [target]'s [affected.name]", "patched samage to \the [affected.name]")
	affected.heal_damage(rand(30,50),0,1,1)
	affected.disfigured = 0

/datum/surgery_step/robotics/repair_brute/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_warning("[user]'s [tool.name] slips, damaging the internal structure of [target]'s [affected.name]."),
	span_warning("Your [tool.name] slips, damaging the internal structure of [target]'s [affected.name]."))
	user.balloon_alert_visible("slips, damaging the internal structure of [target]'s [affected.name]", "your [tool.name] slips, damaging the internal structure of \the [affected.name]")
	target.apply_damage(rand(5,10), BURN, affected)

///////////////////////////////////////////////////////////////
// Burn Repair Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/repair_burn
	surgery_name = "Repair Robotic Burn"
	allowed_tools = list(
		/obj/item/stack/cable_coil = 100
	)

	min_duration = 50
	max_duration = 50 //CHOMPedit

/datum/surgery_step/robotics/repair_burn/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(..())
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		if(istype(tool, /obj/item/stack/cable_coil))
			var/obj/item/stack/cable_coil/C = tool
			if(affected.burn_dam == 0)
				user.balloon_alert_visible("there are no burnt wires here!")
				to_chat(user, span_notice("There are no burnt wires here!"))
				return SURGERY_FAILURE
			else
				if(!C.can_use(5))
					to_chat(user, span_danger("You need at least five cable pieces to repair this part.")) //usage amount made more consistent with regular cable repair
					user.balloon_alert_visible("You need at least five cable pieces to repair this part.")
					return SURGERY_FAILURE
				else
					C.use(5)

		return affected && affected.open == 3 && (affected.disfigured || affected.burn_dam > 0) && target_zone != O_MOUTH

/datum/surgery_step/robotics/repair_burn/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_filter_notice("[user] begins to splice new cabling into [target]'s [affected.name].") , \
	span_filter_notice("You begin to splice new cabling into [target]'s [affected.name]."))
	user.balloon_alert_visible("begins to splice new cabling into [target]'s [affected.name]", "splcing new cabling into \the [affected.name]")
	..()

/datum/surgery_step/robotics/repair_burn/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_notice("[user] finishes splicing cable into [target]'s [affected.name]."), \
	span_notice("You finishes splicing new cable into [target]'s [affected.name]."))
	user.balloon_alert_visible("finishes splicing cable into [target]'s [affected.name]", "finished splicing new cable into [target]'s [affected.name]")
	affected.heal_damage(0,rand(30,50),1,1)
	affected.disfigured = 0

/datum/surgery_step/robotics/repair_burn/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_warning("[user] causes a short circuit in [target]'s [affected.name]!"),
	span_warning("You cause a short circuit in [target]'s [affected.name]!"))
	user.balloon_alert_visible("causes a short circuit in [target]'s [affected.name]", "you cause a short circuit in \the [affected.name]")
	target.apply_damage(rand(5,10), BURN, affected)

///////////////////////////////////////////////////////////////
// Robot Organ Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/fix_organ_robotic //For artificial organs

	priority = 2
	surgery_name = "Fix Robotic Organ"
	allowed_tools = list(
	/obj/item/stack/nanopaste = 100,		\
	/obj/item/surgical/bonegel = 30, 		\
	)

	allowed_procs = list(IS_SCREWDRIVER = 100)

	min_duration = 70
	max_duration = 70 //CHOMPedit

/datum/surgery_step/robotics/fix_organ_robotic/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(!affected) return
	var/is_organ_damaged = 0
	for(var/obj/item/organ/I in affected.internal_organs)
		if(I.damage > 0 && (I.robotic >= ORGAN_ROBOT))
			is_organ_damaged = 1
			break
	return affected.open == 3 && is_organ_damaged

/datum/surgery_step/robotics/fix_organ_robotic/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	for(var/obj/item/organ/I in affected.internal_organs)
		if(I && I.damage > 0)
			if(I.robotic >= ORGAN_ROBOT)
				user.visible_message(span_filter_notice("[user] starts mending the damage to [target]'s [I.name]'s mechanisms."), \
				span_filter_notice("You start mending the damage to [target]'s [I.name]'s mechanisms.") )
				user.balloon_alert_visible("starts mending the damage to [target]'s [I.name]'s mechanisms.", "mending the damage to \the [I.name]'s mechanism")

	target.custom_pain("The pain in your [affected.name] is living hell!",1)
	..()

/datum/surgery_step/robotics/fix_organ_robotic/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	for(var/obj/item/organ/I in affected.internal_organs)
		if(I && I.damage > 0)
			if(I.robotic >= ORGAN_ROBOT)
				user.visible_message(span_notice("[user] repairs [target]'s [I.name] with [tool]."), \
				span_notice("You repair [target]'s [I.name] with [tool].") )
				user.balloon_alert_visible("repairs [target]'s [I.name]", "repaired \the [I.name]")
				I.damage = 0
				if(I.organ_tag == O_EYES)
					target.sdisabilities &= ~BLIND

/datum/surgery_step/robotics/fix_organ_robotic/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	user.visible_message(span_warning("[user]'s hand slips, gumming up the mechanisms inside of [target]'s [affected.name] with \the [tool]!"), \
	span_warning("Your hand slips, gumming up the mechanisms inside of [target]'s [affected.name] with \the [tool]!"))
	user.balloon_alert_visible("slips, gumming up the mechanisms inside [target]'s [affected.name]", "your hand slips, gumming up the mechanisms inside of \the [affected.name]")

	target.adjustToxLoss(5)
	affected.createwound(CUT, 5)

	for(var/obj/item/organ/I in affected.internal_organs)
		if(I)
			I.take_damage(rand(3,5),0)

///////////////////////////////////////////////////////////////
// Robot Organ Detaching Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/detatch_organ_robotic
	surgery_name = "Detach Robotic Organ"
	allowed_tools = list(
	/obj/item/multitool = 100
	)

	min_duration = 90
	max_duration = 110

/datum/surgery_step/robotics/detatch_organ_robotic/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(!(affected && (affected.robotic >= ORGAN_ROBOT)))
		return 0
	if(affected.open < 3)
		return 0

	var/list/attached_organs = list() //Let's see if we have any organs able to be detached!
	for(var/organ in target.internal_organs_by_name)
		var/obj/item/organ/I = target.internal_organs_by_name[organ]
		if(I && !(I.status & ORGAN_CUT_AWAY) && I.parent_organ == target_zone)
			attached_organs |= organ

	if(!attached_organs.len) //No organs able to be detached!
		return 0

	return ..()

/datum/surgery_step/robotics/detatch_organ_robotic/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/list/attached_organs = list() //Which organs can we detach?
	for(var/organ in target.internal_organs_by_name)
		var/obj/item/organ/I = target.internal_organs_by_name[organ]
		if(I && !(I.status & ORGAN_CUT_AWAY) && I.parent_organ == target_zone)
			attached_organs |= organ

	var/organ_to_remove = tgui_input_list(user, "Which organ do you want to prepare for removal?", "Organ Choice", attached_organs)

	if(!organ_to_remove) //They chose cancel!
		to_chat(user, span_notice("You decide against preparing any organs for removal."))
		return
	target.op_stage.current_organ = organ_to_remove

	user.visible_message(span_filter_notice("[user] starts to decouple [target]'s [target.op_stage.current_organ] with \the [tool]."), \
	span_filter_notice("You start to decouple [target]'s [target.op_stage.current_organ] with \the [tool].") )
	user.balloon_alert_visible("starts to decouple [target]'s [target.op_stage.current_organ]", "decoupling \the [target.op_stage.current_organ]")
	..()

/datum/surgery_step/robotics/detatch_organ_robotic/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	user.visible_message(span_notice("[user] has decoupled [target]'s [target.op_stage.current_organ] with \the [tool].") , \
	span_notice("You have decoupled [target]'s [target.op_stage.current_organ] with \the [tool]."))
	user.balloon_alert_visible("decoupled [target]'s [target.op_stage.current_organ]", "decouple \the [target.op_stage.current_organ]")

	var/obj/item/organ/internal/I = target.internal_organs_by_name[target.op_stage.current_organ]
	if(I && istype(I))
		I.status |= ORGAN_CUT_AWAY
	target.op_stage.current_organ = null

/datum/surgery_step/robotics/detatch_organ_robotic/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	user.visible_message(span_warning("[user]'s hand slips, disconnecting \the [tool]."), \
	span_warning("Your hand slips, disconnecting \the [tool]."))
	user.balloon_alert_visible("slips, disconnecting \the [tool]", "your hand slips, disconnecting \the [tool]")

///////////////////////////////////////////////////////////////
// Robot Organ Attaching Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/attach_organ_robotic

	priority = 2
	surgery_name = "Attach Robotic Organ"
	allowed_procs = list(IS_SCREWDRIVER = 100)

	min_duration = 100
	max_duration = 120

/datum/surgery_step/robotics/attach_organ_robotic/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(!(affected && (affected.robotic >= ORGAN_ROBOT)))
		return 0
	if(affected.open < 3)
		return 0

	var/list/attachable_organs = list()
	for(var/organ in target.internal_organs_by_name)
		var/obj/item/organ/I = target.internal_organs_by_name[organ]
		if(I && (I.status & ORGAN_CUT_AWAY) && (I.robotic >= ORGAN_ROBOT) && I.parent_organ == target_zone)
			attachable_organs |= organ

	if(!attachable_organs.len)
		return 0

	return ..()

/datum/surgery_step/robotics/attach_organ_robotic/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	var/list/attachable_organs = list()
	for(var/organ in target.internal_organs_by_name)
		var/obj/item/organ/I = target.internal_organs_by_name[organ]
		if(I && (I.status & ORGAN_CUT_AWAY) && (I.robotic >= ORGAN_ROBOT) && I.parent_organ == target_zone)
			attachable_organs |= organ

	var/organ_to_replace = tgui_input_list(user, "Which organ do you want to reattach?", "Organ Choice", attachable_organs)
	if(!organ_to_replace) //They chose cancel!
		to_chat(user, span_notice("You decide against reattaching any organs."))
		return


	target.op_stage.current_organ = organ_to_replace

	user.visible_message(span_filter_notice("[user] begins reattaching [target]'s [target.op_stage.current_organ] with \the [tool]."), \
	span_filter_notice("You start reattaching [target]'s [target.op_stage.current_organ] with \the [tool]."))
	user.balloon_alert_visible("begins reattaching [target]'s [target.op_stage.current_organ]", "reattaching \the [target.op_stage.current_organ]")
	..()

/datum/surgery_step/robotics/attach_organ_robotic/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	user.visible_message(span_notice("[user] has reattached [target]'s [target.op_stage.current_organ] with \the [tool].") , \
	span_notice("You have reattached [target]'s [target.op_stage.current_organ] with \the [tool]."))
	user.balloon_alert_visible("reattaches [target]'s [target.op_stage.current_organ]", "reattached \the [target.op_stage.current_organ]")

	var/obj/item/organ/I = target.internal_organs_by_name[target.op_stage.current_organ]
	if(I && istype(I))
		I.status &= ~ORGAN_CUT_AWAY
	target.op_stage.current_organ = null

/datum/surgery_step/robotics/attach_organ_robotic/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	user.visible_message(span_warning("[user]'s hand slips, disconnecting \the [tool]."), \
	span_warning("Your hand slips, disconnecting \the [tool]."))
	user.balloon_alert_visible("slips, disconnecting \the [tool]", "your hand slips, disonnectng \the [tool]")

///////////////////////////////////////////////////////////////
// MMI Insertion Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/robotics/install_mmi
	surgery_name = "Install MMI"
	allowed_tools = list(
	/obj/item/mmi = 100
	)

	min_duration = 60
	max_duration = 80

/datum/surgery_step/robotics/install_mmi/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(target_zone != BP_HEAD)
		return

	var/obj/item/mmi/M = tool
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(!(affected && affected.open == 3))
		return 0

	if(!istype(M))
		return 0

	/* VOREStation Edit - Don't worry about it. We can put these in regardless, because resleeving might make it useful after.
	if(!M.brainmob || !M.brainmob.client || !M.brainmob.ckey || M.brainmob.stat >= DEAD)
		to_chat(user, span_danger("That brain is not usable."))
		return SURGERY_FAILURE
	*/

	if(!(affected.robotic >= ORGAN_ROBOT))
		to_chat(user, span_danger("You cannot install a computer brain into a meat skull."))
		user.balloon_alert(user, "you cannot install a computer brain into a meat skull")
		return SURGERY_FAILURE

	if(!target.should_have_organ(O_BRAIN))
		to_chat(user, span_danger("You're pretty sure [target.species.name_plural] don't normally have a brain."))
		user.balloon_alert(user, "you're pertty sure [target.species.name_plural] don't normall have a brain")
		return SURGERY_FAILURE

	if(!isnull(target.internal_organs[O_BRAIN]))
		to_chat(user, span_danger("Your subject already has a brain."))
		user.balloon_alert(user, "your subject already has a brain")
		return SURGERY_FAILURE

	return 1

/datum/surgery_step/robotics/install_mmi/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_filter_notice("[user] starts installing \the [tool] into [target]'s [affected.name]."), \
	span_filter_notice("You start installing \the [tool] into [target]'s [affected.name]."))
	user.balloon_alert_visible("starts installing \the [tool] into [target]'s [affected.name]", "installing \the [tool] into \the [affected.name]")
	..()

/datum/surgery_step/robotics/install_mmi/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_notice("[user] has installed \the [tool] into [target]'s [affected.name]."), \
	span_notice("You have installed \the [tool] into [target]'s [affected.name]."))
	user.balloon_alert_visible("installed \the [tool] into [target]'s [affected.name]", "installed \the [tool] into \the [affected.name]")

	var/obj/item/mmi/M = tool
	// VOREstation edit begin - Select the proper mmi holder subtype based on the brain inserted
	var/obj/item/organ/internal/mmi_holder/holder = null
	user.drop_from_inventory(M)
	M.loc = holder
	if(istype(M,/obj/item/mmi/digital/posibrain/nano))
		holder = new /obj/item/organ/internal/mmi_holder/posibrain/nano(target, 1, M)
	else if(istype(M,/obj/item/mmi/digital/posibrain))
		holder = new /obj/item/organ/internal/mmi_holder/posibrain(target, 1, M)
	else if(istype(M,/obj/item/mmi/digital/robot))
		holder = new /obj/item/organ/internal/mmi_holder/robot(target, 1, M)
	else
		holder = new /obj/item/organ/internal/mmi_holder(target, 1, M) // Fallback to old behavior if organic MMI or if no subtype exists.
	//VOREstation edit end
	target.internal_organs_by_name[O_BRAIN] = holder

	if(M.brainmob && M.brainmob.mind)
		M.brainmob.mind.transfer_to(target)
		target.languages = M.brainmob.languages

	spawn(0) //Name yourself on your own damn time
		var/new_name = target.real_name
		while(target.client)
			if(!target) return
			var/try_name = tgui_input_text(target,"Pick a name for your new form!", "New Name", target.name)
			var/clean_name = sanitizeName(try_name, allow_numbers = TRUE)
			if(clean_name)
				var/okay = tgui_alert(target,"New name will be '[clean_name]', ok?", "Confirmation",list("Cancel","Ok"))
				if(okay == "Ok")
					new_name = clean_name
					break //ChompEDIT infinite rename bug

		new_name = sanitizeName(new_name, allow_numbers = TRUE)
		target.name = new_name
		target.real_name = target.name

/datum/surgery_step/robotics/install_mmi/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	user.visible_message(span_warning("[user]'s hand slips."), \
	span_warning("Your hand slips."))
	user.balloon_alert_visible("slips", "your hand slips")

/*
 * Install a Diona Nymph into a Nymph Mech
 */

/datum/surgery_step/robotics/install_nymph
	surgery_name = "Install Nymph"
	allowed_tools = list(
	/obj/item/holder/diona = 100
	)

	min_duration = 60
	max_duration = 80

/datum/surgery_step/robotics/install_nymph/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(target_zone != BP_TORSO)
		return

	var/obj/item/holder/diona/N = tool
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	if(!(affected && affected.open == 3))
		return 0

	if(!istype(N))
		return 0

	if(!N.held_mob.client || N.held_mob.stat >= DEAD)
		to_chat(user, span_danger("That nymph is not viable."))
		user.balloon_alert(user, "that nymph is not viable")
		return SURGERY_FAILURE

	if(!(affected.robotic >= ORGAN_ROBOT))
		to_chat(user, span_danger("You cannot install a nymph into a meat puppet."))
		user.balloon_alert(user, "you cannot install a nymph into a meat puppet")
		return SURGERY_FAILURE

	if(!(affected.model != "Skrellian Exoskeleton"))
		to_chat(user, span_danger("You're fairly certain a nymph can't pilot a normal robot."))
		user.balloon_alert(user, "you're fairly certain a nymph can't pilot a normal robot")
		return SURGERY_FAILURE

	if(!target.should_have_organ(O_BRAIN))
		to_chat(user, span_danger("You're pretty sure [target.species.name_plural] don't normally have a brain."))
		user.balloon_alert(user, "you're pretty sure [target.species.name_plural] don't normall have a brain")
		return SURGERY_FAILURE

	if(!isnull(target.internal_organs[O_BRAIN]))
		to_chat(user, span_danger("Your subject already has a cephalon."))
		user.balloon_alert(user, "your subject already has a cephalon")
		return SURGERY_FAILURE

	return 1

/datum/surgery_step/robotics/install_nymph/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_filter_notice("[user] starts setting \the [tool] into [target]'s [affected.name]."), \
	span_filter_notice("You start setting \the [tool] into [target]'s [affected.name]."))
	user.balloon_alert_visible("starts setting \the [tool] into [target]'s [affected.name]", "setting \the into \the [affected.name]")
	..()

/datum/surgery_step/robotics/install_nymph/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message(span_notice("[user] has installed \the [tool] into [target]'s [affected.name]."), \
	span_notice("You have installed \the [tool] into [target]'s [affected.name]."))
	user.balloon_alert_visible("installed \the [tool] into [target]'s [affected.name]", "installed \the [tool] into \the [affected.name]")

	var/obj/item/holder/diona/N = tool
	var/obj/item/organ/internal/brain/cephalon/cephalon = new(target, 1)
	target.internal_organs_by_name[O_BRAIN] = cephalon
	var/mob/living/carbon/alien/diona/D = N.held_mob
	user.drop_from_inventory(tool)

	if(D && D.mind)
		D.mind.transfer_to(target)
		target.languages |= D.languages

	qdel(D)

	target.species = GLOB.all_species[SPECIES_DIONA]

	add_verb(target, /mob/living/carbon/human/proc/diona_split_nymph)
	add_verb(target, /mob/living/carbon/human/proc/regenerate)

	spawn(0) //Name yourself on your own damn time
		var/new_name = ""
		while(!new_name)
			if(!target) return
			var/try_name = tgui_input_text(target,"Pick a name for your new form!", "New Name", target.name)
			var/clean_name = sanitizeName(try_name, allow_numbers = TRUE)
			if(clean_name)
				var/okay = tgui_alert(target,"New name will be '[clean_name]', ok?", "Confirmation",list("Cancel","Ok"))
				if(okay == "Ok")
					new_name = clean_name

		target.name = new_name
		target.real_name = target.name

/datum/surgery_step/robotics/install_nymph/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	user.visible_message(span_warning("[user]'s hand slips."), \
	span_warning("Your hand slips."))
	user.balloon_alert_visible("slips", "your hand slips")
