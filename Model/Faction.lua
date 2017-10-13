-- ===========================================================================
-- file: Model/Faction
-- author: Hardballer
--
-- Faction Model Class
-- ===========================================================================

local Console = require("Core/Console");
local Model = require("Model");

local FactionModel = {};
local Faction = {} --# assume Faction: M_Faction
local Factions = {} --: map<string, M_Faction>


--v function(name: string) --> M_Faction
function FactionModel.new(name)
    local self = {};

    setmetatable(self, {
        __index = Faction,
        __tostring = function() return "MAGA Faction: "..name end
    })

    --# assume self: M_Faction
    
    self.Name = function(self) --: M_Faction
        return name;
    end

    Console.log("Create Faction: "..name, "Model");
    
    Factions[name] = self;
    return self;
end


--v function(self: M_Faction) --> CA_Faction
function Faction.cai(self)
    return cm:model():world():faction_by_key(self:Name());
end

--v function(self: M_Faction, faction: M_Faction) --> boolean
function Faction.AtWarWith(self, faction)
    return self:cai():at_war_with(faction:cai());
end

--v function(self: M_Faction) --> M_Region
function Faction.Capital(self)
    if not self:cai():has_home_region() then return nil end

    local name = self:cai():home_region():name();
    return Model.getRegion(name);
end

--v function(self: M_Faction) --> boolean
function Faction.IsHorde(self)
    return self:cai():is_horde();
end


--v function(name: string) --> M_Faction
function Model.getFaction(name)
    return Factions[name] or FactionModel.new(name);
end

--v function() --> M_Faction
function Model.getPlayer()
    return Model.getFaction(cm:get_local_faction());
end
