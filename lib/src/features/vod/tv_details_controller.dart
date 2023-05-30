
import 'package:flutter/material.dart';
import 'package:play_nuvem/src/shared/models/reproduction_items.dart';
import 'package:play_nuvem/src/shared/services/connection_clouds/i_connections_clouds.dart';
import 'package:play_nuvem/src/shared/services/local_storage/i_local_storage.dart';

import '../../shared/models/cloud_model.dart';
import '../../shared/models/tvshows_details_model.dart';
import '../../shared/repositories/i_media_repository.dart';
import 'tv_details_state.dart';

class TvDetailsController extends ChangeNotifier {
  final IMediaRepository _mediaRepository;
  final IConnectionsClouds _connectionsClouds;
  final ILocalStorage _localStorage;

  TvDetailsController(this._mediaRepository, this._connectionsClouds, this._localStorage);

  TvDetailsState _state = TvDetailsInitialState();
  TvDetailsState get state => _state;

  void changeState(TvDetailsState newValue) {
    _state = newValue;
    notifyListeners();
  }
  
  late TvShowsDetailsModel tvShowsDetails;
  late String imdbId;
  late List<Cloud> listCloud;

   Future<void> loadTvShows({required String tvId}) async {
     changeState(TvDetailsLoadingState());
    try {
      tvShowsDetails = await _mediaRepository.getTvDetails(tvId, 'tv');

      imdbId = await _mediaRepository.getImdb(tvId, 'tv');

      //Recuperar listCloud do localStorage e converte objeto de list<Cloud>
      String result = await _localStorage.getString('listCloud');
      if(result.isNotEmpty) {

      listCloud = CloudModel.fromJson(result).list;
      } else {
        listCloud = [];
      }

      List<ReproductionItems> listReproductions = await _connectionsClouds.getAllObjectos(listCloud: listCloud, mediaType: 'tv', object: '${imdbId}_S01_E01');
     
      changeState(TvDetailsSuccessState(tvShowsDetails, listReproductions, imdbId));
    } catch (error, StackTrace) {
      print("Exception occured: $error by $StackTrace");
      changeState(TvDetailsErrorState(error.toString()));
    }
  }

  Future<void> updateTvShows({required String episode}) async{
    changeState(TvDetailsLoadingState());
    try {
      List<ReproductionItems> listReproductions = await _connectionsClouds.getAllObjectos(listCloud: listCloud, mediaType: 'tv', object: '$imdbId$episode');
      changeState(TvDetailsSuccessState(tvShowsDetails, listReproductions, imdbId));
    } catch (error, stackTrace) {
      print("Exception occured: $error by $stackTrace");
      changeState(TvDetailsErrorState(error.toString()));
    }
  }
  
}