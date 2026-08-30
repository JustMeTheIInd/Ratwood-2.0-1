/datum/job/roguetown/foreguard
	name = "Foreguard" // LEGALLY DISTINCT. I CANNOT BE SUED.
	flag = FOREGUARD
	department_flag = GARRISON
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	selection_color = JCOLOR_SOLDIER
	
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = ACCEPTED_RACES
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Deserter, insolvent debtor, behated bastard-chyld or just a simple dullard that believed the high-tales? It matters not, really, for now you are a part of the Foreguard. \
	A glorious and honorable position in the most valiant and gallant group that took upon themselves the damning duty of protecting the weak. A militia band, really, clothed and  \
	armed with the very cheapest, placed on the very front, forced to stare-down the hordes of the rot-damned deadites, and the unsacred maniacs which seem to lead the dreaded hordes..  \
	Expected to, by some miracle of the TEN, attempt at mounting something resembling a coherent defense against all those unholy horrors just salivating at the thought of your savory flesh  \
	and sweetened lyfe-blood.. Tis' is a death sentence in all but name."
	display_order = JDO_TOWNGUARD
	whitelist_req = TRUE

	min_pq = 0
	max_pq = null
	round_contrib_points = 2
	cmode_music = 'sound/music/combat_blackoak.ogg'
	social_rank = SOCIAL_RANK_PEASANT
	job_traits = list(TRAIT_STEELHEARTED)
	job_subclasses = list(
		/datum/advclass/foreguard/deserter
		/datum/advclass/foreguard/serf
		/datum/advclass/foreguard/bastard
		/datum/advclass/foreguard/fool
	)

	/datum/outfit/job/roguetown/foreguard
		head = /obj/item/clothing/head/roguetown/helmet/kettle/iron
		neck = /obj/item/clothing/neck/roguetown/coif
		cloak = /obj/item/clothing/cloak/stabard/black
		gloves = /obj/item/clothing/gloves/roguetown/leather
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
		shoes = /obj/item/clothing/shoes/roguetown/boots
		pants = /obj/item/clothing/under/roguetown/trou/leather
		belt = /obj/item/storage/belt/rogue/leather/rope/dark

	/datum/advclass/foreguard/deserter
	name = "Deserter"
	tutorial = "You were, well, are, fast. You weren't fast enough back then to, save you from this fate.. But, well maybe it, and the skills you picked while still with the Count's men, shall save you this tyme?"
	outfit = /datum/outfit/job/roguetown/foreguard/deserter
	category_tags = list(CTAG_VANGUARD)
	subclass_stats = list(
		STATKEY_SPD = 2,
		STATKEY_STR = 1,
		STATKEY_WIL = -1
	)
	subclass_skills = list(
		/datum/skill/combat/polearms = 4,
		/datum/skill/combat/maces = 3,
		/datum/skill/combat/unarmed = 2,
		/datum/skill/combat/wrestling = 3,
		/datum/skill/misc/athletics = 5,
		/datum/skill/craft/crafting = 1,
		/datum/skill/craft/cooking = 1, 
		/datum/skill/misc/swimming = 2,
		/datum/skill/misc/medicine = 1,
	)

/datum/outfit/job/roguetown/foreguard/deserter/pre_equipt(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	beltr = /obj/item/rogueweapon/mace/cudgel
	beltl = /obj/item/roguekey/foreguard
	backl = /obj/item/rogueweapon/scabbard/gwstrap
	wrists = /obj/item/clothing/wrists/roguetown/bracers/iron
	r_hand = /obj/item/rogueweapon/eaglebeak/lucerne
