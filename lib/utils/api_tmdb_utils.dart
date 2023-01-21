class ApiTmdbUtils {
  static String REQUEST_GENRES(String midiaType) => 'genre/$midiaType/list';
  static String REQUEST_MIDIA_BY_GENRES(String idGenre, String midiaType) => 'discover/$midiaType?with_genres=$idGenre';
  static String REQUEST_DETAIL(String midiaId, String midiaType) => '$midiaType/$midiaId';
  static String REQUEST_IMDB(String midiaId, String midiaType) => '$midiaType/$midiaId/external_ids';
  static String REQUEST_IMAGE(String pathImage) => 'https://image.tmdb.org/t/p/w500$pathImage';
  static String REQUEST_TRENDING(String midiaType) => 'trending/$midiaType/week';
}

//28,12,16,35,80,99,18,10751,14,36,27,10402,9648,10749,878,10770,53,10752,37