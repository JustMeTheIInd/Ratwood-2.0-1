/obj/structure/ladder/manhole
	name = "manhole"
	desc = "A sturdy and heavy iron manhole cover. Foul smells escape from underneath it."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "manhole"
	anchored = TRUE

	obj_flags = BLOCK_Z_OUT_DOWN
	max_integrity = 0


/obj/structure/ladder/manhole/proc/travel(going_up, mob/user, is_ghost, obj/structure/ladder/ladder)
	if(is_ghost)
		return

	if(!is_ghost)
		playsound(src, 'sound/foley/ladder.ogg', 100, FALSE)
		var/climb_time = 3 SECONDS
		if(!going_up)
			climb_time = 20 SECONDS
			if(isliving(user))
				climb_time -= max(0, user.get_stat(STAT_STRENGTH) - 10) * 1 SECONDS
		if(!do_after(user, max(1 SECONDS, climb_time), TRUE, src))
			return

	if(!is_ghost)
		show_fluff_message(going_up, user)
		ladder.add_fingerprint(user)
	var/turf/T = going_up ? get_turf(ladder) : get_step_multiz(get_turf(src), DOWN)
	movable_travel_z_level(user, T)
	if(!going_up && isliving(user) && prob(50))
		to_chat(user, "You fall down straight into the filth below! Urgh!")
		user.Stun(5 SECONDS)
		user.Knockdown(5 SECONDS)
