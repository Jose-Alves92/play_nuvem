import '../../shared/models/movie_detail_model.dart';
import '../../shared/models/reproduction_items.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitialState extends MovieDetailsState {
  final MovieDetailsModel movieDetails = MovieDetailsModel();
  final List<ReproductionItems> listReproductions = [];
}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsErrorState extends MovieDetailsState {
  final String message;

  MovieDetailsErrorState(this.message);
}

class MovieDetailsSuccessState extends MovieDetailsState {
  final MovieDetailsModel movieDetails;
  final List<ReproductionItems> listReproductions;

  MovieDetailsSuccessState(this.movieDetails, this.listReproductions);
}
