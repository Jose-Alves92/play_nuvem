
import 'package:play_nuvem/src/models/m3u/playlist.dart';

abstract class IPlaylistService {
 

  Future<List<Playlist>> fetch();

 Future<bool> addPlaylist(Playlist playlist);
 Future<bool> removePlaylist(Playlist playlist);
}
