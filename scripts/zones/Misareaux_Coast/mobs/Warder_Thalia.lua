-----------------------------------
-- Area: Misareaux Coast
--  Mob: Warder Thalia
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.A_PLACE_TO_RETURN and player:getCharVar("PromathiaStatus") == 1) then
        player:setCharVar("Warder_Thalia_KILL", 1)
    end
end

return entity
