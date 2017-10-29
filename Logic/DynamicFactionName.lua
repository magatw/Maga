-- ===========================================================================
-- file: Logic/DynamicFactionName
-- author: DETrooper
--
-- Dynamic Faction Name Logic
-- ===========================================================================

local Event = require("Core/Event");
local DynamicFactionName = {};

local RequiredRegions = {
    lvl2 = 1;
    lvl3 = 10;
} --: map<string, number>


--v function(context: CA_FactionContext)
function DynamicFactionName.FactionTurnStart(context) 
    if not context:faction():is_human() then return end

    local name = context:faction():name();
    -- to do...
end


Event.addListener("FactionTurnStart", DynamicFactionName.FactionTurnStart);






-- BACKUP

-- function Region_Checks(context)
-- local faction_name = context:faction():name();
-- if context:faction():is_human() then
--     if context:faction():region_list():num_items() < NUM_REQUIRED_REGIONS_LVL2 then
--         local newname = faction_name.."_lvl1";
--         cm:set_faction_name_override(faction_name, newname);
--     elseif context:faction():region_list():num_items() >= NUM_REQUIRED_REGIONS_LVL2 and context:faction():region_list():num_items() < NUM_REQUIRED_REGIONS_LVL3 then
--         local newname = faction_name.."_lvl2";
--         cm:set_faction_name_override(faction_name, newname);
--     elseif context:faction():region_list():num_items() >= NUM_REQUIRED_REGIONS_LVL3 then
--         local newname = faction_name.."_lvl3";
--         cm:set_faction_name_override(faction_name, newname);
--     end
-- end
-- end

-- function Has_Required_Regions(faction_key, region_list)
-- for i = 1, #region_list do
--     local region = cm:model():world():region_manager():region_by_key(region_list[i]);
    
--     if region:owning_faction():name() ~= faction_key then
--         return false;
--     end
-- end
-- return true;
-- end
