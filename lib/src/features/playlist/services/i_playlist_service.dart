
import 'package:play_nuvem/src/shared/models/m3u/playlist.dart';

abstract class IPlaylistService {
 

  Future<List<Playlist>> fetch();

 Future<List<Playlist>> addPlaylist(Playlist playlist);
}
