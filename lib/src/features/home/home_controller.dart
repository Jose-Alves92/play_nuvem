// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:play_nuvem/src/features/home/services/home_service.dart';
import 'package:play_nuvem/src/shared/models/category_model.dart';

import 'home_state.dart';

class HomeController with ChangeNotifier {
  final HomeService _homeService;
  HomeController(
    this._homeService,
  ) {
    fetch();
  }


  HomeState state = HomeState.initial();

  void changeState(HomeState newValue) {
    state = newValue;
    notifyListeners();
  }


  Future<void> fetch() async {
    changeState(state.copyWith(status: HomeStatus.loading));
    try {
      
      List<CategoryModel> categories = await _homeService.fetch();

      changeState(state.copyWith(status: HomeStatus.success, categories: categories));
    } catch (error, stackTrace) {
      print("Exception occured: $error by $stackTrace");
      
     changeState( state.copyWith(status: HomeStatus.error));
      
    }
  }

}
