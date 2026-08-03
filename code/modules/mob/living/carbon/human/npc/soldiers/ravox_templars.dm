GLOBAL_LIST_INIT(mad_templar_aggro, world.file2list("strings/rt/madtemplaraggrolines.txt"))

/mob/living/carbon/human/species/human/northern/mad_templar
	aggressive=1
	rude = FALSE
	mode = NPC_AI_IDLE
	faction = list("viking", "station")
	ambushable = FALSE
	cmode = 1
	setparrytime = 30
	flee_in_pain = FALSE
	a_intent = INTENT_HELP
	d_intent = INTENT_PARRY
	is_silent = TRUE
	possible_mmb_intents = list(INTENT_BITE, INTENT_JUMP, INTENT_KICK, INTENT_STEAL)
	possible_rmb_intents = list(
		/datum/rmb_intent/feint,\
		/datum/rmb_intent/aimed,\
		/datum/rmb_intent/strong,\
		/datum/rmb_intent/riposte,\
		/datum/rmb_intent/weak
	)

/mob/living/carbon/human/species/human/northern/mad_templar/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(!is_silent && target != newtarg)
			say(pick(GLOB.mad_templar_aggro))
			linepoint(target)

/mob/living/carbon/human/species/human/northern/mad_templar/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/human/northern/mad_templar/Initialize(mapload)
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	is_silent = TRUE

/mob/living/carbon/human/species/human/northern/mad_templar/after_creation()
	..()
	job = "Maddened Templar"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/mad_templar)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		organ_eyes.eye_color = pick("27becc", "35cc27", "000000")
	update_hair()
	update_body()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	head.sellprice = 0 // None! you'll get enough from the dungeon. Probably. Maybe.

/mob/living/carbon/human/species/human/northern/mad_templar/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))

/mob/living/carbon/human/species/human/northern/mad_templar/handle_combat()
	if(mode == NPC_AI_HUNT)
	. = ..()

/datum/outfit/job/roguetown/human/species/human/northern/mad_templar/pre_equip(mob/living/carbon/human/H) // Templar is the lowest level, still should be rather formidable.
	..()
	//Body Stuff
	H.eye_color = "27becc"
	H.hair_color = "61310f"
	H.facial_hair_color = H.hair_color
	if(H.gender == FEMALE)
		H.hairstyle =  "Messy (Rogue)"
	else
		H.hairstyle = "Messy"
		H.facial_hairstyle = "Beard (Manly)"
	//skill Stuff
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE) //NPCs do not get these skills unless a mind takes them over, hopefully in the future someone can fix
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.STASTR = 14 
	H.STASPD = 8
	H.STACON = 13
	H.STAWIL = 13
	H.STAINT = 11
	gloves = /obj/item/clothing/gloves/roguetown/plate/iron
	wrists = /obj/item/clothing/wrists/roguetown/bracers/iron
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron
	neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/iron
	else if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/iron
	if(prob(50))
		armor = /obj/item/clothing/suit/roguetown/armor/plate/iron
	else if(prob(50))
		armor = /obj/item/clothing/suit/roguetown/armor/plate/full/iron
	if(prob(25))
		cloak = /obj/item/clothing/cloak/templar/ravox
	else if(prob(25))
		cloak = /obj/item/clothing/cloak/cleric/ravox
	else if(prob(25))
		cloak = /obj/item/clothing/cloak/templar/noc // lil' bit of flavour. Noccites would PROBABLY help containing evyl ass artyfacts.
		shirt = /obj/item/clothing/suit/roguetown/shirt/robe/noc
	else if(prob(25))
		cloak = /obj/item/clothing/cloak/cleric/noc
		shirt = /obj/item/clothing/suit/roguetown/shirt/robe/noc
	if(prob(25))
		r_hand = obj/item/rogueweapon/sword/iron
		l_hand = /obj/item/rogueweapon/shield/iron
	else if(prob(25))
		r_hand = /obj/item/rogueweapon/eaglebeak/lucerne
	else if(prob(25))
		r_hand = /obj/item/rogueweapon/greatsword/iron
	else if(prob(25))
		r_hand = /obj/item/rogueweapon/mace
		l_hand = /obj/item/rogueweapon/shield/iron

/mob/living/carbon/human/species/human/northern/mad_templar/knight
	aggressive=1
	rude = FALSE
	mode = NPC_AI_IDLE
	faction = list("viking", "station")
	ambushable = FALSE
	cmode = 1
	setparrytime = 30
	flee_in_pain = FALSE
	a_intent = INTENT_HELP
	d_intent = INTENT_PARRY
	is_silent = TRUE
	possible_mmb_intents = list(INTENT_BITE, INTENT_JUMP, INTENT_KICK, INTENT_STEAL)
	possible_rmb_intents = list(
		/datum/rmb_intent/feint,\
		/datum/rmb_intent/aimed,\
		/datum/rmb_intent/strong,\
		/datum/rmb_intent/riposte,\
		/datum/rmb_intent/weak
	)

/datum/outfit/job/roguetown/human/species/human/northern/mad_templar/knight/pre_equip(mob/living/carbon/human/H) // Knight has STEEL weapons. And better stats. You ought to worry. Also it dusts, as a means of preventing looting.
	..()
	//Body Stuff
	H.eye_color = "27becc"
	H.hair_color = "61310f"
	H.facial_hair_color = H.hair_color
	if(H.gender == FEMALE)
		H.hairstyle =  "Messy (Rogue)"
	else
		H.hairstyle = "Messy"
		H.facial_hairstyle = "Beard (Manly)"
	//skill Stuff
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE) //NPCs do not get these skills unless a mind takes them over, hopefully in the future someone can fix
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.STASTR = 16
	H.STASPD = 10
	H.STACON = 16
	H.STAWIL = 16
	H.STAINT = 14 // I'm sure this stat line up is FINE...
	gloves = /obj/item/clothing/gloves/roguetown/plate
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	neck = /obj/item/clothing/neck/roguetown/gorget/steel
	head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet
	if(prob(25))
		head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	if(prob(25))
		head = /obj/item/clothing/head/roguetown/helmet/heavy/knight
	if(prob(25))
		head = /obj/item/clothing/head/roguetown/helmet/heavy/ravox_visor
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	if(prob(25))
		armor = /obj/item/clothing/suit/roguetown/armor/plate
	if(prob(25))
		armor = /obj/item/clothing/suit/roguetown/armor/plate/fluted
	if(prob(10))
		armor = /obj/item/clothing/suit/roguetown/armor/plate/full/fluted
	pants = /obj/item/clothing/under/roguetown/platelegs
	cloak = /obj/item/clothing/cloak/templar/ravox
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	belt = /obj/item/storage/belt/rogue/leather/steel
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword/long
		l_hand = /obj/item/rogueweapon/shield/tower/metal
	else if(prob(50))
		r_hand = /obj/item/rogueweapon/mace/goden/steel
	else if(prob(50))
		r_hand = /obj/item/rogueweapon/halberd
