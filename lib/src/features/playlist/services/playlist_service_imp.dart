// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:play_nuvem/src/features/playlist/services/i_playlist_service.dart';
import 'package:play_nuvem/src/services/local_storage/i_local_storage_service.dart';
import 'package:play_nuvem/src/services/m3u_generate_content/I_m3u_generate-content_service.dart';
import 'package:play_nuvem/src/shared/models/m3u/playlist.dart';

class PlaylistServiceImp implements IPlaylistService {
  final ILocalStorageService _localStorageService;
  final IM3uGenerateContentService _im3uGenerateContentService;
  PlaylistServiceImp(
   this._localStorageService,
   this._im3uGenerateContentService,
  );

  @override
  Future<List<Playlist>> fetch() async {
    String playlistJson =  await _localStorageService.getString('playlist');

    if(playlistJson.isNotEmpty) {
      List<Map<String, dynamic>> decode = jsonDecode(playlistJson);
      

      return decode.map((e) => Playlist.fromMap(e)).toList();

    }
    
    return <Playlist>[
      //Playlist(id: '1', name: 'Test', url: 'https://github.com/Jose-Alves92/play_nuvem/raw/161ea4cb5dc85dc0b75ea116c27026eafbee1c6a/assets/images/listteste.m3u')
    ];
  }
  @override
  Future<List<Playlist>> addPlaylist(Playlist playlist) async {
    var list = await fetch();
    list.add(playlist);

    var newPlaylist = list.map((e) => e.toMap()).toList();
    
    var isSave = await _localStorageService.saveString('playlist', jsonEncode(newPlaylist));

    if(isSave) {
   
      await _im3uGenerateContentService.updateContent();

      return list;
    }
    return [];
  }
}
