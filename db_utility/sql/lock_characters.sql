update swg.swg_characters set enabled='N' where station_id in (select station_id from swg.players where uc_character_name = '&uc_character_name');
commit;