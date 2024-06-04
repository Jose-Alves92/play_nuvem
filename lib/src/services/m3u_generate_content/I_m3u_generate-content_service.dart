import 'package:m3u_parser_nullsafe/m3u_parser_nullsafe.dart';
import 'package:play_nuvem/src/shared/models/m3u/group_media.dart';
import 'package:play_nuvem/src/shared/models/media_details.dart';

abstract class IM3uGenerateContentService {
  
   Future<List<GroupMedia>> fetch();

  updateContent() {}

  Future<MediaDetails> addLinks(MediaDetails mediaDetails);



   Future<List<GroupMedia>> convertPlaylistData();

  void converterMovie(M3uItem item);

  void converterTv(M3uItem item);
}