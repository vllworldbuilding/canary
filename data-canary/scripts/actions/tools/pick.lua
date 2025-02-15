local mountainIds = { 4457, 4458, 4459, 4460, 4461, 4462, 4463, 4464 } --rock mountain
local earthIds = { 21302, 21303, 21304, 21305, 21306, 21307, 21311, 21312, 21313, 21314, 21315 } --river water
local mountainlootOre = { 60048 } --just food loot from sea: hering
local mountainlootCommon = { 60048 } --common loot from sea: hering
local mountainlootRare = { 60050, 3581 } --rare loot from sea: bluefin, shrimp
local mountainlootVeryRare = { 60047 } --veryrare loot from sea: codfish 
local earthlootOre = { 60051, 32044, 32045 } --just food loot from river: saint-peter, small bass, tiny bass
local earthlootCommon = { 32043, 60056, 7159 } --common loot from river: bass, black-bass, green perch
local earthlootRare = { 60055, 60052, 3580, 7158 } --rare loot from river: salmon, trout, northern pike, rainbow trout
local earthlootVeryRare = { 60049 } --veryrare loot from river: sockeye

--[[local specials = {
	chances = {
		{ from = 0, to = 500, itemId = 3026 }, -- white pearl
		{ from = 501, to = 801, itemId = 3029 }, -- small sapphire
		{ from = 802, to = 1002, itemId = 3032 }, -- small emerald
		{ from = 1003, to = 1053, itemId = 281 }, -- giant shimmering pearl (green)
		{ from = 1054, to = 1104, itemId = 282 }, -- giant shimmering pearl (brown)
		{ from = 1105, to = 1115, itemId = 9303 }, -- leviathan's amulet
	},
}]]

local mining = Action()

function mining.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not (table.contains(mountainIds, target.itemid) or table.contains(earthIds, target.itemid)) then
		return false
	end

	if math.random(100) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_MINING) - 10) * 0.597, 10), 50) then
		--if useWorms and not player:removeItem("worm", 1) then
		--	return true
		--end

		--[[if player:getItemCount(3492) > 0 then
			player:addSkillTries(SKILL_MINING, 1, true)
		end]]

		if table.contains(mountainIds, target.itemid) then
			player:addSkillTries(SKILL_MINING, 1, true)	
			local rareChance = math.random(100)
			if rareChance == 1 then
				toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
				player:say("Test 1.", TALKTYPE_MONSTER_SAY)
				player:addItem(mountainlootVeryRare[math.random(#mountainlootVeryRare)], 1)
			elseif rareChance == 2 then
				player:addItem(mountainlootRare[math.random(#mountainlootRare)], 1)
			elseif rareChance <= 10 then
				player:addItem(mountainlootCommon[math.random(#mountainlootCommon)], 1)
			else
				player:addItem(mountainlootOre[math.random(#mountainlootOre)], 1)
			end
			return true
		end

		if table.contains(earthIds, target.itemid) then
			local rareChance1 = math.random(100)
			if rareChance1 == 1 then
				toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
				player:say("Test 1.", TALKTYPE_MONSTER_SAY)
				player:addItem(earthlootVeryRare[math.random(#earthlootVeryRare)], 1)
			elseif rareChance1 == 2 then
				player:addItem(earthlootRare[math.random(#earthlootRare)], 1)
			elseif rareChance1 <= 10 then
				player:addItem(earthlootCommon[math.random(#earthlootCommon)], 1)
			else
				player:addItem(earthlootOre[math.random(#earthlootOre)], 1)
			end
			return true
		end
	end

	--[[if table.contains(seaIds, target.itemid) or table.contains(riverIds, target.itemid) then
		toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
		local targetId = target.itemid
		target:transform(targetId + 1)
		if targetId == 4602 then
			target:transform(4597)
			target:decay()
		elseif targetId == 4614 then
			target:transform(4609)
			target:decay()
		end
		if targetId == 21307 then
			target:transform(21302)
			target:decay()
		elseif targetId == 21315 then
			target:transform(21311)
			target:decay()
		end
	end]]
	return true
end

mining:id(3456)
mining:allowFarUse(false)
mining:register()