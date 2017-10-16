-- ===========================================================================
-- file: Logic/RegionTrading
-- author: Hardballer
--
-- Region Trading Logic
-- ===========================================================================

local Console = require("Core/Console");
local Event = require("Core/Event");
local Util = require("Core/Util");
local Model = require("Model");

local RegionTrading = {};
local Player = nil --: M_Faction
local AI = nil --: M_Faction
local VisibleRegions = {} --: vector<string>


function RegionTrading.init()
    Player = Model.getPlayer();
    Console.log("Region Trading init done", "Logic");
end

--v function(Region: M_Region) --> (boolean, string)
function RegionTrading.isTradablePlayer(Region)
    if Region:IsUnderSiege() then
        return false, "siege";
    end

    local Capital = Player:Capital();
    if Capital and Capital:Name() == Region:Name() then
        return false, "capital";
    end

    return true, "tradable";
end

--v function(Region: M_Region) --> (boolean, string)
function RegionTrading.isTradableAI(Region) 
    if Region:IsUnderSiege() then 
        return false, "siege";
    end

    local Capital = AI:Capital();
    if Capital and Capital:Name() == Region:Name() then
        return false, "capital";
    end

    return true, "tradable";
end


--v function(faction: string)
function RegionTrading.updateAIFaction(faction) 
    AI = Model.getFaction(faction);
    Console.log("Region Trading AI Faction set to "..faction, "Logic");
end

--v function(visible: vector<string>)
function RegionTrading.updateVisibleRegions(visible) 
    VisibleRegions = visible;
end

function RegionTrading.canTradeWithAI() 
    if Player:IsHorde() or AI:IsHorde() or Player:AtWarWith(AI) then
        return false;
    end

    return true;
end


function RegionTrading.getTradeData() 
    local list = {} --: map<string, {name: string, owner: string, tradable: boolean, reason: string}>

    for index, Region in ipairs(Player:Regions()) do 
        local n = Region:Name();
        local d = Region:DisplayedName();
        local t, r = RegionTrading.isTradablePlayer(Region);
        list[n] = {name = d, owner = "player", tradable = t, reason = r};
    end

    for index, Region in ipairs(AI:Regions()) do 
        local n = Region:Name();
        if Util.indexOf(VisibleRegions, n) > -1 then
            local d = Region:DisplayedName();
            local t, r = RegionTrading.isTradableAI(Region);
            list[n] = {name = d, owner = "ai", tradable = t, reason = r};
        end
    end
    
    return list;
end


Event.addListener("UICreated", RegionTrading.init);


return {
    canTradeWithAI = RegionTrading.canTradeWithAI;
    getTradeData = RegionTrading.getTradeData;
    updateAIFaction = RegionTrading.updateAIFaction;
    updateVisibleRegions = RegionTrading.updateVisibleRegions;
}
