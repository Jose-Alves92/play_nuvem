// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:play_nuvem/src/features/playlist/services/i_playlist_service.dart';
import 'package:play_nuvem/src/models/m3u/playlist.dart';
import 'package:play_nuvem/src/services/http_client/http_client_service.dart';
import 'package:play_nuvem/src/services/local_storage/i_local_storage_service.dart';

class PlaylistServiceImp implements IPlaylistService {
  final ILocalStorageService _localStorageService;
  final HttpClientService _httpClientService;
  PlaylistServiceImp(
    this._localStorageService,
    this._httpClientService,
  );
  late List<Playlist> _playlist;

  @override
  Future<List<Playlist>> fetch() async {
    String playlistJson = await _localStorageService.getString('playlist');

    if (playlistJson.isNotEmpty) {
      List<dynamic> decode = jsonDecode(playlistJson);

      _playlist = decode.map((e) => Playlist.fromMap(e)).toList();

      return _playlist;
    }

    //https://raw.githubusercontent.com/Jose-Alves92/play_nuvem/533593e6ef8f7e228a5273b4b6340e3e79a81941/assets/listteste.m3u
    return _playlist = [];
  }

  @override
  Future<bool> addPlaylist(Playlist playlist) async {
    if (playlist.id != null) {
      try {
        await _httpClientService.get(playlist.url);

        int index = _playlist.indexWhere((element) => element.id == playlist.id);
        _playlist[index] = playlist;
      } catch (e) {
        return false;
      }
    }
    if (playlist.id == null) {
      try {
        await _httpClientService.get(playlist.url);

        playlist.id = playlist.name.hashCode.toString();
        _playlist.add(playlist);
      } catch (e) {
        return false;
      }
    }

    var playlistToMap = _playlist.map((e) => e.toMap()).toList();

    String playlistJson = _playlist.isEmpty ? '' : jsonEncode(playlistToMap);

    var isSave = await _localStorageService.saveString('playlist', playlistJson);
  
    return isSave;
  }

  @override
  Future<bool> removePlaylist(Playlist playlist) async {
    int index = _playlist.indexWhere((element) => element.id == playlist.id);

    _playlist.removeAt(index);

    var playlistToMap = _playlist.map((e) => e.toMap()).toList();

    String playlistJson = _playlist.isEmpty ? '' : jsonEncode(playlistToMap);

    var isSave =
        await _localStorageService.saveString('playlist', playlistJson);

    return isSave;
  }
}
