-- ===========================================================================
-- file: Core/Util
-- author: Hardballer
--
-- Core utility functions
-- ===========================================================================

local Util = {};


--v function(t: vector<WHATEVER>, val: any) --> number
function Util.indexOf(t, val) 
    for k, v in ipairs(t) do
        if v == val then return k end;
    end
    return -1;
end


return {
    indexOf = Util.indexOf;
}
