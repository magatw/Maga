-- ===========================================================================
-- file: .vscode/typing
-- author: Hardballer
--
-- Creative Assembly type declaration
-- ===========================================================================


-- CLASS DECLARATION
--# assume global class CM
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


-- CAMPAIGN MANAGER
--# assume CM.add_listener: method(
--#     handler: string,
--#     event: CA_EventName,
--#     condition: boolean,
--#     callback: function(context: WHATEVER?),
--#     shouldRepeat: boolean
--# )
--# assume CM.add_time_trigger: method(name: string, duration: number)
--# assume CM.remove_listener: method(handler: string)


-- GLOBAL FUNCTIONS
--# assume global is_uicomponent: function(arg: any) --> boolean
--# assume global uicomponent_to_str: function(uic: CA_UIC) --> string


-- GLOBAL VARIABLES
--# assume global cm: CM
