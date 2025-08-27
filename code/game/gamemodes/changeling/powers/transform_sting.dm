//Suggested to leave unchecked because this is why we can't have nice things.
/datum/power/changeling/transformation_sting
	name = "Transformation Sting"
	desc = "We silently sting a human, injecting a retrovirus that forces them to transform into another."
	helptext = "Does not provide a warning to others. The victim will transform much like a changeling would."
	ability_icon_state = "ling_sting_transform"
	genomecost = 3
	verbpath = /mob/proc/changeling_transformation_sting

/mob/proc/changeling_transformation_sting()
	set category = "Changeling"
	set name = "Transformation sting (40)"
	set desc="Sting target"

	var/datum/changeling/changeling = changeling_power(40)
	if(!changeling)
<<<<<<< HEAD:code/game/gamemodes/changeling/powers/transform_sting.dm
		return 0

	var/list/names = list()
	for(var/datum/dna/DNA in changeling.absorbed_dna)
		names += "[DNA.real_name]"
=======
		return FALSE

	var/list/names = list()
	for(var/datum/absorbed_dna/DNA in changeling.absorbed_dna)
		names += "[DNA.name]"
	if(!LAZYLEN(names))
		to_chat(src, "We have no DNA to select from!)")
		return FALSE
	var/S
	if(LAZYLEN(names) > 1)
		tgui_input_list(src, "Select the target DNA:", "Target DNA", names)
	else
		S = names[1]
>>>>>>> 398539e00a ([MIRROR] clears up debugs (#11507)):code/datums/components/antags/changeling/powers/transform_sting.dm

	var/S = tgui_input_list(src, "Select the target DNA:", "Target DNA", names)
	if(!S)
		return

	var/datum/dna/chosen_dna = changeling.GetDNA(S)
	if(!chosen_dna)
		return

	var/mob/living/carbon/T = changeling_sting(40,/mob/proc/changeling_transformation_sting)
	if(!T)
<<<<<<< HEAD:code/game/gamemodes/changeling/powers/transform_sting.dm
		return 0
=======
		return FALSE
>>>>>>> 398539e00a ([MIRROR] clears up debugs (#11507)):code/datums/components/antags/changeling/powers/transform_sting.dm
	if((HUSK in T.mutations) || (!ishuman(T) && !issmall(T)))
		to_chat(src, span_warning("Our sting appears ineffective against its DNA."))
		return 0
	add_attack_logs(src,T,"Transformation sting (changeling)")
	T.visible_message(span_warning("[T] transforms!"))
	qdel_swap(T.dna, chosen_dna.Clone())
	T.real_name = chosen_dna.real_name
	T.UpdateAppearance()
	domutcheck(T, null)
	feedback_add_details("changeling_powers","TS")
	return 1
