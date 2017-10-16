-- ===========================================================================
-- file: Model/Character
-- author: Hardballer
--
-- Character Model Class
-- ===========================================================================

local Console = require("Core/Console");
local Event = require("Core/Event");
local Model = require("Model");

local CharacterModel = {};
local Character = {} --# assume Character: M_Character
local Characters = {} --: map<number, M_Character>

-- forward declaration
--# assume M_Character.cai: method() --> CA_Character


--v function(cqi: number) --> M_Character
function CharacterModel.new(cqi)
    local self = {};

    setmetatable(self, {
        __index = Character,
        __tostring = function() return "MAGA Character: "..cqi end
    })

    --# assume self: M_Character

    self.cqi = cqi;

    Console.log("Create Character: "..cqi, "Model");

    Characters[cqi] = self;
    return self;
end

--v function(a: CA_Character, b: CA_Character) --> boolean
function CharacterModel.isSameCharacter(a, b) 
    if a:faction():name() ~= b:faction():name() or
       a:get_forename() ~= b:get_forename() or
       a:get_surname() ~= b:get_surname() or
       a:age() ~= b:age() or
       a:rank() ~= b:rank() or
       a:battles_won() ~= b:battles_won()
    then return false end

    return true;
end

--v function(context: CA_CharacterContext)
function CharacterModel.CharacterCreated(context)
    local cai = context:character();
    if not cai:character_type("general") then return end

    -- When a general is recruited or disbanded his cqi will change
    -- We look here for a match inside the existing classes to update the cqi
    for cqi, class in pairs(Characters) do 
        if not class:cai():is_null_interface() then
            if CharacterModel.isSameCharacter(class:cai(), cai) then
                local newCQI = cai:cqi();
                class.cqi = newCQI;

                Characters[cqi] = nil;
                Characters[newCQI] = class;

                Console.log("Character cqi updated: "..cqi.." -> "..newCQI, "Model");
                return;
            end
        else -- remove null interface
            Characters[cqi] = nil;
        end    
    end
end


--v function(self: M_Character) --> CA_Character
function Character.cai(self) 
    return cm:model():character_for_command_queue_index(self.cqi);
end

--v function(self: M_Character, immortal: boolean)
function Character.SetImmortal(self, immortal)
    cm:set_character_immortality("character_cqi:"..self.cqi, immortal);
end


--v function(cqi: number) --> M_Character
function Model.getCharacter(cqi)
    return Characters[cqi] or CharacterModel.new(cqi);
end


Event.addListener("CharacterCreated", CharacterModel.CharacterCreated);
