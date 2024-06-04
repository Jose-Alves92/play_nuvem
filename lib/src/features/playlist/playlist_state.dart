
import 'package:play_nuvem/src/shared/models/m3u/playlist.dart';

abstract class PlaylistState {
  List<Playlist> playlist = [];

}

class PlaylistInitial extends PlaylistState{}
class PlaylistLoading extends PlaylistState{}
class PlaylistSuccess extends PlaylistState{
  
  List<Playlist> playlist = [];

  PlaylistSuccess({required this.playlist});
}
class PlaylistError extends PlaylistState{}