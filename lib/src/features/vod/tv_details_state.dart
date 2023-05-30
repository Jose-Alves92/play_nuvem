import '../../shared/models/reproduction_items.dart';
import '../../shared/models/tvshows_details_model.dart';

abstract class TvDetailsState {}

class TvDetailsInitialState extends TvDetailsState{
  final TvShowsDetailsModel tvShowsDetails = TvShowsDetailsModel();
  final List<ReproductionItems> listReproductions = [];
  final String _imdbId = '';
}

class TvDetailsLoadingState extends TvDetailsState{}

class TvDetailsErrorState extends TvDetailsState{
  final String message;

  TvDetailsErrorState(this.message);
}

class TvDetailsSuccessState extends TvDetailsState{
  final TvShowsDetailsModel tvShowsDetails;
  final List<ReproductionItems> listReproductions;
  final String imdbId;

  TvDetailsSuccessState(this.tvShowsDetails, this.listReproductions, this.imdbId);
}