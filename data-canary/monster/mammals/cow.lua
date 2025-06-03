local mType = Game.createMonsterType("Cow")
local monster = {}

monster.name = "Cow"
monster.description = "a cow"
monster.experience = 400
monster.outfit = {
	lookType = 1253,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1856
monster.Bestiary = {
	class = "Mammal",
	race = BESTY_RACE_MAMMAL,
	toKill = 1000,
	FirstUnlock = 10, -- don't know
	SecondUnlock = 100, -- don't know
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 3,
	Locations = "Orcsoberfest Island.",
}

monster.health = 700
monster.maxHealth = 700
monster.race = "blood"
monster.corpse = 32091
monster.speed = 95
monster.manaCost = 300

monster.changeTarget = {
	interval = 4000, -- don't know
	chance = 20, -- don't know
}

monster.strategiesTarget = {
	nearest = 100, -- don't know
}

monster.flags = {
	summonable = true,
	attackable = true,
	hostile = false, -- don't know
	convinceable = false, -- don't know
	pushable = true,
	rewardBoss = false, -- don't know
	illusionable = true,
	canPushItems = false,
	canPushCreatures = false, -- don't know
	staticAttackChance = 90, -- don't know
	targetDistance = 1,
	runHealth = 15,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Weeeeheeeeeee", yell = false }, -- don't know, MUUUU?
}

monster.loot = { -- don't know
	{ id = 3577, chance = 0000, maxCount = 22 }, -- meat
	{ id = 32009, chance = 0000, maxCount = 2 }, -- veal
	{ id = 32010, chance = 0000, maxCount = 2 }, -- meat hammer
	{ id = 32011, chance = 0000, maxCount = 165 }, -- milk churn
	{ id = 32012, chance = 0000, maxCount = 2 }, -- cow bell
}

monster.attacks = { -- don't know
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -85 },
}

monster.defenses = { -- don't know
	defense = 5,
	armor = 28,
	mitigation = 0.78,
}

monster.elements = { -- don't know
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
