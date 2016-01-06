update swg.objects set scene_id='&scene_id',x='&x',y='&y',z='&z',contained_by=0 where object_id = (select character_object from swg.players where uc_character_name = '&uc_character_name');
commit;