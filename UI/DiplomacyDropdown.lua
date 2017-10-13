-- ===========================================================================
-- file: UI/DiplomacyDropdown
-- author: Hardballer
--
-- Handle the diplomatic panel
-- ===========================================================================

local Panel = require("UI/Panel");
local DiplomacyDropdown = {};


--v function(context: CA_UIContext)
function DiplomacyDropdown.click(context) 

end

function DiplomacyDropdown.open() 
    return true;
end

function DiplomacyDropdown.close()
    return true;
end


Panel.register(
    "DiplomacyDropdown",
    "diplomacy_dropdown",
    DiplomacyDropdown.open,
    DiplomacyDropdown.close,
    DiplomacyDropdown.click
)
