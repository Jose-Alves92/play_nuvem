import '../../shared/models/media_model.dart';

abstract class MoviesTabBarState {}

class MoviesTabBarInitialState extends MoviesTabBarState{
  final Map<String, List<Media>> moviesCategories = {};
}

class MoviesTabBarLoadingState extends MoviesTabBarState{}

class MoviesTabBarErrorState extends MoviesTabBarState{
  final String message;

  MoviesTabBarErrorState(this.message);
}

class MoviesTabBarSuccessState extends MoviesTabBarState{
  final Map<String, List<Media>> moviesCategories;

  MoviesTabBarSuccessState(this.moviesCategories);
}
