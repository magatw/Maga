-- ===========================================================================
-- file: UI/RegionTrading
-- author: Hardballer
--
-- Handle the region trading panel
-- ===========================================================================

local Console = require("Core/Console");
local Event = require("Core/Event");
local Timer = require("Core/Timer");
local RTLogic = require("Logic/RegionTrading");
local Button = require("UIC/Button");
local Frame = require("UIC/Frame");
local Panel = require("UI/Panel");
local Util = require("UI/Util");

local RegionTrading = {};
local RTFrame = {};
local Map = {};
local UIC = {};

-- forward declaration
--# assume Map.getVisibleRegions: function() --> vector<string>


-- Determine which icons would be visible on the map for region trading
-- cbox item id => wanted state (active = not visible, selected = visible)
Map.visibleIcons = {
    checkbox_forces = "active",
    checkbox_agents = "active",
    checkbox_resources = "active",
    checkbox_settlements = "selected",
    checkbox_siege = "selected"
} --: const map<string, string>

-- Keep track of the cbox items state to restore them on closing
Map.iconsCBoxState = {} --: map<string, string>

-- List of visible settlement icons
Map.settlementIcons = {} --: vector<CA_UIC>
Map.detailsIconsInitDone = false;


function RegionTrading.init() 
    -- UIC
    local root = cm:ui_root();

    UIC.diplo = UIComponent(root:Find("diplomacy_dropdown"));
    UIC.offer = UIComponent(UIC.diplo:Find("offers_panel"));
    UIC.toggleMap = UIComponent(UIC.offer:Find("button_tactical_map"));
    UIC.factionCancel = find_uicomponent_by_table(UIC.diplo, {
        "faction_panel", "both_buttongroup", "button_cancel"
    })
    UIC.speechBubble = find_uicomponent_by_table(UIC.diplo, {
        "faction_right_status_panel", "speech_bubble"
    })

    UIC.radar = find_uicomponent_by_table(root, {"campaign_tactical_map", "radar"});
    UIC.map = UIComponent(UIC.radar:Find("map"));
    UIC.tacticalHud = find_uicomponent_by_table(root, {"campaign_tactical_map", "tactical_hud"});
    UIC.overlayCbox = UIComponent(UIC.tacticalHud:Find("checkbox_overlay"));
    
    RegionTrading.overlayState = UIC.overlayCbox:CurrentState();

    UIC.iconsCbox = {} --: map<string, CA_UIC>
    local iconsParent = find_uicomponent_by_table(UIC.tacticalHud, {
        "radar_menu", "icon_filter_parent"
    })

    for i = 0, iconsParent:ChildCount() - 1 do
        local uic = UIComponent(iconsParent:Find(i));
        UIC.iconsCbox[uic:Id()] = uic;
    end

    RTLogic.updateVisibleRegions(Map.getVisibleRegions());
    RegionTrading.regionsList = RTLogic.getRegionsList();
end


function RTFrame.create() 
    local frame = Frame.new("RegionTrading", UIC.diplo);
    local frameW = UIC.offer:Dimensions();

    frame:Resize(frameW, 250);
    frame:AddBottomBar();
    frame:SetTitle("Trade Regions");

    local cancel = Button.new("cancel", frame.uic);
    cancel:MoveTo(UIC.factionCancel:Position());
    
    cancel:On("click", function() 
        Panel.close("RegionTrading");
    end)

    local toggle = Button.new("toggle_map", frame.uic);
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


--v function(id: string) --> string
function Map.getRegionKeyFromID(id)
    local name = string.gsub(id, "radar_icon_settlement:", "");

    -- Some icons in bel_attila are named province_name:name
    local index = string.find(name, ":");
    if index then name = string.sub(name, 1, index - 1) end

    return name;
end

function Map.getVisibleRegions() 
    local list = {} --: vector<string>
    
    for i = 0, UIC.map:ChildCount() - 1 do
        local icon = UIComponent(UIC.map:Find(i));
        local id = icon:Id();

        if string.find(id, "radar_icon_settlement") then
            local key = Map.getRegionKeyFromID(id);
            table.insert(list, key);
        end
    end

    return list;
end

