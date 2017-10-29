-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
--
-- 	DYNAMIC FACTION NAMES - EVENTS
--
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

att_fact_ostrogothi_lvl1 = "Ostrogoths";
att_fact_ostrogothi_lvl2 = "Ostrogothic Kingdom";
att_fact_ostrogothi_lvl3 = "Ostrogothic Empire";
att_fact_visigothi_lvl1 = "Visigoths";
att_fact_visigothi_lvl2 = "Visigothic Kingdom";
att_fact_visigothi_lvl3 = "Visigothic Empire";
att_fact_franci_lvl1 = "Franks";
att_fact_franci_lvl2 = "Frankish Kingdom";
att_fact_franci_lvl3 = "Frankish Empire";
att_fact_saxones_lvl1 = "Saxons";
att_fact_saxones_lvl2 = "Saxon Kingdom";
att_fact_saxones_lvl3 = "Saxon Empire";
att_fact_alamanni_lvl1 = "Alamans";
att_fact_alamanni_lvl2 = "Alamannic Kingdom";
att_fact_alamanni_lvl3 = "Alamannic Empire";
att_fact_langobardi_lvl1 = "Langobards";
att_fact_langobardi_lvl2 = "Lombard Kingdom";
att_fact_langobardi_lvl3 = "Lombard Empire";
att_fact_burgundii_lvl1 = "Burgundians";
att_fact_burgundii_lvl2 = "Burgundian Kingdom";
att_fact_burgundii_lvl3 = "Burgundian Empire";
att_fact_alani_lvl1 = "Alans";
att_fact_alani_lvl2 = "Alannic Kingdom";
att_fact_alani_lvl3 = "Alannic Empire";
att_fact_suebi_lvl1 = "Suebi";
att_fact_suebi_lvl2 = "Suebian Kingdom";
att_fact_suebi_lvl3 = "Suebian Empire";
att_fact_vandali_lvl1 = "Vandals";
att_fact_vandali_lvl2 = "Vandal Kingdom";
att_fact_vandali_lvl3 = "Vandal Empire";
att_fact_dani_lvl1 = "Danes";
att_fact_dani_lvl2 = "Danish Kingdom";
att_fact_dani_lvl3 = "Danish Empire";
att_fact_gauti_lvl1 = "Geats";
att_fact_gauti_lvl2 = "Kingdom of the Geats";
att_fact_gauti_lvl3 = "Empire of the Geats";
att_fact_iuti_lvl1 = "Jutes";
att_fact_iuti_lvl2 = "Jutish Kingdom";
att_fact_iuti_lvl3 = "Jutish Empire";
att_fact_ebdani_lvl1 = "Ebdanians";
att_fact_ebdani_lvl2 = "Ebdanian Kingdom";
att_fact_ebdani_lvl3 = "Ebdanian Empire";
att_fact_votadini_lvl1 = "Caledonians";
att_fact_votadini_lvl2 = "Caledonian Kingdom";
att_fact_votadini_lvl3 = "Caledonian Empire";
att_fact_picti_lvl1 = "Picts";
att_fact_picti_lvl2 = "Pictish Kingdom";
att_fact_picti_lvl3 = "Pictish Empire";
att_fact_axum_lvl1 = "Aksum";
att_fact_axum_lvl2 = "Aksumite Kingdom";
att_fact_axum_lvl3 = "Aksumite Empire";
att_fact_garamantes_lvl1 = "Garamantians";
att_fact_garamantes_lvl2 = "Garamantian Kingdom";
att_fact_garamantes_lvl3 = "Garamantian Empire";
att_fact_himyar_lvl1 = "Himyar";
att_fact_himyar_lvl2 = "Himyarite Kingdom";
att_fact_himyar_lvl3 = "Himyarite Empire";
att_fact_lakhmids_lvl1 = "Lakhmids";
att_fact_lakhmids_lvl2 = "Lakhmid Kingdom";
att_fact_lakhmids_lvl3 = "Lakhmid Empire";
att_fact_antes_lvl1 = "Anteans";
att_fact_antes_lvl2 = "Antean Kingdom";
att_fact_antes_lvl3 = "Antean Empire";
att_fact_sclaveni_lvl1 = "Sclavenians";
att_fact_sclaveni_lvl2 = "Sclavenian Kingdom";
att_fact_sclaveni_lvl3 = "Sclavenian Empire";
att_fact_venedi_lvl1 = "Venedians";
att_fact_venedi_lvl2 = "Venedian Kingdom";
att_fact_venedi_lvl3 = "Venedian Empire";

NUM_REQUIRED_REGIONS_LVL2 = 1; -- 6
NUM_REQUIRED_REGIONS_LVL3 = 18;

function Add_Region_Events_Listeners()
cm:add_listener(
    "FactionTurnStart_Region_Checks",
    "FactionTurnStart",
    true,
    function(context) Region_Checks(context) end,
    true
);
end

function Region_Checks(context)
local faction_name = context:faction():name();
if context:faction():is_human() then
    if context:faction():region_list():num_items() < NUM_REQUIRED_REGIONS_LVL2 then
        local newname = faction_name.."_lvl1";
        cm:set_faction_name_override(faction_name, newname);
    elseif context:faction():region_list():num_items() >= NUM_REQUIRED_REGIONS_LVL2 and context:faction():region_list():num_items() < NUM_REQUIRED_REGIONS_LVL3 then
        local newname = faction_name.."_lvl2";
        cm:set_faction_name_override(faction_name, newname);
    elseif context:faction():region_list():num_items() >= NUM_REQUIRED_REGIONS_LVL3 then
        local newname = faction_name.."_lvl3";
        cm:set_faction_name_override(faction_name, newname);
    end
end
end

function Has_Required_Regions(faction_key, region_list)
for i = 1, #region_list do
    local region = cm:model():world():region_manager():region_by_key(region_list[i]);
    
    if region:owning_faction():name() ~= faction_key then
        return false;
    end
end
return true;
end