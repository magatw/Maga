-- ===========================================================================
-- file: UI/DiplomacyDropdown
-- author: Hardballer
--
-- Handle the diplomatic panel
-- ===========================================================================

local Console = require("Core/Console");
local Timer = require("Core/Timer");
local Panel = require("UI/Panel");

local DiplomacyDropdown = {};
local UIC = {};


function DiplomacyDropdown.init() 
    DiplomacyDropdown.offerPanelOpened = false;
    DiplomacyDropdown.stopLoop = false;

    local root = cm:ui_root();
    
    UIC.offer = find_uicomponent_by_table(root, {"diplomacy_dropdown", "offers_panel"});
end

function DiplomacyDropdown.loop() 
    if DiplomacyDropdown.stopLoop then return end
    
    -- Catch the offer panel opening on faction double click
    if not DiplomacyDropdown.offerPanelOpened and UIC.offer:Visible() then
        DiplomacyDropdown.offerPanelOpened = true;
        Console.log("Open offer panel", "UI");
    end

    Timer.nextTick(DiplomacyDropdown.loop);
end


--v function(context: CA_UIContext)
function DiplomacyDropdown.click(context) 
    local name = context.string;

    if not DiplomacyDropdown.offerPanelOpened then
        -- offer panel is opening stop here
        if name == "button_ok" then
            DiplomacyDropdown.offerPanelOpened = true;
            Console.log("Open offer panel", "UI");
            return;
        end

    else -- Offer panel is opened
        Timer.nextTick(function()
            -- The offers panel can only be closed by pressing the button_cancel uic
            -- but this id is not unique, it may come up when the player cancel an offer
            -- we look at the offer panel visibility one tick after the event to determine
            -- if we should close it or not
            if name == "button_cancel" and not UIC.offer:Visible() then
                DiplomacyDropdown.offerPanelOpened = false;
                Console.log("Close offer panel", "UI");
                return;
            end
        end)
    end
end

function DiplomacyDropdown.open() 
    -- abort if it's not the player that opened the panel
    if not cm:model():is_player_turn() then return false end
    
    DiplomacyDropdown.init();
    DiplomacyDropdown.loop();

    return true;
end

function DiplomacyDropdown.close()
    DiplomacyDropdown.stopLoop = true;
    return true;
end


Panel.register(
    "DiplomacyDropdown",
    "diplomacy_dropdown",
    DiplomacyDropdown.open,
    DiplomacyDropdown.close,
    DiplomacyDropdown.click
)
