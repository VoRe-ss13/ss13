/mob/living/proc/toggle_rider_reins()
	set name = "Give Reins"
	set category = "Abilities.General" //CHOMPEdit
	set desc = "Let people riding on you control your movement."

	if(riding_datum)
		if(istype(riding_datum,/datum/riding))
			if(riding_datum.keytype)
				riding_datum.keytype = null
				to_chat(src, span_filter_notice("Rider control enabled."))
				return
			else
<<<<<<< HEAD
				riding_datum.keytype = /obj/item/weapon/material/twohanded/riding_crop
				to_chat(src, "<span class='filter_notice'>Rider control restricted.</span>")
=======
				riding_datum.keytype = /obj/item/material/twohanded/riding_crop
				to_chat(src, span_filter_notice("Rider control restricted."))
>>>>>>> ab154b48b2 ([MIRROR] refactors most spans (#9139))
				return
	return
