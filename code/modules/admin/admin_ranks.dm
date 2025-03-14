var/list/admin_ranks = list()								//list of all ranks with associated rights

//load our rank - > rights associations
/proc/load_admin_ranks()
	admin_ranks.Cut()

	var/previous_rights = 0

	//Clear profile access
	for(var/A in world.GetConfig("admin"))
		world.SetConfig("APP/admin", A, null)

	//load text from file
	var/list/Lines = file2list("config/admin_ranks.txt")

	//process each line seperately
	for(var/line in Lines)
		if(!length(line))				continue
		if(copytext(line,1,2) == "#")	continue

		var/list/List = splittext(line,"+")
		if(!List.len)					continue

		var/rank = ckeyEx(List[1])
		switch(rank)
			if(null,"")		continue
			if("Removed")	continue				//Reserved

		var/rights = 0
		for(var/i=2, i<=List.len, i++)
			switch(ckey(List[i]))
				if("@","prev")					rights |= previous_rights
				if("buildmode","build")			rights |= R_BUILDMODE
				if("admin")						rights |= R_ADMIN
				if("ban")						rights |= R_BAN
				if("fun")						rights |= R_FUN
				if("server")					rights |= R_SERVER
				if("debug")						rights |= R_DEBUG
				if("permissions","rights")		rights |= R_PERMISSIONS
				if("possess")					rights |= R_POSSESS
				if("stealth")					rights |= R_STEALTH
				if("rejuv","rejuvinate")		rights |= R_REJUVINATE
				if("varedit")					rights |= R_VAREDIT
				if("everything","host","all")	rights |= (R_HOST | R_BUILDMODE | R_ADMIN | R_BAN | R_FUN | R_SERVER | R_DEBUG | R_PERMISSIONS | R_POSSESS | R_STEALTH | R_REJUVINATE | R_VAREDIT | R_SOUNDS | R_SPAWN | R_MOD| R_EVENT)
				if("sound","sounds")			rights |= R_SOUNDS
				if("spawn","create")			rights |= R_SPAWN
				if("mod")						rights |= R_MOD
				if("event")						rights |= R_EVENT

		admin_ranks[rank] = rights
		previous_rights = rights

<<<<<<< HEAD
=======
/// Loads admin ranks.
///	Return a list containing the backup data if they were loaded from the database backup json
/proc/load_admin_ranks(dbfail, no_update)
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("Admin Reload blocked: Advanced ProcCall detected."), confidential = TRUE)
		return
	GLOB.admin_ranks.Cut()
	GLOB.protected_ranks.Cut()
	//load text from file and process each entry
	var/ranks_text = file2text("[global.config.directory]/admin_ranks.txt")
	var/datum/admin_rank/previous_rank
	var/regex/admin_ranks_regex = new(@"^Name\s*=\s*(.+?)\s*\n+Include\s*=\s*([\l @]*?)\s*\n+Exclude\s*=\s*([\l @]*?)\s*\n+Edit\s*=\s*([\l @]*?)\s*\n*$", "gm")
	while(admin_ranks_regex.Find(ranks_text))
		var/datum/admin_rank/R = new(admin_ranks_regex.group[1])
		if(!R)
			continue
		var/count = 1
		for(var/i in admin_ranks_regex.group - admin_ranks_regex.group[1])
			if(i)
				R.process_keyword(i, count, previous_rank)
			count++
		GLOB.admin_ranks += R
		GLOB.protected_ranks += R
		previous_rank = R
	if(!CONFIG_GET(flag/admin_legacy_system) && !dbfail)
		if(CONFIG_GET(flag/load_legacy_ranks_only))
			if(!no_update)
				sync_ranks_with_db()
		else
			var/datum/db_query/query_load_admin_ranks = SSdbcore.NewQuery("SELECT `rank`, flags, exclude_flags, can_edit_flags FROM [format_table_name("admin_ranks")]")
			if(!query_load_admin_ranks.Execute())
				message_admins("Error loading admin ranks from database. Loading from backup.")
				log_sql("Error loading admin ranks from database. Loading from backup.")
				dbfail = TRUE
			else
				while(query_load_admin_ranks.NextRow())
					var/skip
					var/rank_name = query_load_admin_ranks.item[1]
					for(var/datum/admin_rank/R in GLOB.admin_ranks)
						if(R.name == rank_name) //this rank was already loaded from txt override
							skip = 1
							break
					if(!skip)
						var/rank_flags = text2num(query_load_admin_ranks.item[2])
						var/rank_exclude_flags = text2num(query_load_admin_ranks.item[3])
						var/rank_can_edit_flags = text2num(query_load_admin_ranks.item[4])
						var/datum/admin_rank/R = new(rank_name, rank_flags, rank_exclude_flags, rank_can_edit_flags)
						if(!R)
							continue
						GLOB.admin_ranks += R
			qdel(query_load_admin_ranks)
	//load ranks from backup file
	if(dbfail)
		var/backup_file = file2text("data/admins_backup.json")
		if(backup_file == null)
			log_world("Unable to locate admins backup file.")
			return FALSE
		var/list/json = json_decode(backup_file)
		for(var/J in json["ranks"])
			var/skip
			for(var/datum/admin_rank/R in GLOB.admin_ranks)
				if(R.name == "[J]") //this rank was already loaded from txt override
					skip = TRUE
			if(skip)
				continue
			var/datum/admin_rank/R = new("[J]", json["ranks"]["[J]"]["include rights"], json["ranks"]["[J]"]["exclude rights"], json["ranks"]["[J]"]["can edit rights"])
			if(!R)
				continue
			GLOB.admin_ranks += R
		return json
