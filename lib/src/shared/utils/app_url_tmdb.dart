class AppUrlTmdb {

  static String BASE_URL = 'https://api.themoviedb.org/3/';
  
  static Map<String, dynamic> HEADERS = {
      'Content-Type': 'application/json;charset=utf-8',
      'Authorization': 'Bearer ${const String.fromEnvironment("TOKEN_TMDB")}',
    };
  static Map<String, dynamic> QUERY_PARAMETERS = {
      'api_key': const String.fromEnvironment("APIKEY_TMDB"),
      'language': 'pt-BR',
    };

  
  static String genres(String mediaType) => 'genre/$mediaType/list';

  static String mediaByGenres(String idGenre, String mediaType) => 'discover/$mediaType?with_genres=$idGenre';
  static String mediaDetails(String mediaId, String mediaType) => '$mediaType/$mediaId';
  static String episodes(String tvId, String seasonNumber) => 'tv/$tvId/season/$seasonNumber';
  static String similar(String mediaType, String mediaId) => '$mediaType/$mediaId/similar';
  static String image(String pathImage) => 'https://image.tmdb.org/t/p/w200$pathImage';

  static String allTrending = 'trending/all/week';
  static String trending(String mediaType) => 'trending/$mediaType/week';
  
  static String popularMovie = 'movie/popular';
  static String popularTv = 'tv/popular';
  
}
