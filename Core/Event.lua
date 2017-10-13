-- ===========================================================================
-- file: Core/Event
-- author: Hardballer
--
-- Campaign events wrapper
-- ===========================================================================

local Console = require("Core/Console");
local Event = {};


Event.callbacks = {} --: map<string, vector<function(c: WHATEVER?)>>
Event.id = 0;


--v function(e: string, cb: function(context: WHATEVER?))
function Event.on(e, cb)
    Event.callbacks[e] = Event.callbacks[e] or {};
    table.insert(Event.callbacks[e], cb);
end

--v function(e: string, arg: WHATEVER?)
function Event.emit(e, arg)
    Event.callbacks[e] = Event.callbacks[e] or {};

    Console.log(e, "Event");

    for index, cb in ipairs(Event.callbacks[e]) do
        cb(arg);
    end
end

--v function(e: CA_EventName, cb: function(context: WHATEVER?)) --> string
function Event.addListener(e, cb)
    Event.id = Event.id + 1;
    local handlerID = e..tostring(Event.id);

    cm:add_listener("MAGA_EH_"..handlerID, e, true, cb, true);

    return handlerID;
end

--v function(handlerID: string)
function Event.removeListener(handlerID)
    cm:remove_listener("MAGA_EH_"..handlerID);
end


return {
    addListener = Event.addListener;
    emit = Event.emit;
    on = Event.on;
    removeListener = Event.removeListener;
}
