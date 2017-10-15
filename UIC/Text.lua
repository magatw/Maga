-- ===========================================================================
-- file: UIC/Text
-- author: Hardballer
--
-- Text UIC Class
-- ===========================================================================

--# assume global class M_Text
--# type local Colors = "brown"


local Console = require("Core/Console");
local Util = require("UIC/Util");

local Text = {} --# assume Text: M_Text
local Colors = {
    brown = "87:47:37"
} --: map<Colors, string>


--v function(case: "default" | "uppercase", align: "center" | "left", parent: CA_UIC) --> M_Text
function Text.new(case, align, parent)
    local temp = nil --: CA_UIC
    local text = nil --: CA_UIC
    local root = cm:ui_root();

    -- Default
    if case == "default" and align == "left" then
        root:CreateComponent("MagaTemp", "ui/campaign ui/events");
        temp = UIComponent(root:Find("MagaTemp"));

        text = find_uicomponent_by_table(temp, {
            "event_dilemma", "non_political", "bg_description", "dy_description"
        })

        text:DestroyChildren();
    end

    if case == "default" and align == "center" then
        root:CreateComponent("MagaTemp", "ui/common ui/confirm_overwrite");
        temp = UIComponent(root:Find("MagaTemp"));
        text = UIComponent(temp:Find("txt"));
    end

    -- Uppercase
    if case == "uppercase" and align == "left" then
        root:CreateComponent("MagaTemp", "ui/campaign ui/mission_active");
        temp = UIComponent(root:Find("MagaTemp"));

        text = find_uicomponent_by_table(temp, {"mission_active_entry", "dy_action_dy"});
        text:DestroyChildren();
    end

    if case == "uppercase" and align == "center" then
        root:CreateComponent("MagaTemp", "ui/common ui/confirm_overwrite");
        temp = UIComponent(root:Find("MagaTemp"));
        text = UIComponent(temp:Find("dy_filename"));
    end
    
    text:SetStateText("");

    parent:Adopt(text:Address());
    Util.delete(temp);


    local self = {};

    setmetatable(self, {
        __index = Text,
        __tostring = function() return "MAGA Text" end
    })

    --# assume self: M_Text

    self.uic = text --: const
    self.case = case --: const
    self.align = align --: const

    self.text = "";
    self.color = Colors.brown;

    Console.log("Create Text for "..parent:Id(), "UIC");

    return self;
end


--v function(self: M_Text, x: number, y: number)
function Text.MoveTo(self, x, y) 
    self.uic:MoveTo(x, y);
end

--v function(self: M_Text) --> (number, number)
function Text.Position(self) 
    return self.uic:Position();
end

--v function(self: M_Text, w: number, h: number)
function Text.Resize(self, w, h) 
    self.uic:Resize(w, h);
end

--v function(self: M_Text, interactive: boolean)
function Text.SetInteractive(self, interactive) 
    self.uic:SetInteractive(interactive);
end

--v function(self: M_Text, visible: boolean)
function Text.SetVisible(self, visible)
    self.uic:SetVisible(visible);
end

--v function(self: M_Text, text: string)
function Text.SetStateText(self, text) 
    self.text = text;
    
    local color = "rgba:"..self.color.."]]";
    local str = "[["..color..text.."[[/"..color;

    if self.align == "left" then
        -- We add an empty line before and after the actual text
        -- It helps with the redimension and ensures that
        -- the top of the characters are not cut
        str = "\n\002"..str.."\n\002";
    end

    self.uic:SetStateText(str);
end

--v function(self: M_Text) --> string
function Text.GetStateText(self)
    return self.text;
end


--v function(self: M_Text, e: UIC_EventName, cb: function())
function Text.On(self, e, cb) 
    Util.on(self.uic, e, cb);
end

--v function(self: M_Text)
function Text.Delete(self) 
    Util.delete(self.uic, true);
end


return {
    new = Text.new;
}
