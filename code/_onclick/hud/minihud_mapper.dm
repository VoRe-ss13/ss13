// Specific types
/datum/mini_hud/mapper
	var/obj/item/mapping_unit/owner

/datum/mini_hud/mapper/New(var/datum/hud/other, owner)
	src.owner = owner
	screenobjs = list(new /obj/screen/movable/mapper_holder(null, owner))
	..()

/datum/mini_hud/mapper/Destroy()
<<<<<<< HEAD
    owner?.hud_item = null
    owner?.hud_datum = null
    return ..()
=======
	owner?.hud_item = null
	owner?.hud_datum = null
	return ..()
>>>>>>> 789db280cc ([MIRROR] space cleanup (#10414))
