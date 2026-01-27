/datum/antagonist/informant
	name = "Informant"
	roundend_category = "informants"
	antagpanel_category = "Informant"
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "informant"
	show_name_in_check_antagonists = TRUE
	show_in_antagpanel = TRUE
	confess_lines = list(
		"SECRETS ARE THE CURRENCY OF POWER!",
		"KNOWLEDGE IS THE SHARPEST BLADE!",
		"INFORMATION IS WORTH MORE THAN GOLD!",
	)
	antag_flags = FLAG_FAKE_ANTAG
	var/informant_faction = null // Will be set by specialization
	// Global blacklist, cannot be ANY type of informant
	var/static/list/global_blacklist = list(
		"Inquisitor", "Orthodoxist", "Absolver",
		"Grand Duke", "Prince", "Knight Captain", "Knight", "Hand", "Consort", "Marshal","Squire",
		"Bishop", "Martyr", "Templar"
	)

/datum/antagonist/informant/specialization(datum/mind/new_owner)
	// Check global blacklist first
	if(new_owner?.assigned_role in global_blacklist)
		return FALSE
	
	// Calculate roll weight based on character features
	var/roll_weight = get_roll_weight(new_owner)
	var/base_chance = 10 // 10% base chance
	var/final_chance = base_chance * roll_weight
	
	if(!prob(final_chance))
		return FALSE
	
	// Randomly select a faction
	var/selected = pick("inquisition", "crown", "church")
	
	switch(selected)
		if("inquisition")
			return new /datum/antagonist/informant/inquisition(new_owner)
		if("crown")
			return new /datum/antagonist/informant/crown(new_owner)
		if("church")
			return new /datum/antagonist/informant/church(new_owner)
	
	// When in doubt, join the french.
	return new /datum/antagonist/informant/inquisition(new_owner)

/datum/antagonist/informant/proc/get_roll_weight(datum/mind/new_owner)
	// Weight multiplier for base chance. 1.0 = normal chance
	var/weight = 1.0
	
	// Notably lower chance for some roles that we still want people to (somewhat) trust.
	if(new_owner?.assigned_role in list("Man at Arms", "Squire", "Dungeeoneer", "Veteran", "Merchant", "Guildmaster"))
		weight *= 0.4 // 40% of base chance
	
	// Beware The French.
	if(ishuman(new_owner?.current))
		var/mob/living/carbon/human/H = new_owner.current
		if(H.accent == "otavan")
			weight *= 1.2 // 20% increased chance
	
	return weight

/datum/antagonist/informant/proc/can_recognize_mark(mob/user)
	// Check if user has perception 18+ or is a Malumite with intelligence 15+
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/H = user
	if(H.mind?.combat_experience?.get_skill_level("perception") >= 18)
		return TRUE
	if(H.patron?.type == /datum/patron/malum && H.stats?.intel?.base >= 15)
		return TRUE
	return FALSE

/datum/antagonist/informant/proc/on_inform_masters()
	// Base proc for informing their faction about important events
	return

///////////////////
// Inquisition Informant
///////////////////

/datum/antagonist/informant/inquisition
	name = "Inquisition Informant"
	informant_faction = "inquisition"
	show_in_antagpanel = FALSE

/datum/antagonist/informant/inquisition/can_be_owned(datum/mind/new_owner)
	. = ..()
	if(!.)
		return FALSE
	
	// Members of the Inquisition cannot be Inquisition informants
	var/list/inquisition_jobs = list(
		"Inquisitor",
		"Orthodoxist",
		"Absolver"
	)
	
	if(new_owner?.assigned_role in inquisition_jobs)
		return FALSE
	
	return TRUE
	to_chat(owner.current, span_userdanger("Whether willingly or not, I am an informant for the Otavan Inquisition. I am to report heretics and anything that may resist HIS Will."))
	
	// Gives them their mark
	if(owner?.special_items)
		owner.special_items["Informant Mark"] = /obj/item/clothing/neck/roguetown/psicross/informant_mark
	
	..()

///////////////////
// Crown Informant
///////////////////

/datum/antagonist/informant/crown
	name = "Crown Informant"
	informant_faction = "crown"
	show_in_antagpanel = FALSE

/datum/antagonist/informant/crown/can_be_owned(datum/mind/new_owner)
	. = ..()
	if(!.)
		return FALSE
	
	// Members of the Crown cannot be Crown informants (faction-specific, in addition to global blacklist)
	var/list/crown_jobs = list(
		"Marshal",
		"Steward",
		"Councillor",
		"Head Physician",
		"Consort",
		"Consort Dowager",
		"Suitor",
		"Servant",
		"Veteran",
		"Warden",
		"Squire",
		"Sergeant",
		"Dungeeoneer",
		"Man at Arms",
		"Seneschal",
		"Court Magician",
		"Jester",
		"Magicians Associate"
	)
	
	if(new_owner?.assigned_role in crown_jobs)
		return FALSE
	
	return TRUE

