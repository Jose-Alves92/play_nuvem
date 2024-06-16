// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:play_nuvem/src/repositories/media_info/i_media_info_repository.dart';
import 'package:play_nuvem/src/services/http_client/http_client_service.dart';
import 'package:play_nuvem/src/models/media_details.dart';
import 'package:play_nuvem/src/shared/utils/app_url_tmdb.dart';

class TmdbRepository implements IMediaInfoRepository{
  final HttpClientService httpClientService;

  TmdbRepository(
    this.httpClientService,
  );

  @override
  Future<List<MediaDetails>> getAllTrending() async {
    ResponseClient response =
        await httpClientService.get(AppUrlTmdb.allTrending);

    List<dynamic> data = response.data?['results'];

    List<MediaDetails> result = data.map<MediaDetails>((e) => MediaDetails.fromMap(e as Map<String, dynamic>)).toList();

    return result;
  }

  @override
  Future<List<MediaDetails>> getPopularMovie() async {
    // ResponseClient response = await httpClientService.get(AppUrlTmdb.trending('movie'));
    ResponseClient response = await httpClientService.get(AppUrlTmdb.popularMovie);

    List<dynamic> data = response.data?['results'];

    List<MediaDetails> result = data.map<MediaDetails>((e) => MediaDetails.fromMap(e as Map<String, dynamic>)).toList();

    return result;
  }
  @override
  Future<List<MediaDetails>> getPopularTv() async {
    // ResponseClient response = await httpClientService.get(AppUrlTmdb.trending('tv'));
    ResponseClient response = await httpClientService.get(AppUrlTmdb.popularTv);

    List<dynamic> data = response.data?['results'] as List<Map<String, dynamic>>;

    List<MediaDetails> result = data.map<MediaDetails>((e) => MediaDetails.fromMap(e as Map<String, dynamic>)).toList();

    return result;
  }
  @override
  Future<MediaDetails> getDetails(String mediaId, String mediaType) async {
    ResponseClient response = await httpClientService.get(AppUrlTmdb.mediaDetails(mediaId, mediaType));

    Map<String, dynamic> data = response.data!;

    MediaDetails result = MediaDetails.fromMap(data);

    return result;

  }
  @override
  Future<List<Episode>> getEpisodes(String tvId, String seasonNumber) async {
    ResponseClient response = await httpClientService.get(AppUrlTmdb.episodes(tvId, seasonNumber));

    List<dynamic> data = response.data?['episodes'];

    List<Episode> result = data.map<Episode>((e) => Episode.fromMap(e as Map<String, dynamic>)).toList();

    return result;

  }
  @override
  Future<List<Map<String, dynamic>>> getSimilar(String mediaId, String mediaType) async {
    ResponseClient response = await httpClientService.get(AppUrlTmdb.similar(mediaType, mediaId));

    List<Map<String, dynamic>> data = response.data?['results'] as List<Map<String, dynamic>>;

    return data;

  }
}
