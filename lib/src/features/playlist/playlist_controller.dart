// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/home/home_controller.dart';
import 'package:play_nuvem/src/features/playlist/playlist_state.dart';
import 'package:play_nuvem/src/features/playlist/services/i_playlist_service.dart';
import 'package:play_nuvem/src/shared/locator/locator_services.dart';
import 'package:play_nuvem/src/shared/models/m3u/playlist.dart';

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

  Future<void> updatePlaylist(Playlist playlist) async{
    changeState(PlaylistLoading());
    try {
      var list = await _playlistService.addPlaylist(playlist);
      changeState(PlaylistSuccess(playlist: list));

      getIt.get<HomeController>().fetch();

    } catch (error, stackTrace) {
      changeState(PlaylistError());
      throw Exception('Exception occurred: $error by $stackTrace');
    }
  }
}
