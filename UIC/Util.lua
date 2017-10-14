-- ===========================================================================
-- file: UIC/Util
-- author: Hardballer
--
-- UIC utility functions
-- ===========================================================================

--# type global UIC_EventName = "click" | "hover" | "exit"

local Console = require("Core/Console");
local Event = require("Core/Event");

local Util = {};
local Callback = {};

-- forward declaration
--# assume Util.removeCallback: function(uic: CA_UIC)


Callback.click = {} --: map<string, function()>
Callback.hover = {} --: map<string, function()>
Callback.exit = {} --: map<string, function()>
Callback.lastHover = nil --: string


function Util.init() 
    local root = cm:ui_root();

    root:CreateComponent("MagaGarbage", "UI/campaign ui/script_dummy");
    Util.garbage = UIComponent(root:Find("MagaGarbage"));

    Console.log("Util init done", "UIC");
end

--v function(uic: CA_UIC)
function Util.removeCallback(uic) 
    local p = tostring(uic:Address());

    Callback.click[p] = nil;
    Callback.hover[p] = nil;
    Callback.exit[p] = nil;

    if uic:ChildCount() == 0 then return end

    for i = 0, uic:ChildCount() - 1 do
        local child = UIComponent(uic:Find(i));
        Util.removeCallback(child);
    end
end

--v function(context: CA_UIContext)
function Util.click(context) 
    local p = tostring(context.component);
    if Callback.click[p] then
        Callback.click[p]();
    end 
end

--v function(context: CA_UIContext)
function Util.hover(context)
    local p = tostring(context.component);
    
    if Callback.exit[Callback.lastHover] then
        Callback.exit[Callback.lastHover]();
    end

    if Callback.hover[p] then
        Callback.hover[p]();
    end

    Callback.lastHover = p;
end


--v function(uic: CA_UIC, e: UIC_EventName, cb: function())
function Util.on(uic, e, cb) 
    --# assume e: "click"
    local p = tostring(uic:Address());
    Callback[e][p] = cb;
end

--v function(uic: CA_UIC, removeCallback: boolean?)
function Util.delete(uic, removeCallback) 
    if removeCallback then
        Util.removeCallback(uic);
    end
    
    Util.garbage:Adopt(uic:Address());
    Util.garbage:DestroyChildren();
end


Event.addListener("UICreated", Util.init);
Event.addListener("ComponentLClickUp", Util.click);
Event.addListener("ComponentMouseOn", Util.hover);


return {
    delete = Util.delete;
    on = Util.on;
}
