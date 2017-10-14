-- ===========================================================================
-- file: UIC/Frame
-- author: Hardballer
--
-- Frame UIC Class
-- ===========================================================================

--# assume global class M_Frame
--# assume M_Frame.bottomBar: method() --> CA_UIC

local Console = require("Core/Console");
local Util = require("UIC/Util");
local Frame = {} --# assume Frame: M_Frame


--v function(name: string, parent: CA_UIC) --> M_Frame
function Frame.new(name, parent)
    local root = cm:ui_root();
    root:CreateComponent(name, "ui/campaign ui/finance_screen");

    local frame = UIComponent(root:Find(name));
    local scroll = UIComponent(frame:Find("scroll_frame"));

    Util.delete( UIComponent(frame:Find("TabGroup")) );
    Util.delete( UIComponent(frame:Find("button_info_holder")) );

    parent:Adopt(frame:Address());
    local self = {};
    
    setmetatable(self, {
        __index = Frame,
        __tostring = function() return "MAGA FRAME: "..name end
    })

    --# assume self: M_Frame

    self.uic = function(self) --: M_Frame 
        return frame;
    end

    self.scroll = function(self) --: M_Frame
        return scroll;
    end

    Console.log("Create Frame "..name, "UIC");

    return self;
end


--v function(self: M_Frame, w: number, h: number)
function Frame.Resize(self, w, h) 
    self:uic():Resize(w, h);
end


--v function(self: M_Frame)
function Frame.AddBottomBar(self)
    if self.bottomBar then return end

    local root = cm:ui_root();
    root:CreateComponent("MagaTemp", "ui/campaign ui/diplomacy_hud");

    local temp = UIComponent(root:Find("MagaTemp"));
    local bar = find_uicomponent_by_table(temp, {"offers_panel", "small_bar"});

    self:uic():Adopt(bar:Address());

    self.bottomBar = function(self) --: M_Frame
        return bar;
    end

    Util.delete(temp);
end

--v function(self: M_Frame, text: string)
function Frame.SetTitle(self, text) 
    local tx = find_uicomponent_by_table(self:uic(), {"title_plaque", "tx_finance"});
    tx:SetStateText(text);
end

--v function(self: M_Frame)
function Frame.Delete(self)
    Util.delete(self:uic(), true);
end


return {
    new = Frame.new;
}
