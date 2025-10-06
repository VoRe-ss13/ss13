/mob/living/Bump(atom/movable/AM)
	//. = ..()
	if(isliving(AM))
		var/mob/living/L = AM
		if(!L.is_incorporeal())
			if(buckled != AM && (((confused || is_blind()) && stat == CONSCIOUS && prob(50) && m_intent==I_RUN) || flying && flight_vore))
				AM.stumble_into(src)
	return ..()
// Because flips toggle density
/mob/living/Crossed(var/atom/movable/AM)
	if(isliving(AM) && isturf(loc) && AM != src)
		var/mob/living/AMV = AM
		if(AMV.buckled != src && (((AMV.confused || AMV.is_blind()) && AMV.stat == CONSCIOUS && prob(50) && AMV.m_intent==I_RUN) || AMV.flying && AMV.flight_vore))
			INVOKE_ASYNC(src,TYPE_PROC_REF(/atom/movable, stumble_into), AMV)
	..()

/mob/living/stumble_into(mob/living/M)
<<<<<<< HEAD
	var/mob/living/carbon/human/S = src
=======
	if(buckled || M.buckled)
		return

	//Stumblevore occurs here. Look at the 'stumblevore' element for more information.
	if(SEND_SIGNAL(src, COMSIG_LIVING_STUMBLED_INTO, M) & CANCEL_STUMBLED_INTO)
		return
>>>>>>> 11a4471110 ([MIRROR] Spontaneous Vore Element (#11785))

	playsound(src, "punch", 25, 1, -1)
	M.Weaken(4)
	M.stop_flying()
<<<<<<< HEAD
	if(CanStumbleVore(M)) //This is if the person stumbling into us is able to eat us!
		visible_message(span_vwarning("[M] flops carelessly into [src]!"))
		M.forceMove(get_turf(src))
		perform_the_nom(src,M,src,src.vore_selected,-1)
		return

	if(M.CanStumbleVore(src)) //This is if the person stumbling into us is able to be eaten by us! BROKEN!
		visible_message(span_vwarning("[M] flops carelessly into [src]!"))
		M.forceMove(get_turf(src))
		perform_the_nom(M,src,M,M.vore_selected,-1)
		return

	if(istype(S) && S.species.lightweight == 1)
		visible_message(span_vwarning("[M] carelessly bowls [src] over!"))
		M.forceMove(get_turf(src))
		M.apply_damage(0.5, BRUTE)
		Weaken(4)
		stop_flying()
		apply_damage(0.5, BRUTE)
		return
=======

	if(ishuman(src))
		var/mob/living/carbon/human/S = src
		if(S.species.lightweight == 1)
			visible_message(span_vwarning("[M] carelessly bowls [src] over!"))
			M.forceMove(get_turf(src))
			M.apply_damage(0.5, BRUTE)
			Weaken(4)
			stop_flying()
			apply_damage(0.5, BRUTE)
			return
>>>>>>> 11a4471110 ([MIRROR] Spontaneous Vore Element (#11785))

	if(round(weight) > 474)
		var/throwtarget = get_edge_target_turf(M, reverse_direction(M.dir))
		visible_message(span_vwarning("[M] bounces backwards off of [src]'s plush body!"))
		M.throw_at(throwtarget, 5, 1) //it's funny and nobdy ever takes weight >474 so this is extremely rare
		return

	visible_message(span_vwarning("[M] trips over [src]!"))
	M.forceMove(get_turf(src))
	M.apply_damage(1, BRUTE)
