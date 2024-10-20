<<<<<<< HEAD:code/_onclick/hud/action.dm
#define AB_ITEM 1
#define AB_SPELL 2
#define AB_INNATE 3
#define AB_GENERIC 4


=======
>>>>>>> 45025bd128 ([MIRROR] Ports tgstation/tgstation/pull/15673 (#9270)):code/_onclick/hud/action/action.dm
/datum/action
	var/name = "Generic Action"
	var/atom/movable/target = null
	var/check_flags = 0
	var/processing = 0
	var/obj/screen/movable/action_button/button = null
	var/button_icon = 'icons/mob/actions.dmi'
	var/button_icon_state = "default"
	var/background_icon_state = "bg_default"
	var/mob/living/owner

/datum/action/New(Target)
	target = Target
	button = new
	button.linked_action = src
	button.name = name

/datum/action/Destroy()
	if(owner)
		Remove(owner)
	target = null
	QDEL_NULL(button)
	return ..()

/datum/action/proc/Grant(mob/living/L)
	if(owner)
		if(owner == L)
			return
		Remove(owner)
	owner = L
	L.actions += src
	if(L.client)
		L.client.screen += button
	L.update_action_buttons(TRUE)

/datum/action/proc/Remove(mob/living/L)
	if(L.client)
		L.client.screen -= button
	button.moved = FALSE
	L.actions -= src
	L.update_action_buttons(TRUE)
	owner = null

/datum/action/proc/Trigger()
	if(!IsAvailable())
		return 0
	return 1

/datum/action/process()
	return

/datum/action/proc/IsAvailable()
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
	if(check_flags & AB_CHECK_CONSCIOUS)
		if(owner.stat)
			return 0
	return 1

/datum/action/proc/UpdateButtonIcon()
	if(button)
		button.icon = button_icon
		button.icon_state = background_icon_state

<<<<<<< HEAD:code/_onclick/hud/action.dm
/obj/screen/movable/action_button
	var/datum/action/owner
	screen_loc = "WEST,NORTH"

/obj/screen/movable/action_button/Click(location,control,params)
	var/list/modifiers = params2list(params)
	if(modifiers["shift"])
		moved = 0
		return 1
	if(!usr.checkClickCooldown())
		return
	owner.Trigger()
	return 1

/obj/screen/movable/action_button/proc/UpdateIcon()
	if(!owner)
		return
	icon = owner.button_icon
	icon_state = owner.background_icon_state

	cut_overlays()
	var/image/img
	if(owner.action_type == AB_ITEM && owner.target)
		var/obj/item/I = owner.target
		img = image(I.icon, src , I.icon_state)
	else if(owner.button_icon && owner.button_icon_state)
		img = image(owner.button_icon,src,owner.button_icon_state)
	img.pixel_x = 0
	img.pixel_y = 0
	add_overlay(img)

	if(!owner.IsAvailable())
		color = rgb(128,0,0,128)
	else
		color = rgb(255,255,255,255)

//Hide/Show Action Buttons ... Button
/obj/screen/movable/action_button/hide_toggle
	name = "Hide Buttons"
	icon = 'icons/mob/actions.dmi'
	icon_state = "bg_default"
	var/hidden = 0

/obj/screen/movable/action_button/hide_toggle/Click()
	usr.hud_used.action_buttons_hidden = !usr.hud_used.action_buttons_hidden

	hidden = usr.hud_used.action_buttons_hidden
	if(hidden)
		name = "Show Buttons"
	else
		name = "Hide Buttons"
	UpdateIcon()
	usr.update_action_buttons()


/obj/screen/movable/action_button/hide_toggle/proc/InitialiseIcon(var/mob/living/user)
	if(isalien(user))
		icon_state = "bg_alien"
	else
		icon_state = "bg_default"
	UpdateIcon()
	return

/obj/screen/movable/action_button/hide_toggle/UpdateIcon()
	cut_overlays()
	var/image/img = image(icon,src,hidden?"show":"hide")
	add_overlay(img)
	return

//This is the proc used to update all the action buttons. Properly defined in /mob/living/
/mob/proc/update_action_buttons()
	return

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
=======
		ApplyIcon(button)

		if(!IsAvailable())
			button.color = rgb(128, 0, 0, 128)
		else
			button.color = rgb(255, 255, 255, 255)
			return 1

/datum/action/proc/ApplyIcon(obj/screen/movable/action_button/current_button)
	current_button.cut_overlays()
	if(button_icon && button_icon_state)
		var/image/img
		img = image(button_icon, current_button, button_icon_state)
		img.pixel_x = 0
		img.pixel_y = 0
		current_button.add_overlay(img)
>>>>>>> 45025bd128 ([MIRROR] Ports tgstation/tgstation/pull/15673 (#9270)):code/_onclick/hud/action/action.dm

//Presets for item actions
/datum/action/item_action
	check_flags = AB_CHECK_RESTRAINED|AB_CHECK_STUNNED|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

/datum/action/item_action/New(Target)
	. = ..()
	var/obj/item/I = target
	I.actions += src

/datum/action/item_action/Destroy()
	var/obj/item/I = target
	I.actions -= src
	return ..()

/datum/action/item_action/Trigger()
	if(!..())
		return 0
	if(target)
		var/obj/item/I = target
		I.ui_action_click(owner, src.type)
	return 1

/datum/action/item_action/ApplyIcon(obj/screen/movable/action_button/current_button)
	current_button.cut_overlays()
	if(target)
		var/mutable_appearance/ma = new(target.appearance)
		ma.plane = FLOAT_PLANE
		ma.layer = FLOAT_LAYER
		ma.pixel_x = 0
		ma.pixel_y = 0
		current_button.add_overlay(ma)

/datum/action/item_action/hands_free
	check_flags = AB_CHECK_CONSCIOUS


<<<<<<< HEAD:code/_onclick/hud/action.dm

/datum/action/innate/
	action_type = AB_INNATE

#undef AB_ITEM
#undef AB_SPELL
#undef AB_INNATE
#undef AB_GENERIC
=======
/datum/action/innate
	check_flags = 0
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

//Preset for action that call specific procs (consider innate).
/datum/action/generic
	check_flags = 0
	var/procname

/datum/action/generic/Trigger()
	if(!..())
		return 0
	if(target && procname)
		call(target, procname)(usr)
	return 1
>>>>>>> 45025bd128 ([MIRROR] Ports tgstation/tgstation/pull/15673 (#9270)):code/_onclick/hud/action/action.dm
