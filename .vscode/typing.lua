-- ===========================================================================
-- file: .vscode/typing
-- author: Hardballer
--
-- Creative Assembly type declaration
-- ===========================================================================


-- CLASS DECLARATION
--# assume global class CM
--# assume global class CA_UIC


-- TYPES
--# type global CA_EventName = ""


-- CAMPAIGN MANAGER
--# assume CM.add_listener: method(
--#     handler: string,
--#     event: CA_EventName,
--#     condition: boolean,
--#     callback: function(context: WHATEVER?),
--#     shouldRepeat: boolean
--# )
--# assume CM.remove_listener: method(handler: string)


-- GLOBAL FUNCTIONS
--# assume global is_uicomponent: function(arg: any) --> boolean
--# assume global uicomponent_to_str: function(uic: CA_UIC) --> string


-- GLOBAL VARIABLES
--# assume global cm: CM