>>>>>>> f682996b40 ([MIRROR] tgui core 1.8.2 (#10398))
	#ifdef TESTING
	var/msg = "Permission Sets Built:\n"
	for(var/rank in admin_ranks)
		msg += "\t[rank] - [admin_ranks[rank]]\n"
	testing(msg)
	#endif

/hook/startup/proc/loadAdmins()
	load_admins()
	return 1

/proc/load_admins()
	//clear the datums references
	admin_datums.Cut()
	for(var/client/C in GLOB.admins)
		C.remove_admin_verbs()
		C.holder = null
	GLOB.admins.Cut()
	load_admin_ranks() //CHOMP Edit: moved this from "f(config.admin_legacy_system)" and put it here instead, literally just moved it 3 lines.

	if(CONFIG_GET(flag/admin_legacy_system)) // CHOMPEdit
		//Clear profile access
		for(var/A in world.GetConfig("admin"))
			world.SetConfig("APP/admin", A, null)

		//load text from file
		var/list/Lines = file2list("config/admins.txt")

		//process each line seperately
		for(var/line in Lines)
			if(!length(line))				continue
			if(copytext(line,1,2) == "#")	continue

			//Split the line at every "-"
			var/list/List = splittext(line, "-")
			if(!List.len)					continue

			//ckey is before the first "-"
			var/ckey = ckey(List[1])
			if(!ckey)						continue

			//rank follows the first "-"
			var/rank = ""
			if(List.len >= 2)
				rank = ckeyEx(List[2])

			//load permissions associated with this rank
			var/rights = admin_ranks[rank]

			//create the admin datum and store it for later use
			var/datum/admins/D = new /datum/admins(rank, rights, ckey)

			if(D.rights & R_DEBUG) //grant profile access
				world.SetConfig("APP/admin", ckey, "role=admin")

			//find the client for a ckey if they are connected and associate them with the new admin datum
			D.associate(GLOB.directory[ckey])

	else
		//The current admin system uses SQL

		establish_db_connection()
		if(!SSdbcore.IsConnected())
			error("Failed to connect to database in load_admins(). Reverting to legacy system.")
			log_misc("Failed to connect to database in load_admins(). Reverting to legacy system.")
			CONFIG_SET(flag/admin_legacy_system, TRUE)
			load_admins()
			return

		var/datum/db_query/query = SSdbcore.NewQuery("SELECT ckey, rank, level, flags FROM erro_admin")
		query.Execute()
		while(query.NextRow())
			var/ckey = query.item[1]
			var/rank = query.item[2]
			if(rank == "Removed")	continue	//This person was de-adminned. They are only in the admin list for archive purposes.

			var/rights = query.item[4]
			if(istext(rights))	rights = text2num(rights)
			var/datum/admins/D = new /datum/admins(rank, rights, ckey)

			if(D.rights & R_DEBUG) //grant profile access
				world.SetConfig("APP/admin", ckey, "role=admin")

			//find the client for a ckey if they are connected and associate them with the new admin datum
			D.associate(GLOB.directory[ckey])
		qdel(query)
		if(!admin_datums)
			error("The database query in load_admins() resulted in no admins being added to the list. Reverting to legacy system.")
			log_misc("The database query in load_admins() resulted in no admins being added to the list. Reverting to legacy system.")
			CONFIG_SET(flag/admin_legacy_system, TRUE)
			load_admins()
			return

	#ifdef TESTING
	var/msg = "Admins Built:\n"
	for(var/ckey in admin_datums)
		var/rank
		var/datum/admins/D = admin_datums[ckey]
		if(D)	rank = D.rank
		msg += "\t[ckey] - [rank]\n"
	testing(msg)
	#endif


#ifdef TESTING
/client/verb/changerank(newrank in admin_ranks)
	if(holder)
		holder.rank = newrank
		holder.rights = admin_ranks[newrank]
	else
		holder = new /datum/admins(newrank,admin_ranks[newrank],ckey)
	remove_admin_verbs()
	holder.associate(src)

<<<<<<< HEAD
/client/verb/changerights(newrights as num)
	if(holder)
		holder.rights = newrights
	else
		holder = new /datum/admins("testing",newrights,ckey)
	remove_admin_verbs()
	holder.associate(src)

#endif
=======
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("Admin rank DB Sync blocked: Advanced ProcCall detected."), confidential = TRUE)
		return

	var/list/sql_ranks = list()
	for(var/datum/admin_rank/R as anything in GLOB.protected_ranks)
		sql_ranks += list(list("rank" = R.name, "flags" = R.include_rights, "exclude_flags" = R.exclude_rights, "can_edit_flags" = R.can_edit_rights))
	SSdbcore.MassInsert(format_table_name("admin_ranks"), sql_ranks, duplicate_key = TRUE)
	update_everything_flag_in_db()


/proc/update_everything_flag_in_db()
	for(var/datum/admin_rank/R as anything in GLOB.admin_ranks)
		var/list/flags = list()
		if(R.include_rights == R_EVERYTHING)
			flags += "flags"
		if(R.exclude_rights == R_EVERYTHING)
			flags += "exclude_flags"
		if(R.can_edit_rights == R_EVERYTHING)
			flags += "can_edit_flags"
		if(!flags.len)
			continue
		var/flags_to_check = flags.Join(" != [R_EVERYTHING] AND ") + " != [R_EVERYTHING]"
		var/datum/db_query/query_check_everything_ranks = SSdbcore.NewQuery(
			"SELECT flags, exclude_flags, can_edit_flags FROM [format_table_name("admin_ranks")] WHERE rank = :rank AND ([flags_to_check])",
			list("rank" = R.name)
		)
		if(!query_check_everything_ranks.Execute())
			qdel(query_check_everything_ranks)
			return
		if(query_check_everything_ranks.NextRow()) //no row is returned if the rank already has the correct flag value
			var/flags_to_update = flags.Join(" = [R_EVERYTHING], ") + " = [R_EVERYTHING]"
			var/datum/db_query/query_update_everything_ranks = SSdbcore.NewQuery(
				"UPDATE [format_table_name("admin_ranks")] SET [flags_to_update] WHERE rank = :rank",
				list("rank" = R.name)
			)
			if(!query_update_everything_ranks.Execute())
				qdel(query_update_everything_ranks)
				return
			qdel(query_update_everything_ranks)
		qdel(query_check_everything_ranks)


/proc/sync_admins_with_db()
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("Admin rank DB Sync blocked: Advanced ProcCall detected."))
		return

	if(CONFIG_GET(flag/admin_legacy_system) || !SSdbcore.IsConnected()) //we're already using legacy system so there's nothing to save
		return
	sync_ranks_with_db()
	var/list/sql_admins = list()
	for(var/holder_ckey in GLOB.protected_admins)
		var/datum/admins/holder = GLOB.protected_admins[holder_ckey]
		sql_admins += list(list("ckey" = holder.target, "rank" = holder.rank_names()))
	SSdbcore.MassInsert(format_table_name("admin"), sql_admins, duplicate_key = TRUE)
	var/datum/db_query/query_admin_rank_update = SSdbcore.NewQuery("UPDATE [format_table_name("player")] AS p INNER JOIN [format_table_name("admin")] AS a ON p.ckey = a.ckey SET p.lastadminrank = a.rank")
	query_admin_rank_update.Execute()
	qdel(query_admin_rank_update)

