import 'package:flutter/material.dart';

import '../models/genres_model.dart';
import '../models/media_model.dart';
import '../models/movie_detail_model.dart';
import '../models/tvshows_details_model.dart';
import '../repositories/media_repository.dart';
import '../repositories/media_repository_imp.dart';

class MediaController with ChangeNotifier {
  final MediaRepository _mediaRepository = MediaRepositoryImp();

  MediaController();

  List<Genros> genres = [];
  List<Media> _recentlyWatched = [];
  List<Media> _moviesActionAdventure = [];
  List<Media> _moviesTrending = [];
  List<Media> _tvTrending = [];
  
  
  List<Media> get recentlyWatched {
    return _recentlyWatched;
  }
  List<Media> get moviesActionAdventure {
    return _moviesActionAdventure;
  }
  
  List<Media> get moviesTrending {
    return _moviesTrending;
  }
  List<Media> get tvTrending {
    return _tvTrending;
  }


  Future<void> fetchRecommendations() async {
    try {
      _moviesTrending = await _mediaRepository.getTrending('movie');
    
      _tvTrending = await _mediaRepository.getTrending('tv');
      //Assistido recentemente
      //Lista de Favoritos
      print('Esta chamando');
      notifyListeners(); 
    } catch(error, stackTrace) {
     print("Exception occured: $error by $stackTrace");
    } 
  }

  Future<void> fetchMovies() async {
    try {
      
      _moviesActionAdventure = await _mediaRepository.getMediaByGenres('28,12', 'movie');
      notifyListeners(); 
    } catch(error) {
     print("Exception occured: $error");
    } 
  }
  Future<MovieDetailModel?> fetchMovieDetails(String midiaId, String midiaType) async {
    try {
      MovieDetailModel details = await _mediaRepository.getDetailsMovie(midiaId, midiaType);
      return details;
      //notifyListeners(); 
    } catch(error) {
     print("Exception occured: $error");
    } 
  }
  Future<TvShowsDetailsModel?> fetchTvDetails(String midiaId, String midiaType) async {
    try {
      TvShowsDetailsModel details = await _mediaRepository.getDetailsTv(midiaId, midiaType);
      return details;
      //notifyListeners(); 
    } catch(error) {
     print("Exception occured: $error");
    } 
  }
  
}
