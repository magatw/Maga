-- ===========================================================================
-- file: UIC/Dummy
-- author: Hardballer
--
-- Dummy UIC Class
-- ===========================================================================

--# assume global class M_Dummy

local Console = require("Core/Console");
local Util = require("UIC/Util");
local Dummy = {} --# assume Dummy: M_Dummy


--v function(parent: CA_UIC) --> M_Dummy
function Dummy.new(parent) 
    local root = cm:ui_root();
    root:CreateComponent("MagaTemp", "ui/campaign ui/ai_turns");

    local temp = UIComponent(root:Find("MagaTemp"));
    local dummy = UIComponent(temp:Find("flag_2"));
    
    parent:Adopt(dummy:Address());
    Util.delete(temp);

    dummy:SetOpacity(0);
    
    local self = {};

    setmetatable(self, {
        __index = Dummy,
        __tostring = function() return "MAGA Dummy" end
    })

    --# assume self: M_Dummy

    self.uic = dummy --: const

    Console.log("Dummy created for parent: "..parent:Id(), "UIC");

    return self;
end


--v function(self: M_Dummy, x: number, y: number)
function Dummy.MoveTo(self, x, y) 
    self.uic:MoveTo(x, y);
end

--v function(self: M_Dummy)
function Dummy.Delete(self)
    Util.delete(self.uic, true); 
end


return {
    new = Dummy.new;
}
