// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/splash/splash_state.dart';
import 'package:play_nuvem/src/services/m3u_generate_content/I_m3u_generate-content_service.dart';

class SplashController extends ChangeNotifier{
  final IM3uGenerateContentService _m3uGenerateContentService;
  SplashController(
    this._m3uGenerateContentService,
  );

  SplashState state = SplashLoading();

  void changeState(SplashState newState){
    state = newState;
    notifyListeners();
  }

  Future<void> call() async {
    changeState(SplashLoading());
    try {
        await _m3uGenerateContentService.fetch();    
        changeState(SplashLoaded());
    } catch(error, stackTrace) {
      changeState(SplashError());
      throw Exception('Exception occurred: $error by $stackTrace');
    }
  }
}
