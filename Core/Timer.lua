-- ===========================================================================
-- file: Core/Timer
-- author: Hardballer
--
-- Timer utility functions
-- ===========================================================================

local Event = require("Core/Event");
local Timer = {};

Timer.callbacks = {} --: map<number, function()>
Timer.id = 0;


--v function(cb: function())
function Timer.nextTick(cb)
    Timer.id = Timer.id + 1;
    Timer.callbacks[Timer.id] = cb;

    local handlerID = "MAGA_NextTick"..tostring(Timer.id);
    cm:add_time_trigger(handlerID, 0);
end

--v function(context: CA_TimeTriggerContext)
function Timer.TimeTrigger(context)
    local str = context.string;
    
    if string.find(str, "MAGA_NextTick") then
        local strID = string.gsub(str, "MAGA_NextTick", "");
        local id = tonumber(strID);

        Timer.callbacks[id]();
        Timer.callbacks[id] = nil;
    end
end


Event.addListener("TimeTrigger", Timer.TimeTrigger);


return {
    nextTick = Timer.nextTick;
}
