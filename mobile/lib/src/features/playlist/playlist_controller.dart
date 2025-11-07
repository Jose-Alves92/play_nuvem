// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/playlist/playlist_state.dart';
import 'package:play_nuvem/src/features/playlist/services/i_playlist_service.dart';
import 'package:play_nuvem/src/models/m3u/playlist.dart';

class PlaylistController extends ChangeNotifier{
  final IPlaylistService _playlistService;
  PlaylistController(
    this._playlistService,
  );

  PlaylistState state = PlaylistInitial();

  void changeState(PlaylistState newState){
    state = newState;
    notifyListeners();
  }

  Future<void> fetch() async {
    changeState(PlaylistLoading());
    try {
      var list = await _playlistService.fetch();
      changeState(PlaylistSuccess(playlist: list));
    } catch (error, stackTrace) {
      changeState(PlaylistError());
      throw Exception('Exception occurred: $error by $stackTrace');
    }
  }

  Future<bool> addPlaylist(Playlist playlist) async{
    changeState(PlaylistLoading());
    try {
      var isSave= await _playlistService.addPlaylist(playlist);
      var list = await _playlistService.fetch();

      changeState(PlaylistSuccess(playlist: list));
      return isSave;
    } catch (error, stackTrace) {
      changeState(PlaylistError());
      throw Exception('Exception occurred: $error by $stackTrace');
    }
  }

  Future<bool> removePlaylist(Playlist playlist) async{
    changeState(PlaylistLoading());
    try {
      var isSave= await _playlistService.removePlaylist(playlist);
      var list = await _playlistService.fetch();


      changeState(PlaylistSuccess(playlist: list));
      return isSave;
    } catch (error, stackTrace) {
      changeState(PlaylistError());
      throw Exception('Exception occurred: $error by $stackTrace');
    }
  }
}
