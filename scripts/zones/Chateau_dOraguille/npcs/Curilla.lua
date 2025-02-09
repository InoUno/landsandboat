-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Curilla
-- Starts and Finishes Quest: The General's Secret, Enveloped in Darkness, Peace for the Spirit,
--                            Lure of the Wildcat (San d'Oria), Old Wounds
-- !pos 27 0.1 0.1 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/magic")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local sandyQuests = xi.quest.id.sandoria

local TrustMemory = function(player)
    local memories = 0
    -- 2 - PEACE_FOR_THE_SPIRIT
    if player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT) then
        memories = memories + 2
    end
    -- 4 - OLD_WOUNDS
    if player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.OLD_WOUNDS) then
        memories = memories + 4
    end
    -- 8 - THE_HEIR_TO_THE_LIGHT
    if player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT) then
        memories = memories + 8
    end
    -- 16 - Heroine's Combat BCNM
    -- if (playervar for Heroine's Combat) then
    --  memories = memories + 16
    -- end
    -- 32 - FIT_FOR_A_PRINCE
    if player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FIT_FOR_A_PRINCE) then
        memories = memories + 32
    end
    return memories
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()
    local theGeneralSecret = player:getQuestStatus(xi.quest.log_id.SANDORIA, sandyQuests.THE_GENERAL_S_SECRET)
    local envelopedInDarkness = player:getQuestStatus(xi.quest.log_id.SANDORIA, sandyQuests.ENVELOPED_IN_DARKNESS)
    local peaceForTheSpirit = player:getQuestStatus(xi.quest.log_id.SANDORIA, sandyQuests.PEACE_FOR_THE_SPIRIT)
    local Rank3 = player:getRank(player:getNation()) >= 3 and 1 or 0

    -- Trust: San d'Oria (Curilla)
    if
        player:hasKeyItem(xi.ki.SAN_DORIA_TRUST_PERMIT) and
        not player:hasSpell(xi.magic.spell.CURILLA) and
        player:getLocalVar("TrustDialogue") == 0
    then
        player:setLocalVar("TrustDialogue", 1)
        player:startEvent(573, 0, 0, 0, TrustMemory(player), 0, 0, 0, Rank3)

    -- "Lure of the Wildcat"
    elseif
        player:getQuestStatus(xi.quest.log_id.SANDORIA, sandyQuests.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(player:getCharVar("WildcatSandy"), 15)
    then
        player:startEvent(562)

    -- "The General's Secret"
    -- [Blocks everything further down]
    elseif theGeneralSecret == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.CURILLAS_BOTTLE_FULL) then
            player:startEvent(54)
        else
            player:startEvent(53)
        end
    elseif theGeneralSecret == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) > 1 then
        player:startEvent(55) -- Start

    -- "Peace for the Spirit" (RDM AF Body)
    elseif peaceForTheSpirit == QUEST_ACCEPTED then
        local questStatus = player:getCharVar("peaceForTheSpiritCS")
        if questStatus == 5 then
            player:startEvent(51)
        elseif questStatus > 1 then
            player:startEvent(113)
        else
            player:startEvent(108)
        end
    elseif
        mJob == xi.job.RDM and mLvl >= AF2_QUEST_LEVEL and envelopedInDarkness == QUEST_COMPLETED and
        peaceForTheSpirit == QUEST_AVAILABLE
    then
        player:startEvent(109) -- Start

    -- "Enveloped in Darkness" (RDM AF Shoes)
    elseif envelopedInDarkness == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.OLD_POCKET_WATCH) and not player:hasKeyItem(xi.ki.OLD_BOOTS) then
            player:startEvent(93)
        elseif player:hasKeyItem(xi.ki.OLD_BOOTS) and player:getCharVar("needs_crawler_blood") == 0 then
            player:startEvent(101)
        elseif player:getCharVar("needs_crawler_blood") == 1 then
            player:startEvent(117)
        end
    elseif
        mJob == xi.job.RDM and mLvl >= AF2_QUEST_LEVEL and
        player:getQuestStatus(xi.quest.log_id.SANDORIA, sandyQuests.THE_CRIMSON_TRIAL) == QUEST_COMPLETED and
        envelopedInDarkness == QUEST_AVAILABLE
    then
        player:startEvent(94) -- Start

    -- San d'Oria Missions (optional dialogues)
    elseif
        player:getNation() == xi.nation.SANDORIA and
        (player:getCharVar("SandoEpilogue") == 1 or player:getRank(player:getNation()) ~= 10)
    then
        local sandyMissions = xi.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getMissionStatus(player:getNation())

        -- San d'Oria Epilogue
        if player:getRank(player:getNation()) == 10 then
            player:startEvent(20)

        -- San d'Oria 9-2 "The Heir to the Light"
        elseif currentMission == sandyMissions.THE_HEIR_TO_THE_LIGHT and missionStatus > 1 then
            if missionStatus > 3 then
                player:startEvent(19)
            else
                player:startEvent(18)
            end

        -- San d'Oria 9-1 "Breaking Barrier"
        elseif
            player:hasCompletedMission(xi.mission.log_id.SANDORIA, sandyMissions.BREAKING_BARRIERS) and
            currentMission ~= sandyMissions.THE_HEIR_TO_THE_LIGHT
        then
            player:startEvent(16)

        -- San d'Oria 8-2 "Lightbringer"
        elseif currentMission == sandyMissions.LIGHTBRINGER and (missionStatus == 6 or missionStatus == 2) then
            if missionStatus == 6 then
                player:startEvent(103)
            else
                player:startEvent(57)
            end

        -- San d'Oria 5-2 "The Shadow Lord" (optional)
        elseif
            -- Directly after winning BCNM and up until next mission
            currentMission == sandyMissions.THE_SHADOW_LORD and missionStatus == 4 or
            player:hasCompletedMission(xi.mission.log_id.SANDORIA, sandyMissions.THE_SHADOW_LORD) and player:getRank(player:getNation()) == 6 and
            (currentMission ~= sandyMissions.LEAUTE_S_LAST_WISHES or currentMission ~= sandyMissions.RANPERRE_S_FINAL_REST)
        then
            player:startEvent(56)

        -- Default dialogue while doing missions
        else
            player:startEvent(530)
        end

    -- Default dialogue after "Peace for the Spirit"
    elseif peaceForTheSpirit == QUEST_COMPLETED then
        player:startEvent(52)

    -- Default dialogue after "Enveloped in Darkness"
    elseif envelopedInDarkness == QUEST_COMPLETED and peaceForTheSpirit == QUEST_AVAILABLE then
        player:startEvent(114)

    -- Default dialogue
    else
        player:startEvent(530)
    end

