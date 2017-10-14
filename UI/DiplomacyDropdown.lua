-- ===========================================================================
-- file: UI/DiplomacyDropdown
-- author: Hardballer
--
-- Handle the diplomatic panel
-- ===========================================================================

local Console = require("Core/Console");
local Timer = require("Core/Timer");
local RTLogic = require("Logic/RegionTrading");
local Panel = require("UI/Panel");

local DiplomacyDropdown = {};
local UIC = {};


function DiplomacyDropdown.init() 
    DiplomacyDropdown.offerPanelOpened = false;
    DiplomacyDropdown.stopLoop = false;

    local root = cm:ui_root();
    
    UIC.offer = find_uicomponent_by_table(root, {"diplomacy_dropdown", "offers_panel"});
    UIC.factionLBox = find_uicomponent_by_table(root, {
        "diplomacy_dropdown", "faction_panel",
        "sortable_list_factions", "list_clip", "list_box"   
    })

    -- The panel automatically select the first faction of the lbox when opening
    Timer.nextTick(function() 
        local uic = UIComponent(UIC.factionLBox:Find(0));
        DiplomacyDropdown.selectedFaction = string.gsub(uic:Id(), "faction_row_entry_", "");
        RTLogic.updateAIFaction(DiplomacyDropdown.selectedFaction);
    end)
end

function DiplomacyDropdown.updateSelectedFaction()
    local faction --: string

    for i = 0, UIC.factionLBox:ChildCount() - 1 do
        local child = UIComponent(UIC.factionLBox:Find(i));
        local state = child:CurrentState();

        if state == "selected" or state == "selected_hover" then
            faction = string.gsub(child:Id(), "faction_row_entry_", "");
            break;
        end
    end

    if DiplomacyDropdown.selectedFaction ~= faction then
        DiplomacyDropdown.selectedFaction = faction;
        RTLogic.updateAIFaction(faction);
    end
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

        Timer.nextTick(function()
            -- Faction can be selected by clicking on the listbox,
            -- on a city map icon or a faction icon (i.e list of allies)
            -- To keep track of the selected faction we look for a selected item
            -- inside the lb one tick after the click event
            DiplomacyDropdown.updateSelectedFaction();
        end)

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
