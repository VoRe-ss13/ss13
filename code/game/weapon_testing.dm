#define STAT_COLLECTION_ENABLED 1

/proc/generate_info_melee(var/store_to = "data/melee.csv")
	var/list/types = typesof(/obj/item/weapon)
	var/output = "Name,Damage,DPS,\"Attack delay\",\"Thrown Damage\"\n"
	for(var/type in types)
		var/info = melee_info_row(type)
		if(info[2]) //Ignore anything with 0 damage
			output += info[1]
			output += "\n"


	rustg_file_write(output,store_to)

/proc/melee_info_row(var/type)
	var/name = get_name_of(type)
	var/damage = get_melee_damage(type)
	var/delay = get_melee_attack_delay_seconds(type)
	var/thrown = get_throw_damage(type)
	var/dps = damage / delay
	return list("\"[name]\",[damage],[dps],[delay],[thrown]",damage)

/proc/get_name_of(var/type)
	var/obj/item/weapon/wep = new type()
	var/name = wep.name
	if(istype(wep,/obj/item/weapon/material))
		var/obj/item/weapon/material/mwep = new type(null,MAT_DURASTEEL)
		name = mwep.name
		qdel(mwep)
	qdel(wep)
	return name

/proc/get_melee_damage(var/type)
	var/obj/item/weapon/wep = new type()
	var/force = wep.force
	if(istype(wep,/obj/item/weapon/chainsaw))
		var/obj/item/weapon/chainsaw/cwep = wep
		force = cwep.active_force
	else if(istype(wep,/obj/item/weapon/melee/energy))
		var/obj/item/weapon/melee/energy/ewep = wep
		force = ewep.active_force
	else if(istype(wep,/obj/item/weapon/cell/device/weapon/gunsword))
		var/obj/item/weapon/cell/device/weapon/gunsword/gwep = wep
		force = gwep.active_force
	else if(istype(wep,/obj/item/weapon/melee/fluffstuff))
		var/obj/item/weapon/melee/fluffstuff/fwep = wep
		force = fwep.active_force
	else if(istype(wep,/obj/item/weapon/material))
		var/obj/item/weapon/material/mwep = new type(null,MAT_DURASTEEL)
		if(mwep.damtype == HALLOSS)
			force = 0
		else
			force = mwep.force
		qdel(mwep)
	if(wep)
		qdel(wep)
	return force

/proc/get_throw_damage(var/type)
	var/obj/item/weapon/wep = new type()
	var/force = wep.throwforce
	if(istype(wep,/obj/item/weapon/material))
		var/obj/item/weapon/material/mwep = new type(null,MAT_DURASTEEL)
		force = mwep.throwforce
		qdel(mwep)
	qdel(wep)
	return force

/proc/get_melee_attack_delay_seconds(var/type)
	var/obj/item/weapon/wep = new type()
	var/force = wep.attackspeed / 10.0
	qdel(wep)
	return force
