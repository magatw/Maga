-- ===========================================================================
-- file: Model
-- author: Hardballer
--
-- Declare the Model namespace and class type
-- The Model table is used as a mediator between all the model classes
-- ===========================================================================

-- CLASS
--# assume global class M_Model
--# assume global class M_Character
--# assume global class M_Faction
--# assume global class M_Region


-- Model/Character
--# assume M_Model.getCharacter: function(cqi: number) --> M_Character

-- Model/Faction
--# assume M_Model.getFaction: function(name: string) --> M_Faction
--# assume M_Model.getPlayer: function() --> M_Faction

-- Model/Region
--# assume M_Model.getRegion: function(name: string) --> M_Region


local Model = {} --# assume Model: M_Model
return Model;
