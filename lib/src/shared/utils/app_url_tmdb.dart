class AppUrlTmdb {
  
  static String REQUEST_GENRES(String midiaType) => 'genre/$midiaType/list';
  static String REQUEST_MIDIA_BY_GENRES(String idGenre, String midiaType) => 'discover/$midiaType?with_genres=$idGenre';
  static String REQUEST_DETAIL(String midiaId, String midiaType) => '$midiaType/$midiaId';
  static String REQUEST_IMDB(String midiaId, String midiaType) => '$midiaType/$midiaId/external_ids';
  static String REQUEST_IMAGE(String pathImage) => 'https://image.tmdb.org/t/p/w500$pathImage';
  static String REQUEST_TRENDING(String midiaType) => 'trending/$midiaType/week';
}
