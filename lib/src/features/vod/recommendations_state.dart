import '../../shared/models/media_model.dart';

abstract class RecommendationsState{}

class RecommendationsSInitialState extends RecommendationsState{
  final Map<String, List<Media>> recommendationsCategories;

  RecommendationsSInitialState(this.recommendationsCategories);
}

class RecommendationsLoadingState extends RecommendationsState{}

class RecommendationsErrorState extends RecommendationsState{
  final String message;

  RecommendationsErrorState(this.message);
}

class RecommendationsSuccessState extends RecommendationsState{
  final Map<String, List<Media>> recommendationsCategories;

  RecommendationsSuccessState(this.recommendationsCategories);
}