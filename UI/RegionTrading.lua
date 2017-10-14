-- ===========================================================================
-- file: UI/RegionTrading
-- author: Hardballer
--
-- Handle the region trading panel
-- ===========================================================================

local Panel = require("UI/Panel");
local RegionTrading = {};


--v function(context: CA_UIContext)
function RegionTrading.click(context)

end

function RegionTrading.open() 
    if not Panel.isOpened("DiplomacyDropdown") then
        return false;
    end

    return true;
end

function RegionTrading.close()
    return true; 
end


Panel.register(
    "RegionTrading",
    nil,
    RegionTrading.open,
    RegionTrading.close,
    RegionTrading.click
)
