import '../../shared/models/media_model.dart';

abstract class TvTabBarState{}

class TvTabBarInitialState extends TvTabBarState{}

class TvTabBarLoadingState extends TvTabBarState{}

class TvTabBarErrorState extends TvTabBarState{
  final String message;

  TvTabBarErrorState(this.message);
}

class TvTabBarSuccessState extends TvTabBarState{
  final Map<String, List<Media>> tvShowsCategories;

  TvTabBarSuccessState(this.tvShowsCategories);
}
