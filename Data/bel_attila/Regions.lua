-- ===========================================================================
-- file: Data/bel_attila/Regions
-- author: Hardballer
--
-- Provinces to Regions table
-- Regions are sorted as the settlement UI (capital, region 1, region 2)
-- ===========================================================================

local Regions = {
    ["africa_proconsularis"] = {"bel_reg_africa_proconsularis_carthago", "bel_reg_africa_proconsularis_thuburbo", "bel_reg_africa_proconsularis_hippo_diarrhytus"},
    ["apulia_et_calabria"] = {"bel_reg_apulia_et_calabria_tarentum", "bel_reg_apulia_et_calabria_hydruntum", "bel_reg_apulia_et_calabria_sipontum"},
    ["aquitaine"] = {"bel_reg_aquitaine_lemonum", "bel_reg_aquitaine_arvernis", "bel_reg_aquitaine_avaricum"},
    ["austrasia"] = {"bel_reg_austrasia_mettis", "bel_reg_austrasia_remorum", "bel_reg_austrasia_augustobona_tricassium"},
    ["baetica"] = {"bel_reg_baetica_malaca", "bel_reg_baetica_hispalis", "bel_reg_baetica_gades"},
    ["brittany"] = {"bel_reg_brittany_riedonum", "bel_reg_brittany_osismorum", "bel_reg_brittany_gwened"},
    ["burgundy"] = {"bel_reg_burgundy_vienne", "bel_reg_burgundy_besantio", "bel_reg_burgundy_valentia"},
    ["byzacena"] = {"bel_reg_byzacena_hadrumentum", "bel_reg_byzacena_thysdrus", "bel_reg_byzacena_sufetula"},
    ["campania_et_samnium"] = {"bel_reg_campania_et_samnium_neapolis", "bel_reg_campania_et_samnium_corfinium", "bel_reg_campania_et_samnium_beneventum"},
    ["cantabria"] = {"bel_reg_cantabria_legio", "bel_reg_cantabria_portus_victoriae", "bel_reg_cantabria_pompaelo"},
    ["carthaginensis"] = {"bel_reg_carthaginensis_carthago_nova", "bel_reg_carthaginensis_libisosa", "bel_reg_carthaginensis_ilici"},
    ["celtiberia"] = {"bel_reg_celtiberia_complutum", "bel_reg_celtiberia_tolentum", "bel_reg_celtiberia_segovia"},
    ["dalmatia"] = {"bel_reg_dalmatia_salona", "bel_reg_dalmatia_tarsatica", "bel_reg_dalmatia_narona"},
    ["epirus_nova"] = {"bel_reg_epirus_nova_nicopolis", "bel_reg_epirus_nova_dyrrachium", "bel_reg_epirus_nova_photiki"},
    ["flaminia_et_picenum"] = {"bel_reg_flaminia_et_picenum_ravenna", "bel_reg_flaminia_et_picenum_pisaurum", "bel_reg_flaminia_et_picenum_bononia"},
    ["gallaecia"] = {"bel_reg_gallaecia_bracara", "bel_reg_gallaecia_astorga", "bel_reg_gallaecia_brigantium"},
    ["italia"] = {"bel_reg_italia_roma", "bel_reg_italia_reate", "bel_reg_italia_cosa"},
    ["liguria"] = {"bel_reg_liguria_mediolanum", "bel_reg_liguria_augusta_taurinorum", "bel_reg_liguria_genua"},
    ["lucania_et_brutii"] = {"bel_reg_lucania_et_brutii_rhegium", "bel_reg_lucania_et_brutii_crotona", "bel_reg_lucania_et_brutii_thurii"},
    ["lusitania"] = {"bel_reg_lusitania_emerita", "bel_reg_lusitania_olissipo", "bel_reg_lusitania_aeminium"},
    ["mauretania_caesariensis"] = {"bel_reg_mauretania_caesariensis_caesarea", "bel_reg_mauretania_caesariensis_cartenna", "bel_reg_mauretania_caesariensis_pomaria"},
    ["mauretania_sitifensis"] = {"bel_reg_mauretania_sitifensis_sitifis", "bel_reg_mauretania_sitifensis_tipasa", "bel_reg_mauretania_sitifensis_cirta"},
    ["mauretania_tingitana"] = {"bel_reg_mauretania_tingitana_tingis", "bel_reg_mauretania_tingitana_rusaddir", "bel_reg_mauretania_tingitana_anfa"},
    ["neustria"] = {"bel_reg_neustria_paris", "bel_reg_neustria_portus_namnetum", "bel_reg_neustria_turonorum"},
    ["novempopulania"] = {"bel_reg_novempopulania_tolosa", "bel_reg_novempopulania_burdigala", "bel_reg_novempopulania_aquensium"},
    ["picenum_suburbicarium"] = {"bel_reg_picenum_suburbicarium_asculum", "bel_reg_picenum_suburbicarium_ancona", "bel_reg_picenum_suburbicarium_spoletum"},
    ["praeualitana"] = {"bel_reg_praeualitana_doclea", "bel_reg_praeualitana_lissus", "bel_reg_praeualitana_epidaurum"},
    ["provence"] = {"bel_reg_provence_massilia", "bel_reg_provence_nikaia", "bel_reg_provence_vapincum"},
    ["sardinia_et_corsica"] = {"bel_reg_sardinia_et_corsica_caralis", "bel_reg_sardinia_et_corsica_turris", "bel_reg_sardinia_et_corsica_aleria"},
    ["sicilia"] = {"bel_reg_sicilia_syracuse", "bel_reg_sicilia_panormus", "bel_reg_sicilia_agrigentum"},
    ["septimania"] = {"bel_reg_septimania_narbonne", "bel_reg_septimania_nimes", "bel_reg_septimania_elne"},
    ["tarraconensis"] = {"bel_reg_tarraconensis_barcino", "bel_reg_tarraconensis_caesaraugusta", "bel_reg_tarraconensis_valentia"},
    ["tuscia_et_umbria"] = {"bel_reg_tuscia_et_umbria_faesulae", "bel_reg_tuscia_et_umbria_pisae", "bel_reg_tuscia_et_umbria_arretium"},
    ["venetia_et_histria"] = {"bel_reg_venetia_et_histria_aquileia", "bel_reg_venetia_et_histria_patavium", "bel_reg_venetia_et_histria_verona"},
    ["zeugitana"] = {"bel_reg_zeugitana_hippo_regis", "bel_reg_zeugitana_thagaste", "bel_reg_zeugitana_bulla_regia"}
} --: map<string, vector<string>>


return Regions;
