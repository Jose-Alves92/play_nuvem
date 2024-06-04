
                // ignore_for_file: public_member_api_docs, sort_constructors_first

class MediaDetails {
  bool? adult;
  String? backdropPath;
  String? firstAirDate;
  List<Genres>? genres;
  int? id;
  String? mediaType;
  String? name;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  int? runtime;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<Seasons>? seasons;
  double? voteAverage;
  int? voteCount;
  List<String> links;
  bool isAvailable;

  MediaDetails(
      {this.adult,
      this.backdropPath,
      this.firstAirDate,
      this.genres,
      this.id,
      this.mediaType,
      this.name,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.runtime,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.seasons,
      this.voteAverage,
      this.voteCount,
      this.links = const[],
      this.isAvailable = false,
      });

  factory MediaDetails.fromMap(Map<String, dynamic> map) {
    return MediaDetails(
      adult: map['adult'],
      backdropPath: map['backdrop_path'],
      firstAirDate: map['first_air_date'] ?? map['release_date'],
      genres: map['genres']?.map<Genres>((g) => Genres.fromMap(g as Map<String, dynamic>)).toList(),
      id: map['id'],
      mediaType: map['media_type'],
      name: map['name'] ?? map['title'],
      numberOfEpisodes: map['number_of_episodes'],
      numberOfSeasons: map['number_of_seasons'],
      runtime: map['runtime'],
      originalName: map['original_name'] ?? map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      seasons: map['seasons']?.map<Seasons>((s) => Seasons.fromMap(s as Map<String, dynamic>)).toList(),
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
      links: List<String>.from(map['links'] ?? []),
      isAvailable: map['isAvailable'] ?? false,
    );
    
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['first_air_date'] = firstAirDate;
    data['genres'] = genres?.map((v) => v.toMap()).toList();
    data['id'] = id;
    data['media_type'] = mediaType;
    data['name'] = name;
    data['number_of_episodes'] = numberOfEpisodes;
    data['number_of_seasons'] = numberOfSeasons;
    data['runtime'] = runtime;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['seasons'] = seasons?.map((v) => v.toMap()).toList();
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['links'] = links;
    data['isAvailable'] = isAvailable;
    return data;
  }

  MediaDetails copyWith({
    bool? adult,
    String? backdropPath,
    String? firstAirDate,
    List<Genres>? genres,
    int? id,
    String? mediaType,
    String? name,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    List<Seasons>? seasons,
    double? voteAverage,
    int? voteCount,
    List<String>? links,
    bool? isAvailable,
  }) {
    return MediaDetails(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      genres: genres ?? this.genres,
      id: id ?? this.id,
      mediaType: mediaType ?? this.mediaType,
      name: name ?? this.name,
      numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      seasons: seasons ?? this.seasons,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      links: links ?? this.links,
      isAvailable: isAvailable ?? this.isAvailable,
    );
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
  List<Episode>? episodes;

  Seasons(
      {this.airDate,
      this.episodeCount,
      this.id,
      this.name,
      this.overview,
      this.posterPath,
      this.seasonNumber,
      this.voteAverage,
      this.episodes,
      });

  Seasons.fromMap(Map<String, dynamic> map) {
    airDate = map['air_date'];
    episodeCount = map['episode_count'];
    id = map['id'];
    name = map['name'];
    overview = map['overview'];
    posterPath = map['poster_path'];
    seasonNumber = map['season_number'];
    voteAverage = map['vote_average'];
    episodes = map['episodes']?.map<Episode>((s) => Episode.fromMap(s as Map<String, dynamic>)).toList();
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
    data['episodes'] = episodes?.map((v) => v.toMap()).toList();
    return data;
  }

  Seasons copyWith({
    String? airDate,
    int? episodeCount,
    int? id,
    String? name,
    String? overview,
    String? posterPath,
    int? seasonNumber,
    double? voteAverage,
    List<Episode>? episodes,
  }) {
    return Seasons(
      airDate: airDate ?? this.airDate,
      episodeCount: episodeCount ?? this.episodeCount,
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      voteAverage: voteAverage ?? this.voteAverage,
      episodes: episodes ?? this.episodes,
  );
  }
}

class Episode {
  int? episodeNumber;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  String? stillPath;
  double? voteAverage;
  List<String> links;

  Episode({
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.links = const []
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
      data['episode_number'] = episodeNumber;
      data['id'] = id;
      data['name'] = name;
      data['overview'] = overview;
      data['production_code'] = productionCode;
      data['runtime'] = runtime;
      data['season_number'] = seasonNumber;
      data['still_path'] = stillPath;
      data['vote_average'] = voteAverage;
      data['links'] = links;
      return data;

  }

  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      episodeNumber: map['episode_number'],
      id: map['id'],
      name: map['name'],
      overview: map['overview'],
      productionCode: map['production_code'],
      runtime: map['runtime'],
      seasonNumber: map['season_number'],
      stillPath: map['still_path'],
      voteAverage: map['vote_average'],
      links: List<String>.from(map['links'] ?? []),
    );
      
    }

 

 

  Episode copyWith({
    int? episodeNumber,
    int? id,
    String? name,
    String? overview,
    String? productionCode,
    int? runtime,
    int? seasonNumber,
    String? stillPath,
    double? voteAverage,
    List<String>? links,
  }) {
    return Episode(
      episodeNumber: episodeNumber ?? this.episodeNumber,
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      productionCode: productionCode ?? this.productionCode,
      runtime: runtime ?? this.runtime,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      stillPath: stillPath ?? this.stillPath,
      voteAverage: voteAverage ?? this.voteAverage,
      links: links ?? this.links,
    );
  }
}


  

