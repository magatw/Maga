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
local Image = require("UIC/Image");
local MapOverlay = require("UIC/MapOverlay");
local Text = require("UIC/Text");
local Panel = require("UI/Panel");
local Util = require("UI/Util");

local RegionTrading = {};
local RTFrame = {};
local Map = {};
local UIC = {};

-- forward declaration
--# assume RegionTrading.closeDiplomacy: function()
--# assume RTFrame.update: function()
--# assume RTFrame.onValidClick: function()
--# assume Map.getVisibleRegions: function() --> vector<string>


RTFrame.selectedRegion = {
    player = nil;
    ai = nil;
} --: {player: string, ai: string}

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


function RegionTrading.init() 
    -- UIC
    local root = cm:ui_root();

    UIC.diplo = UIComponent(root:Find("diplomacy_dropdown"));
    UIC.offer = UIComponent(UIC.diplo:Find("offers_panel"));
    UIC.toggleMap = UIComponent(UIC.offer:Find("button_tactical_map"));
    UIC.factionOK = find_uicomponent_by_table(UIC.diplo, {
        "faction_panel", "both_buttongroup", "button_ok"
    })
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

    -- Variables
    RTLogic.setVisibleRegions(Map.getVisibleRegions());

    RegionTrading.stopLoop = false;
    RegionTrading.tradeData = RTLogic.getTradeData();

    RTFrame.selectedRegion.player = nil;
    RTFrame.selectedRegion.ai = nil;
    Map.detailsIconsInitDone = false;
end


function RTFrame.create() 
    local frame = Frame.new("RegionTrading", UIC.diplo);
    local frameW = UIC.offer:Dimensions();

    frame:Resize(frameW, 250);
    frame:AddBottomBar();
    frame:SetTitle("Trade Regions");

    local valid = Button.new("valid", frame.uic);
    valid:MoveTo(UIC.factionOK:Position());
    valid:SetState("inactive");
    valid:On("click", RTFrame.onValidClick);
    
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

    local player = Text.new("uppercase", "center", frame.uic);
    local ai = Text.new("uppercase", "center", frame.uic);
    local textX, textY = player:Position();

    player:MoveTo(textX - 200, textY + 25);
    ai:MoveTo(textX + 200, textY + 25);

    player:On("click", function() 
        RTFrame.selectedRegion.player = nil;
        player:SetStateText("");
        RTFrame.update();
    end)

    ai:On("click", function() 
        RTFrame.selectedRegion.ai = nil;
        ai:SetStateText("");
        RTFrame.update();
    end)

    local gift = Image.new("gift", frame.uic);
    local trade = Image.new("trade", frame.uic);
    gift:SetVisible(false);
    trade:SetVisible(false);

    local iconX = gift:Position();
    local iconY = textY + 20;
    gift:MoveTo(iconX, iconY);
    trade:MoveTo(iconX, iconY);


    RTFrame.frame = frame;
    RTFrame.valid = valid;
    RTFrame.player = player;
    RTFrame.ai = ai;
    RTFrame.gift = gift;
    RTFrame.trade = trade;
end

function RTFrame.delete() 
    RTFrame.frame:Delete();
end

function RTFrame.update() 
    RTFrame.valid:SetState("inactive");
    RTFrame.gift:SetVisible(false);
    RTFrame.trade:SetVisible(false);
    
    if not RTFrame.selectedRegion.player then return end

    if RTFrame.selectedRegion.ai then
        RTFrame.trade:SetVisible(true);
    else
        RTFrame.gift:SetVisible(true);
    end
    
    RTFrame.valid:SetState("active");
end

--v function(key: string)
function RTFrame.onRegionClick(key) 
    local data = RegionTrading.tradeData[key];
    if not data.tradable then return end

    if data.owner == "player" then
        RTFrame.selectedRegion.player = key;
        RTFrame.player:SetStateText(data.name);
    elseif data.owner == "ai" then
        RTFrame.selectedRegion.ai = key;
        RTFrame.ai:SetStateText(data.name);  
    end

    RTFrame.update();
end

function RTFrame.onValidClick()
    local player = RTFrame.selectedRegion.player;
    local ai = RTFrame.selectedRegion.ai;

    if not player then return end

    if ai then 
        RTLogic.trade(player, ai);
    else 
        RTLogic.gift(player);
    end

    RegionTrading.closeDiplomacy();
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

function Map.initDetailsIcon() 
    if not UIC.radar:Visible() then return end

    -- The details icon are created when the player scroll in
    -- An settlement icon with more then 4 childs have 
    -- his details icon created
    if Map.settlementIcons[1]:ChildCount() < 4 then return end

    for i, uic in ipairs(Map.settlementIcons) do
        local main = UIComponent(uic:Find("main_icon"));
        local bar = find_uicomponent_by_table(uic, {"details_icon", "name_bar"});
        bar:SetInteractive(true);
        bar:SetTooltipText(main:GetTooltipText());
    end

    Map.detailsIconsInitDone = true;
end

function Map.restoreDetailsIcons()
    if not Map.detailsIconsInitDone then return end

    for i, uic in ipairs(Map.settlementIcons) do
        local main = UIComponent(uic:Find("main_icon"));
        local bar = find_uicomponent_by_table(uic, {"details_icon", "name_bar"});
        bar:SetInteractive(false);
    end
end

--v function(icon: CA_UIC)
function Map.initSettlementIcon(icon) 
    local key = Map.getRegionKeyFromID(icon:Id());
    local data = RegionTrading.tradeData[key];

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

function Map.addOverlay() 
    Map.overlay = MapOverlay.new(UIC.map);

    local color = nil --: "green" | "yellow"
    local opacity = nil --: number

    for key, data in pairs(RegionTrading.tradeData) do 
        if data.owner == "player" then color = "yellow" else color = "green" end
        if data.tradable then opacity = 100 else opacity = 50 end

        Map.overlay:AddRegion(key, color);
        Map.overlay:SetRegionOpacity(key, opacity);
    end

    Map.overlay:CorrectPriority();
end


function RegionTrading.closeDiplomacy() 
    local root = cm:ui_root();
    local offerCancel = find_uicomponent_by_table(UIC.offer, {
        "offers_list_panel", "button_set1", "button_cancel"
    })

    UIC.offer:SetVisible(false);

    Panel.close("RegionTrading");
    offerCancel:SimulateClick();

    Timer.nextTick(function() 
        UIC.factionCancel:SimulateClick();
    end)
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
        Map.addOverlay();
        
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
        Map.restoreDetailsIcons();
        Map.overlay:Clear();

        Console.log("UI restore from Region Trading mod", "UI");
    end
end

function RegionTrading.loop() 
    if RegionTrading.stopLoop then return end;

    if not Map.detailsIconsInitDone then
        Map.initDetailsIcon();
    end

    Timer.nextTick(RegionTrading.loop);
end

--v function(context: CA_UIContext)
function RegionTrading.click(context)
    local uic = nil --: CA_UIC
    local name = context.string;

    if name == "main_icon" or name == "name_bar" then
        uic = UIComponent(context.component);
        local id = nil --: string

        if name == "main_icon" then
            id = UIComponent(uic:Parent()):Id();
        end

        if name == "name_bar" then
            local parent = UIComponent(uic:Parent());
            id = UIComponent(parent:Parent()):Id();
        end

        local region = Map.getRegionKeyFromID(id);
        RTFrame.onRegionClick(region);
    end
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
    RegionTrading.loop();

    RTFrame.create();
    
    return true;
end

function RegionTrading.close()
    RegionTrading.stopLoop = true;
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
