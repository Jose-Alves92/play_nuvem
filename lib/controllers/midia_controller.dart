import 'package:flutter/material.dart';
import 'package:play_nuvem/models/midia_model.dart';
import 'package:play_nuvem/models/genres_model.dart';
import 'package:play_nuvem/models/movie_detail_model.dart';
import 'package:play_nuvem/models/tvshows_details_model.dart';
import 'package:play_nuvem/repositories/midia_repository.dart';
import 'package:play_nuvem/repositories/midia_repository_imp.dart';

class MidiaController with ChangeNotifier {
  final MidiaRepository _midiaRepository = MidiaRepositoryImp();
  //final CategoryData _categoryData = CategoryData();
  MidiaController();

  List<Genros> genres = [];
  List<Midia> _recentlyWatched = [];
  List<Midia> _moviesActionAdventure = [];
  List<Midia> _moviesTrending = [];
  List<Midia> _tvTrending = [];
  
  
  List<Midia> get recentlyWatched {
    return _recentlyWatched;
  }
  List<Midia> get moviesActionAdventure {
    return _moviesActionAdventure;
  }
  
  List<Midia> get moviesTrending {
    return _moviesTrending;
  }
  List<Midia> get tvTrending {
    return _tvTrending;
  }


  Future<void> fetchRecommendations() async {
    try {
      //genres = await _moviesRepository.getGenres();
      _moviesTrending = await _midiaRepository.getTrending('movie');
      _tvTrending = await _midiaRepository.getTrending('tv');
      //Assistido recentemente
      //Lista de Favoritos
      notifyListeners(); 
    } catch(error, stackTrace) {
     print("Exception occured: $error by $stackTrace");
    } 
  }

  Future<void> fetchMovies() async {
    try {
      
      _moviesActionAdventure = await _midiaRepository.getMidiaByGenres('28,12', 'movie');
      notifyListeners(); 
    } catch(error) {
     print("Exception occured: $error");
    } 
  }
  Future<MovieDetailModel?> fetchMovieDetails(String midiaId, String midiaType) async {
    try {
      MovieDetailModel details = await _midiaRepository.getDetailsMovie(midiaId, midiaType);
      return details;
      //notifyListeners(); 
    } catch(error) {
     print("Exception occured: $error");
    } 
  }
  Future<TvShowsDetailsModel?> fetchTvDetails(String midiaId, String midiaType) async {
    try {
      TvShowsDetailsModel details = await _midiaRepository.getDetailsTv(midiaId, midiaType);
      return details;
      //notifyListeners(); 
    } catch(error) {
     print("Exception occured: $error");
    } 
  }
  
}
