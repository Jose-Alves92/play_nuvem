import 'package:flutter/material.dart';

import '../../shared/models/media_model.dart';
import '../../shared/repositories/i_media_repository.dart';
import 'recommendations_state.dart';

class RecommendationsController with ChangeNotifier {
  final IMediaRepository _mediaRepository;

  RecommendationsController(this._mediaRepository);

  RecommendationsState _state = RecommendationsSInitialState(<String, List<Media>>{});
  RecommendationsState get state => _state;

  void changeState(RecommendationsState newValue) {
    _state = newValue;
    notifyListeners();
  } 
    



  Future<void> fetchRecommendations() async {
    changeState(RecommendationsLoadingState());
    try {
      Map<String, List<Media>> recommendationsCategories = {
        'allTrending': await _mediaRepository.getTrending('all'),
        'moviesTrending': await _mediaRepository.getTrending('movie'),
        'tvTrending': await _mediaRepository.getTrending('tv'),
      };

      changeState(RecommendationsSuccessState(recommendationsCategories));
    } catch (error, stackTrace) {
      print("Exception occured: $error by $stackTrace");
      changeState(RecommendationsErrorState(error.toString()));
    }
  }

}
