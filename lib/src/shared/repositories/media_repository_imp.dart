import '../models/genres_model.dart';
import '../models/imdb_id_model.dart';
import '../models/media_model.dart';
import '../models/movie_detail_model.dart';
import '../models/tvshows_details_model.dart';
import '../utils/app_url_tmdb.dart';
import '../services/http_client/dio_service_imp.dart';
import 'i_media_repository.dart';

class MediaRepositoryImp implements IMediaRepository {
  final DioServiceImp _httpClient = DioServiceImp(
    baseUrl: 'https://api.themoviedb.org/3/',
    headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization':
                'Bearer ${const String.fromEnvironment("TOKEN_TMDB")}',
        },
    queryParameters: {
          'api_key': const String.fromEnvironment("APIKEY_TMDB"),
          'language': 'pt-BR',
        },
  );

  MediaRepositoryImp();

  @override
  Future<List<Genres>> getGenres(String mediaType) async {
      var response = await _httpClient.get(AppUrlTmdb.REQUEST_GENRES(mediaType));
      var data = GenresModel.fromJson(response.data);
      return data.genres;
  }

  @override
  Future<List<Media>> getMediaByGenres(String idGenre, String mediaType) async {
    var response = await _httpClient.get(AppUrlTmdb.REQUEST_MIDIA_BY_GENRES(idGenre, mediaType));
    MediaModel data = MediaModel.fromJson(response.data as Map<String, dynamic>);
    return data.listMedia;
  }
  
  @override
  Future<List<Media>> getTrending(String mediaType) async {
    var response = await _httpClient.get(AppUrlTmdb.REQUEST_TRENDING(mediaType));
    MediaModel data = MediaModel.fromJson(response.data as Map<String, dynamic>);
    return data.listMedia;
  }
  
  @override
  Future<MovieDetailsModel> getMovieDetails(String mediaId, String mediaType) async {
    var response = await _httpClient.get(AppUrlTmdb.REQUEST_DETAIL(mediaId, mediaType));
    MovieDetailsModel data = MovieDetailsModel.fromJson(response.data as Map<String, dynamic>);
    return data;
  }
  @override
  Future<TvShowsDetailsModel> getTvDetails(String mediaId, String mediaType) async {
    var response = await _httpClient.get(AppUrlTmdb.REQUEST_DETAIL(mediaId, mediaType));
    TvShowsDetailsModel data = TvShowsDetailsModel.fromJson(response.data as Map<String, dynamic>);
    return data;
  }
  
  @override
  Future<String> getImdb(String mediaId, String mediaType) async {
    var response = await _httpClient.get(AppUrlTmdb.REQUEST_IMDB(mediaId, mediaType));
    ImdbIdModel data = ImdbIdModel.fromJson(response.data as Map<String, dynamic>);
    return data.imdbId!;
  }
  
  

}
    