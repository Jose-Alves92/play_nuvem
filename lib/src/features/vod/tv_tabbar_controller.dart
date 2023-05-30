
import 'package:flutter/material.dart';

import '../../shared/models/media_model.dart';
import '../../shared/repositories/i_media_repository.dart';
import 'tv_tabbar_state.dart';

class TvTabBarController extends ChangeNotifier {
   final IMediaRepository _mediaRepository;

  TvTabBarController(this._mediaRepository);

  TvTabBarState _state = TvTabBarInitialState();
  TvTabBarState get state => _state;

  void changeState(TvTabBarState newValue) {
    _state = newValue;
    notifyListeners();
  }

  Future<void> fetchTvShows() async {
    changeState(TvTabBarLoadingState());
    try {
      Map<String, List<Media>> tvShowsCategories = {
        'ActionAdventure': await _mediaRepository.getMediaByGenres('10759', 'tv'),
        'Animation': await _mediaRepository.getMediaByGenres('16', 'tv'),
        'Comedy': await _mediaRepository.getMediaByGenres('35', 'tv'),
        'Crime': await _mediaRepository.getMediaByGenres('80', 'tv'),
        'Drama': await _mediaRepository.getMediaByGenres('18', 'tv'),
        'Family': await _mediaRepository.getMediaByGenres('10751', 'tv'),
        'Sci-Fi & Fantasy': await _mediaRepository.getMediaByGenres('10765', 'tv'),
      };

      changeState(TvTabBarSuccessState(tvShowsCategories));
    } catch (error) {
      print("Exception occured: $error");
      changeState(TvTabBarErrorState(error.toString()));
    }
  }

}