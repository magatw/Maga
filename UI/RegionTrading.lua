-- ===========================================================================
-- file: UI/RegionTrading
-- author: Hardballer
--
-- Handle the region trading panel
-- ===========================================================================

local Console = require("Core/Console");
local Button = require("UIC/Button");
local Frame = require("UIC/Frame");
local Panel = require("UI/Panel");

local RegionTrading = {};
local RTFrame = {};
local UIC = {};


function RegionTrading.init() 
    local root = cm:ui_root();

    UIC.diplo = UIComponent(root:Find("diplomacy_dropdown"));
    UIC.offer = UIComponent(UIC.diplo:Find("offers_panel"));
    UIC.toggleMap = UIComponent(UIC.offer:Find("button_tactical_map"));
    UIC.factionCancel = find_uicomponent_by_table(UIC.diplo, {
        "faction_panel", "both_buttongroup", "button_cancel"
    })

    UIC.radar = find_uicomponent_by_table(root, {"campaign_tactical_map", "radar"});
end


function RTFrame.create() 
    local frame = Frame.new("RegionTrading", UIC.diplo);
    local frameW = UIC.offer:Dimensions();

    frame:Resize(frameW, 250);
    frame:AddBottomBar();
    frame:SetTitle("Trade Regions");

    local cancel = Button.new("cancel", frame:uic());
    cancel:MoveTo(UIC.factionCancel:Position());
    
    cancel:On("click", function() 
        Panel.close("RegionTrading");
    end)


    local toggle = Button.new("toggle_map", frame:uic());
    toggle:ClearSound();
    toggle:MoveTo(UIC.toggleMap:Position());
    toggle:SetTooltipText(UIC.toggleMap:GetTooltipText());

    toggle:On("click", function() 
        UIC.toggleMap:SimulateClick();
        toggle:SetState("hover");
    end)


    RTFrame.frame = frame;
end

function RTFrame.delete() 
    RTFrame.frame:Delete();
end


--v function(mode: "open" | "close")
function RegionTrading.setUI(mode)
    if mode == "open" then
        -- Reveal the map
        if not UIC.radar:Visible() then
            UIC.toggleMap:SimulateClick();
        end
        
        UIC.offer:SetVisible(false);

        Console.log("UI set for Region Trading", "UI");
    elseif mode == "close" then
        UIC.offer:SetVisible(true);
      
        Console.log("UI restore from Region Trading mod", "UI");
    end
end


--v function(context: CA_UIContext)
function RegionTrading.click(context)

end

function RegionTrading.open() 
    if not Panel.isOpened("DiplomacyDropdown") then
        return false;
    end

    RegionTrading.init();
    RegionTrading.setUI("open");
    RTFrame.create();

    return true;
end

function RegionTrading.close()
    RegionTrading.setUI("close");
    RTFrame.delete();

    return true; 
end


Panel.register(
    "RegionTrading",
    nil,
    RegionTrading.open,
    RegionTrading.close,
    RegionTrading.click
)
