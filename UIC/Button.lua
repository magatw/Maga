-- ===========================================================================
-- file: UIC/Button
-- author: Hardballer
--
-- Button UIC Class
-- ===========================================================================

--# assume global class M_Button

local Console = require("Core/Console");
local Util = require("UIC/Util");
local Button = {} --# assume Button: M_Button

local States = {
    "active", "down", "drop_down",
    "hover", "inactive", "selected"
} --: vector<string>


--v function(name: string, parent: CA_UIC) --> M_Button
function Button.new(name, parent) 
    local root = cm:ui_root();
    root:CreateComponent("MagaTemp", "ui/bin/button/"..name);

    local temp = UIComponent(root:Find("MagaTemp"));
    local button = find_uicomponent_by_table(temp, {"both_group", "maga_button00"});

    parent:Adopt(button:Address());
    Util.delete(temp);

    local self = {};

    setmetatable(self, {
        __index = Button,
        __tostring = function() return "MAGA BUTTON: "..name end
    })

    --# assume self: M_Button

    self.uic = function(self) --: M_Button 
        return button;
    end

    Console.log("Create Button: "..name, "UIC");

    return self;
end


--v function(self: M_Button)
function Button.ClearSound(self)
    self:uic():ClearSound();
end

--v function(self: M_Button, x: number, y: number)
function Button.MoveTo(self, x, y) 
    self:uic():MoveTo(x, y);
end

--v function(self: M_Button, state: string)
function Button.SetState(self, state) 
    self:uic():SetState(state);
end

--v function(self: M_Button, text: string)
function Button.SetTooltipText(self, text) 
    local saved = self:uic():CurrentState();
    
    -- Make sure the default tooltip "Cancel" will
    -- be replace by the custom one for each possible state
    for index, state in ipairs(States) do
        self:SetState(state);
        self:uic():SetTooltipText(text);
    end

    self:SetState(saved);
end


--v function(self: M_Button, e: UIC_EventName, cb: function())
function Button.On(self, e, cb) 
    Util.on(self:uic(), e, cb);
end

--v function(self: M_Button)
function Button.Delete(self) 
    Util.delete(self:uic(), true);
end


return {
    new = Button.new;
}
