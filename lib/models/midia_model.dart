class MidiaModel {
  List<Midia> listMidia = [];
 // List<TvModel> listTv = [];
  //Map<int, Map<int, Map<String, List<MoviesModel>>>> listMoviesByGenres = {};

  MidiaModel({required this.listMidia});

  MidiaModel.fromJson(Map<String, dynamic> json) {
   
    if (json['results'] != null) {
      json['results'].forEach((v) => listMidia.add(Midia.fromJson(v)));
    }
    
  }
}


class Midia {
  String? posterPath;
  bool? adult;
  String? overview;
  String? releaseDate;
  List<int>? genreIds;
  int? id;
  String? originalTitle;
  String? originalLanguage;
  String? title;
  String? backdropPath;
  double? popularity;
  int? voteCount;
  bool? video;
  double? voteAverage;

  Midia(
      {this.posterPath,
      this.adult,
      this.overview,
      this.releaseDate,
      this.genreIds,
      this.id,
      this.originalTitle,
      this.originalLanguage,
      this.title,
      this.backdropPath,
      this.popularity,
      this.voteCount,
      this.video,
      this.voteAverage});

  Midia.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalTitle = json['original_title'] ?? json['original_name'];
    originalLanguage = json['original_language'];
    title = json['title'] ?? json['name'];
    backdropPath = json['backdrop_path'];
    popularity = json['popularity'];
    voteCount = json['vote_count'];
    video = json['video'];
    voteAverage = json['vote_average'];
  }
}


// { 
//     28: {
//       1: [{"adult": false, "backdrop_path": "/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg", "genre_ids": [28, 14, 878], "id": 436270, "original_language": "en", "original_title": "Black Adam", "overview": "Quase 5.000 anos depois de ter sido concedido com os poderes onipotentes dos deuses egípcios - e de ter sido preso, - Adão Negro se ergue de seu túmulo, pronto para trazer sua justiça ao mundo moderno.", "popularity": 6345.586, "poster_path": "/9z256FFPDsL7kSVJ9oyLELaN1ph.jpg", "release_date": "2022-10-19", "title": "Adão Negro", "video": false, "vote_average": 7.3, "vote_count": 2683},],
//       "totalPages": 1,
//     },
    //  json['results'].forEach((v) => listMovies.add(MoviesModel.fromJson(v)))
    // json['results'].map((v) => MoviesModel.fromJson(v))
// };