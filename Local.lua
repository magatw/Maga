-- ===========================================================================
-- file: Local
-- author: Hardballer
--
-- Load locals data
-- ===========================================================================

local Console = require("Core/Console");
local Util = require("Core/Util");

local languages = {
    "CZ", "DE", "EN", "ES", "FR",
    "IT", "PL", "RU", "TR"
} --: vector<string>

local language = nil --: string
local file = io.open("data/language.txt");


if file then 
    local str = file:read();
    if Util.indexOf(languages, str) > -1 then
        language = str;
    else
        language = "EN";
    end
    Console.log("Language set to "..language, "Local");
else 
    language = "EN";
    Console.log("No language.txt found, default to EN", "Local");
end


local path = "Local/"..language.."/"..cm.name.."/";
--# assume path: "Local/EN/main_attila/"

return {
    RegionsName = require(path.."/RegionsName");
}
