-- ===========================================================================
-- file: Model/Faction
-- author: Hardballer
--
-- Faction Model Class
-- ===========================================================================

--# type local IFactionData = {
--# RegionTransfered: number   
--# }

--# type local IncrementKey = "RegionTransfered"


local Console = require("Core/Console");
local Model = require("Model");

local FactionModel = {};
local Faction = {} --# assume Faction: M_Faction
local Factions = {} --: map<string, M_Faction>
local FactionsData = {} --: map<string, IFactionData>

local Shema = {
    RegionTransfered = 0;
} --: const IFactionData


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
    FactionsData[name] = FactionsData[name] or Shema;
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

--v function(self: M_Faction, key: IncrementKey)
function Faction.Increment(self, key)
    local data = FactionsData[self:Name()];
    data[key] = data[key] + 1;
end

--v function(self: M_Faction) --> vector<M_Region>
function Faction.Regions(self) 
    local regions = {} --: vector<M_Region>
    local list = self:cai():region_list();

    for i = 0, list:num_items() - 1 do 
        local name = list:item_at(i):name();
        local Region = Model.getRegion(name);
        table.insert(regions, Region);
    end

    return regions;
end

--v function(self: M_Faction) --> number
function Faction.RegionTransfered(self) 
    return FactionsData[self:Name()].RegionTransfered;
end


--v function(name: string) --> M_Faction
function Model.getFaction(name)
    return Factions[name] or FactionModel.new(name);
end

--v function() --> M_Faction
function Model.getPlayer()
    return Model.getFaction(cm:get_local_faction());
end
