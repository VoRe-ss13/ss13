
/datum/action
	var/name = "Generic Action"
<<<<<<< HEAD
	var/action_type = AB_ITEM
	var/procname = null
	var/atom/movable/target = null
	var/check_flags = 0
	var/processing = 0
	var/active = 0
=======
	var/desc = null

	var/atom/movable/target = null

	var/check_flags = NONE
	var/processing = FALSE

>>>>>>> 3becf31cf4 (manually ports last upstream PRs (#9286))
	var/obj/screen/movable/action_button/button = null

	var/button_icon = 'icons/mob/actions.dmi'
	var/background_icon_state = "bg_default"
	var/buttontooltipstyle = ""
	var/transparent_when_unavailable = TRUE

	var/icon_icon = 'icons/mob/actions.dmi'
	var/button_icon_state = "default"

	var/mob/owner

<<<<<<< HEAD
/datum/action/New(var/Target)
	target = Target
=======
/datum/action/New(Target)
	link_to(Target)
	button = new
	button.linked_action = src
	button.name = name
	button.actiontooltipstyle = buttontooltipstyle
	if(desc)
		button.desc = desc

/datum/action/proc/link_to(Target)
	target = Target
	RegisterSignal(Target, COMSIG_ATOM_UPDATED_ICON, .proc/OnUpdatedIcon)
>>>>>>> 3becf31cf4 (manually ports last upstream PRs (#9286))

/datum/action/Destroy()
	if(owner)
		Remove(owner)
	target = null
	QDEL_NULL(button)
	return ..()

<<<<<<< HEAD
/datum/action/proc/Grant(mob/living/T)
	if(owner)
		if(owner == T)
			return
		Remove(owner)
	owner = T
	owner.actions.Add(src)
	owner.update_action_buttons()
	return

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
=======
/datum/action/proc/Grant(mob/M)
	if(M)
		if(owner)
			if(owner == M)
				return
			Remove(owner)
		owner = M


		// button id generation
		var/counter = 0
		var/bitfield = 0
		for(var/datum/action/A as anything in M.actions)
			if(A.name == name && A.button.id)
				counter += 1
				bitfield |= A.button.id
		bitfield = !bitfield
		var/bitflag = 1
		for(var/i in 1 to (counter + 1))
			if(bitfield & bitflag)
				button.id = bitflag
				break
			bitflag *= 2

		LAZYADD(M.actions, src)
		if(M.client)
			M.client.screen += button
			button.locked = /* M.client.prefs.buttons_locked  || */ button.id ? LAZYACCESS(M.client.prefs.action_button_screen_locs, "[name]_[button.id]") : FALSE //even if its not defaultly locked we should remember we locked it before
			button.moved = button.id ? LAZYACCESS(M.client.prefs.action_button_screen_locs, "[name]_[button.id]") : FALSE
		M.update_action_buttons(TRUE)
	else
		Remove(owner)

/datum/action/proc/Remove(mob/M)
	if(M)
		if(M.client)
			M.client.screen -= button
		button.moved = FALSE
		LAZYREMOVE(M.actions, src)
		M.update_action_buttons(TRUE)
	owner = null
	button.moved = FALSE //so the button appears in its normal position when given to another owner.
	button.locked = FALSE
	button.id = null

/datum/action/proc/Trigger()
	if(!IsAvailable())
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_ACTION_TRIGGER, src) & COMPONENT_ACTION_BLOCK_TRIGGER)
		return FALSE
	return TRUE
>>>>>>> 3becf31cf4 (manually ports last upstream PRs (#9286))

/datum/action/proc/CheckRemoval(mob/living/user) // 1 if action is no longer valid for this mob and should be removed
	return 0

/datum/action/proc/IsAvailable()
	return Checks()

/datum/action/proc/Checks()// returns 1 if all checks pass
	if(!owner)
		return FALSE
	if(check_flags & AB_CHECK_RESTRAINED)
		if(owner.restrained())
			return FALSE
	if(check_flags & AB_CHECK_STUNNED)
		if(owner.stunned)
			return FALSE
	if(check_flags & AB_CHECK_LYING)
		if(owner.lying)
<<<<<<< HEAD
			return 0
	if(check_flags & AB_CHECK_ALIVE)
		if(owner.stat)
			return 0
	if(check_flags & AB_CHECK_INSIDE)
		if(!(target in owner))
			return 0
	return 1

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
=======
			return FALSE
	if(check_flags & AB_CHECK_CONSCIOUS)
		if(owner.stat)
			return FALSE
	return TRUE

/datum/action/proc/UpdateButtonIcon(status_only = FALSE, force = FALSE)
	if(button)
		if(!status_only)
			button.name = name
			button.desc = desc

			// if(owner && owner.hud_used && background_icon_state == ACTION_BUTTON_DEFAULT_BACKGROUND)
			// 	var/list/settings = owner.hud_used.get_action_buttons_icons()
			// 	if(button.icon != settings["bg_icon"])
			// 		button.icon = settings["bg_icon"]
			// 	if(button.icon_state != settings["bg_state"])
			// 		button.icon_state = settings["bg_state"]
			// else

			if(button.icon != button_icon)
				button.icon = button_icon
			if(button.icon_state != background_icon_state)
				button.icon_state = background_icon_state

			ApplyIcon(button, force)

		if(!IsAvailable())
			button.color = transparent_when_unavailable ? rgb(128, 0, 0, 128) : rgb(128, 0, 0)
		else
			button.color = rgb(255, 255, 255, 255)
			return TRUE

/datum/action/proc/ApplyIcon(obj/screen/movable/action_button/current_button, force = FALSE)
	if(icon_icon && button_icon_state && ((current_button.button_icon_state != button_icon_state) || force))
		current_button.cut_overlays(TRUE)
		current_button.add_overlay(mutable_appearance(icon_icon, button_icon_state))
		current_button.button_icon_state = button_icon_state

// Currently never triggered
/datum/action/proc/OnUpdatedIcon()
	SIGNAL_HANDLER
	UpdateButtonIcon()

//Presets for item actions
/datum/action/item_action
	check_flags = AB_CHECK_RESTRAINED|AB_CHECK_STUNNED|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	button_icon_state = null
	// If you want to override the normal icon being the item
	// then change this to an icon state

/datum/action/item_action/New(Target)
	. = ..()
	var/obj/item/I = target
	LAZYADD(I.actions, src)

/datum/action/item_action/Destroy()
	var/obj/item/I = target
	LAZYREMOVE(I.actions, src)
	return ..()

/datum/action/item_action/Trigger()
	if(!..())
		return 0
	if(target)
		var/obj/item/I = target
		I.ui_action_click(owner, src.type)
	return 1

/datum/action/item_action/ApplyIcon(obj/screen/movable/action_button/current_button, force)
	if(button_icon && button_icon_state)
		// If set, use the custom icon that we set instead
		// of the item appearence
		return ..()
	else if(target && ((current_button.appearance_cache != target.appearance) || force))
		var/mutable_appearance/ma = new(target.appearance)
		ma.plane = FLOAT_PLANE
		ma.layer = FLOAT_LAYER
		ma.pixel_x = 0
		ma.pixel_y = 0

		current_button.cut_overlays()
		current_button.add_overlay(ma)
		current_button.appearance_cache = target.appearance
>>>>>>> 3becf31cf4 (manually ports last upstream PRs (#9286))

/datum/action/item_action/hands_free
	check_flags = AB_CHECK_ALIVE|AB_CHECK_INSIDE

#undef AB_WEST_OFFSET
#undef AB_NORTH_OFFSET
#undef AB_MAX_COLUMNS

/datum/action/innate
<<<<<<< HEAD
	action_type = AB_INNATE
=======
	check_flags = NONE
	var/active = 0

/datum/action/innate/Trigger()
	if(!..())
		return 0
	if(!active)
		Activate()
	else
		Deactivate()
	return 1

/datum/action/innate/proc/Activate()
	return

/datum/action/innate/proc/Deactivate()
	return

//Preset for an action with a cooldown
/datum/action/cooldown
	check_flags = NONE
	transparent_when_unavailable = FALSE
	var/cooldown_time = 0
	var/next_use_time = 0

/datum/action/cooldown/New()
	..()
	button.maptext = ""
	button.maptext_x = 8
	button.maptext_y = 0
	button.maptext_width = 24
	button.maptext_height = 12

/datum/action/cooldown/IsAvailable()
	return next_use_time <= world.time

/datum/action/cooldown/proc/StartCooldown()
	next_use_time = world.time + cooldown_time
	button.maptext = span_maptext(span_bold("[round(cooldown_time/10, 0.1)]"))
	UpdateButtonIcon()
	START_PROCESSING(SSfastprocess, src)

/datum/action/cooldown/process()
	if(!owner)
		button.maptext = ""
		STOP_PROCESSING(SSfastprocess, src)
	var/timeleft = max(next_use_time - world.time, 0)
	if(timeleft == 0)
		button.maptext = ""
		UpdateButtonIcon()
		STOP_PROCESSING(SSfastprocess, src)
	else
		button.maptext = span_maptext(span_bold("[round(timeleft/10, 0.1)]"))

/datum/action/cooldown/Grant(mob/M)
	..()
	if(owner)
		UpdateButtonIcon()
		if(next_use_time > world.time)
			START_PROCESSING(SSfastprocess, src)
>>>>>>> 3becf31cf4 (manually ports last upstream PRs (#9286))
