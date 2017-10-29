-- ===========================================================================
-- file: .vscode/typing
-- author: Hardballer
--
-- Creative Assembly type declaration
-- ===========================================================================


-- CLASS DECLARATION
--# assume global class CM
--# assume global class CA_Model
--# assume global class CA_World
--# assume global class CA_Region
--# assume global class CA_RegionList
--# assume global class CA_RegionManager
--# assume global class CA_GarrisonResidence
--# assume global class CA_Character
--# assume global class CA_Faction
--# assume global class CA_UIC
--# assume global class CA_Component
--# assume global class CA_CharacterContext
--# assume global class CA_TimeTriggerContext
--# assume global class CA_UIContext


-- TYPES
--# type global CA_EventName = 
--# "CharacterCreated"      | "ComponentLClickUp"     | "ComponentMouseOn"    |
--# "PanelClosedCampaign"   | "PanelOpenedCampaign" |
--# "TimeTrigger"           | "UICreated"


--# type global CA_PanelName = "diplomacy_dropdown"


-- CONTEXT
--# assume CA_CharacterContext.character: method() --> CA_Character
--# assume CA_TimeTriggerContext.string: string
--# assume CA_UIContext.component: CA_Component
--# assume CA_UIContext.string: string


-- MODEL
--# assume CA_Model.character_for_command_queue_index: method(cqi: number) --> CA_Character
--# assume CA_Model.is_player_turn: method() --> boolean
--# assume CA_Model.world: method() --> CA_World


-- WORLD
--# assume CA_World.faction_by_key: method(key: string) --> CA_Faction
--# assume CA_World.region_manager: method() --> CA_RegionManager


-- REGION MANAGER
--# assume CA_RegionManager.region_by_key: method(key: string) --> CA_Region


-- REGION LIST
--# assume CA_RegionList.item_at: method(index: number) --> CA_Region
--# assume CA_RegionList.num_items: method() --> number


-- REGION
--# assume CA_Region.garrison_residence: method() --> CA_GarrisonResidence
--# assume CA_Region.governor: method() --> CA_Character
--# assume CA_Region.has_governor: method() --> boolean
--# assume CA_Region.name: method() --> string


-- GARRISON RESIDENCE
--# assume CA_GarrisonResidence.is_under_siege: method() --> boolean


-- CHARACTER
--# assume CA_Character.age: method() --> number
--# assume CA_Character.battles_won: method() --> number
--# assume CA_Character.character_type: method(ctype: string) --> boolean
--# assume CA_Character.cqi: method() --> number
--# assume CA_Character.faction: method() --> CA_Faction
--# assume CA_Character.get_forename: method() --> string
--# assume CA_Character.get_surname: method() --> string
--# assume CA_Character.is_null_interface: method() --> boolean
--# assume CA_Character.rank: method() --> number


-- FACTION
--# assume CA_Faction.at_war_with: method(faction: CA_Faction) --> boolean
--# assume CA_Faction.has_home_region: method() --> boolean
--# assume CA_Faction.home_region: method() --> CA_Region
--# assume CA_Faction.is_horde: method() --> boolean
--# assume CA_Faction.name: method() --> string
--# assume CA_Faction.region_list: method() --> CA_RegionList


-- UIC
--# assume CA_UIC.Address: method() --> CA_Component
--# assume CA_UIC.Adopt: method(pointer: CA_Component)
--# assume CA_UIC.ChildCount: method() --> number
--# assume CA_UIC.ClearSound: method()
--# assume CA_UIC.CreateComponent: method(name: string, path: string)
--# assume CA_UIC.CurrentState: method() --> string
--# assume CA_UIC.DestroyChildren: method()
--# assume CA_UIC.Dimensions: method() --> (number, number)
--# assume CA_UIC.Find: method(arg: number | string) --> CA_Component
--# assume CA_UIC.GetTooltipText: method() --> string
--# assume CA_UIC.Id: method() --> string
--# assume CA_UIC.MoveTo: method(x: number, y: number)
--# assume CA_UIC.Parent: method() --> CA_Component
--# assume CA_UIC.Position: method() --> (number, number)
--# assume CA_UIC.Resize: method(w: number, h: number)
--# assume CA_UIC.SetInteractive: method(interactive: boolean)
--# assume CA_UIC.SetOpacity: method(opacity: number)
--# assume CA_UIC.SetState: method(state: string)
--# assume CA_UIC.SetStateText: method(text: string)
--# assume CA_UIC.SetTooltipText: method(text: string)
--# assume CA_UIC.SetVisible: method(visible: boolean)
--# assume CA_UIC.ShaderTechniqueSet: method(technique: string | number, unknown: boolean)
--# assume CA_UIC.ShaderVarsSet: method(p1: number, p2: number, p3: number, p4: number, unknown: boolean)
--# assume CA_UIC.SimulateClick: method()
--# assume CA_UIC.Visible: method() --> boolean


-- CAMPAIGN MANAGER
--# assume CM.add_listener: method(
--#     handler: string,
--#     event: CA_EventName,
--#     condition: boolean,
--#     callback: function(context: WHATEVER?),
--#     shouldRepeat: boolean
--# )
--# assume CM.add_time_trigger: method(name: string, duration: number)
--# assume CM.get_local_faction: method() --> string
--# assume CM.model: method() --> CA_Model
--# assume CM.name: "main_attila"
--# assume CM.remove_listener: method(handler: string)
--# assume CM.set_character_immortality: method(lookup: string, immortal: boolean)
--# assume CM.transfer_region_to_faction: method(region: string, faction: string)
--# assume CM.ui_root: method() --> CA_UIC
--# assume CM.set_faction_name_override: method(faction: string, name: string)


-- GLOBAL FUNCTIONS
--# assume global is_uicomponent: function(arg: any) --> boolean
--# assume global find_uicomponent_by_table: function(uic: CA_UIC, path: vector<string>) --> CA_UIC
--# assume global UIComponent: function(pointer: CA_Component) --> CA_UIC
--# assume global uicomponent_to_str: function(uic: CA_UIC) --> string


-- GLOBAL VARIABLES
--# assume global cm: CM
