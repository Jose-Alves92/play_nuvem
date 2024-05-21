// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:play_nuvem/src/services/http_client/dio_service_imp.dart';
import 'package:play_nuvem/src/services/http_client/http_client_service.dart';
import 'package:play_nuvem/src/shared/models/media_model.dart';
import 'package:play_nuvem/src/shared/utils/app_url_tmdb.dart';

class TmdbRepository {
  final HttpClientService httpClientService;

  TmdbRepository({
    required this.httpClientService,
  });

  Future<List<MediaModel>> getAllTrending() async {
    ResponseClient response =
        await httpClientService.get(AppUrlTmdb.allTrending);

    List<dynamic> data = response.data?['results'];


    List<MediaModel> result = data.map<MediaModel>((e) => MediaModel.fromMap(e as Map<String, dynamic>)).toList();
    
    return result;
  }

  Future<List<MediaModel>> getMoviePopular() async {
    ResponseClient response =
        await httpClientService.get(AppUrlTmdb.popularMovie);

    List<dynamic> data = response.data?['results'];


     List<MediaModel> result = data.map<MediaModel>((e) => MediaModel.fromMap(e as Map<String, dynamic>)).toList();

    return result;
  }

  Future<List<MediaModel>> getTvPopular() async {
    ResponseClient response = await httpClientService.get(AppUrlTmdb.popularTv);

    List<dynamic> data = response.data?['results'];


   List<MediaModel> result = data.map<MediaModel>((e) => MediaModel.fromMap(e as Map<String, dynamic>)).toList();

    return result;
  }
}
