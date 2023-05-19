import 'package:play_nuvem/models/imdb_id_model.dart';
import 'package:play_nuvem/models/midia_model.dart';
import 'package:play_nuvem/models/genres_model.dart';
import 'package:play_nuvem/models/movie_detail_model.dart';
import 'package:play_nuvem/models/tvshows_details_model.dart';
import 'package:play_nuvem/repositories/midia_repository.dart';
import 'package:play_nuvem/services/tmdb/http_service.dart';
import 'package:play_nuvem/services/tmdb/dio_service_imp.dart';
import 'package:play_nuvem/utils/api_tmdb_utils.dart';


class MidiaRepositoryImp implements MidiaRepository {
  final HttpService _httpService = DioServiceImp();

  MidiaRepositoryImp();

  @override
  Future<List<Genros>> getGenres(String midiaType) async {
      var response = await _httpService.get(ApiTmdbUtils.REQUEST_GENRES(midiaType));
      var data = GenresModel.fromJson(response);
      return data.genres;
  }

  @override
  Future<List<Midia>> getMidiaByGenres(String idGenre, String midiaType) async {
    var response = await _httpService.get(ApiTmdbUtils.REQUEST_MIDIA_BY_GENRES(idGenre, midiaType));
    MidiaModel data = MidiaModel.fromJson(response as Map<String, dynamic>);
    return data.listMidia;
  }
  
  @override
  Future<List<Midia>> getTrending(String mediaType) async {
    var response = await _httpService.get(ApiTmdbUtils.REQUEST_TRENDING(mediaType));
    MidiaModel data = MidiaModel.fromJson(response as Map<String, dynamic>);
    return data.listMidia;
  }
  
  @override
  Future<MovieDetailModel> getDetailsMovie(String midiaId, String midiaType) async {
    var response = await _httpService.get(ApiTmdbUtils.REQUEST_DETAIL(midiaId, midiaType));
    MovieDetailModel data = MovieDetailModel.fromJson(response);
    return data;
  }
  @override
  Future<TvShowsDetailsModel> getDetailsTv(String midiaId, String midiaType) async {
    var response = await _httpService.get(ApiTmdbUtils.REQUEST_DETAIL(midiaId, midiaType));
    TvShowsDetailsModel data = TvShowsDetailsModel.fromJson(response);
    return data;
  }
  
  @override
  Future<String> getImdb(String midiaId, String midiaType) async {
    var response = await _httpService.get(ApiTmdbUtils.REQUEST_IMDB(midiaId, midiaType));
    ImdbIdModel data = ImdbIdModel.fromJson(response);
    return data.imdbId!;
  }
  
  

}
    