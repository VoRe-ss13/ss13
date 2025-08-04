/mob/living/silicon/pai/examine(mob/user)
	. = ..(user, infix = ", personal AI")

	switch(src.stat)
		if(CONSCIOUS)
			if(!src.client)	. += "It appears to be in stand-by mode." //afk
		if(UNCONSCIOUS)		. += span_warning("It doesn't seem to be responding.")
		if(DEAD)			. += span_deadsay("It looks completely unsalvageable.")
<<<<<<< HEAD
	. += attempt_vr(src,"examine_reagent_bellies",args) // reagent bellies

	// VOREStation Edit: Start
	. += attempt_vr(src,"examine_bellies",args) //VOREStation Edit
=======

	. += formatted_vore_examine()
>>>>>>> 8cec277367 ([MIRROR] dropdown vore examines (#11297))
	if(print_flavor_text()) . += "\n[print_flavor_text()]\n"
	. += ""
	if (pose)
		if(!findtext(pose, regex("\[.?!]$"))) // Will be zero if the last character is not a member of [.?!]
			pose = addtext(pose,".") //Makes sure all emotes end with a period.
		. += "<br>It is [pose]" //Extra <br> intentional