end

entity.onEventFinish = function(player, csid, option)
    if (csid == 55 and option == 1) then
        player:addQuest(xi.quest.log_id.SANDORIA, sandyQuests.THE_GENERAL_S_SECRET)
        player:addKeyItem(xi.ki.CURILLAS_BOTTLE_EMPTY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CURILLAS_BOTTLE_EMPTY)
    elseif (csid == 54) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16409) -- Lynx Baghnakhs
        else
            player:delKeyItem(xi.ki.CURILLAS_BOTTLE_FULL)
            player:addItem(16409)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16409) -- Lynx Baghnakhs
            player:addFame(SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, sandyQuests.THE_GENERAL_S_SECRET)
        end
    elseif (csid == 94 and option == 1) then
        player:addQuest(xi.quest.log_id.SANDORIA, sandyQuests.ENVELOPED_IN_DARKNESS)
        player:addKeyItem(xi.ki.OLD_POCKET_WATCH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.OLD_POCKET_WATCH)
    elseif (csid == 109 and option == 1) then
        player:addQuest(xi.quest.log_id.SANDORIA, sandyQuests.PEACE_FOR_THE_SPIRIT)
        player:setCharVar("needs_crawler_blood", 0)
    elseif (csid == 101) then
        player:setCharVar("needs_crawler_blood", 1)
    elseif (csid == 562) then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 15, true))
    elseif csid == 573 and option == 2 then
        player:addSpell(902, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 902)
    end
end

return entity
