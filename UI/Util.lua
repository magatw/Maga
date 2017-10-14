-- ===========================================================================
-- file: UI/Util
-- author: Hardballer
--
-- UI utility functions
-- ===========================================================================

local Util = {};


--v function(uic: CA_UIC, state: string)
function Util.clickWithState(uic, state) 
    -- The SimulateClick function doesn't always change the uic state
    -- This can be avoided by manually changing the state before calling the click
    -- By doing so we trigger the wanted behaviour
    uic:SetState(state);
    uic:SimulateClick();
end


return {
    clickWithState = Util.clickWithState;
}
