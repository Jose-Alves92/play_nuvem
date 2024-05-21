class MediaDetails {
  bool? adult;
  String? backdropPath;
  String? firstAirDate;
  List<Genres>? genres;
  int? id;
  String? name;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<Seasons>? seasons;
  double? voteAverage;
  int? voteCount;

  MediaDetails(
      {this.adult,
      this.backdropPath,
      this.firstAirDate,
      this.genres,
      this.id,
      this.name,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.seasons,
      this.voteAverage,
      this.voteCount});

  MediaDetails.fromMap(Map<String, dynamic> map) {
    adult = map['adult'];
    backdropPath = map['backdrop_path'];
    firstAirDate = map['first_air_date'];
    if (map['genres'] != null) {
      genres = <Genres>[];
      map['genres'].forEach((v) {
        genres!.add(Genres.fromMap(v));
      });
    }
    id = map['id'];
    name = map['name'] ?? map['title'];
    numberOfEpisodes = map['number_of_episodes'];
    numberOfSeasons = map['number_of_seasons'];
    originalName = map['original_name'] ?? map['original_title'];
    overview = map['overview'];
    popularity = map['popularity'];
    posterPath = map['poster_path'];
    seasons = map['seasons'] != null ? map['seasons'].map((s) => Seasons.fromMap(s)).toList() : [];
    voteAverage = map['vote_average'];
    voteCount = map['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['first_air_date'] = firstAirDate;
    data['genres'] = genres!.map((v) => v.toMap()).toList();
    data['id'] = id;
    data['name'] = name;
    data['number_of_episodes'] = numberOfEpisodes;
    data['number_of_seasons'] = numberOfSeasons;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['seasons'] = seasons!.map((v) => v.toMap()).toList();
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Seasons {
  String? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  Seasons(
      {this.airDate,
      this.episodeCount,
      this.id,
      this.name,
      this.overview,
      this.posterPath,
      this.seasonNumber,
      this.voteAverage});

  Seasons.fromMap(Map<String, dynamic> map) {
    airDate = map['air_date'];
    episodeCount = map['episode_count'];
    id = map['id'];
    name = map['name'];
    overview = map['overview'];
    posterPath = map['poster_path'];
    seasonNumber = map['season_number'];
    voteAverage = map['vote_average'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_count'] = episodeCount;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['season_number'] = seasonNumber;
    data['vote_average'] = voteAverage;
    return data;
  }
}
