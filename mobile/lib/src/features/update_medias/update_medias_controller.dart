import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/home/home_controller.dart';
import 'package:play_nuvem/src/features/update_medias/update_medias_state.dart';
import 'package:play_nuvem/src/services/m3u_generate_content/I_m3u_generate-content_service.dart';
import 'package:play_nuvem/src/shared/locator/locator_services.dart';

class UpdateMediasController extends ChangeNotifier {
  UpdateMediasState state = UpdateMediasInitial();

  void changeState(UpdateMediasState newState) {
    state = newState;
    notifyListeners();
  }

  init() async {
    changeState(UpdateMediasLoading());

    await getIt.get<IM3uGenerateContentService>().updateContent();
    await getIt.get<HomeController>().fetch();
    
    changeState(UpdateMediasLoaded());
  }
}
