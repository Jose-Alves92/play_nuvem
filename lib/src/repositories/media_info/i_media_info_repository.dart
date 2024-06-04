import 'package:play_nuvem/src/shared/models/media_details.dart';

abstract class IMediaInfoRepository {


  Future<List<MediaDetails>> getAllTrending();

  Future<List<MediaDetails>> getPopularMovie();

  Future<List<MediaDetails>> getPopularTv();

  Future<MediaDetails> getDetails(String mediaId, String mediaType);

    Future<List<Episode>> getEpisodes(String tvId, String seasonNumber);

    Future<List<Map<String, dynamic>>> getSimilar(String mediaId, String mediaType);
}