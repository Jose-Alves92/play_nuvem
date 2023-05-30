
abstract class IMediaRepository {
  getGenres(String midiaType);
  getMediaByGenres(String idGenre, String midiaType);
  getMovieDetails(String midiaId, String midiaType);
  getTvDetails(String midiaId, String midiaType);
  getTrending(String midiaType);
  getImdb(String midiaId, String midiaType);
  //getMovieDetail(int idMovie);
}