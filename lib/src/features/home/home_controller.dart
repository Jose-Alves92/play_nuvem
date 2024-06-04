// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:play_nuvem/src/features/home/services/i_home_service.dart';
import 'package:play_nuvem/src/shared/models/home_content.dart';

import 'home_state.dart';

class HomeController with ChangeNotifier {
  final IHomeService _homeService;
  HomeController(
    this._homeService,
  );

  HomeState state = HomeState.initial();

  void changeState(HomeState newValue) {
    state = newValue;
    notifyListeners();
  }

  Future<void> fetch() async {
    changeState(state.copyWith(status: HomeStatus.loading));
    try {
      HomeContent content = await _homeService.fetch();

      changeState(state.copyWith(status: HomeStatus.success, homeContent: content));
    } catch (error, stackTrace) {

      changeState(state.copyWith(status: HomeStatus.error));
      throw Exception("Exception occured: $error by $stackTrace");
    }
  }
}
