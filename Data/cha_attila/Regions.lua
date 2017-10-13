-- ===========================================================================
-- file: Data/cha_attila/Regions
-- author: Hardballer
--
-- Provinces to Regions table
-- Regions are sorted as the settlement UI (capital, region 1, region 2)
-- ===========================================================================

local Regions = {
    ["al_andalus"] = {"cha_reg_al_andalus_cordoba", "cha_reg_al_andalus_almeria", "cha_reg_al_andalus_jaen"},
    ["alemannia"] = {"cha_reg_alemannia_basel", "cha_reg_alemannia_konstanz", "cha_reg_alemannia_chur"},
    ["austrasia"] = {"cha_reg_austrasia_aachen", "cha_reg_austrasia_metz", "cha_reg_austrasia_trier"},
    ["angria"] = {"cha_reg_angria_buraburg", "cha_reg_angria_erfurt", "cha_reg_angria_paderborn"},
    ["bavaria"] = {"cha_reg_bavaria_regensburg", "cha_reg_bavaria_augsburg", "cha_reg_bavaria_passau"},
    ["benevento"] = {"cha_reg_benevento_benevento", "cha_reg_benevento_salerno", "cha_reg_benevento_bari"},
    ["bohemia"] = {"cha_reg_bohemia_dresden", "cha_reg_bohemia_praha", "cha_reg_bohemia_iglau"},
    ["brittany"] = {"cha_reg_brittany_quimper", "cha_reg_brittany_vannes", "cha_reg_brittany_st_malo"},
    ["burgundy"] = {"cha_reg_burgundy_lyon", "cha_reg_burgundy_geneve", "cha_reg_burgundy_grenoble"},
    ["calabria"] = {"cha_reg_calabria_taranto", "cha_reg_calabria_region", "cha_reg_calabria_kroton"},
    ["carinthia"] = {"cha_reg_carinthia_salzburg", "cha_reg_carinthia_wien", "cha_reg_carinthia_lorch"},
    ["croatia"] = {"cha_reg_croatia_sisak", "cha_reg_croatia_jadra", "cha_reg_croatia_ptuj"},
    ["east_aquitaine"] = {"cha_reg_east_aquitaine_arvernis", "cha_reg_east_aquitaine_rodez", "cha_reg_east_aquitaine_autun"},
    ["east_neustria"] = {"cha_reg_east_neustria_reims", "cha_reg_east_neustria_amiens", "cha_reg_east_neustria_troyes"},
    ["eastphalia"] = {"cha_reg_eastphalia_magdeburg", "cha_reg_eastphalia_hildesheim", "cha_reg_eastphalia_halberstadt"},
    ["exarchate"] = {"cha_reg_exarchate_ravenna", "cha_reg_exarchate_bologna", "cha_reg_exarchate_ancona"},
    ["france"] = {"cha_reg_france_paris", "cha_reg_france_tours", "cha_reg_france_chatres"},
    ["franconia"] = {"cha_reg_franconia_hallstadt", "cha_reg_franconia_wurzburg", "cha_reg_franconia_frankfurt"},
    ["frisia"] = {"cha_reg_frisia_ghent", "cha_reg_frisia_utrecht", "cha_reg_frisia_boulogne"},
    ["friuli"] = {"cha_reg_friuli_venezia", "cha_reg_friuli_aquileia", "cha_reg_friuli_verona"},
    ["gallicia"] = {"cha_reg_gallicia_oviedo", "cha_reg_gallicia_santiago", "cha_reg_gallicia_lugo"},
    ["gascony"] = {"cha_reg_gascony_bordeaux", "cha_reg_gascony_agen", "cha_reg_gascony_bayonne"},
    ["gharb_al_anadalus"] = {"cha_reg_gharb_al_anadalus_seville", "cha_reg_gharb_al_anadalus_beja", "cha_reg_gharb_al_anadalus_cadiz"},
    ["jutland"] = {"cha_reg_jutland_ribe", "cha_reg_jutland_hedeby", "cha_reg_jutland_aarhus"},
    ["leon"] = {"cha_reg_leon_leon", "cha_reg_leon_valladoid", "cha_reg_leon_santander"},
    ["lombardy"] = {"cha_reg_lombardy_pavia", "cha_reg_lombardy_genova", "cha_reg_lombardy_pisa"},
    ["marca_hispanica"] = {"cha_reg_marca_hispanica_barcelona", "cha_reg_marca_hispanica_tarragona", "cha_reg_marca_hispanica_girona"},
    ["marca_inferior"] = {"cha_reg_marca_inferior_lisbon", "cha_reg_marca_inferior_coimbra", "cha_reg_marca_inferior_braga"},
    ["marca_media"] = {"cha_reg_marca_media_caceres", "cha_reg_marca_media_merida", "cha_reg_marca_media_salamanca"},
    ["mercia"] = {"cha_reg_mercia_lichfield", "cha_reg_mercia_lincoln", "cha_reg_mercia_chester"},
    ["moravia"] = {"cha_reg_moravia_nitra", "cha_reg_moravia_mosaburg", "cha_reg_moravia_savaria"},
    ["munster"] = {"cha_reg_munster_cashel", "cha_reg_munster_cork", "cha_reg_munster_dublin"},
    ["navarre"] = {"cha_reg_navarre_saragossa", "cha_reg_navarre_tudela", "cha_reg_navarre_pamplona"},
    ["northumbria"] = {"cha_reg_northumbria_bamburgh", "cha_reg_northumbria_york", "cha_reg_northumbria_streonshalh"},
    ["obodrites"] = {"cha_reg_obodrites_rerik", "cha_reg_obodrites_stargard", "cha_reg_obodrites_havelberg"},
    ["pannonia"] = {"cha_reg_pannonia_szeged", "cha_reg_pannonia_kaposvar", "cha_reg_pannonia_cibakhaza"},
    ["pictland"] = {"cha_reg_pictland_rhynie", "cha_reg_pictland_scone", "cha_reg_pictland_dumbarton"},
    ["provence"] = {"cha_reg_provence_marseille", "cha_reg_provence_nice", "cha_reg_provence_arles"},
    ["rome"] = {"cha_reg_rome_roma", "cha_reg_rome_spoleto", "cha_reg_rome_siena"},
    ["sardinia_and_corsica"] = {"cha_reg_sardinia_and_corsica_cagliari", "cha_reg_sardinia_and_corsica_olbia", "cha_reg_sardinia_and_corsica_ajaccio"},
    ["saxony"] = {"cha_reg_saxony_hamburg", "cha_reg_saxony_bremen", "cha_reg_saxony_osnabruck"},
    ["septimania"] = {"cha_reg_septimania_toulouse", "cha_reg_septimania_narbonne", "cha_reg_septimania_urgell"},
    ["sicilia"] = {"cha_reg_sicilia_syracuse", "cha_reg_sicilia_panormos", "cha_reg_sicilia_akragas"},
    ["swabia"] = {"cha_reg_swabia_strasbourg", "cha_reg_swabia_speyer", "cha_reg_swabia_bescanon"},
    ["toledo"] = {"cha_reg_toledo_toledo", "cha_reg_toledo_calatrava", "cha_reg_toledo_guadalajara"},
    ["ulster"] = {"cha_reg_ulster_grinan_of_ailech", "cha_reg_ulster_downpatrick", "cha_reg_ulster_cruachan"},
    ["valencia"] = {"cha_reg_valencia_valencia", "cha_reg_valencia_palma", "cha_reg_valencia_cartagena"},
    ["wales"] = {"cha_reg_wales_mathrafal", "cha_reg_wales_degannwy", "cha_reg_wales_caerwent"},
    ["wessex"] = {"cha_reg_wessex_winchester", "cha_reg_wessex_canterbury", "cha_reg_wessex_london"},
    ["west_aquitaine"] = {"cha_reg_west_aquitaine_poitiers", "cha_reg_west_aquitaine_bourges", "cha_reg_west_aquitaine_angouleme"},
    ["west_neustria"] = {"cha_reg_west_neustria_rennes", "cha_reg_west_neustria_nantes", "cha_reg_west_neustria_bayeux"},
    ["wilzi"] = {"cha_reg_wilzi_cottbus", "cha_reg_wilzi_brandenburg", "cha_reg_wilzi_lipsk"}
} --: map<string, vector<string>>


return Regions;
