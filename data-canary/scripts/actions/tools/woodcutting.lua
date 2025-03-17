local config = {
    trees = {2701, 2702, 2703, 2704, 2705, 2706, 2707, 2708, 2709, 2710, 2712, 2717, 2718, 2720, 2722},
    t = {
        [{1, 100}] = {tree = 2701},
        [{101, 200}] = {tree = 2702},
        [{201, 300}] = {tree = 2703},
        [{301, 400}] = {tree = 2704},
        [{401, 500}] = {tree = 2705},
        [{501, 600}] = {tree = 2706},
        [{601, 700}] = {tree = 2707},
        [{701, 800}] = {tree = 2708},
        [{801, 900}] = {tree = 2709},
        [{901, 1000}] = {tree = 2710},
        [{1001, 1100}] = {tree = 2712},
        [{1101, 1200}] = {tree = 2717},
        [{1201, 1300}] = {tree = 2718},
        [{1301, 1400}] = {tree = 2720},
        [{1401, 1500}] = {tree = 2722}
    },
    
    ItemId = 60030, ---- here item 
    
    level = 15,
    skill = SKILL_AXE,
    skillReq = 10,
    effect = CONST_ME_BLOCKHIT,
    addTries = 100,
    branches = 6432,
    msgType = MESSAGE_EVENT_ADVANCE,
    soul = 3,
    minutes = 5
}

local t = {
    [{1, 500}] = {msg = "You chopped the tree and got some wood", item = 5901, amountmax = 3},
    [{501, 750}] = {msg = "You have damaged your axe and it broke!", destroy = true},
    [{751, 1550}] = {msg = "You chopped the tree down, but the wood was not good."},
    [{1551, 1650}] = {msg = "Oh no, the tree had a wasp nest in it!", summon = "Wasp"},
    [{1651, 1750}] = {msg = "You hurt yourself while chopping the tree down", damage = {1, 100}},
    [{1751, 2000}] = {msg = "You chopped the tree and got some wood", item = 5901, amountmax = 5},
    [{2001, 2250}] = {msg = "A cat that was stuck jumped from the chopped tree", summon = "Cat"},
    [{2251, 2500}] = {msg = "There was a bird's nest in the tree and you took some eggs from the nest", item = 2695, amountmax = 5},
    [{2501, 2750}] = {msg = "Hahaa! You found a sack with coins in it!", item = 2148, amountmax = 50},
    [{2751, 3000}] = {msg = "A rat jumped at you!", summon = "Rat"}
}

local function newTrees(toPosition)
    local tile = Tile(toPosition)
    if not tile then
        return
    end
    
    local tree = tile:getTopVisibleThing()
    if not tree or not tree:isItem() or tree.itemid ~= config.branches then
        return
    end
    
    for i2, k2 in pairs(config.t) do
        if v >= i2[1] and v <= i2[2] then
            if k2.tree then
                tree:transform(k2.tree)
            end
        end
    end
end

local Action = Action()

function Action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player then
        return false
    end

    local itemEx = Tile(toPosition):getItemById(target.itemid)
    if not itemEx then
        return false
    end

    if not isInArray(config.trees, itemEx.itemid) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This tree can't be chopped.")
        return false
    end

    if config.level > player:getLevel() then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your level is too low to chop this tree. Required level: " .. config.level)
        return false
    end

    local axeSkillLevel = player:getSkillLevel(config.skill)
    if config.skillReq > axeSkillLevel then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your axe skill level is too low to chop this tree. Required skill level: " .. config.skillReq .. ", Your skill level: " .. axeSkillLevel)
        return false
    end

    if config.soul > player:getSoul() then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You do not have enough soul to chop this tree.")
        return false
    end

    local v = math.random(3000)
    for i, k in pairs(t) do
        if v >= i[1] and v <= i[2] then
            if k.destroy then
                itemEx:remove(1)
            end
            if k.summon then
                Game.createMonster(k.summon, toPosition)
            end
            if k.damage then
                local damage = math.random(k.damage[1], k.damage[2])
                player:addHealth(-damage)
                player:say("OUCH! You received " .. damage .. " damage!", TALKTYPE_MONSTER_SAY)
            end
            if k.item then
                local amount = k.amountmax and math.random(k.amountmax) or 1
                player:addItem(k.item, amount)
            end
            if k.msg then
                player:sendTextMessage(config.msgType, k.msg)
            end

            newTrees(toPosition)
            addEvent(newTrees, config.minutes * 60 * 1000, toPosition)
            itemEx:transform(config.branches)
            player:getPosition():sendMagicEffect(k.destroy and CONST_ME_HITAREA or config.effect)
            player:addSkillTries(config.skill, config.addTries)
            player:addSoul(-config.soul)
            return true
        end
    end
    
  player:sendTextMessage(MESSAGE_EVENT_ADVANCE,"Debug: All conditions met.") 
    return true
end

Action:id(config.ItemId)
Action:register()