/datum/antagonist/informant/crown/greet()
	to_chat(owner.current, span_userdanger("Whether willingly or not, I am an informant for the Crown of the Vale. I am to report anything that may pose a threat to the realm and the Crown."))
	
	if(owner?.special_items)
		owner.special_items["Informant Mark"] = /obj/item/clothing/neck/roguetown/psicross/astrata/informant_mark
	
	..()

///////////////////
// Church Informant
///////////////////

/datum/antagonist/informant/church
	name = "Church Informant"
	show_in_antagpanel = FALSE
	informant_faction = "church"

/datum/antagonist/informant/church/can_be_owned(datum/mind/new_owner)
	. = ..()
	if(!.)
		return FALSE
	
	var/list/church_jobs = list(
		"Bishop",
		"Acolyte",
		"Templar",
		"Keeper",
		"Druid",
		"Martyr",
		"Churchling"
	)
	
	if(new_owner?.assigned_role in church_jobs)
		return FALSE
	
	return TRUE

/datum/antagonist/informant/church/greet()
	to_chat(owner.current, span_userdanger("Whether willingly or not, I am an informant for the Church. I am to report anything that may pose a threat to the faithful, and the reign of the Ten."))
	
	if(owner?.special_items)
		owner.special_items["Informant Mark"] = /obj/item/clothing/neck/roguetown/psicross/ravox/informant_mark
	
	..()

///////////////////
// Informant Psicross Mark
///////////////////

/obj/item/clothing/neck/roguetown/psicross/informant_mark
	name = "psycross"
	desc = "'With every broken bone, I swore I lived!'"
	icon_state = "psycross"
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	possible_item_intents = list(/datum/intent/use, /datum/intent/special/magicarc)
	sellprice = 10
	experimental_onhip = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing
	grid_width = 32
	grid_height = 32

/obj/item/clothing/neck/roguetown/psicross/informant_mark/examine(mob/user)
	. = ...()
	
	var/is_inquisitor = (user.mind?.assigned_role in list("Inquisitor", "Orthodoxist", "Absolver"))
	var/is_inquisition_informant = user.mind?.has_antag_datum(/datum/antagonist/informant/inquisition)
	var/can_perceive = user.mind?.get_antag_datum(/datum/antagonist/informant)?.can_recognize_mark(user)
	
	if(is_inquisitor || is_inquisition_informant || can_perceive)
		. += span_danger("This psycross bears the hidden mark of an informant.")

///////////////////
// Crown Informant Mark - Amulet of Astrata
///////////////////

/obj/item/clothing/neck/roguetown/psicross/astrata/informant_mark
	name = "amulet of Astrata"
	desc = "As sure as the sun rises, tomorrow will come."
	icon_state = "astrata"

/obj/item/clothing/neck/roguetown/psicross/astrata/informant_mark/examine(mob/user)
	. = ...()
	
	var/is_crown_nobility = (user.mind?.assigned_role in list("Hand", "Grand Duke", "Prince", "Knight Captain", "Knight", "Marshal", "Sergeant"))
	var/is_crown_informant = user.mind?.has_antag_datum(/datum/antagonist/informant/crown)
	var/can_perceive = user.mind?.get_antag_datum(/datum/antagonist/informant)?.can_recognize_mark(user)
	
	if(is_crown_nobility || is_crown_informant || can_perceive)
		. += span_danger("This amulet bears the hidden mark of a Crown informant.")

///////////////////
// Church Informant Mark - Amulet of Ravox
///////////////////

/obj/item/clothing/neck/roguetown/psicross/ravox/informant_mark
	name = "amulet of Ravox"
	desc = "What are you fighting for?"
	icon_state = "ravox"

/obj/item/clothing/neck/roguetown/psicross/ravox/informant_mark/examine(mob/user)
	. = ...()
	
	var/is_church_leadership = (user.mind?.assigned_role in list("Bishop", "Martyr", "Templar"))
	var/is_church_informant = user.mind?.has_antag_datum(/datum/antagonist/informant/church)
	var/can_perceive = user.mind?.get_antag_datum(/datum/antagonist/informant)?.can_recognize_mark(user)
	
	if(is_church_leadership || is_church_informant || can_perceive)
		. += span_danger("This amulet bears the hidden mark of a Church informant.")
