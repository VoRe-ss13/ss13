#ifndef OVERRIDE_BAN_SYSTEM
//Blocks an attempt to connect before even creating our client datum thing.
/world/IsBanned(key,address,computer_id)
	if(ckey(key) in GLOB.admin_datums)
		return ..()

	//Guest Checking
	if(!CONFIG_GET(flag/guests_allowed) && IsGuestKey(key))
		log_adminwarn("Failed Login: [key] - Guests not allowed")
		message_admins(span_blue("Failed Login: [key] - Guests not allowed"))
		return list("reason"="guest", "desc"="\nReason: Guests not allowed. Please sign in with a byond account.")

	//check if the IP address is a known TOR node
	if(config && CONFIG_GET(flag/ToRban) && ToRban_isbanned(address))
		log_adminwarn("Failed Login: [src] - Banned: ToR")
		message_admins(span_blue("Failed Login: [src] - Banned: ToR"))
		//ban their computer_id and ckey for posterity
		AddBan(ckey(key), computer_id, "Use of ToR", "Automated Ban", 0, 0)
		return list("reason"="Using ToR", "desc"="\nReason: The network you are using to connect has been banned.\nIf you believe this is a mistake, please request help at [CONFIG_GET(string/banappeals)]")


	if(CONFIG_GET(flag/ban_legacy_system))

		//Ban Checking
		. = CheckBan( ckey(key), computer_id, address )
		if(.)
			log_adminwarn("Failed Login: [key] [computer_id] [address] - Banned [.["reason"]]")
			message_admins(span_blue("Failed Login: [key] id:[computer_id] ip:[address] - Banned [.["reason"]]"))
			return .

		return ..()	//default pager ban stuff

	else

		var/ckeytext = ckey(key)

		if(!establish_db_connection())
			error("Ban database connection failure. Key [ckeytext] not checked")
			log_misc("Ban database connection failure. Key [ckeytext] not checked")
			return

		//Fops Edit Begin
		if(CONFIG_GET(flag/discord_whitelist))
			var/datum/db_query/query = SSdbcore.NewQuery("SELECT ckey FROM whitelist") //Not optimal but keys in the DB aren't stored in ckey format so we have to check all of them through the ckey function.
			query.Execute()

			var/is_whitelisted = FALSE

			while(query.NextRow())
				if(ckey(query.item[1])==ckeytext)
					is_whitelisted = TRUE
					break

			qdel(query)

			if(!is_whitelisted)
				return list("reason"="Not whitelisted", "desc"="You aren't in the whitelist for the server! If you're in the VoRe furs discord, simply add yourself using the bot. If you did this already, make sure you input the correct information.")

		//Fops Edit End
		var/failedcid = 1
		var/failedip = 1

		var/ipquery = ""
		var/cidquery = ""
		if(address)
			failedip = 0
			ipquery = " OR ip = '[sanitizeSQL(address)]' "

		if(computer_id)
			failedcid = 0
			if(isnum(text2num(computer_id)))
				cidquery = " OR computerid = '[computer_id]' "
			else
				log_misc("Key [ckeytext] cid not checked. Non-Numeric: [computer_id]")
				failedcid = 1

		var/datum/db_query/query = SSdbcore.NewQuery("SELECT ckey, ip, computerid, a_ckey, reason, expiration_time, duration, bantime, bantype FROM erro_ban WHERE (ckey = '[ckeytext]' [ipquery] [cidquery]) AND (bantype = 'PERMABAN'  OR (bantype = 'TEMPBAN' AND expiration_time > Now())) AND isnull(unbanned)")

		query.Execute()

		while(query.NextRow())
			var/pckey = query.item[1]
			//var/pip = query.item[2]
			//var/pcid = query.item[3]
			var/ackey = query.item[4]
			var/reason = query.item[5]
			var/expiration = query.item[6]
			var/duration = query.item[7]
			var/bantime = query.item[8]
			var/bantype = query.item[9]

			var/expires = ""
			if(text2num(duration) > 0)
				expires = " The ban is for [duration] minutes and expires on [expiration] (server time)."

			var/desc = "\nReason: You, or another user of this computer or connection ([pckey]) is banned from playing here. The ban reason is:\n[reason]\nThis ban was applied by [ackey] on [bantime], [expires]"
			qdel(query)
			return list("reason"="[bantype]", "desc"="[desc]")
		qdel(query)
		if (failedcid)
			message_admins("[key] has logged in with a blank computer id in the ban check.")
		if (failedip)
			message_admins("[key] has logged in with a blank ip in the ban check.")
		return ..()	//default pager ban stuff
#endif
