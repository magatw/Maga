-- ===========================================================================
-- file: UI/Panel
-- author: Hardballer
--
-- Panel Class
-- ===========================================================================

--# assume global class M_Panel
--# assume M_Panel.Open: method()
--# assume M_Panel.Close: method()

--# type local PanelName = 
--# "DiplomacyDropdown" | "RegionTrading"

--# type local CB_Bool = function() --> boolean
--# type local CB_UI = function(context: CA_UIContext)


local Console = require("Core/Console");
local Event = require("Core/Event");
local Panel = {} --# assume Panel: M_Panel
local Panels = {} --: map<string, M_Panel>


--v function(name: PanelName, CA_Panel: CA_PanelName, Open: CB_Bool, Close: CB_Bool, Click: CB_UI)
function Panel.register(name, CA_Panel, Open, Close, Click)
    local self = {};
    
    setmetatable(self, {
        __index = Panel,
        __tostring = function() return "MAGA PANEL: "..name end
    })
    
    --# assume self: M_Panel

    self.name = name;
    self._open = Open;
    self._close = Close;
    self._click = Click;

    self.opened = false;
    self.clickID = nil --: string

    -- register panel open/close listener
    if CA_Panel then
        Event.on("Open:"..CA_Panel, function() self:Open() end);
        Event.on("Close:"..CA_Panel, function() self:Close() end);
    end

    Panels[name] = self;
end

--v function(name: PanelName)
function Panel.open(name) 
    Panels[name]:Open();
end

--v function(name: PanelName)
function Panel.close(name)
    Panels[name]:Close();
end

--v function(name: PanelName) --> boolean
function Panel.isOpened(name) 
    return Panels[name].opened;
end


--v function(self: M_Panel)
function Panel.Open(self)
    if self.opened then return end

    if self._open() then
        self.opened = true;
        if self._click then 
            self.clickID = Event.addListener("ComponentLClickUp", self._click);
        end

        Console.log("Open "..self.name, "UI");
    end
end

--v function(self: M_Panel)
function Panel.Close(self)
    if not self.opened then return end

    if self._close() then 
        self.opened = false;
        if self._click then
            Event.removeListener(self.clickID);
        end

        Console.log("Close "..self.name, "UI");
    end
end


--v function(context: CA_UIContext)
function Panel.PanelOpenedCampaign(context) 
    local name = context.string;
    Event.emit("Open:"..name);
end

--v function(context: CA_UIContext)
function Panel.PanelClosedCampaign(context) 
    local name = context.string;
    Event.emit("Close:"..name);
end


Event.addListener("PanelOpenedCampaign", Panel.PanelOpenedCampaign);
Event.addListener("PanelClosedCampaign", Panel.PanelClosedCampaign);


return {
    close = Panel.close;
    isOpened = Panel.isOpened;
    open = Panel.open;
    register = Panel.register;
}
