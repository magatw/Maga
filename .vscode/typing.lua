-- ===========================================================================
-- file: .vscode/typing
-- author: Hardballer
--
-- Creative Assembly type declaration
-- ===========================================================================


-- CLASS DECLARATION
--# assume global class CM
--# assume global class CA_Model
--# assume global class CA_UIC
--# assume global class CA_Component
--# assume global class CA_TimeTriggerContext
--# assume global class CA_UIContext


-- TYPES
--# type global CA_EventName = 
--# "ComponentLClickUp"     | "TimeTrigger" |
--# "PanelClosedCampaign"   | "PanelOpenedCampaign"


--# type global CA_PanelName = "diplomacy_dropdown"


-- CONTEXT
--# assume CA_TimeTriggerContext.string: string
--# assume CA_UIContext.component: CA_Component
--# assume CA_UIContext.string: string


-- MODEL
--# assume CA_Model.is_player_turn: method() --> boolean


-- UIC
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
--# assume CM.model: method() --> CA_Model
--# assume CM.remove_listener: method(handler: string)
--# assume CM.ui_root: method() --> CA_UIC


-- GLOBAL FUNCTIONS
--# assume global is_uicomponent: function(arg: any) --> boolean
--# assume global find_uicomponent_by_table: function(uic: CA_UIC, path: vector<string>) --> CA_UIC
--# assume global uicomponent_to_str: function(uic: CA_UIC) --> string


-- GLOBAL VARIABLES
--# assume global cm: CM
