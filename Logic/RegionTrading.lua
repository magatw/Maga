-- ===========================================================================
-- file: Logic/RegionTrading
-- author: Hardballer
--
-- Region Trading Logic
-- ===========================================================================

local Console = require("Core/Console");
local Event = require("Core/Event");
local Model = require("Model");

local RegionTrading = {};
local Player = nil --: M_Faction
local AI = nil --: M_Faction


function RegionTrading.init()
    Player = Model.getPlayer();
    Console.log("Region Trading init done", "Logic");
end

--v function(Region: M_Region) --> boolean
function RegionTrading.isTradablePlayer(Region)
    if Region:IsUnderSiege() then return false end

    local Capital = Player:Capital();
    if Capital and Capital:Name() == Region:Name() then
        return false;
    end

    return true;
end

--v function(Region: M_Region) --> boolean
function RegionTrading.isTradableAI(Region) 
    if Region:IsUnderSiege() then return false end

    local Capital = AI:Capital();
    if Capital and Capital:Name() == Region:Name() then
        return false;
    end

    return true;
end


--v function(faction: string)
function RegionTrading.updateAIFaction(faction) 
    AI = Model.getFaction(faction);
    Console.log("Region Trading AI Faction set to "..faction, "Logic");
end

function RegionTrading.canTradeWithAI() 
    if Player:IsHorde() or AI:IsHorde() or Player:AtWarWith(AI) then
        return false;
    end

    return true;
end


Event.addListener("UICreated", RegionTrading.init);


return {
    canTradeWithAI = RegionTrading.canTradeWithAI;
    updateAIFaction = RegionTrading.updateAIFaction;
}
