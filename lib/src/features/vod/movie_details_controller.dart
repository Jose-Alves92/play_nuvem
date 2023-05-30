// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../shared/models/cloud_model.dart';
import '../../shared/models/movie_detail_model.dart';
import '../../shared/models/reproduction_items.dart';
import '../../shared/repositories/i_media_repository.dart';
import '../../shared/services/connection_clouds/i_connections_clouds.dart';
import '../../shared/services/local_storage/i_local_storage.dart';
import 'movie_details_state.dart';


class MovieDetailsController extends ChangeNotifier {
  
  final  IMediaRepository _mediaRepository;
   final IConnectionsClouds _connectionsClouds;
  final ILocalStorage _localStorage;

  MovieDetailsController(this._mediaRepository, this._connectionsClouds, this._localStorage);


  MovieDetailsState _state = MovieDetailsInitialState();
  MovieDetailsState get state => _state;

  void changeState(MovieDetailsState newValue) {
    _state = newValue;
    notifyListeners();
  }
 

  Future<void> loadMovies(String midiaId) async {
    changeState(MovieDetailsLoadingState());
    try {
   
      MovieDetailsModel movieDetails = await _mediaRepository.getMovieDetails(midiaId, 'movie');

      String result = await _localStorage.getString('listCloud');
      List<Cloud> listCloud;
      if(result.isNotEmpty) {
        listCloud = CloudModel.fromJson(result).list;
      } else {
        listCloud = [];
      }

      List<ReproductionItems> listReproductions = await _connectionsClouds.getAllObjectos(listCloud: listCloud, mediaType: 'movie', object: movieDetails.imdbId!);
     
     changeState(MovieDetailsSuccessState(movieDetails, await listReproductions));
    } catch (error, StackTrace) {
      print("Exception occured: $error by $StackTrace");
      changeState(MovieDetailsErrorState(error.toString()));
    }
  }
}
