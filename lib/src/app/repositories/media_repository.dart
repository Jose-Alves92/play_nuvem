
abstract class MediaRepository {
  getGenres(String midiaType);
  getMediaByGenres(String idGenre, String midiaType);
  getDetailsMovie(String midiaId, String midiaType);
  getDetailsTv(String midiaId, String midiaType);
  getTrending(String midiaType);
  getImdb(String midiaId, String midiaType);
  //getMovieDetail(int idMovie);
}