/proc/save_admin_backup()
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("Admin rank DB Sync blocked: Advanced ProcCall detected."))
		return

	if(CONFIG_GET(flag/admin_legacy_system)) //we're already using legacy system so there's nothing to save
		return

	//json format backup file generation stored per server
	var/json_file = file("data/admins_backup.json")
	var/list/file_data = list(
		"ranks" = list(),
		"admins" = list()
	)
	for(var/datum/admin_rank/R as anything in GLOB.admin_ranks)
		file_data["ranks"]["[R.name]"] = list()
		file_data["ranks"]["[R.name]"]["include rights"] = R.include_rights
		file_data["ranks"]["[R.name]"]["exclude rights"] = R.exclude_rights
		file_data["ranks"]["[R.name]"]["can edit rights"] = R.can_edit_rights

	for(var/admin_ckey in GLOB.admin_datums + GLOB.deadmins)
		var/datum/admins/admin = GLOB.admin_datums[admin_ckey]

		if(!admin)
			admin = GLOB.deadmins[admin_ckey]
			if (!admin)
				continue

		file_data["admins"][admin_ckey] = admin.rank_names()

		//admin.backup_connections()

	fdel(json_file)
	WRITE_FILE(json_file, json_encode(file_data, JSON_PRETTY_PRINT))
>>>>>>> f682996b40 ([MIRROR] tgui core 1.8.2 (#10398))
