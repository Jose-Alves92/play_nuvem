import 'package:get_it/get_it.dart';
import 'package:play_nuvem/src/features/home/home_controller.dart';
import 'package:play_nuvem/src/features/home/services/home_service_imp.dart';
import 'package:play_nuvem/src/features/home/services/i_home_service.dart';
import 'package:play_nuvem/src/features/playlist/playlist_controller.dart';
import 'package:play_nuvem/src/features/playlist/services/i_playlist_service.dart';
import 'package:play_nuvem/src/features/playlist/services/playlist_service_imp.dart';
import 'package:play_nuvem/src/features/splash/splash_controller.dart';
import 'package:play_nuvem/src/repositories/media_info/i_media_info_repository.dart';
import 'package:play_nuvem/src/repositories/media_info/tmdb_repository.dart';
import 'package:play_nuvem/src/services/http_client/dio_service_imp.dart';
import 'package:play_nuvem/src/services/http_client/http_client_service.dart';
import 'package:play_nuvem/src/services/local_storage/i_local_storage_service.dart';
import 'package:play_nuvem/src/services/local_storage/local_storage_service_imp.dart';
import 'package:play_nuvem/src/services/m3u_generate_content/I_m3u_generate-content_service.dart';
import 'package:play_nuvem/src/services/m3u_generate_content/m3u_generate_content_service_imp.dart';
import 'package:play_nuvem/src/shared/utils/app_url_tmdb.dart';

final getIt = GetIt.I;

setup() {
  getIt.registerSingleton<HttpClientService>(DioServiceImp(BaseOptionsHttp(
    baseUrl: AppUrlTmdb.BASE_URL,
    headers: AppUrlTmdb.HEADERS,
    queryParameters: AppUrlTmdb.QUERY_PARAMETERS,
  )));

  getIt.registerSingleton<IMediaInfoRepository>(
      TmdbRepository(getIt.get<HttpClientService>()));

  getIt.registerSingleton<ILocalStorageService>(LocalStorageServiceImp());

  getIt.registerSingleton<IM3uGenerateContentService>(
      M3uGenerateContentServiceImp(getIt.get<ILocalStorageService>()));

  getIt.registerSingleton<SplashController>(
    SplashController(getIt.get<IM3uGenerateContentService>()),
  );

  getIt.registerSingleton<IHomeService>(
    HomeServiceImp(
      getIt.get<IM3uGenerateContentService>(),
      getIt.get<IMediaInfoRepository>(),
      getIt.get<ILocalStorageService>(),
    ),
  );

  getIt.registerSingleton<HomeController>(
      HomeController(getIt.get<IHomeService>()));

  getIt.registerSingleton<IPlaylistService>(
      PlaylistServiceImp(getIt.get<ILocalStorageService>(), getIt.get<IM3uGenerateContentService>()));

  getIt.registerSingleton<PlaylistController>(
      PlaylistController(getIt.get<IPlaylistService>()));
}