--v function(icon: CA_UIC)
function Map.initSettlementIcon(icon) 
    local key = Map.getRegionKeyFromID(icon:Id());
    local data = RegionTrading.regionsList[key];

    -- region is not present in the list, hide it and return
    if not data then return icon:SetVisible(false) end

    table.insert(Map.settlementIcons, icon);

    if not data.tradable then 
        -- apply shader on untradable region
        local mi = UIComponent(icon:Find("main_icon"));
        mi:ShaderTechniqueSet("set_greyscale_t0", false);
        mi:ShaderVarsSet(0.75, 0.75, 0, 0, false);
    end
end

--v function(mode: "set" | "restore")
function Map.setSettlementIconVisibility(mode) 
    if mode == "set" then
        -- reset the variables
        Map.settlementIcons = {};
        Map.detailsIconsInitDone = false;
    end
    
    for i = 0, UIC.map:ChildCount() - 1 do
        local icon = UIComponent(UIC.map:Find(i));
        local id = icon:Id();

        if string.find(id, "radar_icon_settlement") then
            if mode == "set" then Map.initSettlementIcon(icon) end

            if mode == "restore" then
                icon:SetVisible(true);

                -- reset shader effect
                local mi = UIComponent(icon:Find("main_icon"));
                mi:ShaderTechniqueSet(7, false);
                mi:ShaderVarsSet(0, 0, 0, 0, false);
            end
        end
    end
end

--v function(mode: "set" | "restore")
function Map.setIconsVisibility(mode)
    for id, uic in pairs(UIC.iconsCbox) do
        local wantedState = Map.visibleIcons[id];

        if mode == "set" then
            Map.iconsCBoxState[id] = uic:CurrentState();

            if Map.iconsCBoxState[id] ~= wantedState then
                Util.clickWithState(uic, wantedState);
            end

        elseif mode == "restore" then
            local originalState = Map.iconsCBoxState[id];
            if originalState ~= wantedState then
                Util.clickWithState(uic, originalState);
            end
        end
    end
end

--v function(visible: boolean)
function Map.setFactionIconVisibility(visible)
    for i = 0, UIC.radar:ChildCount() - 1 do
        local c = UIComponent(UIC.radar:Find(i));
        if c:Id() ~= "map" then c:SetVisible(visible) end
    end
end


--v function(mode: "open" | "close")
function RegionTrading.setUI(mode)
    if mode == "open" then
        -- Reveal the map
        if not UIC.radar:Visible() then
            UIC.toggleMap:SimulateClick();
        end

        UIC.offer:SetVisible(false);
        UIC.speechBubble:SetVisible(false);
        UIC.tacticalHud:SetVisible(false);

        if RegionTrading.overlayState ~= "active" then
            UIC.overlayCbox:SimulateClick();
        end

        Map.setIconsVisibility("set");
        Map.setSettlementIconVisibility("set");
        Map.setFactionIconVisibility(false);

        Console.log("UI set for Region Trading", "UI");
    elseif mode == "close" then
        UIC.offer:SetVisible(true);
        UIC.speechBubble:SetVisible(true);
        UIC.tacticalHud:SetVisible(true);

        if RegionTrading.overlayState ~= "active" then
            Util.clickWithState(UIC.overlayCbox, "hover");
        end

        Map.setIconsVisibility("restore");
        Map.setSettlementIconVisibility("restore");
        Map.setFactionIconVisibility(true);

        Console.log("UI restore from Region Trading mod", "UI");
    end
end


--v function(context: CA_UIContext)
function RegionTrading.click(context)

end

function RegionTrading.tacticalMapOpened()
    if not Panel.isOpened("RegionTrading") then return end

    -- Reapply some of the modifications that have been reset
    -- when the player close the map
    Timer.nextTick(function()
        UIC.overlayCbox:SimulateClick();
        Map.setIconsVisibility("set");
        Map.setSettlementIconVisibility("set");
        Console.log("Tactical Map restored for Region Trading", "UI");
    end)    
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


Event.on("Open:campaign_tactical_map", RegionTrading.tacticalMapOpened);


Panel.register(
    "RegionTrading",
    nil,
    RegionTrading.open,
    RegionTrading.close,
    RegionTrading.click
)
