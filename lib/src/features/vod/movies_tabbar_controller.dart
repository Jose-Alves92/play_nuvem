import 'package:flutter/material.dart';

import '../../shared/models/media_model.dart';
import '../../shared/repositories/i_media_repository.dart';
import 'movies_tabbar_state.dart';

class MoviesTabBarController extends ChangeNotifier {
  final IMediaRepository _mediaRepository;

  MoviesTabBarController(this._mediaRepository);

  MoviesTabBarState _state = MoviesTabBarInitialState();
  MoviesTabBarState get state => _state;

  void changeState(MoviesTabBarState newValue){
    _state = newValue;
    notifyListeners();
  }

  Future<void> fetchMovies() async {
    changeState(MoviesTabBarLoadingState());
    try {
        Map<String, List<Media>> moviesCategories = {
         'ActionAdventure': await _mediaRepository.getMediaByGenres('28,12', 'movie'),
         'Animation': await _mediaRepository.getMediaByGenres('16', 'movie'),
         'Comedy': await _mediaRepository.getMediaByGenres('35', 'movie'),
         'Crime' : await _mediaRepository.getMediaByGenres('80', 'movie'),
         'Drama': await _mediaRepository.getMediaByGenres('18', 'movie'),
         'Family': await _mediaRepository.getMediaByGenres('10751', 'movie'),
         'Fantasy': await _mediaRepository.getMediaByGenres('14', 'movie'),
         'HorrorMystery': await _mediaRepository.getMediaByGenres('27, 9648', 'movie'),
       };
    changeState(MoviesTabBarSuccessState(moviesCategories));
     } catch (error) {
       print("Exception occured: $error");
       changeState(MoviesTabBarErrorState(error.toString()));
     }
   }
}