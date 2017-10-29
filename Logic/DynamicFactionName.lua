-- ===========================================================================
-- file: Logic/DynamicFactionName
-- author: DETrooper
--
-- Dynamic Faction Name Logic
-- ===========================================================================

local DynamicFactionName = {};

NUM_REQUIRED_REGIONS_LVL2 = 1; -- 6
NUM_REQUIRED_REGIONS_LVL3 = 18;

function DynamicFactionName.Add_Region_Events_Listeners()
cm:add_listener(
    "FactionTurnStart_Region_Checks",
    "FactionTurnStart",
    true,
    function(context) Region_Checks(context) end,
    true
);
end

function Region_Checks(context)
local faction_name = context:faction():name();
if context:faction():is_human() then
    if context:faction():region_list():num_items() < NUM_REQUIRED_REGIONS_LVL2 then
        local newname = faction_name.."_lvl1";
        cm:set_faction_name_override(faction_name, newname);
    elseif context:faction():region_list():num_items() >= NUM_REQUIRED_REGIONS_LVL2 and context:faction():region_list():num_items() < NUM_REQUIRED_REGIONS_LVL3 then
        local newname = faction_name.."_lvl2";
        cm:set_faction_name_override(faction_name, newname);
    elseif context:faction():region_list():num_items() >= NUM_REQUIRED_REGIONS_LVL3 then
        local newname = faction_name.."_lvl3";
        cm:set_faction_name_override(faction_name, newname);
    end
end
end

function Has_Required_Regions(faction_key, region_list)
for i = 1, #region_list do
    local region = cm:model():world():region_manager():region_by_key(region_list[i]);
    
    if region:owning_faction():name() ~= faction_key then
        return false;
    end
end
return true;
end
