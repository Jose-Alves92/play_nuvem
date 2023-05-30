class MediaModel {
  List<Media> listMedia = [];
 // List<TvModel> listTv = [];
  //Map<int, Map<int, Map<String, List<MoviesModel>>>> listMoviesByGenres = {};

  MediaModel({required this.listMedia});

  MediaModel.fromJson(Map<String, dynamic> json) {
   
    if (json['results'] != null) {
      json['results'].forEach((v) => listMedia.add(Media.fromJson(v)));
    }
    
  }
}


class Media {
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
  String? mediaType;

  Media(
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
      this.voteAverage,
      this.mediaType,});

  Media.fromJson(Map<String, dynamic> json) {
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
    popularity = double.parse(json['popularity'].toString());
    voteCount = int.parse(json['vote_count'].toString());
    video = json['video'];
    voteAverage = double.parse(json['vote_average'].toString());
    mediaType = json['media_type'];
  }
}

