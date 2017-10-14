-- ===========================================================================
-- file: UIC/MapOverlay
-- author: Hardballer
--
-- Map Overlay UIC Class
-- ===========================================================================

--# assume global class M_MapOverlay
--# type local Colors = "green" | "yellow"

local Console = require("Core/Console");
local Image = require("UIC/Image");
local Util = require("UIC/Util");

local MapOverlay = {} --# assume MapOverlay: M_MapOverlay


--v function(tacticalMap: CA_UIC) --> M_MapOverlay
function MapOverlay.new(tacticalMap) 
    local self = {};

    setmetatable(self, {
        __index = MapOverlay,
        __tostring = function() return "MAGA Map Overlay" end
    })

    --# assume self: M_MapOverlay

    self.map = tacticalMap;
    self.regions = {} --: map<string, M_Image>

    Console.log("Create Map Overlay", "UIC");

    return self;
end


--v function(self: M_MapOverlay, regionKey: string, color: Colors)
function MapOverlay.AddRegion(self, regionKey, color)
    local path = string.format("map/%s_%s", regionKey, color);
    local region = Image.new(path, self.map);

    region:MoveTo(self.map:Position());
    region:Resize(self.map:Dimensions());

    self.regions[regionKey] = region;
end

--v function(self: M_MapOverlay, regionKey: string, opacity: number)
function MapOverlay.SetRegionOpacity(self, regionKey, opacity) 
    if not self.regions[regionKey] then return end
    self.regions[regionKey]:SetOpacity(opacity);
end

--v function(self: M_MapOverlay)
function MapOverlay.Clear(self) 
    for name, region in pairs(self.regions) do
        region:Delete();
    end

    self.regions = {};
end

--v function(self: M_MapOverlay)
function MapOverlay.CorrectPriority(self) 
    local c = {} --: vector<CA_UIC>

    for i = 0, self.map:ChildCount() - 1 do
        local uic = UIComponent(self.map:Find(i));
        if uic:Id() ~= "flag_2" then
            table.insert(c, uic);
        end
    end

    for index, uic in ipairs(c) do
        self.map:Adopt(uic:Address());
    end
end


return {
    new = MapOverlay.new;
}
