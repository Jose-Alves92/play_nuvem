
// ignore_for_file: public_member_api_docs, sort_constructors_first
class GroupMedia {
  String groupTitle;
  List<MoviesContent> movies;
  List<TvShowsContent> tvShows;

  GroupMedia({
    required this.groupTitle,
    this.movies = const [],
    this.tvShows = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groupTitle': groupTitle,
      'movies': movies.map((x) => x.toMap()).toList(),
      'tvShows': tvShows.map((x) => x.toMap()).toList(),
    };
  }

  factory GroupMedia.fromMap(Map<String, dynamic> map) {
    return GroupMedia(
      groupTitle: map['groupTitle'] as String,
      movies: map['movies'].map<MoviesContent>((x) => MoviesContent.fromMap(x as Map<String,dynamic>),).toList(),
      tvShows: map['tvShows'].map<TvShowsContent>((x) => TvShowsContent.fromMap(x as Map<String,dynamic>),).toList(),
    );
  }

  
}

class MoviesContent {
  String title;
  List<String> links;

  MoviesContent({
    required this.title,
    this.links = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'links': links,
    };
  }

  factory MoviesContent.fromMap(Map<String, dynamic> map) {
    return MoviesContent(
      title: map['title'] as String,
      links: List<String>.from(map['links'])
    );
  }

  
}

class TvShowsContent {
   String title;
   List<SeasonContent> seasons;

  TvShowsContent({
    required this.title,
    this.seasons = const [],
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'seasons': seasons.map((x) => x.toMap()).toList(),
    };
  }

  factory TvShowsContent.fromMap(Map<String, dynamic> map) {
    return TvShowsContent(
      title: map['title'] as String,
      seasons: map['seasons'].map<SeasonContent>((x) => SeasonContent.fromMap(x as Map<String,dynamic>),).toList(),
    );
  }


}

class SeasonContent {
  String title;
  List<EpisodesContent> episodes;

  SeasonContent({
    required this.title,
    this.episodes = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'episodes': episodes.map((x) => x.toMap()).toList(),
    };
  }

  factory SeasonContent.fromMap(Map<String, dynamic> map) {
    return SeasonContent(
      title: map['title'] as String,
      episodes: map['episodes'].map<EpisodesContent>((x) => EpisodesContent.fromMap(x as Map<String,dynamic>),).toList(),
    );
  }

 
}

class EpisodesContent {
  String title;
  List<String> links;

  EpisodesContent({
    required this.title,
    this.links = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'links': links,
    };
  }

  factory EpisodesContent.fromMap(Map<String, dynamic> map) {
    return EpisodesContent(
      title: map['title'] as String,
      links: List<String>.from(map['links']),
    );
  }

 
}

