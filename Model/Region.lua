-- ===========================================================================
-- file: Model/Region
-- author: Hardballer
--
-- Region Model Class
-- ===========================================================================

local Console = require("Core/Console");
local Event = require("Core/Event");
local Model = require("Model");
local RegionsName = require("Local").RegionsName;

local RegionModel = {};
local Region = {} --# assume Region: M_Region
local Regions = {} --: map<string, M_Region>


--v function(name: string, province: string) --> M_Region
function RegionModel.new(name, province)
    local self = {};

    setmetatable(self, {
        __index = Region,
        __tostring = function() return "MAGA Region: "..name end
    })

    --# assume self: M_Region

    self.Name = function(self) --: M_Region
        return name;
    end

    self.province = province;

    Regions[name] = self;
    return self;
end

function RegionModel.init()
    local regionData = require("Data/"..cm.name.."/Regions");
    
    for provinceName, regionsList in pairs(regionData) do
        for index, regionName in ipairs(regionsList) do
            RegionModel.new(regionName, provinceName);
        end
    end
    
    Console.log("Region init done", "Model");
end


--v function(self: M_Region) --> CA_Region
function Region.cai(self)
    return cm:model():world():region_manager():region_by_key(self:Name());
end

--v function(self: M_Region) --> string
function Region.DisplayedName(self)
    return RegionsName[self:Name()];
end

--v function(self: M_Region) --> M_Character
function Region.Governor(self) 
    if not self:cai():has_governor() then return nil end
    
    local cqi = self:cai():governor():cqi();
    return Model.getCharacter(cqi);
end

--v function(self: M_Region) --> boolean
function Region.IsUnderSiege(self)
    return self:cai():garrison_residence():is_under_siege();
end

--v function(self: M_Region, faction: string)
function Region.Transfer(self, faction) 
    local Governor = self:Governor();

    -- Transfering the province capital will kill the governor
    -- to avoid it we temporarily set him immortal
    if Governor then Governor:SetImmortal(true) end

    cm:transfer_region_to_faction(self:Name(), faction);
    
    if Governor then Governor:SetImmortal(false) end

    Console.log("Transfer region "..self:Name().." to "..faction, "Model");
end


--v function(name: string) --> M_Region
function Model.getRegion(name)
    return Regions[name];
end


Event.addListener("UICreated", RegionModel.init);
