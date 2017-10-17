-- ===========================================================================
-- file: UI/DiplomacyDropdown
-- author: Hardballer
--
-- Handle the diplomatic panel
-- ===========================================================================

local Console = require("Core/Console");
local Timer = require("Core/Timer");
local RTLogic = require("Logic/RegionTrading");
local Button = require("UIC/Button");
local Dummy = require("UIC/Dummy");
local Panel = require("UI/Panel");

local DiplomacyDropdown = {};
local BTR = {}; -- Button Trade Region
local UIC = {};


-- forward declaration
--# assume BTR.updateFaction: function()


function DiplomacyDropdown.init() 
    DiplomacyDropdown.offerPanelOpened = false;
    DiplomacyDropdown.stopLoop = false;

    local root = cm:ui_root();
    
    UIC.offer = find_uicomponent_by_table(root, {"diplomacy_dropdown", "offers_panel"});
    UIC.factionLBox = find_uicomponent_by_table(root, {
        "diplomacy_dropdown", "faction_panel",
        "sortable_list_factions", "list_clip", "list_box"   
    })

    UIC.buttonSet = find_uicomponent_by_table(UIC.offer, {"offers_list_panel", "button_set1"});
    UIC.buttonCO = UIComponent(UIC.buttonSet:Find("button_counteroffer"));
    UIC.buttonSend = UIComponent(UIC.buttonSet:Find("button_send"));

    -- The panel automatically select the first faction of the lbox when opening
    Timer.nextTick(function() 
        local uic = UIComponent(UIC.factionLBox:Find(0));
        DiplomacyDropdown.selectedFaction = string.gsub(uic:Id(), "faction_row_entry_", "");
        RTLogic.setAIFaction(DiplomacyDropdown.selectedFaction);
        BTR.updateFaction();
    end)
end


function BTR.create() 
    local coX, coY = UIC.buttonCO:Position();
    local sendX = UIC.buttonSend:Position();

    local posX = coX - (sendX - coX) - 38;
    local posY = coY - 4;

    -- Adding directly the btr to the button set will block it
    -- We use this dummy as the button parent so we can move it
    BTR.dummy = Dummy.new(UIC.buttonSet);
    BTR.dummy:MoveTo(posX, posY);

    BTR.button = Button.new("trade_region", BTR.dummy.uic);
    BTR.button:On("click", function() 
        Panel.open("RegionTrading");
        BTR.button:SetState("hover");
    end)
end

function BTR.delete()
    BTR.dummy:Delete();
end

function BTR.updateFaction()
    if RTLogic.canTradeWithAI() then
        BTR.button:SetState("active");
    else
        BTR.button:SetState("inactive");
    end
end

function BTR.update() 
    local state = UIC.buttonSend:CurrentState();
    
    -- Disable in case of diplomatic offer
    if state == "active" or state == "hover" then
        BTR.button:SetState("inactive");
        return;
    end

    -- Look for any update on the faction like a peace treaty
    BTR.updateFaction();
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
        RTLogic.setAIFaction(faction);
        BTR.updateFaction();
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
    if Panel.isOpened("RegionTrading") then return end
    
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

            BTR.update();
        end)
    end
end

function DiplomacyDropdown.open() 
    -- abort if it's not the player that opened the panel
    if not cm:model():is_player_turn() then return false end
    
    DiplomacyDropdown.init();
    DiplomacyDropdown.loop();
    BTR.create();

    return true;
end

function DiplomacyDropdown.close()
    DiplomacyDropdown.stopLoop = true;
    BTR.delete();

    return true;
end


Panel.register(
    "DiplomacyDropdown",
    "diplomacy_dropdown",
    DiplomacyDropdown.open,
    DiplomacyDropdown.close,
    DiplomacyDropdown.click
)
