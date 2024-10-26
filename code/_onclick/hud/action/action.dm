<<<<<<< HEAD

=======
/**
 * # Action system
 *
 * A simple base for an modular behavior attached to atom or datum.
 */
>>>>>>> 09f82b6fff ([MIRROR] The final action buttons PR (#9324))
/datum/action
	/// The name of the action
	var/name = "Generic Action"
<<<<<<< HEAD
	var/action_type = AB_ITEM
	var/procname = null
	var/atom/movable/target = null
	var/check_flags = 0
	var/processing = 0
	var/active = 0
	var/obj/screen/movable/action_button/button = null
	var/button_icon = 'icons/mob/actions.dmi'
=======
	/// The description of what the action does, shown in button tooltips
	var/desc
	/// The target the action is attached to. If the target datum is deleted, the action is as well.
	/// Set in New() via the proc link_to(). PLEASE set a target if you're making an action
	var/datum/target
	/// Where any buttons we create should be by default. Accepts screen_loc and location defines
	var/default_button_position = SCRN_OBJ_IN_LIST
	/// This is who currently owns the action, and most often, this is who is using the action if it is triggered
	/// This can be the same as "target" but is not ALWAYS the same - this is set and unset with Grant() and Remove()
	var/mob/owner
	/// Flags that will determine of the owner / user of the action can... use the action
	var/check_flags = NONE
	/// Whether the button becomes transparent when it can't be used or just reddened
	var/transparent_when_unavailable = TRUE
	/// List of all mobs that are viewing our action button -> A unique movable for them to view.
	var/list/viewers = list()
	/// If TRUE, this action button will be shown to observers / other mobs who view from this action's owner's eyes.
	/// Used in [/mob/proc/show_other_mob_action_buttons]
	/// (Not really, this behavior is unimplemented)
	var/show_to_observers = TRUE

	/// The style the button's tooltips appear to be
	var/buttontooltipstyle = ""

	/// This is the file for the BACKGROUND underlay icon of the button
	var/background_icon = 'icons/mob/actions/backgrounds.dmi'
	/// This is the icon state state for the BACKGROUND underlay icon of the button
	/// (If set to ACTION_BUTTON_DEFAULT_BACKGROUND, uses the hud's default background)
	var/background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND

	/// This is the file for the icon that appears on the button
	var/button_icon = 'icons/mob/actions.dmi'
	/// This is the icon state for the icon that appears on the button
>>>>>>> 09f82b6fff ([MIRROR] The final action buttons PR (#9324))
	var/button_icon_state = "default"
	var/background_icon_state = "bg_default"
	var/mob/living/owner

<<<<<<< HEAD
/datum/action/New(var/Target)
	target = Target
=======
	/// This is the file for any FOREGROUND overlay icons on the button (such as borders)
	var/overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	/// This is the icon state for any FOREGROUND overlay icons on the button (such as borders)
	var/overlay_icon_state

/datum/action/New(Target)
	link_to(Target)

/// Links the passed target to our action, registering any relevant signals
/datum/action/proc/link_to(Target)
	target = Target
	RegisterSignal(target, COMSIG_PARENT_QDELETING, PROC_REF(clear_ref), override = TRUE)

	if(isatom(target))
		RegisterSignal(target, COMSIG_ATOM_UPDATED_ICON, PROC_REF(on_target_icon_update))

	// if(istype(target, /datum/mind))
	// 	RegisterSignal(target, COMSIG_MIND_TRANSFERRED, .proc/on_target_mind_swapped)
>>>>>>> 09f82b6fff ([MIRROR] The final action buttons PR (#9324))

/datum/action/Destroy()
	if(owner)
		Remove(owner)
	target = null
	QDEL_LIST_ASSOC_VAL(viewers)
	return ..()

<<<<<<< HEAD
/datum/action/proc/Grant(mob/living/T)
	if(owner)
		if(owner == T)
=======

/// Signal proc that clears any references based on the owner or target deleting
/// If the owner's deleted, we will simply remove from them, but if the target's deleted, we will self-delete
/datum/action/proc/clear_ref(datum/ref)
	SIGNAL_HANDLER
	if(ref == owner)
		Remove(owner)
	if(ref == target)
		qdel(src)

/// Grants the action to the passed mob, making it the owner
/datum/action/proc/Grant(mob/grant_to)
	if(!grant_to)
		Remove(owner)
		return
	if(owner)
		if(owner == grant_to)
>>>>>>> 09f82b6fff ([MIRROR] The final action buttons PR (#9324))
			return
		Remove(owner)
	owner = T
	owner.actions.Add(src)
	owner.update_action_buttons()
	return

<<<<<<< HEAD
/datum/action/proc/Remove(mob/living/T)
	if(button)
		if(T.client)
			T.client.screen -= button
		QDEL_NULL(button)
	T.actions.Remove(src)
	T.update_action_buttons()
	owner = null
	return

/datum/action/proc/Trigger()
	if(!Checks())
		return
	switch(action_type)
		if(AB_ITEM)
			if(target)
				var/obj/item/item = target
				item.ui_action_click()
		//if(AB_SPELL)
		//	if(target)
		//		var/obj/effect/proc_holder/spell = target
		//		spell.Click()
		if(AB_INNATE)
			if(!active)
				Activate()
			else
				Deactivate()
		if(AB_GENERIC)
			if(target && procname)
				call(target,procname)(usr)
	return

/datum/action/proc/Activate()
	return

/datum/action/proc/Deactivate()
	return

/datum/action/process()
	return

/datum/action/proc/CheckRemoval(mob/living/user) // 1 if action is no longer valid for this mob and should be removed
	return 0
=======
	SEND_SIGNAL(src, COMSIG_ACTION_GRANTED, grant_to)
	SEND_SIGNAL(grant_to, COMSIG_MOB_GRANTED_ACTION, src)
	owner = grant_to
	RegisterSignal(owner, COMSIG_PARENT_QDELETING, PROC_REF(clear_ref), override = TRUE)

	GiveAction(grant_to)

/// Remove the passed mob from being owner of our action
/datum/action/proc/Remove(mob/remove_from)
	SHOULD_CALL_PARENT(TRUE)

	for(var/datum/hud/hud in viewers)
		if(!hud.mymob)
			continue
		HideFrom(hud.mymob)
	LAZYREMOVE(remove_from.actions, src) // We aren't always properly inserted into the viewers list, gotta make sure that action's cleared
	viewers = list()

	if(owner)
		SEND_SIGNAL(src, COMSIG_ACTION_REMOVED, owner)
		SEND_SIGNAL(owner, COMSIG_MOB_REMOVED_ACTION, src)

		UnregisterSignal(owner, COMSIG_PARENT_QDELETING)
		if(target == owner)
			RegisterSignal(target, COMSIG_PARENT_QDELETING, PROC_REF(clear_ref))

		owner = null

/// Actually triggers the effects of the action.
/// Called when the on-screen button is clicked, for example.
/datum/action/proc/Trigger(trigger_flags)
	if(!IsAvailable())
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_ACTION_TRIGGER, src) & COMPONENT_ACTION_BLOCK_TRIGGER)
		return FALSE
	return TRUE
>>>>>>> 09f82b6fff ([MIRROR] The final action buttons PR (#9324))

/// Whether our action is currently available to use or not
/datum/action/proc/IsAvailable()
	return Checks()

/datum/action/proc/Checks()// returns 1 if all checks pass
	if(!owner)
		return 0
	if(check_flags & AB_CHECK_RESTRAINED)
		if(owner.restrained())
			return 0
	if(check_flags & AB_CHECK_STUNNED)
		if(owner.stunned)
			return 0
	if(check_flags & AB_CHECK_LYING)
		if(owner.lying)
			return 0
	if(check_flags & AB_CHECK_ALIVE)
		if(owner.stat)
			return 0
	if(check_flags & AB_CHECK_INSIDE)
		if(!(target in owner))
			return 0
	return 1

<<<<<<< HEAD
/datum/action/proc/UpdateName()
	return name

//This is the proc used to update all the action buttons. Properly defined in /mob/living/
/mob/proc/update_action_buttons()
	return

/mob/living/update_action_buttons()
	if(!hud_used) return
	if(!client) return

	if(hud_used.hud_shown != 1)	//Hud toggled to minimal
		return

	client.screen -= hud_used.hide_actions_toggle
	for(var/datum/action/A in actions)
		if(A.button)
			client.screen -= A.button

	if(hud_used.action_buttons_hidden)
		if(!hud_used.hide_actions_toggle)
			hud_used.hide_actions_toggle = new(hud_used)
			hud_used.hide_actions_toggle.UpdateIcon()

		if(!hud_used.hide_actions_toggle.moved)
			hud_used.hide_actions_toggle.screen_loc = hud_used.ButtonNumberToScreenCoords(1)
			//hud_used.SetButtonCoords(hud_used.hide_actions_toggle,1)

		client.screen += hud_used.hide_actions_toggle
		return

	var/button_number = 0
	for(var/datum/action/A in actions)
		button_number++
		if(A.button == null)
			var/obj/screen/movable/action_button/N = new(hud_used)
			N.owner = A
			A.button = N

		var/obj/screen/movable/action_button/B = A.button

		B.UpdateIcon()

		B.name = A.UpdateName()

		client.screen += B

		if(!B.moved)
			B.screen_loc = hud_used.ButtonNumberToScreenCoords(button_number)
			//hud_used.SetButtonCoords(B,button_number)

	if(button_number > 0)
		if(!hud_used.hide_actions_toggle)
			hud_used.hide_actions_toggle = new(hud_used)
			hud_used.hide_actions_toggle.InitialiseIcon(src)
		if(!hud_used.hide_actions_toggle.moved)
			hud_used.hide_actions_toggle.screen_loc = hud_used.ButtonNumberToScreenCoords(button_number+1)
			//hud_used.SetButtonCoords(hud_used.hide_actions_toggle,button_number+1)
		client.screen += hud_used.hide_actions_toggle

#define AB_WEST_OFFSET 4
#define AB_NORTH_OFFSET 26
#define AB_MAX_COLUMNS 10

/datum/hud/proc/ButtonNumberToScreenCoords(var/number) // TODO : Make this zero-indexed for readabilty
	var/row = round((number-1)/AB_MAX_COLUMNS)
	var/col = ((number - 1)%(AB_MAX_COLUMNS)) + 1
	var/coord_col = "+[col-1]"
	var/coord_col_offset = AB_WEST_OFFSET+2*col
	var/coord_row = "[-1 - row]"
	var/coord_row_offset = AB_NORTH_OFFSET
	return "WEST[coord_col]:[coord_col_offset],NORTH[coord_row]:[coord_row_offset]"

/datum/hud/proc/SetButtonCoords(var/obj/screen/button,var/number)
	var/row = round((number-1)/AB_MAX_COLUMNS)
	var/col = ((number - 1)%(AB_MAX_COLUMNS)) + 1
	var/x_offset = 32*(col-1) + AB_WEST_OFFSET + 2*col
	var/y_offset = -32*(row+1) + AB_NORTH_OFFSET

	var/matrix/M = matrix()
	M.Translate(x_offset,y_offset)
	button.transform = M

//Presets for item actions
/datum/action/item_action
	check_flags = AB_CHECK_RESTRAINED|AB_CHECK_STUNNED|AB_CHECK_LYING|AB_CHECK_ALIVE|AB_CHECK_INSIDE

/datum/action/item_action/CheckRemoval(mob/living/user)
	return !(target in user)

/datum/action/item_action/hands_free
	check_flags = AB_CHECK_ALIVE|AB_CHECK_INSIDE

#undef AB_WEST_OFFSET
#undef AB_NORTH_OFFSET
#undef AB_MAX_COLUMNS

/datum/action/innate
	action_type = AB_INNATE
=======
/// Builds / updates all buttons we have shared or given out
/datum/action/proc/build_all_button_icons(update_flags = ALL, force)
	for(var/datum/hud/hud as anything in viewers)
		build_button_icon(viewers[hud], update_flags, force)

/**
 * Builds the icon of the button.
 *
 * Concept:
 * - Underlay (Background icon)
 * - Icon (button icon)
 * - Maptext
 * - Overlay (Background border)
 *
 * button - which button we are modifying the icon of
 * force - whether we're forcing a full update
 */
/datum/action/proc/build_button_icon(obj/screen/movable/action_button/button, update_flags = ALL, force = FALSE)
	if(!button)
		return

	if(update_flags & UPDATE_BUTTON_NAME)
		update_button_name(button, force)

	if(update_flags & UPDATE_BUTTON_BACKGROUND)
		apply_button_background(button, force)

	if(update_flags & UPDATE_BUTTON_ICON)
		apply_button_icon(button, force)

	if(update_flags & UPDATE_BUTTON_OVERLAY)
		apply_button_overlay(button, force)

	if(update_flags & UPDATE_BUTTON_STATUS)
		update_button_status(button, force)

/**
 * Updates the name and description of the button to match our action name and discription.
 *
 * current_button - what button are we editing?
 * force - whether an update is forced regardless of existing status
 */
/datum/action/proc/update_button_name(obj/screen/movable/action_button/button, force = FALSE)
	button.name = name
	if(desc)
		button.desc = desc

/**
 * Creates the background underlay for the button
 *
 * current_button - what button are we editing?
 * force - whether an update is forced regardless of existing status
 */
/datum/action/proc/apply_button_background(obj/screen/movable/action_button/current_button, force = FALSE)
	if(!background_icon || !background_icon_state || (current_button.active_underlay_icon_state == background_icon_state && !force))
		return

	// What icons we use for our background
	var/list/icon_settings = list(
		// The icon file
		"bg_icon" = background_icon,
		// The icon state, if is_action_active() returns FALSE
		"bg_state" = background_icon_state,
		// The icon state, if is_action_active() returns TRUE
		"bg_state_active" = background_icon_state,
	)

	// If background_icon_state is ACTION_BUTTON_DEFAULT_BACKGROUND instead use our hud's action button scheme
	if(background_icon_state == ACTION_BUTTON_DEFAULT_BACKGROUND && owner?.hud_used)
		icon_settings = owner.hud_used.get_action_buttons_icons()

	// Determine which icon to use
	var/used_icon_key = is_action_active(current_button) ? "bg_state_active" : "bg_state"

	// Make the underlay
	current_button.underlays.Cut()
	current_button.underlays += image(icon = icon_settings["bg_icon"], icon_state = icon_settings[used_icon_key])
	current_button.active_underlay_icon_state = icon_settings[used_icon_key]

/**
 * Applies our button icon and icon state to the button
 *
 * current_button - what button are we editing?
 * force - whether an update is forced regardless of existing status
 */
/datum/action/proc/apply_button_icon(obj/screen/movable/action_button/current_button, force = FALSE)
	if(!button_icon || !button_icon_state || (current_button.icon_state == button_icon_state && !force))
		return

	current_button.icon = button_icon
	current_button.icon_state = button_icon_state

/**
 * Applies any overlays to our button
 *
 * current_button - what button are we editing?
 * force - whether an update is forced regardless of existing status
 */
/datum/action/proc/apply_button_overlay(obj/screen/movable/action_button/current_button, force = FALSE)
	SEND_SIGNAL(src, COMSIG_ACTION_OVERLAY_APPLY, current_button, force)

	if(!overlay_icon || !overlay_icon_state || (current_button.active_overlay_icon_state == overlay_icon_state && !force))
		return

	current_button.cut_overlay(current_button.button_overlay)
	current_button.button_overlay = mutable_appearance(icon = overlay_icon, icon_state = overlay_icon_state)
	current_button.add_overlay(current_button.button_overlay)
	current_button.active_overlay_icon_state = overlay_icon_state

/**
 * Any other miscellaneous "status" updates within the action button is handled here,
 * such as redding out when unavailable or modifying maptext.
 *
 * current_button - what button are we editing?
 * force - whether an update is forced regardless of existing status
 */
/datum/action/proc/update_button_status(obj/screen/movable/action_button/current_button, force = FALSE)
	if(IsAvailable())
		current_button.color = rgb(255,255,255,255)
	else
		current_button.color = transparent_when_unavailable ? rgb(128,0,0,128) : rgb(128,0,0)

/// Gives our action to the passed viewer.
/// Puts our action in their actions list and shows them the button.
/datum/action/proc/GiveAction(mob/viewer)
	var/datum/hud/our_hud = viewer.hud_used
	if(viewers[our_hud]) // Already have a copy of us? go away
		return

	LAZYOR(viewer.actions, src) // Move this in
	ShowTo(viewer)

/// Adds our action button to the screen of the passed viewer.
/datum/action/proc/ShowTo(mob/viewer)
	var/datum/hud/our_hud = viewer.hud_used
	if(!our_hud || viewers[our_hud]) // There's no point in this if you have no hud in the first place
		return

	var/obj/screen/movable/action_button/button = create_button()
	SetId(button, viewer)

	button.our_hud = our_hud
	viewers[our_hud] = button
	if(viewer.client)
		viewer.client.screen += button

	button.load_position(viewer)
	viewer.update_action_buttons()

/// Removes our action from the passed viewer.
/datum/action/proc/HideFrom(mob/viewer)
	var/datum/hud/our_hud = viewer.hud_used
	var/obj/screen/movable/action_button/button = viewers[our_hud]
	LAZYREMOVE(viewer.actions, src)
	if(button)
		qdel(button)

/// Creates an action button movable for the passed mob, and returns it.
/datum/action/proc/create_button()
	var/obj/screen/movable/action_button/button = new()
	button.linked_action = src
	build_button_icon(button, ALL, TRUE)
	return button

/datum/action/proc/SetId(obj/screen/movable/action_button/our_button, mob/owner)
	//button id generation
	var/bitfield = 0
	for(var/datum/action/action in owner.actions)
		if(action == src) // This could be us, which is dumb
			continue
		var/obj/screen/movable/action_button/button = action.viewers[owner.hud_used]
		if(action.name == name && button.id)
			bitfield |= button.id

	bitfield = ~bitfield // Flip our possible ids, so we can check if we've found a unique one
	for(var/i in 0 to 23) // We get 24 possible bitflags in dm
		var/bitflag = 1 << i // Shift us over one
		if(bitfield & bitflag)
			our_button.id = bitflag
			return

/// Updates our buttons if our target's icon was updated
/// Still never triggered lmao
/datum/action/proc/on_target_icon_update(datum/source, updates, updated)
	SIGNAL_HANDLER

	var/update_flag = NONE
	var/forced = FALSE
	if(updates & UPDATE_ICON_STATE)
		update_flag |= UPDATE_BUTTON_ICON
		forced = TRUE
	if(updates & UPDATE_OVERLAYS)
		update_flag |= UPDATE_BUTTON_OVERLAY
		forced = TRUE
	if(updates & (UPDATE_NAME|UPDATE_DESC))
		update_flag |= UPDATE_BUTTON_NAME
	// Status is not relevant, and background is not relevant. Neither will change

	// Force the update if an icon state or overlay change was done
	build_all_button_icons(update_flag, forced)

/// Checks if our action is actively selected. Used for selecting icons primarily.
/datum/action/proc/is_action_active(obj/screen/movable/action_button/current_button)
	return FALSE
>>>>>>> 09f82b6fff ([MIRROR] The final action buttons PR (#9324))
